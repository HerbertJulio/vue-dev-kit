Faça um resumo rápido de um módulo para onboarding.

Módulo: $ARGUMENTS

## Passos

1. Mapeie a estrutura:
```bash
find src/modules/$ARGUMENTS -type f | head -40
```

2. Resuma em formato rápido:

### Endpoints
Liste os endpoints consumidos (grep nos services).

### Componentes principais
Liste componentes e suas responsabilidades (1 linha cada).

### Estado
- O que está em Pinia? (client state)
- O que está em Vue Query? (server state)

### Fluxo de dados
```
Service (HTTP) → Adapter (parse) → Composable (Vue Query) → Component (UI)
```

### Pontos de atenção
- Algo fora do padrão do ARCHITECTURE.md?
- Componentes > 200 linhas?
- Código legado não migrado?

3. Output: resumo conciso que um dev novo consiga entender o módulo em 2 minutos.
