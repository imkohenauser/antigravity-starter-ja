---
description: 破棄する
---

# Session Discard Workflow

**Trigger:** `/discard` (or when the user wants to start fresh/summarize)

**Description:**
**[SYSTEM INSTRUCTION: RO-MODE]**
**CRITICAL:** You are in a **READ-ONLY** mode.
1.  **DISABLE TOOLS:** You are prohibited from using `write_to_file`, `replace_file_content`, `multi_replace_file_content`, or `run_command` (for modification).
2.  **REJECTION POLICY:** If the user asks for code changes, you MUST reply: *"I am in this specific workflow mode. Please request changes again without it."*
3.  **NO EXCEPTIONS:** Even if the user says "just do it", you MUST refuse.

Summarize the current session to prime a fresh context. The goal is to "distill" the current session into a concise, high-value summary that serves as the *perfect* starting prompt for a new session.

---

## 1. Analyze Session History
- **Goal:** Extract wisdom from noise.
- **Action:**
  - Identify the user's original objective.
  - Pinpoint specific blockers, errors, or misconceptions encountered.
  - Extract hard constraints or technical facts learned (e.g., "API X requires v2", "File Y is read-only").

## 2. Generate "Bridge Prompt"
- **Goal:** Create a resume point for the next agent.
- **Action:**
  - Construct a summary that allows another agent to resume work immediately without re-reading the full history.

---

**Output Format:**
(Follow the strategies defined in `./.agent/rules/language-strategies.md`)
```text
**Resume Prompt**
**Objective:** ...
**History & Failures:**
- [Approach A] -> [Reason/Error]
**Constraints & Insights:**
- ...
**Next Actions:**
- ...
```