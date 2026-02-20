# Installation

## Prerequisites

- A Vue 3 project with `package.json`
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed

## Install

```bash
# Clone the kit
git clone https://github.com/HerbertJulio/vue-dev-kit.git

# Go to your Vue project
cd /path/to/your-vue-project

# Run the installer
/path/to/vue-dev-kit/setup.sh
```

## What Gets Installed

The installer creates the following in your project:

```text
.claude/
├── agents/              ← 4 AI subagents
│   ├── vue-builder.md
│   ├── vue-reviewer.md
│   ├── vue-migrator.md
│   └── vue-doctor.md
└── commands/            ← 12 slash commands
    ├── dev/
    │   ├── create-module.md
    │   ├── create-component.md
    │   ├── create-service.md
    │   ├── create-composable.md
    │   ├── create-test.md
    │   └── generate-types.md
    ├── review/
    │   ├── review.md
    │   ├── check-architecture.md
    │   └── fix-violations.md
    ├── migration/
    │   ├── migrate-component.md
    │   └── migrate-module.md
    └── docs/
        └── onboard.md
docs/
└── ARCHITECTURE.md      ← Source of truth for patterns
CLAUDE.md                ← Project config for Claude
```

::: warning Non-destructive
The installer **never overwrites** existing `ARCHITECTURE.md` or `CLAUDE.md` files. If they already exist, they are skipped.
:::

## Lite Installation

For lower token consumption, install Lite agents that run on the Haiku model:

```bash
/path/to/vue-dev-kit/setup.sh --lite
```

Lite agents have the same names and capabilities but use `model: haiku` in their frontmatter, resulting in significantly lower cost per invocation.

## Verify Installation

```bash
claude
# Check agents are loaded:
/agents
# Try a command:
/review-check-architecture
```

## Next Steps

- [Quick Start](/guide/quick-start) — Start using agents and commands
- [Customization](/customization/creating-agents) — Adapt the kit to your project
