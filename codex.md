# codex.md - OpenClaw Custom

Inherit the workspace rules from `/home/jtbaccus/turing/codex.md`.

## Project Profile

- TypeScript ESM monorepo for OpenClaw customization work.
- Runtime baseline: Node 22+.
- Preferred package manager: `pnpm`. Bun is also supported for TypeScript execution.

## Commands

- `pnpm install`
- `pnpm build`
- `pnpm tsgo`
- `pnpm check`
- `pnpm test`

## Repository Rules

- Do not use `git stash` or `git worktree`.
- Do not switch branches unless explicitly asked.
- Use `scripts/committer "<msg>" <file...>` for scoped commits.
- Do not change patched dependencies or Carbon without explicit approval.
- Do not rebuild the macOS app over SSH.

## Working Rules

- Respect multi-agent safety and keep changes tightly scoped.
- Consider all built-in and extension channels when refactoring shared routing or channel behavior.
- Keep docs links root-relative in Mintlify docs, but use full `https://docs.openclaw.ai/...` URLs when reporting links to the user.
