# OpenClaw Custom Fork — CONTEXT.md

_Project: openclaw-custom | Created: 2026-02-14 | Status: All 10 phases complete_

## What This Is

A trimmed fork of OpenClaw (github.com/openclaw/openclaw) customized as Jon's personal AI assistant. Strips all unwanted channels, skills, and platform adapters. Keeps: Telegram + Discord, tiered model routing, long-term memory, multi-agent routing, browser automation, scheduled heartbeats.

## Architecture Decisions

1. **Fork and trim** (not rewrite) — inherits battle-tested security infrastructure
2. **Telegram + Discord only** — 12 other channel adapters stripped
3. **4-tier model routing:** Ollama (free) → DeepSeek ($0.14/M) → Sonnet ($3/M) → Opus ($15/M)
4. **4 agents:** Turing (main), Turing-Code, Turing-Research, Pulse (heartbeat)
5. **Heartbeats on local Ollama** — qwen3:8b (machine has 15GB RAM, not enough for 30B)
6. **Workspace:** ~/turing/clawd/ with per-agent subdirs for specialized SOULs
7. **Memory:** builtin backend (sqlite-vec + FTS5), OpenAI embeddings with local fallback

## Current Status

All 10 phases complete. Awaiting API keys in ~/.openclaw/.env to go live.

- Phase 0: Project Scaffolding ✅
- Phase 1: Fork & Strip ✅ (534/534 tests, gateway starts)
- Phase 2: Model Routing ✅ (config-only, existing infrastructure)
- Phase 3: Channel Setup ✅ (Telegram + Discord configured)
- Phase 4: Memory & Persistence ✅ (builtin + hybrid search)
- Phase 5: Multi-Agent Routing ✅ (4 agents, SOUL files, subagent delegation)
- Phase 6: Browser Automation ✅ (Playwright headless, 16 browser tools)
- Phase 7: Heartbeats ✅ (Ollama qwen3:8b, 3 cron jobs)
- Phase 8: Clawdbot Migration ✅ (workspace injection verified)
- Phase 9: Security Audit ✅ (localhost-only, no telemetry, 3-tier approval)
- Phase 10: Deployment ✅ (systemd unit, backup cron, health check)

## Key Files

| File             | Location                                  | Purpose                                                            |
| ---------------- | ----------------------------------------- | ------------------------------------------------------------------ |
| openclaw.json    | ~/.openclaw/openclaw.json                 | Main config (providers, channels, agents, skills, memory, browser) |
| cron jobs        | ~/.openclaw/cron/jobs.json                | 3 scheduled jobs (heartbeat, morning brief, memory maintenance)    |
| .env             | ~/.openclaw/.env                          | API keys (MUST be filled in before starting)                       |
| .env.example     | project root                              | Template showing required env vars                                 |
| systemd unit     | ~/.config/systemd/user/turing.service     | Gateway service                                                    |
| SOUL.md          | ~/turing/clawd/SOUL.md                    | Main agent personality                                             |
| SOUL-coder.md    | ~/turing/clawd/SOUL-coder.md              | Code agent personality                                             |
| SOUL-research.md | ~/turing/clawd/SOUL-research.md           | Research agent personality                                         |
| Agent workspaces | ~/turing/clawd/agents/{coder,researcher}/ | Per-agent dirs with symlinks                                       |

## Tech Stack

- Runtime: Node.js 22+ (v22.22.0)
- Language: TypeScript
- Package manager: pnpm (monorepo)
- Session storage: JSONL at ~/.openclaw/agents/{agentId}/sessions/
- Memory: SQLite + sqlite-vec + FTS5 at ~/.openclaw/memory/{agentId}.sqlite
- Embeddings: OpenAI text-embedding-3-small (local fallback via node-llama-cpp)
- Browser: Playwright + Chrome for Testing 145 (headless)
- Local model: Ollama v0.16.1 with qwen3:8b (5.2GB, ~6.7 tok/sec)

## Archived Upstream Code

The `_archived/` directory contains all 1,800 files removed during Phase 1
(fork & strip). This is a read-only reference archive — nothing in it is built
or loaded at runtime. If a stripped feature needs to be restored (e.g. a channel
adapter or skill), copy the relevant files back to their original paths and
re-wire them into the build. See `_archived/README.md` for details.

## Known Issues / Post-Implementation

1. Security tests not yet run (`pnpm vitest run src/security/`)
2. AGENTS.md references old macOS paths — needs updating
3. TOOLS.md references old Clawdbot CLI commands — needs updating
4. 15 benign stale refs to deleted channels (dead code, no runtime impact)
5. browser.noSandbox = true (required for headless Linux, acceptable risk)
