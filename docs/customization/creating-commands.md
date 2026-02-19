# Creating Commands

Slash commands are shortcuts that users invoke with `/command` inside Claude Code.

## Command File Structure

Create a file at `.claude/commands/[category]/my-command.md`:

```markdown
Description of what this command does.

Argument: $ARGUMENTS

## Steps
1. First step
2. Second step
3. ...

## Rules
- Rule one
- Rule two
```

The `$ARGUMENTS` placeholder is replaced with whatever the user types after the command name.

## Examples

### Scaffold Command

```markdown
Create a new utility function following project conventions.

Argument: $ARGUMENTS (utility name and description)

## Steps
1. Read `docs/ARCHITECTURE.md` section 6 (Utils vs Helpers)
2. Determine if this is a util (pure function) or helper (side effects)
3. Create the file in the appropriate directory:
   - Utils: `src/shared/utils/[name].ts`
   - Helpers: `src/shared/helpers/[name]-helper.ts`
4. Add proper TypeScript types
5. Create test file in `src/shared/__tests__/`
6. Run `tsc --noEmit` to validate

## Rules
- Utils must be pure functions (no side effects)
- Helpers can have side effects (DOM, localStorage, etc.)
- Export individual functions, not default exports
- Include JSDoc for public functions
```

### Validation Command

```markdown
Check if the current branch is ready for a pull request.

## Steps
1. Run `tsc --noEmit` — check for type errors
2. Run `eslint .` — check for lint issues
3. Run `vitest run` — run all tests
4. Run `npm run build` — verify build succeeds
5. Search for `console.log` and `debugger` statements
6. Check for files > 200 lines in changed files
7. Produce a summary report

## Output Format
### PR Readiness Report
- ✅ Types: OK / ❌ Types: N errors
- ✅ Lint: OK / ❌ Lint: N warnings
- ✅ Tests: OK / ❌ Tests: N failures
- ✅ Build: OK / ❌ Build: Failed
- ✅ Clean: OK / ❌ Debug artifacts found
```

### Documentation Command

```markdown
Generate API documentation for a module.

Argument: $ARGUMENTS (module name)

## Steps
1. Find the module at `src/modules/$ARGUMENTS/`
2. Read all files in the module
3. Document:
   - Public API (from index.ts)
   - Available composables and their return types
   - Service endpoints
   - Contract types
4. Output as markdown

## Rules
- Only document the public API
- Include usage examples for composables
- List all query keys for cache management
```

## Organization

Organize commands by category:

```
.claude/commands/
├── dev/             ← Scaffolding and generation
├── review/          ← Code quality and validation
├── migration/       ← Legacy code migration
└── docs/            ← Documentation generation
```

## How Commands Become Slash Commands

The file path determines the command name:

```
.claude/commands/dev/create-module.md   → /dev-create-module
.claude/commands/review/check-arch.md   → /review-check-arch
.claude/commands/docs/onboard.md        → /docs-onboard
```

Category folder + file name, joined by `-`.

## Tips

- Keep commands **focused** — one action per command
- Use `$ARGUMENTS` for user input
- Reference `ARCHITECTURE.md` for consistency
- Include a clear output format
- For complex multi-step workflows, consider creating an agent instead
