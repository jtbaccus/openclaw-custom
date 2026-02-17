# Archived Upstream Code

This directory contains all files removed during the Phase 1 fork-and-strip
customization of OpenClaw. They are preserved here as a reference archive so
that any functionality can be restored if needed.

**These files are NOT active.** Nothing in `_archived/` is built, tested, or
loaded at runtime. To re-enable a feature, copy the relevant files back to
their original location in the project tree and wire them into the build.

## Contents

| Directory     | What it contains                                                                                 |
| ------------- | ------------------------------------------------------------------------------------------------ |
| `apps/`       | Native apps — Android (Kotlin), iOS (Swift), macOS (Swift), shared Swift framework               |
| `extensions/` | 29 channel adapters (Slack, Signal, WhatsApp, iMessage, Matrix, IRC, LINE, Teams, and more)      |
| `src/`        | Channel implementations (slack, whatsapp, signal, line, imessage), canvas host, TTS, web/baileys |
| `vendor/`     | Canvas/A2UI renderer framework (Angular + Lit renderers, JSON specs)                             |
| `skills/`     | 39 skill packages (1Password, Apple Notes, Notion, Spotify, Trello, etc.)                        |
| `Swabble/`    | macOS wake-word daemon (Swift)                                                                   |
| `packages/`   | Misc package files removed during cleanup                                                        |

## Origin

Extracted from git commit `ff31df309` (Phase 0, pre-deletion baseline) on
2026-02-17. The original deletions occurred in:

- **Phase 1A** (`37845213f`) — 1,713 files stripped
- **Phase 1B** (`072a3c261`) — 87 files stripped (src/web/ baileys adapter)

## Restoring a Feature

1. Identify the files you need from this archive
2. Copy them back to their original paths in the project root
3. Re-add any removed dependencies to `package.json`
4. Update `src/channels/registry.ts` and/or config schemas as needed
5. Run `pnpm install && pnpm build && pnpm test:fast` to verify
