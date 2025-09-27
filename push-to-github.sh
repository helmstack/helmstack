#!/bin/bash

# HelmStack GitHub Push Script
# Pushes all repositories to GitHub

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# GitHub organization
GITHUB_USERNAME="helmstack"

echo -e "${BLUE}🚀 Pushing HelmStack to GitHub...${NC}"
echo -e "${YELLOW}⚠️  Make sure you've created these repositories on GitHub:${NC}"
echo "• https://github.com/$GITHUB_USERNAME/helmstack"
echo "• https://github.com/$GITHUB_USERNAME/helmstack-schemas"
echo "• https://github.com/$GITHUB_USERNAME/helmstack-core"
echo "• https://github.com/$GITHUB_USERNAME/helmstack-addons"
echo "• https://github.com/$GITHUB_USERNAME/helmstack-cli"
echo

read -p "Press Enter to continue (Ctrl+C to cancel)..."

# Function to push repository
push_repo() {
    local repo_dir=$1
    local repo_name=$2
    local github_url="git@github.com:$GITHUB_USERNAME/$repo_name.git"

    echo -e "${BLUE}📦 Pushing $repo_name...${NC}"

    cd "$repo_dir"

    # Check if remote exists
    if git remote get-url origin &> /dev/null; then
        echo "Remote already exists, updating..."
        git remote set-url origin "$github_url"
    else
        echo "Adding remote origin..."
        git remote add origin "$github_url"
    fi

    # Push to GitHub
    echo "Pushing to GitHub..."
    if git push -u origin master; then
        echo -e "${GREEN}✅ $repo_name pushed successfully${NC}"
        echo -e "${BLUE}🔗 https://github.com/$GITHUB_USERNAME/$repo_name${NC}"
    else
        echo -e "${RED}❌ Failed to push $repo_name${NC}"
        echo "Make sure the repository exists on GitHub and you have access"
        exit 1
    fi
    echo
}

# Base directory
BASE_DIR="/home/oem/Documents/Projects/PersonalUse/Tools/helmstack"

# Push repositories in order
echo -e "${BLUE}Pushing repositories...${NC}"
echo

# 1. Schemas
push_repo "$BASE_DIR/helmstack-schemas" "helmstack-schemas"

# 2. Core
push_repo "$BASE_DIR/helmstack-core" "helmstack-core"

# 3. Addons
push_repo "$BASE_DIR/helmstack-addons" "helmstack-addons"

# 4. CLI
push_repo "$BASE_DIR/helmstack-cli" "helmstack-cli"

# 5. Main repo (last)
push_repo "$BASE_DIR" "helmstack"

echo -e "${GREEN}🎉 All repositories pushed to GitHub successfully!${NC}"
echo
echo -e "${BLUE}📋 Repository URLs:${NC}"
echo "• Main: https://github.com/$GITHUB_USERNAME/helmstack"
echo "• Schemas: https://github.com/$GITHUB_USERNAME/helmstack-schemas"
echo "• Core: https://github.com/$GITHUB_USERNAME/helmstack-core"
echo "• Addons: https://github.com/$GITHUB_USERNAME/helmstack-addons"
echo "• CLI: https://github.com/$GITHUB_USERNAME/helmstack-cli"
echo
echo -e "${YELLOW}🔧 Next Steps:${NC}"
echo "1. Update install script with your GitHub username"
echo "2. Test installation: curl -fsSL https://raw.githubusercontent.com/$GITHUB_USERNAME/helmstack/master/install-helmstack.sh | bash"
echo "3. Publish to npm: ./publish-all.sh"
echo
echo -e "${GREEN}HelmStack is now public on GitHub! 🚀${NC}"