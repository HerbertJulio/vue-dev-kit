#!/bin/bash
# ============================================================
# 🛠️ Vue Dev Kit – Instalação
# ============================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "\n${BLUE}🛠️  Vue Dev Kit – Instalação para o Time${NC}\n"

# Detectar se está em um projeto (tem package.json)
if [ ! -f "package.json" ]; then
    echo -e "${YELLOW}⚠️  Nenhum package.json encontrado.${NC}"
    echo "Execute este script na raiz do seu projeto Vue."
    exit 1
fi

echo -e "${BLUE}Instalando no projeto: $(pwd)${NC}\n"

# 1. Criar .claude/agents/ e copiar agentes
echo -e "${BLUE}📦 Instalando agentes...${NC}"
mkdir -p .claude/agents

count=0
while IFS= read -r agent_file; do
    relative="${agent_file#$SCRIPT_DIR/agents/}"
    target=".claude/agents/$relative"
    mkdir -p "$(dirname "$target")"
    cp "$agent_file" "$target"
    name=$(grep -m1 "^name:" "$agent_file" | cut -d: -f2 | tr -d ' ')
    echo -e "  ${GREEN}✅ @$name${NC}"
    count=$((count + 1))
done < <(find "$SCRIPT_DIR/agents" -name "*.md" -type f)

echo -e "\n  ${GREEN}$count agentes instalados${NC}"

# 2. Criar .claude/commands/ e copiar slash commands
echo -e "\n${BLUE}⚡ Instalando slash commands...${NC}"
mkdir -p .claude/commands

cmd_count=0
while IFS= read -r cmd_file; do
    relative="${cmd_file#$SCRIPT_DIR/commands/}"
    target=".claude/commands/$relative"
    mkdir -p "$(dirname "$target")"
    cp "$cmd_file" "$target"
    cmd_name=$(echo "$relative" | sed 's|/|-|g; s|\.md$||')
    echo -e "  ${GREEN}✅ /$cmd_name${NC}"
    cmd_count=$((cmd_count + 1))
done < <(find "$SCRIPT_DIR/commands" -name "*.md" -type f)

echo -e "\n  ${GREEN}$cmd_count commands instalados${NC}"

# 3. Copiar docs
echo -e "\n${BLUE}📖 Instalando docs...${NC}"
mkdir -p docs

if [ ! -f "docs/ARCHITECTURE.md" ]; then
    cp "$SCRIPT_DIR/docs/ARCHITECTURE.md" docs/ARCHITECTURE.md
    echo -e "  ${GREEN}✅ docs/ARCHITECTURE.md${NC}"
else
    echo -e "  ${YELLOW}⚠️  docs/ARCHITECTURE.md já existe (não sobrescrito)${NC}"
fi

# 4. CLAUDE.md
if [ ! -f "CLAUDE.md" ]; then
    cp "$SCRIPT_DIR/CLAUDE.md" ./CLAUDE.md
    echo -e "  ${GREEN}✅ CLAUDE.md${NC}"
else
    echo -e "  ${YELLOW}⚠️  CLAUDE.md já existe (não sobrescrito)${NC}"
fi

# Done
echo -e "\n${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}  🎉 Vue Dev Kit instalado com sucesso!${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}\n"

echo "Abra o Claude Code e teste:"
echo ""
echo "  claude                              # abrir"
echo "  /agents                             # ver agentes"
echo "  /dev-create-module marketplace      # criar módulo"
echo "  /review-check-architecture          # validar arquitetura"
echo "  /review-review                      # review de código"
echo ""
echo "Ou converse:"
echo ""
echo '  "Use @feature-builder para criar o módulo de domains"'
echo '  "Use @code-archaeologist para mapear src/views/"'
echo '  "Use @bug-hunter para investigar o erro no dashboard"'
echo ""
echo -e "${BLUE}📖 Leia docs/ARCHITECTURE.md para entender os padrões.${NC}"
echo -e "${BLUE}📖 Customize CLAUDE.md e ARCHITECTURE.md para seu projeto.${NC}"
echo ""
