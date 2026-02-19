Valide a conformidade do projeto inteiro (ou módulo específico) com `docs/ARCHITECTURE.md`.

Escopo: $ARGUMENTS (se vazio, validar todo src/modules/)

## Checks Automáticos

Execute todos estes checks e reporte um sumário:

```bash
echo "=== 1. Services com try/catch ==="
grep -rn "try {" src/modules/*/services/ --include="*.ts" 2>/dev/null || echo "✅ Nenhum"

echo "=== 2. Services com transformação ==="
grep -rn "\.map(\|\.filter(\|new Date\|\.reduce(" src/modules/*/services/ --include="*.ts" 2>/dev/null || echo "✅ Nenhum"

echo "=== 3. Componentes sem script setup ==="
grep -rL "script setup" src/modules/*/components/*.vue src/modules/*/views/*.vue 2>/dev/null || echo "✅ Todos ok"

echo "=== 4. Componentes sem TypeScript ==="
grep -rL 'lang="ts"' src/modules/*/components/*.vue src/modules/*/views/*.vue 2>/dev/null || echo "✅ Todos ok"

echo "=== 5. Options API ==="
grep -rn "defineComponent\|export default {" src/modules/ --include="*.vue" 2>/dev/null || echo "✅ Nenhum"

echo "=== 6. Mixins ==="
grep -rn "mixins:" src/ --include="*.vue" 2>/dev/null || echo "✅ Nenhum"

echo "=== 7. Server state em Pinia ==="
grep -rn "async.*fetch\|axios\|api\.\|\.get(\|\.post(" src/modules/*/stores/ --include="*.ts" 2>/dev/null || echo "✅ Nenhum"

echo "=== 8. storeToRefs ausente ==="
grep -rn "const {.*} = use.*Store()" src/ --include="*.vue" 2>/dev/null | grep -v "storeToRefs" || echo "✅ Todos ok"

echo "=== 9. any types ==="
grep -rn ": any\| any;\|as any\|<any>" src/modules/ --include="*.ts" --include="*.vue" 2>/dev/null | wc -l

echo "=== 10. Cross-module imports ==="
for module in src/modules/*/; do
  name=$(basename "$module")
  grep -rn "from.*modules/" "$module" --include="*.ts" --include="*.vue" 2>/dev/null | grep -v "modules/${name}" || true
done

echo "=== 11. v-html ==="
grep -rn "v-html" src/ --include="*.vue" 2>/dev/null || echo "✅ Nenhum"

echo "=== 12. Debug artifacts ==="
grep -rn "console\.\|debugger" src/modules/ --include="*.ts" --include="*.vue" 2>/dev/null | wc -l

echo "=== 13. Queries sem staleTime ==="
grep -rn "useQuery" src/ --include="*.ts" -l 2>/dev/null | while read f; do
  grep -L "staleTime" "$f" 2>/dev/null
done

echo "=== 14. Componentes > 200 linhas ==="
find src/modules -name "*.vue" -exec sh -c 'lines=$(wc -l < "$1"); [ "$lines" -gt 200 ] && echo "$1: $lines linhas"' _ {} \;
```

Produza uma tabela resumo:

| Check | Status | Ocorrências |
|-------|--------|-------------|
| Services sem try/catch | ✅/❌ | X |
| ... | ... | ... |

Score geral: X/14 checks passando.
