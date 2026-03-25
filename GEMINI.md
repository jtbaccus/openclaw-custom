# GEMINI.md - OpenClaw Custom

## Foundational Mandates (Global)

This project inherits all global mandates from the root `GEMINI.md`.

### Workflow: ACE (Research -> Plan -> Implement)

**CRITICAL:** ACE always stands for **Research -> Plan -> Implement**.

- **Research (R):** Explore the codebase, identify constraints, and understand dependencies _before_ proposing a solution.
- **Plan (P):** Create a step-by-step implementation plan with verification procedures.
- **Implement (I):** Execute the plan incrementally, verifying each step.
- Follow this workflow for all complex or architectural tasks.

### Academic Integrity: ABSOLUTE GUARDRAIL

**NEVER generate substantive academic content without source material.**

- **Scaffolding only:** You may create section headings, status labels, checklists, and planning artifacts.
- **No Fabricated Content:** Do not write background paragraphs, methodology claims, results, or novelty assertions unless directly grounded in provided source material (e.g., `Protocol Manual.docx`, `CONTEXT.md`).
- **Mark Gaps:** Label empty sections as "AWAITING" and specify the required source material.

### Communication Style: Terse & Direct

- **Be Terse:** Every word should earn its place. Prefer lists over paragraphs.
- **No Filler:** Skip pleasantries, hedging, and sign-offs.
- **Jarvis-Style:** Be a competent "junior faculty / project collaborator." Flag uncertainty explicitly.
- **Absolute Paths:** Always use absolute paths for file operations to ensure reliability.

---

## Project-Specific Details

### Tech Stack

- **Runtime:** Node 22+, Bun
- **Language:** TypeScript (ESM)
- **Package Manager:** pnpm
- **Tools:** Oxlint, Oxfmt, Vitest

### Build & Dev Commands

- `pnpm install` - Install dependencies
- `pnpm build` - Type-check and build
- `pnpm test` - Run Vitest tests
- `pnpm check` - Lint and format check

### Repository Guidelines

- **Multi-agent safety:** Do not use `git stash` or `git worktree`. Focus on your changes only.
- **Commit Style:** Use `scripts/committer "<msg>" <file...>` for scoped staging.
- **File Size:** Keep files concise, ideally under ~700 LOC.
- **Documentation:** Root-relative internal doc links; avoid em dashes and apostrophes in headings.
- **Builds:** Do not rebuild the macOS app over SSH; must be done directly on the Mac.
