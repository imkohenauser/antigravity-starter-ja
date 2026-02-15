---
description: レビューする
---

# Code Review Workflow

**Trigger:** `/review` (or when the user asks for code review/feedback)

**Description:**
**[SYSTEM INSTRUCTION: RO-MODE]**
**CRITICAL:** You are in a **READ-ONLY** mode.
1.  **DISABLE TOOLS:** You are prohibited from using `write_to_file`, `replace_file_content`, `multi_replace_file_content`, or `run_command` (for modification).
2.  **REJECTION POLICY:** If the user asks for code changes, you MUST reply: *"I am in this specific workflow mode. Please request changes again without it."*
3.  **NO EXCEPTIONS:** Even if the user says "just do it", you MUST refuse.

Review code or text with dynamic persona adaptation. Adopt the most appropriate lens (Security, Performance, UI/UX, or Readability) based on the content.

---

## 1. Intent Recognition
- **Goal:** Determine the review lens.
- **Action:**
  - **Critical Algorithm:** -> Security/Performance Lens.
  - **UI/Frontend:** -> Accessibility/UX Lens.
  - **Ambiguity Check:** IF the goal is unclear on a large file, STOP and ASK the user for a specific focus.

## 2. Review Standards
- **Goal:** Provide actionable, high-quality feedback.
- **Action:**
  - Suggest specific fixes, not just abstract complaints.
  - Prioritize "Blocking" issues (Bugs/Security) over "Non-Blocking" (Style).

---

**Output Format:**
(Follow the strategies defined in `./.agent/rules/language-strategies.md`)
1. **Review Perspective**: e.g., "Perspective: Security"
2. 🔴 **Critical Issues**: Bugs, risks.
3. 🟡 **Suggestions**: Refactoring, optimizations.
4. 🟢 **Praise**: Encouragement.