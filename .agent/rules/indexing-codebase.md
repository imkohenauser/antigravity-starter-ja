---
trigger: always_on
globs: ["**/*"]
---

# Project Structure Awareness (プロジェクト構造認識)

**Activation:** This rule is **ALWAYS ON** for all files (`**/*`).

> **Positioning:** `senior-engineer-conduct.md` の原則を、プロジェクト構造の
> **インデックス化と依存関係の検索** に具体化したルールです。
> 原則的な行動規範は `senior-engineer-conduct.md` を参照。このルールは **具体的な行動手順** のみを定めます。

## 1. Index Before Act (行動前にインデックスを取る)
- 新しいタスクを開始する際、**まずプロジェクト構造を把握する**。推測で作業を始めない。
- 具体的な手段：
    - `ls`, `find`, `tree` でディレクトリ構造を確認
    - **`indexing-awareness` スキルの `index-structure.sh` を実行**
- エントリポイント（`main`, `App`, `index`, `routes` 等）を特定し、アーキテクチャ（レイヤリング、ドメイン境界）と技術スタックを認識する。

## 2. Grep, Don't Guess (推測せず検索する)
- **存在しない関数・型・モジュールを捏造しない。** 確証がなければ `grep` で実在確認する。
- 具体的な手段：
    - `grep -rnI "symbol_name" --include="*.ext" .`
    - **`indexing-awareness` スキルの `trace-dependencies.sh <ファイルまたはシンボル>` を実行**
- 変更対象ファイルの **Forward（参照先）** と **Reverse（被参照元）** の両方を確認してから編集する。
- 循環参照のリスクがある依存関係を追加する場合、事前に警告する。

## 3. Verify After Change (変更後に検証する)
- ファイルの追加・削除・リネーム後、旧パスや旧名称への参照が残っていないか `grep` で確認する。
- ルール・ワークフロー・スキルの構成を変更した場合、**`verify-structure.sh` でドキュメント整合性を検証する**。