Identifique e corrija violações do `docs/ARCHITECTURE.md` no módulo especificado.

Módulo: $ARGUMENTS

## Passos

1. Execute `/check-architecture` para encontrar violações.

2. Para cada violação encontrada, corrija na ordem de prioridade:

   **🔴 Críticas (corrigir primeiro):**
   - try/catch em services → remover, mover error handling para composable
   - Transformação em services → mover para adapter
   - v-html sem sanitização → remover ou sanitizar
   - Secrets hardcoded → mover para env vars

   **🟡 Importantes:**
   - Options API → migrar para script setup (`/migrate-component`)
   - Server state em Pinia → migrar para Vue Query
   - any types → tipar corretamente
   - storeToRefs ausente → adicionar
   - Queries sem staleTime → adicionar

   **🟢 Melhorias:**
   - Componentes > 200 linhas → decompor
   - Console.log → remover
   - TODO/FIXME → resolver ou criar issue

3. Valide após cada correção:
```bash
npx tsc --noEmit && npx vite build && npx vitest run --passWithNoTests
```

4. Reporte o que foi corrigido e o que resta.
