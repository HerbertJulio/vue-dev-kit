Crie a camada de dados completa para um recurso seguindo `docs/ARCHITECTURE.md` §4.1-4.3.

Recurso: $ARGUMENTS

## Passos

1. Leia `docs/ARCHITECTURE.md` seções 4.1 (Services), 4.2 (Adapters), 4.3 (Types).

2. Pergunte ao usuário:
   - Qual a URL base do endpoint? (ex: `/v4/marketplace`)
   - Qual o formato do response JSON? (peça um exemplo ou descreva os campos)
   - Quais operações? (GET list, GET by ID, POST, PATCH, DELETE)

3. Crie na ordem:

   a. `types/[recurso].types.ts` — reflete API exatamente (snake_case)
   b. `types/[recurso].contracts.ts` — contrato da app (camelCase, tipos corretos)
   c. `adapters/[recurso]-adapter.ts` — inbound (API→App) + outbound (App→API)
   d. `services/[recurso]-service.ts` — apenas HTTP, sem try/catch, sem transformação

4. Regras obrigatórias:
   - Service: **SEM try/catch**, **SEM .map()/.filter()/new Date()**
   - Adapter: **funções puras**, sem side effects
   - Types separados: .types.ts (API) ≠ .contracts.ts (App)

5. Valide: `npx tsc --noEmit`
