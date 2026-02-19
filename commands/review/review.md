Faça um code review completo dos arquivos alterados, validando contra `docs/ARCHITECTURE.md`.

Escopo: $ARGUMENTS (se vazio, revisar arquivos alterados no git)

## Passos

1. Identifique os arquivos alterados:
```bash
git diff --name-only HEAD~1 2>/dev/null || git diff --name-only --cached 2>/dev/null || echo "Informe os arquivos"
```

2. Rode checks automáticos:
```bash
npx tsc --noEmit
npx eslint --ext .ts,.vue src/ --max-warnings 0
npx vitest run --passWithNoTests
```

3. Verifique padrões do ARCHITECTURE.md:
   - Services: sem try/catch, sem transformação
   - Adapters: funções puras
   - Composables: usam service+adapter, staleTime definido
   - Stores: apenas client state, storeToRefs nos consumers
   - Componentes: script setup, props/emits tipados, < 200 linhas
   - Naming: convenções corretas
   - Boundaries: sem imports entre módulos

4. Classifique:
   - 🔴 Violação do ARCHITECTURE.md
   - 🟡 Melhoria recomendada
   - 🟢 Conforme
   - ✨ Destaque positivo

5. Produza relatório com veredicto: ✅ Aprovado | ⚠️ Com ressalvas | ❌ Requer mudanças
