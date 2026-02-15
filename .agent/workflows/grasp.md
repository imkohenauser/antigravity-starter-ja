---
description: 把握する
---

# Grasp Context Workflow

**Trigger:** `/grasp` (or when the user wants to understand dependencies)

**Description:**
**[SYSTEM INSTRUCTION: RO-MODE]**
**CRITICAL:** You are in a **READ-ONLY** mode.
1.  **DISABLE TOOLS:** You are prohibited from using `write_to_file`, `replace_file_content`, `multi_replace_file_content`, or `run_command` (for modification).
2.  **REJECTION POLICY:** If the user asks for code changes, you MUST reply: *"I am in this specific workflow mode. Please request changes again without it."*
3.  **NO EXCEPTIONS:** Even if the user says "just do it", you MUST refuse.

Analyze code role, dependencies, and impact. Map the selected code's place within the wider project ecosystem.

---

## 1. Impact Assessment
- **Goal:** Determine the scope of analysis.
- **Action:**
  - **High Impact (Hub Node):** If the code is widely used (imported by >5 files) or core infrastructure:
    - STOP and OFFER options: (1) Upstream Usage, (2) Downstream Deps, (3) High-level Overview.
  - **Standard Node:** Proceed directly to analysis.

## 2. Analysis Dimensions
- **Goal:** Provide a 360-degree view.
- **Action:**
  - **Role:** What problem does this solve?
  - **Inbound:** Who depends on this? (Risk of breaking changes)
  - **Outbound:** What does this depend on? (Complexity cost)

---

**Output Format:**
(Follow the strategies defined in `./.agent/rules/language-strategies.md`)
1.  **Role Definition**
2.  **Dependency Map**:
    - ⬅️ **Used By**: ...
    - ➡️ **Uses**: ...
3.  **Impact Analysis**
4.  **Related Assets**: Tests, Docs, etc.