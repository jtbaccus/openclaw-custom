#!/usr/bin/env bash
# Quick health check for Turing services
echo "=== Turing Health Check ==="
echo "Date: $(date)"
echo ""

# Ollama
echo -n "Ollama: "
systemctl is-active ollama 2>/dev/null && curl -sf http://127.0.0.1:11434/api/version | python3 -c "import sys,json; print(json.load(sys.stdin).get('version','unknown'))" 2>/dev/null || echo "DOWN"

# Node
echo -n "Node.js: "
node --version 2>/dev/null || echo "NOT FOUND"

# Gateway
echo -n "Gateway: "
systemctl --user is-active turing 2>/dev/null || echo "not started yet"

# Config
echo -n "Config: "
[ -f ~/.openclaw/openclaw.json ] && echo "EXISTS ($(wc -c < ~/.openclaw/openclaw.json) bytes)" || echo "MISSING"

# Cron jobs
echo -n "Cron jobs: "
[ -f ~/.openclaw/cron/jobs.json ] && python3 -c "import json; jobs=json.load(open('$(echo $HOME)/.openclaw/cron/jobs.json')); print(f'{len(jobs.get(\"jobs\",[]))} defined')" 2>/dev/null || echo "MISSING"

# Memory
echo -n "Memory DB: "
ls -lh ~/.openclaw/memory/*.sqlite 2>/dev/null | awk '{print $5, $NF}' || echo "not yet created (starts on first use)"

# Backups
echo -n "Latest backup: "
ls -t ~/backups/turing/turing-backup-*.tar.gz 2>/dev/null | head -1 || echo "none"

echo ""
echo "=== Done ==="
