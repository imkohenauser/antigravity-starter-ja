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

## ルール (Rules)

`.agent/rules/` ディレクトリに配置されたマークダウンファイルは、エージェントが**常に**遵守すべき行動規範として機能します。

*   **`senior-engineer-conduct.md`**: シニアエンジニアとしての振る舞い（安全性、透明性、思考の深さ）を強制します。
*   **`git-commit-rules.md`**: GitHub のコミットメッセージ形式を強制します。
*   **`language-strategies.md`**: 言語使用に関する戦略です。
    *   **注意**: 内部推論（CoT）やコード自体は英語が推奨されるため、**エージェントの出力が完全に日本語になるわけではなく、日本語出力の可能性が高まるルールです**。
    *   ユーザー向けの最終出力（チャット、ドキュメント）は日本語になるよう指示されています。

## ワークフロー（Workflows）

Antigravity のチャット欄で `/` (スラッシュ) を入力すると、利用可能なワークフロー（`.agent/workflows/*.md` で定義されたコマンド）の一覧がオートコンプリート候補として表示されます。

*   **`/ask`**: ファイルを変更せずに相談のみを行う
*   **`/grasp`**: コードの依存関係や役割を分析する
*   **`/review`**: コードやテキストのレビューを受ける

これらは一例であり、`.agent/workflows/` ディレクトリで定義されたすべてのワークフローを実行できます。
また、エディタ右下の `Antigravity - Settings > Customizations [Manage] > Workflows` から、グローバルまたは現在のワークスペース固有のスラッシュコマンドを追加・編集できます。

詳細な仕様については [Antigravity Documentation: Rules & Workflows](https://antigravity.google/docs/rules-workflows) を参照してください。

## スキル (Agent Skills)

Skills は、エージェントに追加の能力（外部ツール連携、特定のデータ取得方法など）を与えるための仕組みです。`.agent/skills/` ディレクトリに配置された各スキルの `SKILL.md` に定義された手順に従ってエージェントが行動します。

### knowledge-cutoff-awareness (プリインストール済み)

このスターターテンプレートには、エージェントに「現在のシステム時刻」を認識させるスキルがあらかじめ組み込まれています。

*   **機能**: 現在の日時を取得し、相対的な日付計算（明日、先週など）を行います。
*   **利点**: 学習データのカットオフ（Knowledge Cutoff）を意識し、「2026年の最新情報」などを検索する際に適切な時間的コンテキストを提供します。
*   **ソース**: [github.com/imkohenauser/knowledge-cutoff-awareness](https://github.com/imkohenauser/knowledge-cutoff-awareness)

詳細な仕様については [Antigravity Documentation: Skills](https://antigravity.google/docs/skills) を参照してください。


## カスタマイズ

| ファイル | 用途 |
|---|---|
| `AGENTS.md` | プロジェクト固有の技術ガイドライン（コマンド、コードスタイル、アーキテクチャ） |
| `.agent/rules/` | エージェントの行動規範を追加・編集 |
| `.agent/workflows/` | 独自のスラッシュコマンドを追加 |

## ライセンス

ISC