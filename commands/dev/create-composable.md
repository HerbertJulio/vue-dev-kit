Crie um composable seguindo `docs/ARCHITECTURE.md` §4.4.

Composable: $ARGUMENTS

## Passos

1. Leia `docs/ARCHITECTURE.md` seção 4.4.

2. Determine o tipo:
   - **Query** (leitura de dados) → `useQuery` + service + adapter
   - **Mutation** (escrita/delete) → `useMutation` + invalidação de queries
   - **Lógica pura** (sem API) → refs + computed + lifecycle

3. Crie o composable em `composables/use[Nome].ts`:
   - Prefixo `use` obrigatório
   - Parâmetros com `MaybeRef<T>` para reatividade
   - queryKey reativo (`computed`)
   - `staleTime` explícito
   - Return type com refs/computed

4. Conecte as camadas: service → adapter → Vue Query

5. Valide: `npx tsc --noEmit`
