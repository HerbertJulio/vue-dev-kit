# Vue Dev Kit — AI Development Team for Vue 3 🚀

**Supercharge [Claude Code](https://docs.anthropic.com/en/docs/claude-code) with specialized AI agents for Vue 3 development.** Scaffold modules, review architecture, migrate legacy code, and hunt bugs — all following your project's conventions automatically.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/HerbertJulio/vue-dev-kit?style=social)](https://github.com/HerbertJulio/vue-dev-kit/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/HerbertJulio/vue-dev-kit?style=social)](https://github.com/HerbertJulio/vue-dev-kit/network/members)

---

## ⚠️ Token Consumption Notice

Agents consume tokens proportional to their complexity. For budget-conscious usage, Vue Dev Kit ships with **Lite agents** that use `model: haiku` — **significantly cheaper per token**.

| Mode | Model | Module scaffold | Code review | Bug investigation |
|------|-------|----------------|-------------|-------------------|
| **Full** | Sonnet/Opus | ~15-25k tokens | ~8-15k tokens | ~5-10k tokens |
| **Lite** | Haiku | ~5-10k tokens | ~3-5k tokens | ~2-5k tokens |

Full agents read `ARCHITECTURE.md`, run validation, and produce detailed output. Lite agents embed key rules inline and skip validation steps.

---

## 📑 Table of Contents

- [Quick Start](#-quick-start)
- [Meet Your Vue Dev Team](#-meet-your-vue-dev-team)
- [Slash Commands](#-slash-commands)
- [Architecture at a Glance](#-architecture-at-a-glance)
- [Lite Mode](#-lite-mode--lower-token-usage)
- [Optional: Context7 MCP](#-optional-context7-mcp)
- [Customization](#-customization)
- [Documentation](#-documentation)
- [Contributing](#-contributing)

---

## 🚀 Quick Start

**1. Clone the kit**

```bash
git clone https://github.com/HerbertJulio/vue-dev-kit.git
```

**2. Install into your Vue project**

<details>
<summary><b>macOS / Linux</b></summary>

```bash
cd /path/to/your-vue-project
bash /path/to/vue-dev-kit/setup.sh
```

</details>

<details>
<summary><b>Windows (PowerShell)</b></summary>

```powershell
cd C:\path\to\your-vue-project
bash C:\path\to\vue-dev-kit\setup.sh
```

</details>

> Use `setup.sh --lite` to install Lite agents (Haiku model, lower cost).

**3. Start building**

```bash
claude
"Use @vue-builder to create a domains module with CRUD"
```

---

## 👥 Meet Your Vue Dev Team

### 🏗️ @vue-builder — Build New Code

Creates modules, components, services, composables, and tests following your architecture.

**Detects scope automatically:** module | component | service | composable | test

```bash
"Use @vue-builder to create the payments module with CRUD"
"Use @vue-builder to create a DataTable component"
"Use @vue-builder to create the /v4/domains service layer"
"Use @vue-builder to create tests for the domains adapter"
```

---

### ✅ @vue-reviewer — Review & Analyze

Reviews code against `ARCHITECTURE.md`, explores modules, and detects performance issues.

**Detects scope automatically:** review | explore | performance

```bash
"Use @vue-reviewer to review my last commit"
"Use @vue-reviewer to explore src/modules/auth/"
"Use @vue-reviewer to check performance of the dashboard module"
```

**Review output:** 🔴 Violations | 🟡 Attention | 🟢 Compliant | ✨ Highlights → Verdict: ✅/⚠️/❌

---

### 🔄 @vue-migrator — Modernize Legacy Code

Migrates Options API → script setup, JS → TS, and full module modernization.

**Detects scope automatically:** module (6 phases) | component

```bash
"Use @vue-migrator to migrate the billing module"
"Use @vue-migrator to convert UserSettings.vue to script setup"
```

**Module mode:** Analysis → Structure → Types → Services → State → Components (with approval gates)

---

### 🔍 @vue-doctor — Investigate Bugs

Traces bugs through architecture layers to find root causes, not workarounds.

**Trace path:** Component → Composable → Adapter → Service → API

```bash
"Use @vue-doctor to investigate the 500 error on login"
"Use @vue-doctor to find why the dashboard data is stale"
```

---

## ⚡ Slash Commands

Quick shortcuts you invoke with `/command` in Claude Code.

### Development

| Command | What it does |
|---------|-------------|
| `/dev-create-module [name]` | Full module scaffold (delegates to agents) |
| `/dev-create-component [name]` | Component with script setup template |
| `/dev-create-service [resource]` | Types + contracts + adapter + service |
| `/dev-create-composable [name]` | Composable with Vue Query integration |
| `/dev-create-test [file]` | Tests for adapter, composable, or component |
| `/dev-generate-types [endpoint]` | Types + contracts + adapter from endpoint/JSON |

### Quality

| Command | What it does |
|---------|-------------|
| `/review-review [scope]` | Full code review (automated + manual) |
| `/review-check-architecture [module]` | Automated conformance checks |
| `/review-fix-violations [module]` | Auto-fix violations by priority |

### Migration

| Command | What it does |
|---------|-------------|
| `/migration-migrate-component [file]` | Options API → script setup |
| `/migration-migrate-module [path]` | Full module migration (6 phases) |

### Documentation

| Command | What it does |
|---------|-------------|
| `/docs-onboard [module]` | 2-minute module overview for onboarding |

---

## 🏛️ Architecture at a Glance

All agents enforce this four-layer architecture:

```
Service (HTTP only) → Adapter (parse) → Composable (orchestrate) → Component (UI)
```

```
src/modules/[feature]/
├── types/          .types.ts (API snake_case) + .contracts.ts (app camelCase)
├── adapters/       Pure functions: API ↔ App conversion
├── services/       HTTP calls only — no try/catch, no transformation
├── composables/    Orchestrate service→adapter→Vue Query
├── stores/         Client state only (Pinia) — NOT server state
├── components/     <script setup lang="ts">, < 200 lines
├── views/          Compose components with slots + provide/inject
└── index.ts        Barrel export (public API only)
```

**Key rules:**
- Modules don't import from each other (use `shared/` for cross-cutting)
- **Pinia** = client state (UI, filters) | **Vue Query** = server state (API data)
- Services: no try/catch, no data transformation
- Adapters: pure functions, bidirectional (snake_case ↔ camelCase)
- Components: `<script setup lang="ts">`, typed props/emits, < 200 lines

> Full guide: [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) — this is the source of truth that all agents read.

---

## 🪶 Lite Mode — Lower Token Usage

For cost-conscious usage or simpler tasks, install Lite agents:

```bash
bash /path/to/vue-dev-kit/setup.sh --lite
```

Lite agents use `model: haiku` in their frontmatter, which means Claude Code runs them on the **Haiku model** instead of Sonnet/Opus — significantly cheaper.

| Aspect | Full | Lite |
|--------|------|------|
| **Model** | Sonnet/Opus (default) | Haiku |
| **First action** | Reads ARCHITECTURE.md | Rules inline |
| **Validation** | tsc, build, vitest | Skipped |
| **Size** | ~80-120 lines | ~30-50 lines |
| **Cost** | ~5-25k tokens | ~2-10k tokens |

**Same agents, same names:**

| Lite Agent | What it does |
|-----------|-------------|
| @vue-builder | Create modules, components, services, composables, tests |
| @vue-reviewer | Review code, explore modules, check performance |
| @vue-migrator | Migrate Options → setup, modernize modules |
| @vue-doctor | Investigate bugs, trace errors |

> **When to use Full vs Lite?**
> - **Full**: new modules, PRs, complex migrations, onboarding
> - **Lite**: quick scaffolding, small components, rapid iterations

---

## 🔌 Optional: Context7 MCP

For enhanced documentation access, add the [Context7 MCP server](https://github.com/upstash/context7). It gives Claude real-time access to up-to-date documentation for Vue 3, Pinia, TanStack Query, Vite, and other libraries in your stack.

### Setup

Add to your Claude Code MCP config (`~/.claude/mcp.json`):

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    }
  }
}
```

### Why it helps

- Agents get **current API docs** instead of relying on training data
- Reduces hallucination for Vue 3, Pinia, and TanStack Query APIs
- Especially useful for `@vue-builder` which generates framework-specific code
- Works with both Full and Lite agents

---

## 🔧 Customization

### Add an Agent

Create `.claude/agents/my-agent.md`:

```markdown
---
name: my-agent
description: "MUST BE USED to [do X] whenever [condition]."
tools: Read, Write, Edit, Bash, Glob, Grep
---

# Title

## Mission
One sentence.

## Workflow
1. ...

## Rules
- ...
```

### Add a Command

Create `.claude/commands/[category]/my-command.md`:

```markdown
Description of what to do.

Argument: $ARGUMENTS

## Steps
1. ...
```

### Edit Architecture Patterns

Edit `docs/ARCHITECTURE.md` — all agents read this file before acting. Changes take effect immediately, no restart needed.

---

## 📚 Documentation

Full docs are available via VitePress:

```bash
cd vue-dev-kit
npm install && npm run docs:dev
```

- [Introduction](docs/guide/introduction.md)
- [Installation](docs/guide/installation.md)
- [Quick Start](docs/guide/quick-start.md)
- [Architecture Guide](docs/guide/architecture.md)
- [Responsibility Layers](docs/guide/layers.md)
- [Component Patterns](docs/guide/components.md)
- [Agents Reference](docs/reference/agents.md)
- [Commands Reference](docs/reference/commands.md)
- [Creating Agents](docs/customization/creating-agents.md)
- [Creating Commands](docs/customization/creating-commands.md)

---

## 💬 Contributing

Contributions are welcome!

- ⭐ **Star** this repo if you find it useful
- 🐛 **Issues** — Report bugs or suggest improvements
- 🔀 **Pull Requests** — New agents, commands, or pattern improvements
- 💡 **Discussions** — Share how you've customized Vue Dev Kit

```bash
git checkout -b feature/my-feature
git commit -m 'feat: add my feature'
git push origin feature/my-feature
# Open a Pull Request
```

---

## 📄 License

MIT — Use freely. See [LICENSE](LICENSE).

---

<p align="center">
  <b>Built for the Vue 3 community by developers who use Claude Code every day.</b><br/>
  <a href="https://github.com/HerbertJulio/vue-dev-kit">GitHub</a> · <a href="docs/guide/introduction.md">Docs</a> · <a href="https://github.com/HerbertJulio/vue-dev-kit/issues">Issues</a>
</p>
