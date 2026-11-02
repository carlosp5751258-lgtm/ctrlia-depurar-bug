#!/usr/bin/env bash
# Before the commit: shows the diff and fails if temporary DEBUG-CLAUDE logs remain.
set -euo pipefail
git --no-pager diff --stat
if grep -rn --exclude-dir=.git --exclude=antes-del-commit.sh "DEBUG-CLAUDE" .; then
  echo "Temporary DEBUG-CLAUDE logs remain: remove them before the commit." >&2
  exit 1
fi
echo "No DEBUG-CLAUDE logs."
