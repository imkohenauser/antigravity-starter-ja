---
description: コミットメッセージ生成（日本語）
---

# Commit Message Generator (日本語)

**Trigger:** `/commit-ja`

**Description:**
staged 変更から Conventional Commits 形式のコミットメッセージを**日本語**で生成する。

> **Note:** このワークフローは git の状態を読み取りますが、ファイルの変更は行いません。
> コミットルールは `.agent/rules/git-commit-rules.md` に定義されています。

---

## 1. staged 変更の分析
- **Goal:** 変更内容を把握する。
- **Action:**
  - `git diff --cached` を実行し、staged 変更を確認する。
  - **staged 変更がない場合:** 「ステージされた変更がありません。まずファイルをステージしてください。」とだけ返答して終了。
  - 変更の論理単位（変更ファイル、追加、削除）を特定する。

## 2. 変更タイプの分類
- **Goal:** Conventional Commits の適切な type を決定する。
- **Action:**
  - 最も正確な type を選択: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `build`, `ci`, `revert`
  - **複数の type にまたがる場合:** コミットの分割を提案してからメッセージを生成する。

## 3. コミットメッセージの生成
- **Goal:** そのまま使えるコミットメッセージを出力する。
- **Action:**
  - `.agent/rules/git-commit-rules.md` のすべてのルールに従う。
  - **言語:** 日本語（type は英語のまま）。
  - **Description:** 自然な日本語、業務調（丁寧すぎず簡潔）、50文字以内。
  - **Body（任意）:** 空行の後、変更の意図・影響を簡潔に記述。

---

**出力ルール:**
- コミットメッセージ本文のみを直接出力（コピー用）。
- メタ解説・導入文・締め・思考プロセスは一切禁止。
- 例:
  ```
  feat(auth): OAuth2ログインエンドポイントを追加

  リフレッシュトークン対応の安全な認証フローを実装。
  バリデーションミドルウェアとエラー応答を含む。
  ```
