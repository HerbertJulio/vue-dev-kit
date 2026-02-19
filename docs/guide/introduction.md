# Introduction

## What is Vue Dev Kit?

Vue Dev Kit is an open-source collection of **agents**, **slash commands**, and **architectural conventions** designed for [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

Once installed in your Vue project, Claude automatically follows your architecture rules, generates consistent code, reviews PRs, migrates legacy code, and more.

**It's not a library or framework** — it's a set of markdown instructions that make Claude Code work like a senior Vue developer who knows your codebase conventions.

## What You Get

| Feature | Count | Description |
|---------|-------|-------------|
| AI Agents | 10 | Specialized subagents for building, reviewing, analyzing, and migrating |
| Slash Commands | 13 | Shortcuts to scaffold and validate code |
| Architecture Guide | 1 | Comprehensive source of truth for all patterns |
| Automated Checks | 14 | Conformance validations against your architecture |

## Target Stack

Vue Dev Kit is designed for projects using:

- Vue 3 + `<script setup lang="ts">`
- Pinia (client state) + TanStack Vue Query (server state)
- Vite + TypeScript (strict) + Zod
- Vue Router 4
- Vitest + @vue/test-utils

::: tip Flexible
You can adapt the patterns to your own stack by editing `docs/ARCHITECTURE.md`. All agents read this file before acting.
:::

## How It Works

1. **Install** the kit into your Vue project (copies markdown files)
2. **Open Claude Code** in your project
3. **Use agents and commands** — Claude automatically delegates to the right specialist

```
You: "Create a domains module with CRUD"
                    ↓
Claude delegates to @feature-builder
                    ↓
@feature-builder reads ARCHITECTURE.md
                    ↓
Scaffolds: types → adapter → service → composable → components → view → route
```

## Next Steps

- [Installation](/guide/installation) — Set up Vue Dev Kit in your project
- [Quick Start](/guide/quick-start) — Start using agents and commands
- [Architecture Overview](/guide/architecture) — Understand the patterns
