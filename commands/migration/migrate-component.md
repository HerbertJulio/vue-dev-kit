Migre um componente Vue de Options API para `<script setup lang="ts">` seguindo `docs/ARCHITECTURE.md` seção 5.

Componente: $ARGUMENTS

## Passos

1. Leia `docs/ARCHITECTURE.md` seção 5.

2. Analise o componente:
   - Conte linhas (template, script, style)
   - Liste: props, emits, data, computed, watch, methods, mixins
   - Mapeie quem importa este componente

3. Converta para `<script setup lang="ts">`:
   - `props` → `defineProps<T>()`
   - `emits` → `defineEmits<T>()`
   - `data()` → `ref()` / `reactive()`
   - `computed:` → `computed()`
   - `watch:` → `watch()`
   - `methods:` → `function`
   - `mounted()` → `onMounted()`
   - `mixins: []` → extrair para composable `useXxx()`

4. Aplique composition pattern se houver prop drilling.

5. Decomponha se > 200 linhas.

6. Valide:
```bash
npx tsc --noEmit
npx vite build
npx vitest run --passWithNoTests
```
