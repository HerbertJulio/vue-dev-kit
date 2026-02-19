# CLAUDE.md – Vue Dev Kit

## Sobre
Kit de desenvolvimento para projetos Vue 3 com TypeScript. Inclui agentes, slash commands, e padrões arquiteturais para o time.

**📖 Padrões e convenções: ver `docs/ARCHITECTURE.md`**

## AI Team Configuration

**Important: YOU MUST USE subagents when available for the task.**
**Important: ALWAYS read docs/ARCHITECTURE.md before creating or modifying files.**

### Stack
- Vue 3 + `<script setup lang="ts">`
- Pinia (client state) + TanStack Vue Query (server state)
- Vite + TypeScript (strict) + Zod
- Vue Router 4
- Vitest + @vue/test-utils

### Agentes Disponíveis

| Agente | Quando Usar |
|--------|-------------|
| `@feature-builder` | Criar um módulo/feature novo do zero |
| `@vue-component-creator` | Criar componentes seguindo os padrões |
| `@service-creator` | Criar service + adapter + types de um recurso |
| `@composable-creator` | Criar composables com Vue Query |
| `@code-reviewer` | Revisar código / PRs |
| `@bug-hunter` | Investigar e corrigir bugs |
| `@code-archaeologist` | Mapear código existente antes de mexer |
| `@performance-profiler` | Analisar performance |
| `@migration-orchestrator` | Migrar módulo legado para nova arquitetura |
| `@vue-component-migrator` | Migrar componente de Options → script setup |

### Slash Commands Disponíveis

| Comando | O que faz |
|---------|-----------|
| `/create-module [nome]` | Scaffold completo de um módulo |
| `/create-component [nome]` | Cria componente com template padrão |
| `/create-service [nome]` | Cria service + adapter + types |
| `/create-composable [nome]` | Cria composable com Vue Query |
| `/review` | Roda review completo do código alterado |
| `/check-architecture` | Valida conformidade com ARCHITECTURE.md |
| `/migrate-component [arquivo]` | Migra componente Options→setup |
| `/migrate-module [path]` | Migra módulo inteiro |
| `/generate-types [endpoint]` | Gera types/contracts/adapter de um endpoint |

### Padrões-Chave (detalhes em docs/ARCHITECTURE.md)
- **Services**: só HTTP, sem try/catch, sem transformação
- **Adapters**: funções puras, API↔App, snake→camel
- **Types**: `.types.ts` (API raw) + `.contracts.ts` (app)
- **Composables**: orquestram service→adapter→Vue Query
- **Stores Pinia**: apenas client state
- **Componentes**: script setup, composition pattern, < 200 linhas
- **Utils**: funções puras | **Helpers**: com side effects
- **Modules**: não importam entre si
