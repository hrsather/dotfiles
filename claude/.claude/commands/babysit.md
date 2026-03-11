---
name: Babysit
description: Implement and verify an OpenSpec change end-to-end, fixing failures in a loop until green
category: Workflow
tags: [workflow, artifacts]
---

Babysit an OpenSpec change end-to-end. Implement tasks, run verification, diagnose and fix failures, loop until everything passes — locally, in CI/CD, and in AzureML if applicable.

**Input**: Optionally specify a change name (e.g., `/babysit add-auth`). If omitted, auto-select the active change or ask.

Follow the full workflow defined in the `babysit` skill.
