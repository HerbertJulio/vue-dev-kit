Gere types, contracts e adapter para um endpoint de API seguindo `docs/ARCHITECTURE.md` §4.2-4.3.

Endpoint ou JSON de exemplo: $ARGUMENTS

## Passos

1. Leia `docs/ARCHITECTURE.md` seções 4.2 e 4.3.

2. Se o usuário passou um JSON de exemplo, use-o. Se passou um endpoint:
   - Busque no código existente por chamadas a esse endpoint
   - Peça ao usuário um exemplo de response JSON

3. A partir do JSON, crie:

   a. **`[recurso].types.ts`** — tipos que refletem a API exatamente:
      - snake_case, string dates, IDs como string
      - Inclua request payloads e list response (com paginação)

   b. **`[recurso].contracts.ts`** — contratos limpos da app:
      - camelCase, Date objects, booleans derivados
      - Sem campos internos da API (tokens, metadata)

   c. **`[recurso]-adapter.ts`** — funções puras:
      - `toXxx(response)` — inbound (API → App)
      - `toXxxList(response)` — inbound para lista
      - `toCreatePayload(input)` — outbound (App → API)
      - Conversões: snake→camel, string→Date, cents→decimal

4. Valide: `npx tsc --noEmit`
