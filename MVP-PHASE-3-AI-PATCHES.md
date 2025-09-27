# 🤖 MVP Phase 3: AI & Patches (3 həftə)

## 🎯 **MVP Məqsəd**
AI generates actual code changes - istifadəçi plan approve edir, AI kod yazır və apply edir.

## 📦 **Deliverables**
- ✅ AI code generation (single provider)
- ✅ Atomic patch system
- ✅ Patches panel for review/apply
- ✅ Basic test integration
- ✅ "Context preparation" maddəsinə: "Simple discovery DEPRECATE; RAG-a keçid (Phase 4.5)."

## 🔧 **Patch System**

### 3.1 Atomic Patch Structure
```typescript
interface Patch {
  id: string;
  timestamp: Date;
  goal: string;
  files: FileDiff[];
  status: 'pending' | 'applied' | 'reverted';
  metadata: {
    provider: string;
    confidence: number;
    reasoning: string;
  };
}

interface FileDiff {
  path: string;
  action: 'create' | 'modify' | 'delete';
  oldContent?: string;
  newContent?: string;
  hunks: DiffHunk[];
}
```

### 3.2 Patches Panel
```typescript
class PatchesPanel extends Panel {
  patches: Patch[] = [];
  selectedPatch: Patch | null = null;

  // a = Apply patch
  // r = Revert patch
  // space = Preview patch
  // enter = Select patch
  // d = Delete patch
}
```

## 🤖 **AI Code Generation**

### 3.3 Single Provider Strategy
```typescript
// MVP: Use one provider at a time (no A/B yet)
class MVPCodeGenerator {
  async generateCode(
    goal: string,
    context: Context,
    provider: 'heuristic' | 'openai' | 'anthropic'
  ): Promise<Patch> {
    // Fallback chain: provider → heuristic
    try {
      return await this.generateWithProvider(goal, context, provider);
    } catch (error) {
      return await this.generateWithHeuristic(goal, context);
    }
  }
}
```

### 3.4 Context Collection
```typescript
interface Context {
  goal: string;
  relevantFiles: string[];
  projectStructure: ProjectInfo;
  recentChanges?: string[];
}

class ContextCollector {
  async collectForGoal(goal: string): Promise<Context> {
    // Simple file discovery
    // No complex indexing yet (Phase 4)
    return {
      goal,
      relevantFiles: await this.findRelevantFiles(goal),
      projectStructure: await this.analyzeProject()
    };
  }
}
```

## 🧪 **Basic Test Integration**

### 3.5 Test Runner
```typescript
interface TestResult {
  passed: number;
  failed: number;
  duration: number;
  output: string;
  failures?: TestFailure[];
}

class MVPTestRunner {
  async runTests(pattern?: string): Promise<TestResult> {
    // Support Jest, Vitest, npm test
    // Basic test execution only
  }

  async getFailureHints(failures: TestFailure[]): Promise<string[]> {
    // Simple heuristic hints
    // ML-powered hints in Phase 8
  }
}
```

### 3.6 Test-Fix Workflow
```typescript
// When tests fail after applying patch:
class TestFixWorkflow {
  async handleTestFailure(patch: Patch, failures: TestFailure[]): Promise<void> {
    // 1. Show test failures
    // 2. Generate fix suggestions
    // 3. Offer to auto-fix or revert
    // 4. Apply fix or rollback
  }
}
```

## 📊 **Task Breakdown**

### Task 3.1: Patch System (5 gün)
- [ ] Patch data structure & serialization
- [ ] Atomic apply/revert operations
- [ ] Patch conflict detection
- [ ] Patch storage & persistence

### Task 3.2: Patches Panel (4 gün)
- [ ] Patch list rendering
- [ ] Diff visualization
- [ ] Interactive preview
- [ ] Apply/revert controls

### Task 3.3: AI Integration (5 gün)
- [ ] Provider abstraction layer
- [ ] Code generation pipeline
- [ ] Context preparation → "RAG retriever hook (qısa fallback: heuristic)."
- [ ] Fallback mechanism

### Task 3.4: Test Integration (3 gün)
- [ ] Test runner detection
- [ ] Test execution wrapper
- [ ] Failure analysis
- [ ] Test-fix suggestions

### Task 3.5: Integration (3 gün)
- [ ] Chat → Patch → Apply flow
- [ ] Panel synchronization
- [ ] Error handling
- [ ] Performance optimization

## ✅ **MVP Success Criteria**
- [ ] "Add user endpoint" generates working code
- [ ] Patches apply without breaking existing code
- [ ] Test failures trigger useful fix suggestions
- [ ] Can revert patches cleanly
- [ ] Works with TypeScript/JavaScript projects
- [ ] "Patch planında istifadə edilən faylların ≥60%-i RAG seçimi ilə uyğun gəlir (telemetri lokaldır)."

## 🚀 **User Value**
"AI writes actual code for me and I can safely apply/revert changes"

## 📈 **North-Star Metrics**

### Core Performance Indicators
- **Time-to-Green (TTG)**: Plan → patch → test "yaşıla" qədər orta vaxt ↓
- **First-pass Success**: İlk patch-dən sonra test keçmə faizi ↑
- **Patch Quality**: Generated patches require manual modification ↓
- **Apply Success Rate**: Patches apply without conflicts ↑

### Learning Loop Integration
```typescript
// Patch generation learning cycle
class PatchLearningLoop {
  async recordPatchOutcome(patch: Patch, outcome: PatchOutcome): Promise<void> {
    // Track patch success/failure patterns
    // Learn which contexts produce better patches
    // Improve code generation based on test results
  }

  async updateRunlogEnvelope(patch: Patch): Promise<void> {
    // Record provider, cost, latency metadata
    // Track context hit-rate vs patch success
    // Monitor test-to-green cycles
  }
}
```

## 🔄 **Next Phase Connection**
Phase 4 adds smart context detection to improve AI code quality.