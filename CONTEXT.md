# OpenClaw Custom Fork — CONTEXT.md

*Project: openclaw-custom | Created: 2026-02-14*

## What This Is

A trimmed fork of OpenClaw (github.com/openclaw/openclaw) customized as Jon's personal AI assistant. Strips all unwanted channels, skills, and platform adapters. Keeps: Telegram + Discord, tiered model routing, long-term memory, multi-agent routing, browser automation, scheduled heartbeats.

## Architecture Decisions

1. **Fork and trim** (not rewrite) — inherits battle-tested security infrastructure
2. **Telegram + Discord only** — 12 other channel adapters stripped
3. **4-tier model routing:** Ollama (free) → DeepSeek ($0.14/M) → Sonnet ($3/M) → Opus ($15/M)
4. **4 agents:** Turing (main), Turing-Code, Turing-Research, Pulse (heartbeat)
5. **Heartbeats on local Ollama** — zero cost for scheduled tasks
6. **Workspace:** ~/turing/clawd/ (shared with existing Clawdbot files)

## Current Status

- Phase 0: Project Scaffolding ✅
- Phase 1: Fork & Strip ✅ (build passes, 100% tests, gateway starts)
- Phase 2: Model Routing — IN PROGRESS
- Phase 3: Channel Setup — IN PROGRESS
- Phases 4-10: Pending

## Tech Stack

- Runtime: Node.js 22+
- Language: TypeScript
- Package manager: pnpm (monorepo)
- Session storage: JSONL
- Memory: SQLite + vector embeddings (text-embedding-3-small) + FTS5
- Browser: Playwright (headless)

## Key Files

- `openclaw.json` — main configuration (providers, channels, agents, skills, cron)
- `src/channels/registry.ts` — channel registration
- `src/agents/` — agent pipeline and tool execution
- `src/memory/` — memory backends
- `~/turing/clawd/SOUL.md` — personality file (workspace injection)

## Known Risks

1. Import breakage after Phase 1 deletions — expect 2-3 build iterations
2. DeepSeek tool calling quality — test early, fall back to Sonnet if needed
3. Local model (Qwen3 30B) tool calling — verify before relying on for heartbeats
