# 🏗️ MVP Phase 1: Foundation (2 həftə)

## 🎯 **MVP Məqsəd**
Minimal working TUI və workspace setup - istifadəçi `heck` yazsın və professional TUI görsün.

## 📦 **Deliverables**
- ✅ `heck` komandası TUI açır
- ✅ 2-panel layout (Chat + Tasks)
- ✅ `.heck/` minimal workspace structure
- ✅ Basic navigation (Tab, q, ?)

## 🏗️ **Minimal .heck/ Structure**
```
.heck/
├── config.json          # basic config
├── session/              # active session data
├── runlogs/              # command history
└── .gitignore           # auto-generated
```

## 🖥️ **TUI MVP Components**

### 1.1 Two-Panel Layout
```typescript
interface MVPPanels {
  chat: ChatPanel;    // Main interaction
  tasks: TaskPanel;   // Active/completed tasks
}

// Tab = switch panels
// q = quit with confirmation
// ? = help overlay
```

### 1.2 Basic Config
```json
{
  "provider": "heuristic",
  "ui": { "theme": "dark" },
  "version": "1.0.0-mvp"
}
```

## 📊 **Task Breakdown**

### Task 1.1: TUI Framework Setup (3 gün)
- [ ] Ink.js + React setup
- [ ] Basic layout components
- [ ] Panel switching logic
- [ ] Error boundaries

### Task 1.2: Workspace Init (2 gün)
- [ ] `heck init --pro` command
- [ ] .heck/ directory creation
- [ ] Config file generation
- [ ] .gitignore template

### Task 1.3: Basic Panels (3 gün)
- [ ] Chat panel skeleton
- [ ] Tasks panel skeleton
- [ ] Navigation system
- [ ] Help overlay

### Task 1.4: Integration (2 gün)
- [ ] Command integration
- [ ] Error handling
- [ ] Basic logging
- [ ] Startup optimization

## ✅ **MVP Success Criteria**
- [ ] `heck` starts TUI in <500ms
- [ ] Panels navigate without crashes
- [ ] Can run for 30+ minutes stable
- [ ] Works on macOS + Linux

## 🚀 **User Value**
"Professional TUI experience - user sees this is a serious pro tool"

## 🔄 **Next Phase Connection**
Phase 2 adds actual AI chat functionality to the chat panel.