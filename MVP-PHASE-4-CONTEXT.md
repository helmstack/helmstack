# 🧠 MVP Phase 4: Context Intelligence (2.5 həftə)

## 🎯 **MVP Məqsəd**
AI understands project structure - daha yaxşı context = daha yaxşı kod.

## 📦 **Deliverables**
- ✅ Index panel with file/symbol browser
- ✅ Basic pin system for important files
- ✅ Simple import graph
- ✅ Improved AI context quality
- ✅ "Index panel" və "Pin system" qalır; kontekst seçimi indi 4.5 vasitəsilə RAG-a siqnal verir

## 🗂️ **Index System**

### 4.1 Basic Symbol Indexing
```typescript
interface Symbol {
  name: string;
  type: 'function' | 'class' | 'interface' | 'variable';
  file: string;
  line: number;
  exported: boolean;
}

interface FileIndex {
  path: string;
  symbols: Symbol[];
  imports: Import[];
  exports: Export[];
  lastModified: Date;
}

class BasicIndexer {
  async indexWorkspace(): Promise<FileIndex[]> {
    // Simple AST parsing for TS/JS
    // Regex-based for other languages
  }
}
```

### 4.2 Index Panel
```typescript
class IndexPanel extends Panel {
  files: FileIndex[] = [];
  pins: Pin[] = [];
  filter: string = '';

  // p = Pin/Unpin file
  // enter = Go to file
  // / = Start search
  // f = Filter by type
}
```

## 📍 **Pin System**

### 4.3 Simple Pin Management
```typescript
interface Pin {
  id: string;
  path: string;
  type: 'file' | 'directory';
  reason: string;
  addedAt: Date;
}

class PinManager {
  pins: Pin[] = [];

  async addPin(path: string, reason: string): Promise<void>;
  async removePin(path: string): Promise<void>;
  async getPinnedContext(): Promise<string[]>;
}
```

### 4.4 Smart Context Selection
```typescript
class ContextSelector {
  async selectRelevantFiles(goal: string, maxFiles: number = 5): Promise<string[]> {
    const files: string[] = [];

    // 1. Always include pinned files
    files.push(...await this.getPinnedFiles());

    // 2. Find files mentioned in goal
    files.push(...await this.findMentionedFiles(goal));

    // 3. Find related files (imports/exports)
    files.push(...await this.findRelatedFiles(files));

    // 4. Find test files
    files.push(...await this.findTestFiles(files));

    return files.slice(0, maxFiles);
  }
}
```

## 🕸️ **Basic Import Graph**

### 4.5 Import Analysis
```typescript
interface ImportGraph {
  nodes: FileNode[];
  edges: ImportEdge[];
}

interface FileNode {
  path: string;
  imports: string[];
  exports: string[];
  size: number;
}

class ImportAnalyzer {
  async buildGraph(): Promise<ImportGraph> {
    // Simple import/export tracking
    // No complex dependency analysis yet
  }

  async findRelatedFiles(basePath: string): Promise<string[]> {
    // Files that import/export from basePath
  }
}
```

## 📊 **Task Breakdown**

### Task 4.1: Symbol Indexing (4 gün)
- [ ] TypeScript/JavaScript AST parsing
- [ ] Symbol extraction & storage
- [ ] Basic search functionality
- [ ] Incremental updates

### Task 4.2: Index Panel (3 gün)
- [ ] File tree rendering
- [ ] Symbol list display
- [ ] Search & filter UI
- [ ] Navigation integration

### Task 4.3: Pin System (2 gün)
- [ ] Pin management interface
- [ ] Pin persistence
- [ ] Context integration
- [ ] Pin suggestions

### Task 4.4: Context Intelligence (3 gün)
- [ ] Smart file selection
- [ ] Context optimization
- [ ] Relevance scoring
- [ ] Integration with AI
- [ ] "RAG siqnallaşdırma inteqrasiyası"

### Task 4.5: Import Graph (3 gün)
- [ ] Import/export parsing
- [ ] Dependency tracking
- [ ] Related file discovery
- [ ] Graph visualization (basic)

## ✅ **MVP Success Criteria**
- [ ] Index builds for 1000+ file projects in <10s
- [ ] Pinned files always included in AI context
- [ ] Context selection improves AI response quality
- [ ] Index panel navigates smoothly
- [ ] Import graph shows basic dependencies
- [ ] "Top-K fayl limitinə əməl; pinlər həmişə daxil."

## 🚀 **User Value**
"AI understands my project structure and gives better, more contextual suggestions"

## 📈 **North-Star Metrics**

### Core Performance Indicators
- **Context Hit-Rate**: Files in context actually used in generated patches ↑
- **Index Build Time**: Time to index large projects ↓
- **Pin Relevance**: Pinned files contribute to successful patches ↑
- **Context Quality Score**: AI response quality with context vs without ↑

### Learning Loop Integration
```typescript
// Context intelligence learning cycle
class ContextLearningLoop {
  async learnFromContextUsage(context: Context, patchResult: PatchResult): Promise<void> {
    // Track which context files are actually used
    // Learn patterns of file relevance
    // Improve pin suggestions based on usage
    // Optimize import graph traversal
  }

  async updateRelevanceScoring(patterns: ContextPattern[]): Promise<void> {
    // Update file relevance algorithms
    // Improve context selection over time
    // Adapt to project-specific patterns
  }
}
```

## 🔄 **Next Phase Connection**
Phase 5 adds multiple AI providers to take advantage of better context.