#!/usr/bin/env bash
# Antes del commit: enseña el diff y falla si quedan logs temporales DEBUG-CLAUDE.
set -euo pipefail
git --no-pager diff --stat
if grep -rn --exclude-dir=.git --exclude=antes-del-commit.sh "DEBUG-CLAUDE" .; then
  echo "Quedan logs temporales DEBUG-CLAUDE: quítalos antes del commit." >&2
  exit 1
fi
echo "Sin logs DEBUG-CLAUDE."
