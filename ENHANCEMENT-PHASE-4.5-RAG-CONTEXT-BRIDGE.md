# 🧠 Enhancement Phase 4.5: RAG Context Bridge (1.5 həftə)

## 🎯 **Enhancement Məqsəd**
Phase 4 indeks siqnallarını (pins/symbols/import) RAG retriever ilə birləşdirib, tək "context pipeline" yaratmaq.

## 📦 **Deliverables**
- ✅ ContextSelector → RAG bridge (shared-context mode)
- ✅ Single-source cache: .heck/cache/{embeddings.idx, symbols.json, import-graph.json}
- ✅ Policy-guarded retrieval + audit events
- ✅ TUI: Context Hit-Rate + Top-K göstəriciləri (status/header)

## 🔄 **RAG Context Pipeline**

### 4.5.1 Bridge Architecture
```typescript
interface RAGContextBridge {
  pins: Pin[];
  symbolIndex: SymbolIndex;
  importGraph: ImportGraph;
  retriever: RAGRetriever;
  topK: number; // 5-8 limit
}

class ContextRAGPipeline {
  async assembleContext(
    goal: string,
    projectContext: ProjectContext
  ): Promise<ContextResult> {
    // 1. Pin-priority: always include pinned files
    const pinnedFiles = this.collectPinnedFiles();

    // 2. Mentioned files: parse goal for explicit file mentions
    const mentionedFiles = this.extractMentionedFiles(goal);

    // 3. Import-related: dependency graph navigation
    const importRelated = this.followImportGraph(pinnedFiles, mentionedFiles);

    // 4. RAG retrieval: fill remaining slots with Top-K
    const remainingSlots = this.topK - pinnedFiles.length;
    const ragFiles = await this.retriever.retrieve(goal, remainingSlots);

    // 5. Policy check before read
    const files = [...pinnedFiles, ...mentionedFiles, ...importRelated, ...ragFiles];
    return this.policyGuardedRead(files);
  }
}
```

### 4.5.2 Single-Source Cache
```typescript
interface ContextCache {
  embeddings: EmbeddingIndex;    // .heck/cache/embeddings.idx
  symbols: SymbolDatabase;       // .heck/cache/symbols.json
  importGraph: DependencyGraph;  // .heck/cache/import-graph.json
  lastUpdate: Date;
}

class CacheManager {
  async updateCache(projectFiles: string[]): Promise<void> {
    // Incremental updates only
    // Embeddings for new/changed files
    // Symbol index refresh
    // Import graph rebuild
  }

  async getCachedEmbedding(file: string): Promise<number[]> {
    // Fast lookup from single embedding store
    // No external vector DB required
  }
}
```

## 🛡️ **Policy-Guarded Retrieval**

### 4.5.3 Read-Before-Retrieve Check
```typescript
class PolicyGuardedRetriever {
  async retrieve(
    goal: string,
    maxFiles: number
  ): Promise<ContextFile[]> {
    // 1. RAG ranking without reading files
    const candidates = await this.rankFiles(goal);

    // 2. Policy check for read permissions
    const approved = [];
    for (const file of candidates.slice(0, maxFiles)) {
      const decision = await this.policyEngine.evaluateFileAccess(
        file.path,
        'read'
      );

      if (decision.action === 'allow') {
        approved.push(file);
      } else if (decision.action === 'confirm') {
        const userApproved = await this.requestConfirmation(decision);
        if (userApproved) approved.push(file);
      }
      // 'block' files are skipped
    }

    // 3. Audit logging
    await this.auditLogger.logRetrievalEvent({
      goal,
      candidates: candidates.length,
      approved: approved.length,
      blocked: candidates.length - approved.length
    });

    return approved;
  }
}
```

## 📊 **Performance Monitoring**

### 4.5.4 TUI Context Metrics
```
┌─ Context Status ─────────────────────────┐
│ Hit-Rate: 87% │ Files: 6/8 │ Latency: 340ms │
│ 📌 Pins: 2    │ 🔍 RAG: 3  │ 📋 Imports: 1   │
└──────────────────────────────────────────┘
```

### 4.5.5 Context Performance Tracking
```typescript
interface ContextMetrics {
  hitRate: number;        // Files actually used in patch / Total retrieved
  latency: number;        // Time to assemble context
  costUsd: number;        // Embedding API costs
  cacheHitRate: number;   // Cached vs fresh embeddings
  policyBlocks: number;   // Files blocked by policy
}

class ContextMetricsCollector {
  async recordContextAssembly(
    context: ContextResult,
    patchResult: PatchResult
  ): Promise<void> {
    const usedFiles = patchResult.touchedFiles;
    const hitRate = usedFiles.length / context.files.length;

    await this.updateRunlogEnvelope({
      contextHitRate: hitRate,
      contextLatency: context.assemblyTime,
      contextCost: context.embeddingCost
    });
  }
}
```

## 🔧 **Implementation Tasks**

### Task 4.5.1: RAG Retriever Interface (3 gün)
- [ ] Provider-agnostic retriever abstraction
- [ ] Embedding cache management
- [ ] Similarity ranking algorithms
- [ ] Performance benchmarking

### Task 4.5.2: Context Pipeline Integration (2 gün)
- [ ] Pin-first assembly logic
- [ ] Import graph navigation
- [ ] Top-K limiting with quality threshold
- [ ] Fallback to heuristic when RAG fails

### Task 4.5.3: Policy Integration (2 gün)
- [ ] Read permission checking
- [ ] User confirmation flows
- [ ] Audit event logging
- [ ] Security violation handling

### Task 4.5.4: Performance Optimization (1 gün)
- [ ] Embedding cache optimization
- [ ] Parallel retrieval processing
- [ ] Latency monitoring
- [ ] Memory usage optimization

### Task 4.5.5: TUI Integration (2 gün)
- [ ] Context status indicators
- [ ] Hit-rate visualization
- [ ] Real-time metrics display
- [ ] Performance alerts

## 📈 **North-Star Metrics**

### Core Performance Indicators
- **Context Hit-Rate**: Files actually used in patches / Total retrieved ↑
- **Retrieval Latency**: Time to assemble context ↓
- **Policy Compliance**: Unauthorized file access = 0
- **Cache Efficiency**: Cache hit rate for embeddings ↑

### Learning Loop Integration
```typescript
// Daily context learning cycle
class ContextLearningLoop {
  async dailyLearning(): Promise<void> {
    // Observe: collect context assembly metrics
    const metrics = await this.collectDailyMetrics();

    // Analyze: identify high/low performing contexts
    const patterns = await this.analyzeContextPatterns(metrics);

    // Learn: update file ranking weights
    await this.updateFileRankings(patterns);

    // Optimize: adjust Top-K and similarity thresholds
    await this.optimizeRetrievalParams(patterns);
  }
}
```

## ✅ **Success Criteria**
- [ ] TTG ↓, First-pass ↑ trend (lokal telemetry)
- [ ] Pinned files always included; retrieved files ≤8
- [ ] Policy violations: 0; audit trail tam
- [ ] Context assembly <500ms for projects <10k files
- [ ] Hit-rate >60% for typical development goals

## 🚀 **Value Added**
"Intelligent RAG-powered context assembly with policy compliance and measurable performance improvements"