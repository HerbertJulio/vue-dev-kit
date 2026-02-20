#!/bin/bash
# ============================================================
# Vue Dev Kit — Installation Script
# ============================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

LITE_MODE=false
if [[ "${1:-}" == "--lite" ]]; then
    LITE_MODE=true
fi

if $LITE_MODE; then
    echo -e "\n${BLUE}🪶 Vue Dev Kit — Lite Installation (Haiku model)${NC}\n"
else
    echo -e "\n${BLUE}🛠️  Vue Dev Kit — Full Installation${NC}\n"
fi

# Detect if we're in a project (has package.json)
if [ ! -f "package.json" ]; then
    echo -e "${YELLOW}⚠️  No package.json found.${NC}"
    echo "Run this script from the root of your Vue project."
    exit 1
fi

echo -e "${BLUE}Installing into: $(pwd)${NC}\n"

# 1. Install agents
if $LITE_MODE; then
    echo -e "${BLUE}📦 Installing Lite agents (Haiku model, lower cost)...${NC}"
    AGENTS_DIR="$SCRIPT_DIR/agents-lite"
else
    echo -e "${BLUE}📦 Installing Full agents...${NC}"
    AGENTS_DIR="$SCRIPT_DIR/agents"
fi

mkdir -p .claude/agents

count=0
while IFS= read -r agent_file; do
    filename=$(basename "$agent_file")
    target=".claude/agents/$filename"
    cp "$agent_file" "$target"
    name=$(grep -m1 "^name:" "$agent_file" | cut -d: -f2 | tr -d ' ')
    echo -e "  ${GREEN}✅ @$name${NC}"
    count=$((count + 1))
done < <(find "$AGENTS_DIR" -name "*.md" -type f)

echo -e "\n  ${GREEN}$count agents installed${NC}"

# 2. Install slash commands
echo -e "\n${BLUE}⚡ Installing slash commands...${NC}"
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

echo -e "\n  ${GREEN}$cmd_count commands installed${NC}"

# 3. Copy docs
echo -e "\n${BLUE}📖 Installing docs...${NC}"
mkdir -p docs

if [ ! -f "docs/ARCHITECTURE.md" ]; then
    cp "$SCRIPT_DIR/docs/ARCHITECTURE.md" docs/ARCHITECTURE.md
    echo -e "  ${GREEN}✅ docs/ARCHITECTURE.md${NC}"
else
    echo -e "  ${YELLOW}⚠️  docs/ARCHITECTURE.md already exists (not overwritten)${NC}"
fi

# 4. CLAUDE.md
if [ ! -f "CLAUDE.md" ]; then
    cp "$SCRIPT_DIR/CLAUDE.md" ./CLAUDE.md
    echo -e "  ${GREEN}✅ CLAUDE.md${NC}"
else
    echo -e "  ${YELLOW}⚠️  CLAUDE.md already exists (not overwritten)${NC}"
fi

# Done
echo -e "\n${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}  🎉 Vue Dev Kit installed successfully!${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}\n"

if $LITE_MODE; then
    echo -e "${YELLOW}Lite mode: agents run on Haiku model (lower cost, faster).${NC}"
    echo -e "${YELLOW}To switch to Full agents later, run: setup.sh (without --lite)${NC}\n"
fi

echo "Open Claude Code and try:"
echo ""
echo "  claude                                    # open"
echo "  /agents                                   # list agents"
echo "  /dev-create-module marketplace            # scaffold a module"
echo "  /review-check-architecture                # validate architecture"
echo "  /review-review                            # code review"
echo ""
echo "Or just ask:"
echo ""
echo '  "Use @vue-builder to create the domains module with CRUD"'
echo '  "Use @vue-reviewer to explore src/modules/auth/"'
echo '  "Use @vue-doctor to investigate the dashboard error"'
echo ""
echo -e "${BLUE}📖 Read docs/ARCHITECTURE.md to understand the patterns.${NC}"
echo -e "${BLUE}📖 Customize CLAUDE.md and ARCHITECTURE.md for your project.${NC}"
echo ""
