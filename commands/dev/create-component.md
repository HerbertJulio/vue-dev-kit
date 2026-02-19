Crie um componente Vue seguindo `docs/ARCHITECTURE.md` seção 5.

Componente: $ARGUMENTS

## Passos

1. Leia `docs/ARCHITECTURE.md` seção 5.

2. Determine o tipo:
   - **Feature component** → `src/modules/[modulo]/components/NomeComponente.vue`
   - **Shared component** → `src/shared/components/NomeComponente.vue`
   - **View (página)** → `src/modules/[modulo]/views/NomeView.vue`

3. Crie o componente com o template padrão:

```vue
<script setup lang="ts">
import { ref, computed } from 'vue'

interface Props {
  // tipar todas as props
}

interface Emits {
  // tipar todos os emits
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

// composables, state, computed, handlers...
</script>

<template>
  <!-- template limpo, < 100 linhas -->
</template>

<style scoped>
/* styles */
</style>
```

4. Checklist:
   - `<script setup lang="ts">` ✅
   - Props type-based ✅
   - Emits type-based ✅
   - < 200 linhas ✅
   - PascalCase.vue ✅

5. Valide: `npx tsc --noEmit`
