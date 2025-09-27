#!/bin/bash

# HelmStack CE Publishing Script
# Publishes all packages in correct dependency order

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🚀 Publishing HelmStack CE packages...${NC}"

# Check if logged in to npm
if ! npm whoami &> /dev/null; then
    echo -e "${RED}❌ Not logged in to npm. Run 'npm login' first.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Logged in as: $(npm whoami)${NC}"

# Function to publish package
publish_package() {
    local package_dir=$1
    local package_name=$2

    echo -e "${BLUE}📦 Publishing $package_name...${NC}"

    cd "$package_dir"

    # Build package
    echo "Building..."
    npm run build

    # Check if package already exists with this version
    local current_version=$(node -p "require('./package.json').version")
    if npm view "$package_name@$current_version" version &> /dev/null; then
        echo -e "${BLUE}⬆️  Version $current_version already exists, bumping patch version...${NC}"
        npm version patch --no-git-tag-version
    fi

    # Publish
    echo "Publishing..."
    if [ -n "$OTP_CODE" ]; then
        npm publish --otp="$OTP_CODE"
    else
        npm publish
    fi

    echo -e "${GREEN}✅ $package_name published successfully${NC}"
    echo
}

# Publish in dependency order
echo -e "${BLUE}Publishing packages in dependency order...${NC}"
echo

# 1. Schemas (no dependencies)
publish_package "/home/oem/Documents/Projects/PersonalUse/Tools/helmstack/helmstack-schemas" "helmstack-schemas"

# 2. Core (depends on schemas)
publish_package "/home/oem/Documents/Projects/PersonalUse/Tools/helmstack/helmstack-core" "helmstack-core"

# 3. Addons (depends on core)
publish_package "/home/oem/Documents/Projects/PersonalUse/Tools/helmstack/helmstack-addons" "helmstack-addons"

# 4. CLI (depends on all)
publish_package "/home/oem/Documents/Projects/PersonalUse/Tools/helmstack/helmstack-cli" "helmstack"

echo -e "${GREEN}🎉 All packages published successfully!${NC}"
echo
echo -e "${BLUE}📋 Installation commands:${NC}"
echo "npm install -g helmstack"
echo
echo -e "${BLUE}🔗 Package URLs:${NC}"
echo "• https://www.npmjs.com/package/helmstack-schemas"
echo "• https://www.npmjs.com/package/helmstack-core"
echo "• https://www.npmjs.com/package/helmstack-addons"
echo "• https://www.npmjs.com/package/helmstack"
echo
echo -e "${GREEN}Happy coding! 🚀${NC}"