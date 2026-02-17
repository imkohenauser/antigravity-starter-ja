---
name: indexing-awareness
description: プロジェクトの構造インデックスと依存関係トレースにより、RAG的なコンテキスト取得を実現するスキル
---

# Indexing Awareness Skill

Antigravity はリポジトリの事前インデックス化を行わないため、エージェントが **自律的に** プロジェクト構造を把握し、依存関係を検索する必要があります。
このスキルは、Cursor の RAG（事前インデックス + 関連コンテキスト検索）を擬似的に再現するスクリプト群を提供します。

## Triggers (自動実行のタイミング)

エージェントは以下の状況で、対応するスクリプトを **自発的に** 実行すること。
人間からの指示を待たず、ルール `indexing-codebase.md` に従って自律判断する。

| 状況 | 実行するスクリプト |
|---|---|
| 初見のプロジェクト・新しいタスク開始時 | `index-structure.sh` |
| ファイルの変更・追加・削除を行う前 | `trace-dependencies.sh <対象ファイル>` |
| 未知の関数・クラス・シンボルを参照する前 | `trace-dependencies.sh <シンボル名>` |
| ルール・ワークフロー・スキルの構成を変更した後 | `verify-structure.sh` |

## Scripts

### 1. index-structure.sh (構造インデックス)

プロジェクトのディレクトリ構造、ファイル種別、サイズをインデックス化します。

```bash
# 実行権限の付与（初回のみ）
chmod +x .agent/skills/indexing-awareness/scripts/index-structure.sh

# プロジェクト全体のインデックス
./.agent/skills/indexing-awareness/scripts/index-structure.sh

# 探索深度を指定（デフォルト: 4）
./.agent/skills/indexing-awareness/scripts/index-structure.sh --depth 6

# 特定ディレクトリのみ
./.agent/skills/indexing-awareness/scripts/index-structure.sh --dir src/
```

### 2. trace-dependencies.sh (依存関係トレース)

ファイルまたはシンボルの依存関係を **双方向** に検索します。

```bash
chmod +x .agent/skills/indexing-awareness/scripts/trace-dependencies.sh

# ファイルモード: 依存関係の双方向トレース
./.agent/skills/indexing-awareness/scripts/trace-dependencies.sh src/utils/auth.ts

# シンボルモード: 定義元と使用箇所の検索
./.agent/skills/indexing-awareness/scripts/trace-dependencies.sh handleLogin

# 検索範囲を限定
./.agent/skills/indexing-awareness/scripts/trace-dependencies.sh UserService src/
```

**ファイルモード出力:**
- 📥 Forward Dependencies — そのファイルが何を import/require しているか
- 📤 Reverse Dependencies — そのファイルを誰が import/require しているか
- 🔍 Config/Doc References — 設定ファイルやドキュメントからの参照

**シンボルモード出力:**
- 📌 Definitions — 定義元（function, class, const, def, fn 等）
- 📎 Usages — 使用箇所（word boundary マッチ）
- 📦 Import References — import/require/from 文での参照

### 3. verify-structure.sh (ドキュメント整合性チェック)

`.agent/` 内のルール・ワークフロー・スキルと `README.md` の記載整合性を検証します。

```bash
chmod +x .agent/skills/indexing-awareness/scripts/verify-structure.sh
./.agent/skills/indexing-awareness/scripts/verify-structure.sh
```

## Troubleshooting

- **`trace-dependencies.sh` の結果がノイジー**: 第2引数で検索範囲を限定してください。
- **`index-structure.sh` の出力が長すぎる**: `--depth 2` でツリーの深さを制限してください。
- **`verify-structure.sh` で "Missing in README" エラー**: `README.md` に適切な記述を追加してください。
