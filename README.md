# Google Antigravity 日本語 スターター

[Antigravity IDE](https://antigravity.google/) を実務で利用するためのスターターテンプレートです。  

## 背景の説明

Cursor Composerとの比較から、Antigravityが大規模開発で躓く技術的な要因を分析し、その課題を解決するための実験的なワークスペースです。
ユーザー環境やワークスペース（プロジェクト）ごとに異なる挙動を示し、完全に制御できるわけではありませんが、`/ask`や`/grasp` などのコマンドを利用しながら、Antigravity IDE の挙動や、`.agent/rules`、`.agent/workflows`、`.agent/skills` の考え方を理解することができます。

### コンテキスト認識のアプローチの違い
* **Cursor:** リポジトリ全体を事前にインデックス化し、RAG的に正確な依存関係を引き出してから回答を生成します。
* **Antigravity:** 事前のインデックス化を行わず、長いコンテキストウィンドウを活用して、その都度必要な情報を動的に読み込みます（Gemini汎用モデルの推論能力に依存）。

### エージェントの自由度
Antigravityのエージェントは「自律的にタスクを解決する」権限が強いため、不明点があった際に「ユーザーに聞く」のではなく「ありそうなコードを生成して進める」挙動を取りがちです。  
長いコンテキストウィンドウに依存し、エージェントがその都度必要な情報を推論して取得します。この過程で、読み込み漏れた依存関係を補完能力で埋めてしまい、コードのハルシネーションを引き起こします。

### 実践的解決策
1. 明示的なコンテキスト注入
2. 「わからない時は止まる」指示
3. Rules、Workflows、Agent Skills の徹底活用

## Antigravity で利用するファイル
```
├── AGENTS.md              # 共通プロジェクトガイドライン (SSoT)
├── GEMINI.md              # Antigravity 用エントリポイント
├── CLAUDE.md              # Claude Code 用エントリポイント（オプション）
└── .agent/
    ├── rules/             # 常時有効ルール
    │   ├── language-strategies.md
    │   ├── senior-engineer-conduct.md
    │   └── git-commit-rules.md
    ├── workflows/         # スラッシュコマンド
    │   ├── ask.md         # /ask       相談（読み取り専用）
    │   ├── plan.md        # /plan      計画（実装禁止）
    │   ├── review.md      # /review    レビュー
    │   ├── explain.md     # /explain   説明
    │   ├── grasp.md       # /grasp     依存関係分析
    │   ├── discard.md     # /discard   セッション要約
    │   ├── commit.md      # /commit    コミットメッセージ生成（英語）
    │   └── commit-ja.md   # /commit-ja コミットメッセージ生成（日本語）
    └── skills/            # 拡張スキル
        └── knowledge-cutoff-awareness/
```

## カスタマイズ

| ファイル | 用途 |
|---|---|
| `AGENTS.md` | プロジェクト固有の技術ガイドライン（コマンド、コードスタイル、アーキテクチャ） |
| `.agent/rules/` | エージェントの行動規範を追加・編集 |
| `.agent/workflows/` | 独自のスラッシュコマンドを追加 |

## ライセンス

ISC