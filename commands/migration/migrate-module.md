Migre um módulo inteiro para a arquitetura-alvo de `docs/ARCHITECTURE.md`.

Módulo/Path: $ARGUMENTS

## Passos

Use o `@migration-orchestrator` para coordenar a migração completa nas fases:

1. **Fase 0 – Análise**: `@code-archaeologist` mapeia o módulo
2. **Fase 1 – Estrutura**: Criar `src/modules/[nome]/` e mover arquivos
3. **Fase 2 – Types**: Criar `.types.ts` + `.contracts.ts` + adapter
4. **Fase 3 – Services**: Migrar para service puro (sem try/catch)
5. **Fase 4 – State**: Server state → Vue Query, Client state → Pinia
6. **Fase 5 – Componentes**: Options → script setup + composition
7. **Fase 6 – Review**: `@code-reviewer` valida conformidade

Validar build/tsc/testes após cada fase. Pedir aprovação antes de cada fase.
