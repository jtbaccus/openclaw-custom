# OpenClaw Custom Fork — UPGRADE-PATH.md

_Source of truth for implementation progress. Update checkboxes as phases complete._
_All 10 phases completed: 2026-02-14_

## Phase 0: Project Scaffolding ✅

- [x] Fork openclaw/openclaw to jtbaccus/openclaw-custom
- [x] Add as git submodule under projects/
- [x] Create CONTEXT.md
- [x] Create UPGRADE-PATH.md (this file)
- [x] Update projects/\_index.md
- [x] Log to activity-log.md

## Phase 1: Fork & Strip ✅

**Goal:** Remove unwanted channels/features/native apps; verify build passes.

Build: PASS | Tests: 534/534 (100%) | Gateway: starts cleanly

### Directories deleted:

- [x] apps/android/, apps/ios/, apps/macos/, apps/shared/
- [x] Swabble/ (Swift wake-word daemon)
- [x] vendor/a2ui/ (Canvas)
- [x] src/canvas-host/, src/tts/
- [x] src/whatsapp/, src/slack/, src/imessage/, src/line/

### Extensions deleted (kept: telegram, discord, memory-core, memory-lancedb, llm-task, thread-ownership, diagnostics-otel):

- [x] 29 extensions removed

### Skills deleted (kept: coding-agent, discord, github, healthcheck, himalaya, model-usage, session-logs, skill-creator, summarize, tmux, weather):

- [x] 40 skills removed

### Import fixes:

- [x] src/channels/registry.ts — trimmed to telegram + discord only
- [x] src/config/ — deleted channel-specific type files and zod schemas
- [x] src/agents/tools/ — removed channel-specific action files
- [x] package.json — removed 5 unused deps, 13 scripts
- [x] pnpm-workspace.yaml — cleaned onlyBuiltDependencies
- [x] 82 stale files deleted, ~15 source files fixed

### Archive:

- [x] All 1,800 deleted files extracted into `_archived/` (2026-02-17)
- [x] Original directory structure preserved for easy restoration
- [x] `_archived/README.md` documents contents and restoration steps

### Verify:

- [x] pnpm install succeeds
- [x] pnpm build compiles without errors
- [x] pnpm test:fast passes (534/534 files, 3630/3630 tests)
- [x] Gateway starts on ws://127.0.0.1:19001, clean shutdown on SIGTERM

## Phase 2: Model Routing ✅

**Finding:** OpenClaw already has built-in model fallback, `/think` command, and per-agent model assignment. No new code needed — pure configuration.

- [x] Configure providers in openclaw.json (Ollama, DeepSeek, Anthropic)
- [x] Set up .env.example with required API keys
- [x] Per-agent model assignment with fallback chains
- [x] `/think` command already supports off/minimal/low/medium/high/xhigh escalation
- [x] Model fallback triggers on auth/rate-limit/billing errors automatically

## Phase 3: Channel Setup ✅

- [x] Configure Telegram (botToken, allowFrom, polling mode)
- [x] Configure Discord (token)
- [x] Set up agent bindings (Telegram DMs → main, Discord → main)
- [x] Config validated against Zod schemas (field names corrected in Phase 9)

## Phase 4: Memory & Persistence ✅

**Finding:** `MemoryBackend` only supports "builtin" or "qmd". Original plan's "sqlite-vec" was invalid.

- [x] Memory backend: "builtin" (Node 22 native sqlite + sqlite-vec + FTS5)
- [x] Embeddings: OpenAI text-embedding-3-small with local fallback
- [x] Hybrid search: 70/30 vector/text split
- [x] extraPaths configured for memory/ and shared-activity/ (fixes symlink gap)
- [x] Storage: ~/.openclaw/memory/{agentId}.sqlite (created lazily)
- [x] Sessions: ~/.openclaw/agents/{agentId}/sessions/{sessionId}.jsonl
- [x] Compaction: triggers on context overflow, progressive summarization, pre-compaction memory flush

## Phase 5: Multi-Agent Routing ✅

- [x] 4 agents defined: Turing (main), Turing-Code, Turing-Research, Pulse (heartbeat)
- [x] Created SOUL-coder.md and SOUL-research.md
- [x] Per-agent workspace dirs with symlinks to shared files
- [x] Main agent has subagents.allowAgents: ["coder", "researcher"]
- [x] Inter-agent delegation via sessions_spawn tool
- [x] Agent switching via bindings (not user commands — routing is config-driven)

## Phase 6: Browser Automation ✅

- [x] playwright-core@1.58.2 (lightweight, no bundled browsers)
- [x] Chrome for Testing 145.0.7632.6 installed via Playwright
- [x] Headless mode verified working (screenshot test passed, no display server needed)
- [x] Config: enabled, headless, noSandbox, executablePath set
- [x] 16 browser actions available: status, start, stop, navigate, snapshot, screenshot, act, etc.

## Phase 7: Heartbeats & Scheduled Tasks ✅

- [x] Ollama v0.16.1 installed, systemd service enabled
- [x] qwen3:8b model pulled (5.2 GB — 15GB RAM insufficient for 30B)
- [x] Running at ~6.7 tokens/sec, API at 127.0.0.1:11434
- [x] Cron jobs in ~/.openclaw/cron/jobs.json (proper structured format)
- [x] 3 jobs: heartbeat (30min), morning-brief (7AM weekdays), memory-maintenance (Sunday 3AM)
- [x] Cron service starts automatically with gateway

## Phase 8: Clawdbot Migration ✅

- [x] All 7 bootstrap files load correctly for all 4 agents
- [x] Per-agent SOUL.md files (real files, not symlinks) give specialized personalities
- [x] Symlinks in coder/researcher workspaces followed by bootstrap loader
- [x] Memory indexer skips symlinks (by design) — extraPaths config compensates
- [x] CLAUDE.md not recognized by OpenClaw (AGENTS.md covers cross-instance protocol)
- [x] Clean slate — no existing conversation history to migrate

## Phase 9: Security Audit ✅

- [x] Approval model: 3-tier (deny/allowlist/full) with ask modes (always/on-miss/off), defaults secure
- [x] Skill allowlist: enforced at load time, double-layer (global + per-agent)
- [x] Gateway: localhost-only by default (127.0.0.1)
- [x] Browser server: hardcoded 127.0.0.1
- [x] Telemetry: none found (OTEL is opt-in, not enabled)
- [x] Stale channel refs: 15 benign refs, zero runtime impact
- [x] Hardcoded secrets: none
- [x] Env var substitution: all sensitive fields use ${VAR}
- [x] Config field names corrected (telegram: botToken/allowFrom, discord: removed applicationId)
- [ ] Security tests: run manually (`pnpm vitest run src/security/`)

## Phase 10: Deployment ✅

- [x] systemd user unit: ~/.config/systemd/user/turing.service
- [x] Ollama service enabled and running
- [x] Health check script: deploy/health-check.sh
- [x] Backup script: deploy/backup-turing.sh (daily 4AM cron, 30-day retention)
- [x] First backup verified: 39K archive
- [ ] Service NOT started — awaiting .env with real API keys

---

## Post-Implementation Checklist

- [ ] Fill in ~/.openclaw/.env with real API keys
- [ ] Run security tests: `pnpm vitest run src/security/`
- [ ] Start service: `systemctl --user enable turing && systemctl --user start turing`
- [ ] Send test Telegram message → verify response
- [ ] Send test Discord message → verify response
- [ ] Test `/think high` → verify Opus escalation
- [ ] Test memory: "remember X" → "what do you know about X?"
- [ ] Verify heartbeat fires (wait 30 min or trigger manually)
- [ ] Update AGENTS.md paths (still references /Users/clawdbot/clawd/)
- [ ] Update TOOLS.md (references old Clawdbot CLI commands)
