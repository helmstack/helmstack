# 🎉 HelmStack - Contract-first Development Automation CLI

**CE (Community Edition)**: AI integration, Clean Architecture, Real functionality

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.0-blue.svg)](https://www.typescriptlang.org/)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org/)

HelmStack CE implementation following strict Clean Architecture with Contract-first development and AI integration with offline fallback.

## 🏗️ Architecture (CE Principles)

HelmStack follows 4 focused repositories with Clean Architecture:

```
helmstack/
├── helmstack-schemas    # 📋 Contracts & Validation (Zod + JSON Schema)
├── helmstack-core       # 🏗️ Business Logic & Ports (Services + Interfaces)
├── helmstack-addons     # 🔌 Real World Adapters (Git, FS, AI Providers)
└── helmstack-cli        # 💻 Command Interface (OCLIF + Commands)
```

### 🎯 CE Principles

1. **Contract-First**: All data types defined with Zod schemas, exported as JSON Schema
2. **Ports & Adapters**: Clean separation between interfaces (core) and implementations (addons)
3. **Thin CLI**: Commands only handle parsing and validation, delegate to services
4. **CE = AI var, ML yox**: Multiple providers (OpenAI, Anthropic, Gemini) with heuristic fallback
5. **Deterministic & Atomic**: File operations with temp→fsync→rename pattern
6. **Transparency**: Complete audit trail in Envelope format
7. **Security**: Policy guards, secret redaction, file access control
8. **Performance**: Sub-300ms CLI start, enforced budgets per operation

## 🚀 Commands (31 Total - Spec Based)

### 🌐 Core Workflow
- `heck init` - Initialize workspace (idempotent)
- `heck focus` - Manage current focus
- `heck plan` - Generate development plans (AI)
- `heck review` - Code review with auto-fix (AI)
- `heck wrap` - Complete work session

### 🧪 Test & Fix
- `heck test` - Run test suites with reports
- `heck fix` - Auto-fix issues from test reports (AI)

### ✏️ Edit & Refactor
- `heck edit <file>` - AI-assisted editing
- `heck refactor <pattern>` - Code refactoring (AI/AST)

### 🧩 Index & Search
- `heck index` - Build code index (.heck/cache)

### 🧷 Patch Management
- `heck patch create` - Create atomic patches
- `heck patch apply` - Apply with HITL preview
- `heck patch rollback` - Rollback changes

### ✅ Git Integration
- `heck commit` - Conventional commits (AI assist)

### 🤖 AI Management
- `heck adapter` - Configure AI providers

### 📊 Intelligence
- `heck status` - Project status
- `heck metrics` - Performance metrics
- `heck snapshot` - State snapshots
- `heck memory` - Knowledge management

### 🔄 Collaboration
- `heck sync` - GitHub/Jira/Trello sync
- `heck team` - Team management
- `heck audit` - Audit reports
- `heck share` / `heck join` - Session sharing

### 🔮 AI Assistant
- `heck orchestrate` - AI pipelines
- `heck suggest` - Smart suggestions
- `heck pair` - AI pair programming

### 🏗️ DevOps
- `heck repo` - Repository creation
- `heck publish` - Package publishing
- `heck pr` - Pull request automation
- `heck config` - Configuration management

### 🎨 Brand
- `heck brand sync` - Brand asset management

### 🏥 Health
- `heck health` - System diagnostics

## 📦 Installation

### 🚀 One-Command Install

```bash
curl -fsSL https://raw.githubusercontent.com/helmstack/helmstack/main/install-helmstack.sh | bash
```

### 📥 Manual Installation

```bash
npm install -g helmstack
```

### 🏁 Initialize Your First Project

```bash
# Initialize workspace
heck init

# Check status
heck status

# Add focus items
heck focus add "Build authentication system" --priority high

# Generate AI project plan
heck plan "Build a modern web application"

# Configure AI (optional)
heck adapter set openai --model gpt-4
```

### 🗑️ Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/helmstack/helmstack/main/uninstall.sh | bash
```

## 🔧 Development

### Building & Testing

```bash
# Build in dependency order
npm run build:schemas
npm run build:core
npm run build:addons
npm run build:cli

# Run tests
npm run test:all

# Test specific components
cd helmstack-core && npm test
cd helmstack-cli && npm run test:commands
```

## 🤖 AI Integration

HelmStack supports multiple AI providers with automatic fallback:

```bash
# Configure providers
heck adapter set --provider openai --model gpt-4 --key $OPENAI_API_KEY
heck adapter set --provider anthropic --model claude-3 --key $ANTHROPIC_API_KEY

# Test providers
heck adapter test

# Use AI features
heck plan --ai          # AI-generated development plan
heck review --auto-fix  # AI code review with fixes
heck suggest --scope tasks  # AI task suggestions
heck pair               # AI pair programming
```

### Offline Fallback

When no AI providers are configured, HelmStack uses built-in heuristics.

## 🔒 Security & Policy

### Policy Guards

Protect sensitive files automatically:

```json
{
  "rules": [
    { "glob": ".env", "action": "block" },
    { "glob": "deploy/**/*.yaml", "action": "confirm" },
    { "glob": "db/migrations/**", "action": "confirm" }
  ],
  "on_confirm_note": "Two-man rule for production changes."
}
```

### Secret Redaction

All runlogs automatically redact sensitive information.

## 🏎️ Performance

HelmStack enforces strict performance budgets:

- **CLI Start**: <300ms
- **Plan Generation**: <60s
- **Test Smoke**: <30s
- **Patch Apply**: <1s

## 📁 Workspace Structure

HelmStack creates a `.heck/` directory for workspace management:

```
.heck/
├── config.json         # Configuration
├── focus.md            # Current focus
├── next-steps.md       # Task list
├── policy/
│   └── rules.json      # Security rules
├── patches/            # Atomic patches
├── runlogs/           # Operation history
├── cache/             # Performance cache
└── migrations/        # Schema migrations
```

## 🤝 Contributing

1. **Follow CE Principles**: Contract-first, Ports & Adapters
2. **Add Tests**: Unit tests for services, integration tests for adapters
3. **Update Schemas**: Add/modify Zod schemas for new data types
4. **Document Commands**: Full help text and examples
5. **Performance**: Ensure operations meet budget requirements

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

---

**🎯 HelmStack: Where AI meets Clean Architecture for developer productivity**

*Built following CE (Community Edition) principles with real functionality*