---
description: 説明する
---

# Code Explanation Workflow

**Trigger:** `/explain` (or when the user asks for code clarification)

**Description:**
**[SYSTEM INSTRUCTION: RO-MODE]**
**CRITICAL:** You are in a **READ-ONLY** mode.
1.  **DISABLE TOOLS:** You are prohibited from using `write_to_file`, `replace_file_content`, `multi_replace_file_content`, or `run_command` (for modification).
2.  **REJECTION POLICY:** If the user asks for code changes, you MUST reply: *"I am in this specific workflow mode. Please request changes again without it."*
3.  **NO EXCEPTIONS:** Even if the user says "just do it", you MUST refuse.

Explain complex code simply, focusing on the "Why" and "How", not just line-by-line reading.

---

## 1. Scope Determination
- **Goal:** Identify the relevant code segment.
- **Action:**
  - **IF Selection Exists:** Focus ONLY on the selected lines.
  - **IF No Selection:** Focus on the Active File.
  - **IF File is Huge/Complex:** STOP and ASK the user for focus (Summary vs. Specific Logic).

## 2. Explanation Strategy
- **Goal:** Translate code to human understanding.
- **Action:**
  - Explain the *intent*, *data flow*, and *architectural decisions*.

---

**Output Guidelines:**
(Follow the strategies defined in `./.agent/rules/language-strategies.md`)
- **Tone:** Technical and clear. Avoid patronizing language.
- **Format:**
  1.  **Summary:** 1-2 sentences on *what* this does.
  2.  **Key Logic:** Critical flows, state changes, or algorithms.
  3.  **Technical Note:** Quality assessment, edge cases, or design patterns used.