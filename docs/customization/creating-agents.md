# Creating Agents

You can extend Vue Dev Kit by creating your own agents tailored to your project's needs.

## Agent File Structure

Create a file at `.claude/agents/[category]/agent-name.md`:

```markdown
---
name: my-agent
description: "MUST BE USED to [do X] whenever [condition]."
tools: Read, Write, Edit, Bash, Glob, Grep
---

# Agent Title

## Mission
One sentence describing what this agent does.

## Context
Read the following files before starting:
- `docs/ARCHITECTURE.md`

## Workflow
1. Step one
2. Step two
3. ...

## Rules
- Rule one
- Rule two

## Output
What the agent produces.
```

## Key Fields

### Frontmatter

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Agent identifier (used with `@name`) |
| `description` | Yes | When Claude should delegate to this agent |
| `tools` | Yes | Tools the agent can use |

::: tip Description Matters
The `description` field determines **when Claude automatically delegates** to your agent. Use strong language like "MUST BE USED" to ensure delegation.
:::

### Available Tools

| Tool | Purpose |
|------|---------|
| `Read` | Read files |
| `Write` | Create new files |
| `Edit` | Edit existing files |
| `Bash` | Run shell commands |
| `Glob` | Find files by pattern |
| `Grep` | Search file contents |

## Examples

### Testing Agent

```markdown
---
name: test-writer
description: "MUST BE USED to create tests whenever the user asks for tests or testing."
tools: Read, Write, Edit, Bash, Glob, Grep
---

# Test Writer

## Mission
Create comprehensive tests following project conventions.

## Context
- Read `docs/ARCHITECTURE.md` section 10 (checklists)
- Read existing tests in `__tests__/` for patterns

## Workflow
1. Read the target file
2. Identify what needs testing
3. Create test file in `__tests__/`
4. Run tests with `vitest run [file]`
5. Fix any failures

## Rules
- Adapters: test all transformations (highest priority)
- Composables: mock services, test reactive behavior
- Components: use @vue/test-utils, test user interactions
- Name: `[OriginalName].spec.ts`
```

### Deployment Agent

```markdown
---
name: deploy-checker
description: "MUST BE USED to validate before deployment whenever the user mentions deploy or release."
tools: Read, Bash, Glob, Grep
---

# Deploy Checker

## Mission
Validate the project is ready for deployment.

## Workflow
1. Run `npm run type-check`
2. Run `npm run lint`
3. Run `npm run test -- --run`
4. Run `npm run build`
5. Check for console.log / debugger statements
6. Report results

## Output
✅ Ready to deploy or ❌ Issues found (with details)
```

## Organization

Organize agents by category:

```
.claude/agents/
├── development/     ← Building features
├── quality/         ← Reviewing and testing
├── analysis/        ← Understanding code
└── orchestrators/   ← Multi-step workflows
```

## Tips

- Keep agents focused on **one responsibility**
- Always reference `ARCHITECTURE.md` for consistency
- Use `Bash` sparingly — prefer `Read`/`Write`/`Edit`
- Test your agent by asking Claude to use it: `"Use @my-agent to..."`
