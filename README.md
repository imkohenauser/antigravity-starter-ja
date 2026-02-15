# Antigravity Starter (Japanese Edition)

**Antigravity 日本語環境開発スターター 🇯🇵**

[Google Antigravity IDE](https://antigravity.google/) を、エンジニアやデザイナーが実務で利用するための「AIエージェントとの開発」スターターテンプレートです。

## 特徴

- **マルチエージェント対応** — Antigravity / Claude Code の両方で動作する設計
- **行動規範の組み込み** — 安全優先・透明性・思考の連鎖をルールとして定義済み
- **ワークフロー** — `/ask` `/plan` `/review` `/explain` `/grasp` `/discard` `/commit` `/commit-ja` のスラッシュコマンドを同梱
- **日本語ファースト** — ユーザー向け出力は日本語、コードは英語のルールを標準装備

## クイックスタート

1. このリポジトリをテンプレートとして使用し、新しいリポジトリを作成
2. `AGENTS.md` の `[...]` を自分のプロジェクトに合わせて編集
3. Antigravity または Claude Code で開く

## 構造

```
├── AGENTS.md              # 共通プロジェクトガイドライン (SSoT)
├── GEMINI.md              # Antigravity 用エントリポイント
├── CLAUDE.md              # Claude Code 用エントリポイント
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