# Agents

Agents are specialized AIs that Claude delegates to automatically or that you invoke with `@name`.

Vue Dev Kit includes **4 consolidated agents**, each handling multiple scopes via automatic detection.

## @vue-builder — Build New Code

**When to use:** Create any new code — modules, components, services, composables, or tests.

**Scope detection:** module | component | service | composable | test

```bash
"Use @vue-builder to create the payments module with CRUD"
"Use @vue-builder to create a DataTable component"
"Use @vue-builder to create the /v4/domains service layer"
"Use @vue-builder to create tests for the domains adapter"
```

### Module mode

1. Asks: resource name, endpoints, UI type, client state needs
2. Scaffolds `src/modules/[kebab-name]/` with all subdirectories
3. Creates bottom-up: types → contracts → adapter → service → store → composables → components → view
4. Registers lazy route, creates barrel export
5. Validates with `tsc --noEmit`

### Component mode

- Places in `src/modules/[feature]/components/` or `src/shared/components/`
- `<script setup lang="ts">` with typed defineProps/defineEmits
- < 200 lines, no prop drilling

### Service mode

Creates 4 files:
- `.types.ts` — API response types (snake_case)
- `.contracts.ts` — App contracts (camelCase)
- `-adapter.ts` — Pure bidirectional parser
- `-service.ts` — HTTP calls only

### Composable mode

- **Query**: useQuery with reactive queryKey, staleTime, adapter
- **Mutation**: useMutation with invalidateQueries
- **Shared logic**: ref/computed with lifecycle hooks

### Test mode

Priority: adapters (pure, easy) > composables (mock service) > components (@vue/test-utils)

---

## @vue-reviewer — Review & Analyze

**When to use:** Review code changes, explore modules, analyze performance.

**Scope detection:** review | explore | performance

```bash
"Use @vue-reviewer to review my last commit"
"Use @vue-reviewer to explore src/modules/auth/"
"Use @vue-reviewer to check performance of the dashboard"
```

### Review mode

- Runs automated checks: `tsc`, `eslint`, `vitest`, `build`
- Pattern checks against `ARCHITECTURE.md`
- Classification: 🔴 Violation | 🟡 Attention | 🟢 Compliant | ✨ Highlight
- **Verdict:** ✅ Approved | ⚠️ With caveats | ❌ Requires changes

### Explore mode

- Inventories files by type
- Detects Options vs setup, JS vs TS, mixins, anti-patterns
- Maps dependencies (fan-in / fan-out)
- Read-only report with facts and numbers

### Performance mode

- Bundle size analysis via `vite build`
- Lazy loading verification
- Queries without staleTime
- Deep watchers, inline template objects
- Bottlenecks sorted by user impact

::: tip Read-only
The reviewer never modifies files. It suggests fixes with code snippets you can apply.
:::

---

## @vue-migrator — Modernize Legacy Code

**When to use:** Migrate Options API → script setup, JS → TS, or full module modernization.

**Scope detection:** module (6 phases) | component

```bash
"Use @vue-migrator to migrate the billing module"
"Use @vue-migrator to convert UserSettings.vue to script setup"
```

### Module mode (6 phases)

1. **Analysis** — Map current state: file counts, Options vs setup, JS vs TS, mixins
2. **Structure** — Create target directories
3. **Types & Adapters** — .types.ts + .contracts.ts + adapter
4. **Services** — Extract HTTP to pure services
5. **State** — Server state → Vue Query, client state → Pinia
6. **Components** — Convert to `<script setup lang="ts">`

Order is bottom-up. User approval required between phases.

### Component mode

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
| `this.$emit` | `emit()` |
| `this.$refs` | `useTemplateRef()` |

Decomposes if > 200 lines. Updates consumers if API changes.

---

## @vue-doctor — Investigate Bugs

**When to use:** Investigate bugs, unexpected behavior, console errors, broken features.

```bash
"Use @vue-doctor to investigate the 500 error on login"
"Use @vue-doctor to find why the dashboard data is stale"
```

### Trace path (top-down)

```text
Component → Composable → Adapter → Service → API
```

At each layer, the doctor checks:

| Layer | Checks |
|-------|--------|
| **Component** | Props correct? Emits firing? Reactive bindings? |
| **Composable** | queryKey reactive? staleTime? Service params? Adapter applied? |
| **Adapter** | Transformation correct? Missing fields? Wrong types? |
| **Service** | URL correct? HTTP method? Params format? |
| **API** | Response shape changed? Fields added/removed? |

::: warning Root cause only
The doctor fixes at the root layer, never patches symptoms. If a bug is in the adapter, it fixes the adapter — not the component.
:::

---

## Full vs Lite Agents

All 4 agents have Lite versions that use `model: haiku` for lower cost.

| Aspect | Full | Lite |
|--------|------|------|
| **Model** | Sonnet/Opus | Haiku |
| **First action** | Reads ARCHITECTURE.md | Rules inline |
| **Validation** | tsc, build, vitest | Skipped |
| **Size** | ~80-120 lines | ~30-50 lines |
| **Cost** | ~5-25k tokens | ~2-10k tokens |

Install lite agents with:

```bash
bash /path/to/vue-dev-kit/setup.sh --lite
```
