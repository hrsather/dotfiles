#!/bin/bash
# Helper for the pr-review-loop skill. Works on macOS bash 3.2. Needs gh and jq.
#
# Usage: pr-review.sh <command> [args]
#   acquire                      take the per-PR lock (exit 3 if another loop is running)
#   release                      drop the lock and state
#   bump                         count a loop (exit 4 once it passes PR_REVIEW_MAX_LOOPS)
#   wait [head-sha]              block until the AI review checks finish, then print findings
#   findings                     print unhandled AI and human comments as JSON
#   reply <thread-id> <body>     reply on a review thread
#   resolve <thread-id>          resolve a review thread
#   comment <body>               post a PR comment
#   mark-handled <id>...         remember ids so findings stops reporting them
#
# The PR comes from the current directory's branch, or from PR_URL.

set -euo pipefail

MAX_LOOPS=${PR_REVIEW_MAX_LOOPS:-5}
STALE_SECS=${PR_REVIEW_STALE_SECS:-7200}
WAIT_TIMEOUT=${PR_REVIEW_WAIT_TIMEOUT:-1500}
POLL_SECS=${PR_REVIEW_POLL_SECS:-30}
START_GRACE=${PR_REVIEW_START_GRACE:-180}
SETTLE_SECS=${PR_REVIEW_SETTLE_SECS:-20}
AI_RE=${PR_REVIEW_AI_LOGINS:-'spockulus|copilot|claude|coderabbit|codex|gemini|sourcery|code-review|ai-review|review-plusone'}
IGNORE_RE=${PR_REVIEW_IGNORE_LOGINS:-'snyk|infracost|github-actions|jenkins|dependabot|renovate|pullotter|kyverno|sonar|codecov|release-please|argocd'}
REVIEW_CHECK_RE=${PR_REVIEW_CHECKS:-'review|spockulus'}
MARKER='<!-- pr-review-loop -->'

die() { echo "pr-review: $1" >&2; exit "${2:-1}"; }

load_pr() {
    PR_URL=${PR_URL:-$(gh pr view --json url --jq .url)}
    HOST=$(echo "$PR_URL" | sed -E 's#^https?://([^/]+)/.*#\1#')
    OWNER=$(echo "$PR_URL" | sed -E 's#^https?://[^/]+/([^/]+)/.*#\1#')
    REPO=$(echo "$PR_URL" | sed -E 's#^https?://[^/]+/[^/]+/([^/]+)/.*#\1#')
    NUM=$(echo "$PR_URL" | sed -E 's#.*/pull/([0-9]+).*#\1#')
    STATE_DIR="${TMPDIR:-/tmp}/pr-review-loop/${HOST}_${OWNER}_${REPO}_${NUM}"
}

need_lock() { [ -d "$STATE_DIR" ] || die "no lock for $PR_URL; run acquire first" 2; }
beat() { date +%s > "$STATE_DIR/beat"; }

cmd_acquire() {
    load_pr
    mkdir -p "$(dirname "$STATE_DIR")"
    if ! mkdir "$STATE_DIR" 2>/dev/null; then
        local last age
        last=$(cat "$STATE_DIR/beat" 2>/dev/null || echo 0)
        age=$(( $(date +%s) - last ))
        if [ "$age" -lt "$STALE_SECS" ]; then
            die "a loop is already running for $PR_URL (last activity ${age}s ago)" 3
        fi
        echo "taking over a stale lock (${age}s old)" >&2
        rm -rf "$STATE_DIR"
        mkdir "$STATE_DIR"
    fi
    echo 0 > "$STATE_DIR/loops"
    : > "$STATE_DIR/handled"
    beat
    echo "acquired $PR_URL"
}

cmd_release() {
    load_pr
    rm -rf "$STATE_DIR"
    echo "released $PR_URL"
}

cmd_bump() {
    load_pr
    need_lock
    local n
    n=$(( $(cat "$STATE_DIR/loops") + 1 ))
    echo "$n" > "$STATE_DIR/loops"
    beat
    echo "loop $n of $MAX_LOOPS"
    [ "$n" -le "$MAX_LOOPS" ] || exit 4
}

query_pr() {
    gh api graphql --hostname "$HOST" -F owner="$OWNER" -F name="$REPO" -F number="$NUM" -f query='
query($owner: String!, $name: String!, $number: Int!) {
  repository(owner: $owner, name: $name) {
    pullRequest(number: $number) {
      headRefOid
      reviewThreads(first: 100) {
        nodes {
          id isResolved isOutdated path line
          comments(first: 50) { nodes { databaseId body author { login __typename } } }
        }
      }
      comments(first: 100) { nodes { databaseId body author { login __typename } } }
      reviews(first: 50) { nodes { databaseId state body author { login __typename } } }
    }
  }
}'
}

cmd_findings() {
    load_pr
    need_lock
    local handled
    handled=$(jq -R . "$STATE_DIR/handled" | jq -s .)
    query_pr | jq --arg ai "$AI_RE" --arg ignore "$IGNORE_RE" --arg marker "$MARKER" --argjson handled "$handled" '
def login: .author.login // "";
def kind:
    if (.body // "") | contains($marker) then "ours"
    elif login | test($ai; "i") then "ai"
    elif login == "" or (login | test($ignore; "i")) or ((.author.__typename // "") == "Bot") then "bot"
    else "human" end;
def short: (.body // "") | gsub("<!--[\\s\\S]*?-->"; "") | gsub("^\\s+|\\s+$"; "") | .[0:4000];
def unseen($id): ($handled | index($id)) == null;

.data.repository.pullRequest as $pr
| ($pr.reviewThreads.nodes | map(select(.isResolved | not))) as $open
| {
    head: $pr.headRefOid,
    ai_threads: [
        $open[]
        | ([.comments.nodes[] | kind]) as $kinds
        | select(($kinds | index("human")) == null and ($kinds | index("ai")) != null and ($kinds | last) != "ours")
        | {thread_id: .id, path, line, outdated: .isOutdated,
           comments: [.comments.nodes[] | {author: login, body: short}]}
    ],
    ai_comments: [
        ($pr.comments.nodes[] | select(kind == "ai") | {id: ("c" + (.databaseId | tostring)), author: login, body: short}),
        ($pr.reviews.nodes[] | select(kind == "ai" and ((.body // "") != "")) | {id: ("r" + (.databaseId | tostring)), author: login, body: short})
        | select(unseen(.id))
    ],
    human: [
        ($open[]
         | select([.comments.nodes[] | kind] | index("human") != null)
         | {id: .id, where: (.path + ":" + ((.line // 0) | tostring)), author: ([.comments.nodes[] | select(kind == "human") | login] | first)}),
        ($pr.comments.nodes[] | select(kind == "human") | {id: ("c" + (.databaseId | tostring)), author: login, body: short}),
        ($pr.reviews.nodes[] | select(kind == "human" and ((.body // "") != "")) | {id: ("r" + (.databaseId | tostring)), author: login, body: short})
        | select(unseen(.id))
    ]
}'
}

cmd_wait() {
    load_pr
    need_lock
    local expect=${1:-} start info head counts pending total now
    start=$(date +%s)
    while :; do
        beat
        info=$(gh pr view "$PR_URL" --json headRefOid,statusCheckRollup)
        head=$(echo "$info" | jq -r .headRefOid)
        now=$(( $(date +%s) - start ))
        if [ -z "$expect" ] || [ "$head" = "$expect" ]; then
            counts=$(echo "$info" | jq -r --arg re "$REVIEW_CHECK_RE" '
                def nm: .name // .context // "";
                def pend: if .__typename == "CheckRun" then .status != "COMPLETED" else (.state == "PENDING" or .state == "EXPECTED") end;
                [.statusCheckRollup[]? | select((nm | test($re; "i")) and ((nm | test("human"; "i")) | not))]
                | "\(map(select(pend)) | length) \(length)"')
            pending=${counts% *}
            total=${counts#* }
            if [ "$pending" -eq 0 ] && { [ "$total" -gt 0 ] || [ "$now" -ge "$START_GRACE" ]; }; then
                break
            fi
        fi
        if [ "$now" -ge "$WAIT_TIMEOUT" ]; then
            echo "pr-review: timed out after ${now}s waiting for the AI review checks" >&2
            break
        fi
        sleep "$POLL_SECS"
    done
    sleep "$SETTLE_SECS"
    cmd_findings
}

with_marker() { printf '%s\n\n%s' "$1" "$MARKER"; }

cmd_reply() {
    load_pr
    gh api graphql --hostname "$HOST" -f id="$1" -f body="$(with_marker "$2")" -f query='
mutation($id: ID!, $body: String!) {
  addPullRequestReviewThreadReply(input: {pullRequestReviewThreadId: $id, body: $body}) { comment { id } }
}' --jq '.data.addPullRequestReviewThreadReply.comment.id'
}

cmd_resolve() {
    load_pr
    gh api graphql --hostname "$HOST" -f id="$1" -f query='
mutation($id: ID!) { resolveReviewThread(input: {threadId: $id}) { thread { isResolved } } }' \
        --jq '.data.resolveReviewThread.thread.isResolved'
}

cmd_comment() {
    load_pr
    gh pr comment "$PR_URL" --body "$(with_marker "$1")"
}

cmd_mark_handled() {
    load_pr
    need_lock
    local id
    for id in "$@"; do echo "$id" >> "$STATE_DIR/handled"; done
    beat
}

cmd=${1:-}
[ -n "$cmd" ] || die "usage: pr-review.sh acquire|release|bump|wait|findings|reply|resolve|comment|mark-handled" 2
shift
case "$cmd" in
    acquire) cmd_acquire ;;
    release) cmd_release ;;
    bump) cmd_bump ;;
    wait) cmd_wait "$@" ;;
    findings) cmd_findings ;;
    reply) cmd_reply "$@" ;;
    resolve) cmd_resolve "$@" ;;
    comment) cmd_comment "$@" ;;
    mark-handled) cmd_mark_handled "$@" ;;
    *) die "unknown command: $cmd" 2 ;;
esac
