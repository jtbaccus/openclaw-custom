# OpenClaw Custom Fork — UPGRADE-PATH.md

*Source of truth for implementation progress. Update checkboxes as phases complete.*

## Phase 0: Project Scaffolding ✅
- [x] Fork openclaw/openclaw to jtbaccus/openclaw-custom
- [x] Add as git submodule under projects/
- [x] Create CONTEXT.md
- [x] Create UPGRADE-PATH.md (this file)
- [x] Update projects/_index.md
- [x] Log to activity-log.md

## Phase 1: Fork & Strip ✅
**Goal:** Remove unwanted channels/features/native apps; verify build passes.

Build: PASS | Tests: 534/534 (100%) | Gateway: starts cleanly

### Directories to DELETE entirely:
- [x] apps/android/, apps/ios/, apps/macos/, apps/shared/
- [x] Swabble/ (Swift wake-word daemon)
- [x] vendor/a2ui/ (Canvas)
- [x] src/canvas-host/, src/tts/
- [x] src/whatsapp/, src/slack/, src/imessage/, src/line/

### Extensions to DELETE (keep: telegram, discord, memory-core, memory-lancedb, llm-task, thread-ownership, diagnostics-otel):
- [x] All others (bluebubbles, copilot-proxy, device-pair, feishu, google-antigravity-auth, google-gemini-cli-auth, googlechat, imessage, irc, line, lobster, matrix, mattermost, minimax-portal-auth, msteams, nextcloud-talk, nostr, open-prose, phone-control, qwen-portal-auth, signal, slack, talk-voice, tlon, twitch, voice-call, whatsapp, zalo, zalouser)

### Skills to DELETE (keep: coding-agent, discord, github, healthcheck, himalaya, model-usage, session-logs, skill-creator, summarize, tmux, weather):
- [x] All others (1password, apple-notes, apple-reminders, bear-notes, blogwatcher, blucli, bluebubbles, camsnap, canvas, clawhub, eightctl, food-order, gemini, gifgrep, gog, goplaces, imsg, mcporter, nano-banana-pro, nano-pdf, notion, obsidian, openai-image-gen, openai-whisper-api, openai-whisper, openhue, oracle, ordercli, peekaboo, sag, sherpa-onnx-tts, slack, songsee, sonoscli, spotify-player, things-mac, trello, video-frames, voice-call, wacli)

### Fix broken imports:
- [x] src/channels/registry.ts — remove deleted channel registrations
- [x] src/config/zod-schema.channels.ts — strip removed channel schemas
- [x] src/config/types.*.ts — delete channel-specific type files
- [x] src/agents/tools/ — remove channel-specific action files
- [x] package.json — remove unused deps
- [x] pnpm-workspace.yaml — remove deleted extension/package refs
- [x] Remove macOS/Windows daemon code (keep systemd only)
- [x] Remove iOS/Android/macOS build scripts

### Verify:
- [x] pnpm install succeeds
- [x] pnpm build compiles without errors
- [x] pnpm test:fast passes
- [x] Gateway starts: node scripts/run-node.mjs --dev gateway

## Phase 2: Model Routing ⬜
- [ ] Configure providers in openclaw.json (Ollama, DeepSeek, Anthropic)
- [ ] Set environment variables
- [ ] Create src/routing/model-router.ts — auto-escalation logic
- [ ] Hook router into src/agents/model-selection.ts
- [ ] Configure skills/model-usage/ for cost tracking
- [ ] Verify: simple msg → DeepSeek; /think high → Opus; heartbeat → Ollama

## Phase 3: Channel Setup ⬜
- [ ] Configure Telegram (token, allowedUsers, polling)
- [ ] Configure Discord (token, applicationId)
- [ ] Set up agent bindings
- [ ] Verify all channels working + unauthorized users blocked

## Phase 4: Memory & Persistence ⬜
- [ ] Verify JSONL session storage
- [ ] Configure SQLite memory with embeddings
- [ ] Enable hybrid search (vector + FTS5)
- [ ] Verify context compaction at 80%
- [ ] Verify remember/recall works
- [ ] Verify session persistence across restarts

## Phase 5: Multi-Agent Routing ⬜
- [ ] Define 4 agents in openclaw.json
- [ ] Create SOUL-coder.md and SOUL-research.md
- [ ] Configure agent bindings
- [ ] Verify agent switching and inter-agent delegation

## Phase 6: Browser Automation ⬜
- [ ] Verify Playwright deps after trim
- [ ] Install Chromium
- [ ] Configure browser in openclaw.json
- [ ] Verify headless web search works on Linux

## Phase 7: Heartbeats & Scheduled Tasks ⬜
- [ ] Install Ollama + Qwen3 30B
- [ ] Configure cron jobs
- [ ] Verify heartbeat, morning brief, memory maintenance

## Phase 8: Clawdbot Migration ⬜
- [ ] Workspace file auto-injection (SOUL.md, USER.md, etc.)
- [ ] Ingest memory/*.md into SQLite
- [ ] Ingest activity-log.md history
- [ ] Verify personality and memory retrieval

## Phase 9: Security Audit ⬜
- [ ] Three-tier approval model
- [ ] Skill allowlist
- [ ] Localhost-only gateway
- [ ] No telemetry/beacons
- [ ] No broken refs to deleted channels
- [ ] No unexpected outbound connections

## Phase 10: Deployment ⬜
- [ ] systemd unit file
- [ ] Ollama service enabled
- [ ] Healthcheck monitoring
- [ ] Backup script (daily cron)
- [ ] Verify auto-start and auto-restart
