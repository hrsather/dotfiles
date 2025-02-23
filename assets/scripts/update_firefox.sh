# Get path to profile
PROFILES_PATH="${HOME}/Library/Application Support/Firefox/Profiles/"
PROFILE=$(ls "$PROFILES_PATH" | grep '\.default-release')
PROFILE_PATH="${PROFILES_PATH}${PROFILE}"

mkdir -p "${PROFILE_PATH}/chrome"
echo $PROFILE_PATH

# Rebase repo
cd "${HOME}/dotfiles/firefox/"

for file in ./*; do
    filename=$(basename "$file")
    echo "$(realpath "$file")"

    if [[ "$filename" == "user.js" ]]; then
        if [[ -e "$PROFILE_PATH/user.js" || -L "$PROFILE_PATH/user.js" ]]; then
	    rm -f "$PROFILE_PATH/user.js"
	fi
	ln -s "$(realpath "$file")" "$PROFILE_PATH/user.js"
    else
        if [[ -e "$PROFILE_PATH/chrome/$filename" || -L "$PROFILE_PATH/chrome/$filename" ]]; then
	    rm -f "$PROFILE_PATH/chrome/$filename"
	fi
        ln -sf "$(realpath "$file")" "$PROFILE_PATH/chrome/$filename"
    fi
done
