# 📊 HelmStack Pro - North-Star Metrics & Learning Loop

## 🎯 **Ümumi North-Star Metrikləri**

### Core Performance Indicators (bütün fazalar üçün)
- **Time-to-Green (TTG)**: Plan → patch → test "yaşıla" qədər orta vaxt ↓
- **First-pass Success**: İlk patch-dən sonra test keçmə faizi ↑
- **Human-edit Ratio**: Apply-dan əvvəl manual düzəliş payı ↓
- **Cost per Successful Task**: $/tapşırıq ↓ (provider + token)

### 🔄 **Gündəlik Learning Loop**

```typescript
// Hər gün icra olunan öyrənmə dövrü
class DailyLearningLoop {
  async execute(): Promise<void> {
    // 1. OBSERVE: Runlogs + user feedback toplanır
    const metrics = await this.collectDailyMetrics();
    const feedback = await this.collectUserFeedback();

    // 2. RETRIEVE: Pins + import-graph + symbols → RAG top-K
    const contextPatterns = await this.analyzeContextUsage(metrics);

    // 3. GENERATE/TEST: Patch → tests → auto-fix patterns
    const patchPatterns = await this.analyzePatchSuccess(metrics);

    // 4. SCORE: Success, latency, cost, risk → A/B skorları
    const abResults = await this.analyzeABTestResults(metrics);

    // 5. LEARN: ML artefaktları yenilənir
    await this.updateLearningArtifacts({
      contextPatterns,
      patchPatterns,
      abResults,
      feedback
    });
  }
}
```

## 📈 **Faza-Spesifik Metrikləri**

### MVP Phase 1: Foundation
- **TUI Response Time**: Panel switching < 100ms
- **Workspace Setup Time**: .heck/ initialization < 2s
- **Memory Usage**: CLI resident memory < 50MB

### MVP Phase 2: Chat Interface
- **Time-to-Plan (TTP)**: NL input → structured plan generation ↓
- **Plan Accuracy**: Generated plans actually executable ↑
- **Classification Success**: Goals correctly classified into recipes ↑

### MVP Phase 3: AI Patches
- **Patch Quality**: Generated patches require manual modification ↓
- **Apply Success Rate**: Patches apply without conflicts ↑
- **Test Success Rate**: Patches pass existing tests ↑

### MVP Phase 4: Context Intelligence
- **Context Hit-Rate**: Files in context actually used in patches ↑
- **Index Build Time**: Time to index large projects ↓
- **Pin Relevance**: Pinned files contribute to successful patches ↑

### MVP Phase 4.5: RAG Context Bridge
- **Context Hit-Rate**: Files actually used / Total retrieved ↑
- **Retrieval Latency**: Time to assemble context ↓
- **Policy Compliance**: Unauthorized file access = 0
- **Cache Efficiency**: Cache hit rate for embeddings ↑

### MVP Phase 5: Multi-Provider
- **Provider Selection Accuracy**: Best provider chosen ↑
- **Budget Efficiency**: Cost per successful task ↓
- **A/B Test Value**: Statistically significant improvements ↑

### MVP Phase 6: Security
- **Policy Violation Rate**: Blocked dangerous operations ↑
- **Audit Completeness**: All operations logged = 100%
- **Rollback Success**: Emergency rollback time < 60s

### Enhancement Phase 7: Advanced A/B
- **Statistical Significance**: Valid A/B test results ↑
- **Multi-dimensional Score Accuracy**: Comprehensive quality assessment ↑
- **Optimization Value**: Auto-optimizer beats manual selection ↑

### Enhancement Phase 8: ML Intelligence
- **Prediction Accuracy**: File relevance prediction > 80%
- **Learning Rate**: Performance improvement over time ↑
- **Personalization Value**: Custom recipes outperform generic ↑

### Enhancement Phase 9: Enterprise Security
- **Compliance Score**: SOX/GDPR/HIPAA requirements met = 100%
- **Two-man Rule Efficiency**: Approval workflow time ↓
- **Security Incident Rate**: Unauthorized access = 0

### Enhancement Phase 10: Team Collaboration
- **Team Productivity**: Goals completed per team member ↑
- **Conflict Resolution**: Real-time conflict resolution success ↑
- **Shared Context Value**: Team shared pins improve results ↑

### Enhancement Phase 11: Ecosystem Integration
- **IDE Integration Adoption**: % developers using extensions ↑
- **CI/CD Pipeline Success**: Automated quality gates effectiveness ↑
- **Plugin Ecosystem Health**: Active plugins and marketplace adoption ↑

## 🗄️ **ML Artefaktları (Lokal Storage)**

### .heck/ml/ qovluğunda saxlanılır:
```bash
.heck/ml/
├── file_rank.db           # Fayl relevans skorları
├── provider_scorecard.json # Provider performance məlumatları
├── strategy_recipes.yml    # Optimallaşdırılmış strategiyalar
├── context_patterns.json   # Kontekst istifadə nümunələri
├── patch_success_log.json  # Patch uğur tarixçəsi
├── user_preferences.json   # İstifadəçi tərcihləri
└── daily_metrics/          # Gündəlik metrik arxivləri
    ├── 2024-01-01.json
    ├── 2024-01-02.json
    └── ...
```

## 📊 **TUI Status Bar Integration**

```
┌─ Status ─────────────────────────────────────────────────┐
│ TTG: 2m 34s │ Hit-Rate: 87% │ Cost: $0.12 │ Provider: GPT-4 │
│ Budget: $2.34/$5.00 │ A/B: 3/10 │ Policy: ✓ │ Learning: ↑ │
└──────────────────────────────────────────────────────────┘
```

## 🔄 **Runlog Envelope Metadata**

```typescript
interface RunlogEnvelope {
  // Core metrics
  ttg_seconds: number;              // Time to green
  first_pass_success: boolean;      // Tests passed on first try
  human_edit_ratio: number;         // % of patch manually edited
  cost_usd: number;                 // Total cost for this task

  // Context metrics
  context_hit_rate: number;         // Files used / Files retrieved
  context_latency_ms: number;       // Context assembly time
  context_files_count: number;      // Number of files in context

  // Provider metrics
  provider: string;                 // AI provider used
  model: string;                    // Specific model
  latency_ms: number;              // Provider response time
  tokens_used: number;             // Token consumption

  // Learning signals
  user_feedback?: number;           // -1 to 1 rating
  patch_quality_score: number;     // Automated quality assessment
  policy_violations: number;       // Security policy violations

  // A/B test metadata
  ab_test_id?: string;             // If part of A/B test
  ab_variant?: string;             // Test variant identifier
}
```

## 🎯 **90 Günlük Game-Changer Yol Xəritəsi**

### 0-30 gün — "Ağıllı Kontekst V1"
- RAG retriever-i ContextSelector siqnalları ilə birləşdir
- TUI-də Context Hit-Rate və Top-K fayl göstəricilərini göstər
- Runlog envelope-a cost_usd, latency_ms, provider metalarını yaz

### 30-60 gün — "Öz-özünə yaxşılaşan heck"
- FeedbackLearner + ContextLearner: "thumbs up/down" → pin təklifi
- Simple Auto-fix düyməsi test fail-dən sonra
- Budget göstəricisi + provider seçimi TUI statusuna çıxar

### 60-90 gün — "Self-optimizing orkestrator"
- Advanced A/B panel + Multi-dimensional Scorer
- AutoOptimizer: kontekstə görə model/temperatur auto-tune
- Policy-driven read/write: retriever fayl oxunuşları da PolicyEngine-dən keçir

## 🎉 **Uğur Kriteriyaları**

### MVP Complete (Phase 6 sonrası):
- [ ] TTG < 5 dəqiqə (orta layihələr üçün)
- [ ] First-pass success > 70%
- [ ] Human-edit ratio < 30%
- [ ] Cost per task < $0.50
- [ ] Zero security incidents

### Enterprise Ready (Phase 11 sonrası):
- [ ] TTG < 2 dəqiqə
- [ ] First-pass success > 85%
- [ ] Human-edit ratio < 15%
- [ ] Cost per task < $0.25
- [ ] Full compliance with enterprise security standards

Bu metriklər hər faza üçün spesifik ölçülə bilər və HelmStack Pro-nun real performansını izləməyə imkan verir.