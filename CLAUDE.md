# CLAUDE.md — Vue Dev Kit

## About

Development toolkit for Vue 3 projects with TypeScript. Includes AI agents, slash commands, and architectural patterns.

**Source of truth for patterns: `docs/ARCHITECTURE.md`**

## AI Team Configuration

**Important: YOU MUST USE subagents when available for the task.**
**Important: ALWAYS read docs/ARCHITECTURE.md before creating or modifying files.**

### Stack

- Vue 3 + `<script setup lang="ts">`
- Pinia (client state) + TanStack Vue Query (server state)
- Vite + TypeScript (strict) + Zod
- Vue Router 4
- Vitest + @vue/test-utils

### Available Agents

| Agent | When to Use |
|-------|-------------|
| `@feature-builder` | Create a new module/feature from scratch |
| `@vue-component-creator` | Create components following conventions |
| `@service-creator` | Create service + adapter + types for a resource |
| `@composable-creator` | Create composables with Vue Query |
| `@code-reviewer` | Review code / PRs |
| `@bug-hunter` | Investigate and fix bugs |
| `@code-archaeologist` | Map existing code before changing it |
| `@performance-profiler` | Analyze performance |
| `@migration-orchestrator` | Migrate legacy module to new architecture |
| `@vue-component-migrator` | Migrate component from Options → script setup |

### Available Slash Commands

| Command | What it does |
|---------|-------------|
| `/create-module [name]` | Full module scaffold |
| `/create-component [name]` | Create component with standard template |
| `/create-service [name]` | Create service + adapter + types |
| `/create-composable [name]` | Create composable with Vue Query |
| `/create-test [file]` | Create tests for a file |
| `/review` | Full code review against ARCHITECTURE.md |
| `/check-architecture` | Validate conformance with ARCHITECTURE.md |
| `/fix-violations` | Find and fix architecture violations |
| `/migrate-component [file]` | Migrate component Options → setup |
| `/migrate-module [path]` | Migrate entire module |
| `/generate-types [endpoint]` | Generate types/contracts/adapter from endpoint |
| `/onboard [module]` | Quick module overview for onboarding |

### Key Patterns (details in docs/ARCHITECTURE.md)

- **Services**: HTTP only, no try/catch, no transformation
- **Adapters**: pure functions, API ↔ App, snake_case → camelCase
- **Types**: `.types.ts` (API raw) + `.contracts.ts` (app contract)
- **Composables**: orchestrate service → adapter → Vue Query
- **Pinia Stores**: client state only
- **Components**: script setup, composition pattern, < 200 lines
- **Utils**: pure functions | **Helpers**: with side effects
- **Modules**: don't import from each other
