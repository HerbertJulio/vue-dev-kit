# 🛠️ Vue Dev Kit

Kit de desenvolvimento para projetos Vue 3 com Claude Code. Inclui **agentes**, **slash commands**, e **padrões arquiteturais** para uso diário do time.

## Instalação

```bash
# Clone o kit (ou coloque no repo interno da empresa)
git clone <repo-url> vue-dev-kit

# Entre no seu projeto Vue
cd /seu/projeto-vue

# Instale
/caminho/para/vue-dev-kit/setup.sh
```

Isso cria no seu projeto:
```
.claude/
├── agents/          ← Subagentes (delegação automática)
│   ├── development/
│   ├── quality/
│   ├── analysis/
│   └── orchestrators/
└── commands/        ← Slash commands (/comando)
    ├── dev/
    ├── review/
    ├── migration/
    └── docs/
docs/
└── ARCHITECTURE.md  ← Source of truth de padrões
CLAUDE.md            ← Config do projeto para Claude
```

---

## 🤖 Agentes (10)

Agentes são IA especializadas que o Claude delega automaticamente ou que você invoca com `@nome`.

### Desenvolvimento (dia a dia)

| Agente | Quando Usar | Exemplo |
|--------|-------------|---------|
| `@feature-builder` | Criar módulo novo do zero | *"Use @feature-builder para criar o módulo de domains"* |
| `@vue-component-creator` | Criar componente | *"Use @vue-component-creator para criar um DataTable"* |
| `@service-creator` | Criar service + adapter + types | *"Use @service-creator para o endpoint /v4/domains"* |
| `@composable-creator` | Criar composable com Vue Query | *"Use @composable-creator para buscar lista de domains"* |

### Qualidade

| Agente | Quando Usar | Exemplo |
|--------|-------------|---------|
| `@code-reviewer` | Revisar código / PR | *"Use @code-reviewer para revisar meu último commit"* |
| `@bug-hunter` | Investigar bugs | *"Use @bug-hunter para investigar o erro 500 no login"* |

### Análise

| Agente | Quando Usar | Exemplo |
|--------|-------------|---------|
| `@code-archaeologist` | Entender código antes de mexer | *"Use @code-archaeologist para mapear src/modules/auth/"* |
| `@performance-profiler` | Analisar performance | *"Use @performance-profiler no módulo dashboard"* |

### Migração

| Agente | Quando Usar | Exemplo |
|--------|-------------|---------|
| `@migration-orchestrator` | Migrar módulo completo | *"Use @migration-orchestrator para migrar o módulo billing"* |
| `@vue-component-migrator` | Migrar componente unitário | *"Use @vue-component-migrator em UserSettings.vue"* |

---

## ⚡ Slash Commands (10)

Commands são atalhos que você invoca com `/comando` dentro do Claude Code.

### Desenvolvimento

| Comando | O que faz |
|---------|-----------|
| `/dev-create-module [nome]` | Scaffold completo de um módulo |
| `/dev-create-component [nome]` | Cria componente com template padrão |
| `/dev-create-service [recurso]` | Cria service + adapter + types + contracts |
| `/dev-create-composable [nome]` | Cria composable com Vue Query |
| `/dev-create-test [arquivo]` | Cria testes para um arquivo |
| `/dev-generate-types [endpoint]` | Gera types/contracts/adapter de um endpoint |

### Review & Qualidade

| Comando | O que faz |
|---------|-----------|
| `/review-review [escopo]` | Code review completo contra ARCHITECTURE.md |
| `/review-check-architecture [módulo]` | 14 checks automáticos de conformidade |
| `/review-fix-violations [módulo]` | Encontra e corrige violações |

### Migração

| Comando | O que faz |
|---------|-----------|
| `/migration-migrate-component [arquivo]` | Migra Options→script setup |
| `/migration-migrate-module [path]` | Migra módulo inteiro (6 fases) |

### Docs

| Comando | O que faz |
|---------|-----------|
| `/docs-onboard [módulo]` | Resumo rápido para onboarding |

---

## 📖 ARCHITECTURE.md

O `docs/ARCHITECTURE.md` é a **source of truth** que todos os agentes seguem. Ele define:

### Estrutura Modular
```
src/modules/[feature]/
├── components/     ← UI
├── composables/    ← Lógica (service→adapter→query)
├── services/       ← HTTP puro (sem try/catch)
├── adapters/       ← Parsers (API↔App)
├── stores/         ← Client state only (Pinia)
├── types/          ← .types.ts (API) + .contracts.ts (App)
├── views/          ← Páginas
└── index.ts        ← Barrel export
```

### Camadas de Responsabilidade
```
Service (só HTTP) → Adapter (parse) → Composable (orquestra) → Component (UI)
```

| Camada | Faz | NÃO faz |
|--------|-----|---------|
| **Service** | Chamadas HTTP | try/catch, transformação, lógica |
| **Adapter** | Parse API↔App | HTTP, side effects |
| **Composable** | Orquestra service+adapter+Vue Query | Renderizar UI |
| **Store Pinia** | Client state (UI, filtros) | Server state, HTTP |
| **Component** | UI + composição | Lógica de negócio pesada |

### Padrões-Chave
- **Stop Prop Drilling**: slots + provide/inject + composables diretos
- **Utils vs Helpers**: utils = puras | helpers = side effects
- **Error Handling**: centralizado em composables (Vue Query onError)
- **Naming**: PascalCase componentes, kebab-case dirs, useXxx composables
- **SOLID**: cada arquivo = 1 responsabilidade

> **Customize o `ARCHITECTURE.md` para seu projeto!** Os agentes seguem o que estiver lá.

---

## 🏃 Quick Start para o Time

### Dev novo? Comece assim:
```bash
claude
# Entender um módulo:
/docs-onboard marketplace
# Ou converse:
"Usa @code-archaeologist para me explicar o módulo de auth"
```

### Criar feature nova:
```bash
/dev-create-module domains
# Ou:
"Usa @feature-builder para criar o módulo domains com CRUD"
```

### Criar só um componente:
```bash
/dev-create-component DomainsTable
```

### Criar integração com API:
```bash
/dev-create-service domains
# Cria: types + contracts + adapter + service
```

### Review antes de PR:
```bash
/review-review
# Ou review focado:
/review-check-architecture marketplace
```

### Migrar código legado:
```bash
# Um componente:
/migration-migrate-component src/views/OldPage.vue
# Módulo inteiro:
/migration-migrate-module src/views/marketplace/
```

### Investigar bug:
```bash
"Usa @bug-hunter para investigar por que a lista de domains não carrega"
```

---

## 🔧 Customização

### Adicionar um agente
Crie `.claude/agents/[categoria]/nome-do-agente.md`:
```markdown
---
name: meu-agente
description: "MUST BE USED to [fazer X] whenever [condição]."
tools: Read, Write, Edit, Bash, Glob, Grep
---

# Título

## Missão
Uma frase.

## Workflow
1. ...

## Regras
- ...
```

### Adicionar um command
Crie `.claude/commands/[categoria]/meu-comando.md`:
```markdown
Descrição do que fazer.

Argumento: $ARGUMENTS

## Passos
1. ...
2. ...
```

### Editar padrões
Edite `docs/ARCHITECTURE.md` — todos os agentes leem esse arquivo antes de agir.

---

## 📊 Consumo de Tokens

| Operação | Tokens Estimados |
|----------|-----------------|
| `/dev-create-component` | ~3-5k |
| `/dev-create-service` | ~5-8k |
| `/dev-create-module` (completo) | ~15-25k |
| `/review-check-architecture` | ~5-10k |
| `/review-review` | ~8-15k |
| `@migration-orchestrator` (módulo inteiro) | ~30-80k |
| `@bug-hunter` | ~5-15k |

---

## 📄 Licença

MIT — Use livremente.
