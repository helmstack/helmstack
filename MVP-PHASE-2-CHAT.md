# 💬 MVP Phase 2: Chat Interface (3 həftə)

## 🎯 **MVP Məqsəd**
Working AI chat - istifadəçi yazır "add endpoint", AI plan verir və icra edir.

## 📦 **Deliverables**
- ✅ Interactive chat panel
- ✅ 4 core recipe types
- ✅ Basic NL → Plan conversion
- ✅ Heuristic AI fallback always works
- ✅ "planner.tools" siyahısına RAG siqnalı (sadə klasifikasiyanı tamamlayır)

## 🤖 **Core Recipe System**

### 2.1 Four Essential Recipes
```yaml
# web-endpoint.yml
goal_type: "web-endpoint"
description: "Create API endpoints/routes"
keywords: ["endpoint", "route", "api", "server"]
tools: ["edit", "test"]

# test-fix.yml
goal_type: "test-fix"
description: "Fix failing tests"
keywords: ["test", "failing", "broken", "spec"]
tools: ["test", "edit"]

# bug-fix.yml
goal_type: "bug-fix"
description: "Fix bugs and errors"
keywords: ["bug", "fix", "error", "issue"]
tools: ["edit", "test"]

# refactor.yml
goal_type: "refactor"
description: "Code cleanup and refactoring"
keywords: ["refactor", "cleanup", "organize"]
tools: ["edit"]
```

### 2.2 Simple Classifier
```typescript
function classifyGoal(input: string): GoalType {
  const text = input.toLowerCase();

  if (/endpoint|route|api|server/.test(text)) return 'web-endpoint';
  if (/test.*fail|failing.*test/.test(text)) return 'test-fix';
  if (/fix|bug|error|issue/.test(text)) return 'bug-fix';
  if (/refactor|cleanup|organize/.test(text)) return 'refactor';

  return 'general'; // fallback recipe
}
```

## 💬 **Chat Panel Implementation**

### 2.3 Chat Interface
```typescript
interface ChatMessage {
  id: string;
  type: 'user' | 'ai' | 'system';
  content: string;
  timestamp: Date;
  metadata?: any;
}

class ChatPanel {
  messages: ChatMessage[] = [];
  currentInput: string = '';

  // Enter = send message
  // Up/Down = history navigation
  // Ctrl+C = clear input
}
```

### 2.4 Basic Plan Generation
```typescript
interface Plan {
  id: string;
  goal: string;
  steps: PlanStep[];
  estimated_time: string;
  confidence: number;
}

interface PlanStep {
  id: string;
  description: string;
  type: 'edit' | 'test' | 'review';
  files?: string[];
}
```

## 🔄 **Simple Orchestration**

### 2.5 MVP Helmlet (Minimal Agent)
```typescript
class MVPHelmlet {
  id: string;
  goal: string;
  recipe: Recipe;

  async generatePlan(): Promise<Plan> {
    // Use heuristic AI by default
    // Real AI providers as enhancement
  }

  async executePlan(plan: Plan): Promise<Result> {
    // Simple step-by-step execution
    // No complex orchestration yet
  }
}
```

## 📊 **Task Breakdown**

### Task 2.1: Recipe System (4 gün)
- [ ] YAML recipe parser
- [ ] Goal classification logic
- [ ] Recipe selection algorithm
- [ ] Template recipe library

### Task 2.2: Chat Interface (5 gün)
- [ ] Message rendering system
- [ ] Input handling & validation
- [ ] Command history storage
- [ ] Message streaming display

### Task 2.3: Plan Generation (4 gün)
- [ ] NL → Plan conversion
- [ ] Plan visualization in chat
- [ ] Plan approval workflow
- [ ] Plan execution pipeline
- [ ] "Plan Generation" altına: "NL → Plan zamanı ContextSelector siqnalları (pins/symbol/import) RAG retriever-ə ötürülür; nəticə Top-K (5–8 fayl) ilə məhdud."

### Task 2.4: MVP Orchestrator (3 gün)
- [ ] Simple Helmlet spawning
- [ ] Basic execution flow
- [ ] Error handling & recovery
- [ ] Result display in chat

### Task 2.5: Integration (2 gün)
- [ ] Chat ↔ Tasks panel sync
- [ ] Command routing
- [ ] State persistence
- [ ] Performance optimization

## ✅ **MVP Success Criteria**
- [ ] "Add user endpoint" generates working plan
- [ ] "Fix failing tests" gives useful suggestions
- [ ] Chat responds in <3s (heuristic mode)
- [ ] Plans execute without crashes
- [ ] Fallback always works when AI fails
- [ ] "Pinned files həmişə kontekstdə; RAG gətirdiyi fayllar ≤8."

## 🚀 **User Value**
"I can talk to AI and get structured plans for my development tasks"

## 📈 **North-Star Metrics**

### Core Performance Indicators
- **Time-to-Plan (TTP)**: NL input → structured plan generation ↓
- **Plan Accuracy**: Generated plans actually executable without modification ↑
- **Classification Success**: Goals correctly classified into recipes ↑
- **Response Latency**: Chat response time in heuristic mode ↓

### Learning Loop Integration
```typescript
// Plan generation learning cycle
class PlanLearningLoop {
  async observePlanSuccess(plan: Plan, executionResult: Result): Promise<void> {
    // Track which plans succeed vs fail
    // Learn from user modifications to generated plans
    // Improve recipe selection based on outcomes
  }
}
```

## 🔄 **Next Phase Connection**
Phase 3 adds actual code generation and file editing to execute the plans.