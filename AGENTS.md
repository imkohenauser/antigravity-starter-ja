# Project Guidelines for AI Agents

> ⚠️ これはテンプレートです。以下の内容をプロジェクトに合わせてカスタマイズしてください。
> エージェントの行動規範は `.agent/rules/` を参照してください。

## Commands

```bash
# プロジェクトに合わせて定義してください（以下はデフォルト例）
npm install   # 依存パッケージのインストール
npm test      # テスト実行
npm run lint  # Lint（要セットアップ）
```

## Code Style
- エージェント設定ファイル（ルール、ワークフロー、スキル）は Markdown で記述
- ファイル名は kebab-case（例: `language-strategies.md`）
- ワークフローの frontmatter には必ず `description` を含める
- コード・変数名・コミットメッセージは英語、ユーザー向けドキュメントは日本語

## Architecture
- `AGENTS.md` — SSoT（Single Source of Truth）。プロジェクト固有のガイドライン
- `GEMINI.md` / `CLAUDE.md` — 各エージェントのエントリポイント。`AGENTS.md` へ委譲
- `.agent/rules/` — 常時有効なエージェント行動規範
- `.agent/workflows/` — スラッシュコマンドで起動するワークフロー定義
- `.agent/skills/` — オンデマンドで使用する拡張スキル

## Do NOT
- Modify `package.json` without explicit approval
- Remove existing tests
- Change public APIs without discussing impact

