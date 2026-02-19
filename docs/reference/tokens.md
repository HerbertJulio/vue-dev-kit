# Token Usage

Each operation has a different token cost depending on complexity. Use this table to estimate usage.

## Estimated Consumption

| Operation | Tokens | Notes |
|-----------|--------|-------|
| `/dev-create-component` | ~3-5k | Single component |
| `/dev-create-service` | ~5-8k | 4 files (types + contracts + adapter + service) |
| `/dev-create-composable` | ~3-5k | Single composable |
| `/dev-create-test` | ~3-8k | Depends on file complexity |
| `/dev-create-module` | ~15-25k | Full module scaffold |
| `/dev-generate-types` | ~3-5k | Types + contracts + adapter |
| `/review-check-architecture` | ~5-10k | 14 automated checks |
| `/review-review` | ~8-15k | Full review with automated + manual |
| `/review-fix-violations` | ~5-15k | Depends on violation count |
| `/docs-onboard` | ~3-5k | Module summary |
| `/migration-migrate-component` | ~5-10k | Single component migration |
| `@bug-hunter` | ~5-15k | Depends on bug complexity |
| `@code-archaeologist` | ~5-10k | Module exploration |
| `@performance-profiler` | ~5-10k | Performance analysis |
| `@migration-orchestrator` | ~30-80k | Full module migration (6 phases) |

::: tip Cost Optimization
For large modules, consider migrating incrementally — one component at a time with `/migration-migrate-component` instead of the full `@migration-orchestrator`.
:::
