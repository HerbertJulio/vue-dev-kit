Crie um novo módulo de feature completo seguindo `docs/ARCHITECTURE.md`.

Nome do módulo: $ARGUMENTS

## Passos

1. Leia `docs/ARCHITECTURE.md` seções 2, 3 e 4.

2. Crie a estrutura de diretórios:
```
src/modules/[nome-em-kebab-case]/
├── components/
├── composables/
├── services/
├── adapters/
├── stores/
├── types/
├── views/
├── __tests__/
└── index.ts
```

3. Crie o `index.ts` com barrel export vazio:
```typescript
// src/modules/[nome]/index.ts
// Public API deste módulo
```

4. Pergunte ao usuário:
   - Quais endpoints da API este módulo consome?
   - Qual tipo de UI? (lista com CRUD, dashboard, form, detalhe)

5. Com base na resposta, use os agentes:
   - `@service-creator` para criar types + contracts + adapter + service
   - `@composable-creator` para criar composables com Vue Query
   - `@vue-component-creator` para criar os componentes

6. Registre a rota no router.

7. Valide: `npx tsc --noEmit && npx vite build`
