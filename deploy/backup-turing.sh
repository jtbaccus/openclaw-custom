#!/usr/bin/env bash
# Turing AI Assistant - Daily Backup Script
# Backs up: config, sessions, memory DB, cron jobs, workspace files
set -euo pipefail

BACKUP_DIR="${HOME}/backups/turing"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
ARCHIVE="${BACKUP_DIR}/turing-backup-${TIMESTAMP}.tar.gz"

mkdir -p "${BACKUP_DIR}"

# Files to back up
tar czf "${ARCHIVE}" \
  -C "${HOME}" \
  .openclaw/openclaw.json \
  .openclaw/cron/ \
  .openclaw/memory/ \
  .openclaw/agents/ \
  -C "${HOME}/turing" \
  clawd/SOUL.md \
  clawd/SOUL-coder.md \
  clawd/SOUL-research.md \
  clawd/USER.md \
  clawd/IDENTITY.md \
  clawd/AGENTS.md \
  clawd/TOOLS.md \
  clawd/HEARTBEAT.md \
  clawd/MEMORY.md \
  clawd/memory/ \
  clawd/shared-activity/ \
  clawd/agents/ \
  2>/dev/null || true

# Prune backups older than 30 days
find "${BACKUP_DIR}" -name "turing-backup-*.tar.gz" -mtime +30 -delete 2>/dev/null || true

echo "Backup created: ${ARCHIVE}"
ls -lh "${ARCHIVE}"
