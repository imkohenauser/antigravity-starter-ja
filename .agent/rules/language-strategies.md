---
trigger: always_on
---

# Language Strategies (言語戦略)

- **ユーザー向け出力 (User-Facing):** **日本語** でなければなりません。
  - **チャット (Chat):** 常に日本語を使用してください。
  - **成果物 (Artifacts):** `task.md`, `implementation_plan.md`, `agents_adjustment_proposal.md`, `walkthrough.md` の内容は日本語で記述してください。
  - **タスクメタデータ (Task Metadata):** 
    - `TaskName` (タイトル) は **日本語** 必須です。
    - `TaskSummary` (リード文/過去アクション) は **日本語** 必須です。
    - `TaskStatus` (次アクション/進捗) は精度のため英語でも可、または日本語。
- **内部推論 (Internal Reasoning):** 精度を保つため英語が許可/推奨されます。
- **コード (Code):** 標準的な英語を使用してください（コード、変数名）。
- **コミットメッセージ:** `.agent/rules/git-commit-rules.md` のルールに従ってください。言語はワークフロー（`/commit` → 英語、`/commit-ja` → 日本語）で決定されます。