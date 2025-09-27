#!/bin/bash

# HelmStack CE Official Installer
# One-command installation from GitHub
# Usage: curl -fsSL https://raw.githubusercontent.com/USERNAME/helmstack/main/install-helmstack.sh | bash

set -e

# Colors and styling
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Configuration
HELMSTACK_VERSION="latest"
GITHUB_REPO="https://github.com/helmstack/helmstack"
INSTALL_DIR="$HOME/.helmstack"
BIN_DIR="$HOME/.local/bin"

# Create fancy header
print_header() {
    echo -e "${PURPLE}"
    echo "╔═══════════════════════════════════════════════════════════════╗"
    echo "║                                                               ║"
    echo "║  ██   ██ ███████ ██      ███    ███ ███████ ████████  █████  ║"
    echo "║  ██   ██ ██      ██      ████  ████ ██         ██    ██   ██ ║"
    echo "║  ███████ █████   ██      ██ ████ ██ ███████    ██    ███████ ║"
    echo "║  ██   ██ ██      ██      ██  ██  ██      ██    ██    ██   ██ ║"
    echo "║  ██   ██ ███████ ███████ ██      ██ ███████    ██    ██   ██ ║"
    echo "║                                                               ║"
    echo "║                Contract-first AI Development                  ║"
    echo "║                     Community Edition                        ║"
    echo "╚═══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo
}

# Print step with fancy formatting
print_step() {
    echo -e "${CYAN}▶${NC} ${WHITE}$1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check system requirements
check_requirements() {
    print_step "Checking system requirements..."

    # Check if running on supported OS
    if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
        print_success "Operating system: $OSTYPE"
    else
        print_error "Unsupported operating system: $OSTYPE"
        exit 1
    fi

    # Check Node.js
    if ! command -v node &> /dev/null; then
        print_error "Node.js is required but not installed."
        echo -e "${YELLOW}Please install Node.js 18+ from: ${BLUE}https://nodejs.org/${NC}"
        exit 1
    fi

    # Check Node.js version
    NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        print_error "Node.js 18+ is required. Current: $(node --version)"
        echo -e "${YELLOW}Please upgrade Node.js from: ${BLUE}https://nodejs.org/${NC}"
        exit 1
    fi

    print_success "Node.js $(node --version)"

    # Check npm
    if ! command -v npm &> /dev/null; then
        print_error "npm is required but not installed."
        exit 1
    fi

    print_success "npm $(npm --version)"

    # Check git
    if ! command -v git &> /dev/null; then
        print_warning "Git not found. Some features may be limited."
    else
        print_success "Git $(git --version | cut -d' ' -f3)"
    fi
}

# Create directories
setup_directories() {
    print_step "Setting up directories..."

    mkdir -p "$INSTALL_DIR"
    mkdir -p "$BIN_DIR"

    print_success "Created installation directories"
}

# Download and install packages
install_packages() {
    print_step "Installing HelmStack packages..."

    # Create temporary directory
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"

    echo -e "${BLUE}📦 Downloading packages...${NC}"

    # Install from npm packages
    print_step "Installing @helmstack/schemas..."
    npm install -g @helmstack/schemas

    print_step "Installing @helmstack/core..."
    npm install -g @helmstack/core

    print_step "Installing @helmstack/addons..."
    npm install -g @helmstack/addons

    print_step "Installing helmstack CLI..."
    npm install -g helmstack

    # Cleanup
    cd /
    rm -rf "$TEMP_DIR"

    print_success "All packages installed successfully"
}

# Verify installation
verify_installation() {
    print_step "Verifying installation..."

    if command -v heck &> /dev/null; then
        local version=$(heck --version 2>/dev/null || echo "unknown")
        print_success "HelmStack CLI installed: $version"
    else
        print_error "Installation verification failed"
        exit 1
    fi

    # Test basic functionality
    if heck --help &> /dev/null; then
        print_success "Basic functionality test passed"
    else
        print_warning "Basic functionality test failed"
    fi
}

# Add to PATH if needed
setup_path() {
    print_step "Configuring PATH..."

    local shell_rc=""
    if [[ $SHELL == *"zsh"* ]]; then
        shell_rc="$HOME/.zshrc"
    elif [[ $SHELL == *"bash"* ]]; then
        shell_rc="$HOME/.bashrc"
    fi

    if [[ -n "$shell_rc" ]] && [[ -f "$shell_rc" ]]; then
        if ! grep -q "$BIN_DIR" "$shell_rc"; then
            echo "" >> "$shell_rc"
            echo "# HelmStack CLI" >> "$shell_rc"
            echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$shell_rc"
            print_success "Added to $shell_rc"
        else
            print_success "PATH already configured"
        fi
    fi
}

# Print success message and instructions
print_completion() {
    echo
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                               ║${NC}"
    echo -e "${GREEN}║  🎉 HelmStack CE installed successfully!                      ║${NC}"
    echo -e "${GREEN}║                                                               ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo
    echo -e "${YELLOW}🚀 Getting Started:${NC}"
    echo -e "   ${BLUE}heck init${NC}                    # Initialize new workspace"
    echo -e "   ${BLUE}heck status${NC}                  # Check workspace status"
    echo -e "   ${BLUE}heck focus add \"My task\"${NC}     # Add focus item"
    echo -e "   ${BLUE}heck plan \"Build my app\"${NC}     # Generate AI project plan"
    echo
    echo -e "${YELLOW}🤖 AI Configuration:${NC}"
    echo -e "   ${BLUE}heck adapter list${NC}            # List available AI providers"
    echo -e "   ${BLUE}heck adapter set openai${NC}      # Configure OpenAI (requires API key)"
    echo -e "   ${BLUE}heck adapter test${NC}            # Test AI configuration"
    echo
    echo -e "${YELLOW}📚 Documentation:${NC}"
    echo -e "   ${BLUE}heck --help${NC}                  # Show all commands"
    echo -e "   ${BLUE}heck <command> --help${NC}        # Command-specific help"
    echo
    echo -e "${YELLOW}🔧 Troubleshooting:${NC}"
    echo -e "   If 'heck' command not found, restart terminal or run:"
    echo -e "   ${BLUE}source ~/.bashrc${NC} or ${BLUE}source ~/.zshrc${NC}"
    echo
    echo -e "${PURPLE}Happy coding with HelmStack! 🚀${NC}"
}

# Main installation process
main() {
    print_header

    echo -e "${WHITE}Starting HelmStack CE installation...${NC}"
    echo

    check_requirements
    setup_directories
    install_packages
    verify_installation
    setup_path
    print_completion
}

# Run installation
main "$@"