# Quick Start

After [installing](/guide/installation) Vue Dev Kit, open Claude Code in your project and try these workflows.

## Onboarding — Understand an Existing Module

```bash
/docs-onboard marketplace
```

Or ask conversationally:

```
"Use @code-archaeologist to explain the auth module"
```

## Create a New Feature Module

```bash
/dev-create-module domains
```

Or with more context:

```
"Use @feature-builder to create the domains module with CRUD"
```

This scaffolds the full module structure:
```
src/modules/domains/
├── components/
├── composables/
├── services/
├── adapters/
├── stores/
├── types/
├── views/
└── index.ts
```

## Create a Single Component

```bash
/dev-create-component DomainsTable
```

## Create an API Integration

```bash
/dev-create-service domains
```

Creates 4 files: `types` + `contracts` + `adapter` + `service`.

## Create a Composable

```bash
/dev-create-composable useDomainsList
```

## Generate Types from an Endpoint

```bash
/dev-generate-types /v4/domains
```

## Review Before PR

```bash
# Full review:
/review-review

# Architecture checks only:
/review-check-architecture marketplace

# Auto-fix violations:
/review-fix-violations marketplace
```

## Migrate Legacy Code

```bash
# Single component (Options API → script setup):
/migration-migrate-component src/views/OldPage.vue

# Entire module:
/migration-migrate-module src/views/marketplace/
```

## Investigate a Bug

```
"Use @bug-hunter to investigate why the domains list isn't loading"
```

## What's Next

- [Architecture Overview](/guide/architecture) — Understand the patterns your code follows
- [Agents Reference](/reference/agents) — Detailed guide for each agent
- [Commands Reference](/reference/commands) — All available slash commands
