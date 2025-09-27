# 🔀 MVP Phase 5: Multi-Provider (2 həftə)

## 🎯 **MVP Məqsəd**
Best AI provider automatic selection - istifadəçi ən yaxşı nəticəni alır.

## 📦 **Deliverables**
- ✅ Multiple AI provider support
- ✅ Smart provider selection
- ✅ Budget tracking & controls
- ✅ Performance comparison
- ✅ Simple A/B testing (sampling)
- ✅ "Performance comparison" → RAG-paylaşılan kontekstlə ədalətli A/B

## 🤖 **Provider Management**

### 5.1 Provider Configuration
```typescript
interface ProviderConfig {
  name: 'openai' | 'anthropic' | 'gemini' | 'ollama' | 'heuristic';
  enabled: boolean;
  apiKey?: string;
  model?: string;
  priority: number;
  costPerToken: number;
  averageLatency: number;
}

interface ProviderSettings {
  primary: string;
  fallback: string;
  budget: BudgetConfig;
  sampling: SamplingConfig;
}
```

### 5.2 Smart Provider Selection
```typescript
class ProviderSelector {
  async selectBestProvider(
    goal: string,
    context: Context,
    budget: Budget
  ): Promise<string> {
    // Simple heuristics:
    // - Complex tasks → GPT-4
    // - Simple tasks → GPT-3.5 or heuristic
    // - Budget exhausted → heuristic
    // - API down → fallback
  }

  async shouldRunAB(context: Context): Promise<boolean> {
    // Run A/B only 1 in 10 requests
    // Only when budget allows
    // Only for non-trivial tasks
  }
}
```

## 💰 **Budget Management**

### 5.3 Budget Tracking
```typescript
interface Budget {
  dailyLimit: number;
  dailySpent: number;
  tokenLimit: number;
  tokensUsed: number;
  providerBreakdown: Record<string, number>;
}

class BudgetManager {
  budget: Budget;

  async checkBudgetAvailable(estimatedCost: number): Promise<boolean>;
  async trackSpending(provider: string, cost: number): Promise<void>;
  async optimizeForBudget(request: AIRequest): Promise<ProviderConfig>;
}
```

### 5.4 Budget Display
```
┌─ Budget Status ──────────────────────┐
│ Daily: $2.34 / $5.00  [███▒▒] 47%   │
│ Tokens: 15.2K / 50K   [██▒▒▒] 30%   │
│                                      │
│ Active: GPT-4 (best quality)        │
│ Fallback: Heuristic (free)          │
│ A/B Tests: 2/10 today               │
└──────────────────────────────────────┘
```

## 🧪 **Simple A/B Testing**

### 5.5 Sampling Strategy
```typescript
class SimpleABTester {
  async runSampledAB(
    goal: string,
    context: Context
  ): Promise<ProviderResult[]> {
    // Only run A/B for:
    // - Every 10th request
    // - When budget allows
    // - Non-trivial tasks (>10 tokens)

    if (!this.shouldRunAB()) {
      return [await this.runSingleProvider(goal, context)];
    }

    // Run 2 providers max
    const providers = this.selectABProviders();
    return await Promise.all(
      providers.map(p => this.runProvider(p, goal, context))
    );
  }

  private shouldRunAB(): boolean {
    const random = Math.random();
    const budgetOk = this.budgetManager.hasRoomForAB();
    const frequencyOk = this.abCounter % 10 === 0;

    return random < 0.1 && budgetOk && frequencyOk;
  }
}
```

### 5.6 Performance Tracking
```typescript
interface ProviderMetrics {
  provider: string;
  averageLatency: number;
  successRate: number;
  averageCost: number;
  userSatisfaction: number; // simple thumbs up/down
  lastUsed: Date;
}

class MetricsCollector {
  async recordMetrics(result: ProviderResult, userFeedback?: boolean): Promise<void>;
  async getProviderRanking(): Promise<ProviderMetrics[]>;
  async optimizeSelection(history: ProviderResult[]): Promise<void>;
}
```

## 📊 **Task Breakdown**

### Task 5.1: Provider Infrastructure (3 gün)
- [ ] Multi-provider abstraction
- [ ] Configuration management
- [ ] Provider health checking
- [ ] Fallback mechanisms

### Task 5.2: Selection Logic (2 gün)
- [ ] Smart provider selection
- [ ] Budget-aware routing
- [ ] Performance-based decisions
- [ ] Context-aware optimization
- [ ] "shared-context mode" bayrağı

### Task 5.3: Budget System (2 gün)
- [ ] Budget tracking & limits
- [ ] Cost estimation
- [ ] Spending visualization
- [ ] Budget alerts
- [ ] RAG çağırışlarının token/cost ölçümü (status bar)

### Task 5.4: A/B Testing (3 gün)
- [ ] Sampling strategy
- [ ] Parallel execution
- [ ] Result comparison
- [ ] Simple scoring

### Task 5.5: Integration (4 gün)
- [ ] UI integration
- [ ] Metrics collection
- [ ] Performance monitoring
- [ ] User feedback system

## ✅ **MVP Success Criteria**
- [ ] Automatically selects best available provider
- [ ] Stays within daily budget limits
- [ ] Falls back gracefully when providers fail
- [ ] A/B testing improves results over time
- [ ] Works with OpenAI, Anthropic, local models
- [ ] "A/B yalnız büdçə imkan verəndə; eyni kontekstlə provider müqayisəsi."

## 🚀 **User Value**
"Always get the best AI results while staying within budget"

## 🔄 **Next Phase Connection**
Phase 6 adds security and safety to make this production-ready.