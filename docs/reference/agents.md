# Agents

Agents are specialized AIs that Claude delegates to automatically or that you invoke with `@name`.

## Development Agents

### @feature-builder

**When to use:** Create a new feature module from scratch.

Creates the entire modular structure bottom-up: types → adapter → service → store → composables → components → view → route → barrel export.

```
"Use @feature-builder to create the domains module with CRUD"
```

**Workflow:**
1. Understands requirements
2. Reads `ARCHITECTURE.md`
3. Scaffolds directories
4. Creates types and contracts
5. Creates adapter
6. Creates service
7. Creates store (if needed)
8. Creates composables
9. Creates components
10. Creates view
11. Registers route
12. Creates barrel export
13. Validates with `tsc --noEmit`

---

### @vue-component-creator

**When to use:** Create any Vue component — form, table, modal, list, card, or UI element.

```
"Use @vue-component-creator to create a DataTable component"
```

Determines the right location (module component vs shared), applies the script setup template, and ensures size limits.

---

### @service-creator

**When to use:** Create API integration (service + adapter + types).

```
"Use @service-creator for the /v4/domains endpoint"
```

Creates 4 files:
- `[resource].types.ts` — API response types
- `[resource].contracts.ts` — App contracts
- `[resource]-adapter.ts` — Parser functions
- `[resource]-service.ts` — HTTP calls

---

### @composable-creator

**When to use:** Create composables with Vue Query or shared logic.

```
"Use @composable-creator to fetch the domains list"
```

Provides templates for queries, mutations, and shared logic composables with proper Vue Query integration.

---

## Quality Agents

### @code-reviewer

**When to use:** Review code changes before merging, validate PRs.

```
"Use @code-reviewer to review my last commit"
```

**Checks:**
- Runs `tsc`, `eslint`, `vitest`, `build`
- Reviews against `ARCHITECTURE.md`
- Classifies issues:
  - 🔴 **Violations** — Must fix
  - 🟡 **Attention** — Should fix
  - 🟢 **Compliant** — Good
  - ✨ **Highlights** — Excellent patterns

**Verdict:** ✅ Approved | ⚠️ With caveats | ❌ Requires changes

---

### @bug-hunter

**When to use:** Investigate bugs, unexpected behavior, console errors.

```
"Use @bug-hunter to investigate the 500 error on login"
```

Traces through the architecture top-down: Component → Composable → Service → Adapter → API. Finds root causes, not workarounds.

---

## Analysis Agents

### @code-archaeologist

**When to use:** Explore existing code before changes, onboarding, mapping modules.

```
"Use @code-archaeologist to map src/modules/auth/"
```

Read-only exploration that produces:
- Structure inventory
- API style analysis
- Anti-pattern detection vs `ARCHITECTURE.md`
- Dependency mapping (fan-in/fan-out)

---

### @performance-profiler

**When to use:** Analyze performance before/after optimizations.

```
"Use @performance-profiler on the dashboard module"
```

Detects:
- Bundle size issues
- Missing lazy loading
- Queries without `staleTime`
- Deep watchers
- Heavy components
- Inline objects causing re-renders

---

## Migration Agents

### @migration-orchestrator

**When to use:** Migrate entire modules from legacy to target architecture.

```
"Use @migration-orchestrator to migrate the billing module"
```

**6-phase approach:**
1. **Analysis** — Map current state (delegates to `@code-archaeologist`)
2. **Structure** — Create target directories
3. **Types** — Extract types and contracts
4. **Services** — Create services and adapters
5. **State** — Migrate to Pinia + Vue Query
6. **Components** — Migrate to script setup
7. **Review** — Validate (delegates to `@code-reviewer`)

---

### @vue-component-migrator

**When to use:** Migrate a single component from Options API to script setup.

```
"Use @vue-component-migrator on UserSettings.vue"
```

**Conversion table:**
| Options API | Script Setup |
|------------|--------------|
| `props` | `defineProps<T>()` |
| `emits` | `defineEmits<T>()` |
| `data()` | `ref()` / `reactive()` |
| `computed` | `computed()` |
| `methods` | Functions |
| `watch` | `watch()` / `watchEffect()` |
| Mixins | Composables |

One component per commit. Decomposes if > 200 lines.
