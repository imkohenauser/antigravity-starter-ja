---
description: 計画する
---

# Planning Workflow

**Trigger:** `/plan` (or when the user explicitly asks for a plan)

**Description:**
**[SYSTEM INSTRUCTION: PLAN-ONLY-MODE]**
**CRITICAL:** You are in **PLANNING MODE**.
1.  **DISABLE SOURCE EDITING:** You are prohibited from editing `src/` or project files. You may ONLY write to `implementation_plan.md` (or similar artifacts).
2.  **STOP AFTER PLAN:** Do NOT implement the plan. Do NOT write code.
3.  **REJECTION POLICY:** If the user asks to "implement it now", you MUST reply: *"I have created the plan. Please review it, then ask me to implement it in a new turn."*

Forces a deep reasoning and planning phase akin to "Planning Mode," regardless of the current agent mode (Fast/Pro). This workflow strictly prohibits immediate code execution and focuses solely on generating a comprehensive implementation plan artifact.

---

## 1. Context Analysis & Research
- **Goal:** Understand the user's request and the existing codebase structure.
- **Action:**
  - Read relevant files to understand the current implementation.
  - Identify dependencies, potential risks, and architectural impact.
  - Do NOT modify any source code files during this step.

## 2. Artifact Generation (The "Brain" Protocol)
- **Goal:** Persist the plan into the agent's memory structure.
- **Strict Requirement:** You MUST create or update a markdown file in the appropriate planning directory.
- **Directory Safety:**
  - IF the target directory does not exist OR the location is ambiguous: **STOP and ASK the user for the intended destination.**
- **File Naming Convention:**
  - Default: `implementation_plan.md`
  - For Refactoring: `refactoring_plan.md`
  - For Tasks: `task.md`

## 3. Plan Content Requirements
(Follow the strategies defined in `./.agent/rules/language-strategies.md`)
The generated markdown file MUST include the following sections:
1.  **Objective:** Clear summary of what needs to be achieved.
2.  **Analysis:** Current state vs. Desired state.
3.  **Proposed Changes:**
    - List of files to create or modify.
    - Specific logic changes (pseudo-code or signatures).
    - **Verification Plan:** How will we verify the changes work? (e.g., specific test cases).
4.  **Risk Assessment:** Potential side effects or hallucinations to avoid.

## 4. Strict Implementation Prohibition
- **Goal:** Separate "Planning" from "Coding".
- **Rules:**
  - **ABSOLUTE PROHIBITION:** You are FORBIDDEN from modifying any project source code files during this workflow.
  - **Allowed Writes:** You may ONLY create or update the planning artifact file (e.g., `implementation_plan.md`).
  - **Termination:**
    - After saving the plan, **STOP**.
    - **Reply:** "Plan created. To proceed with implementation, please review this plan and send a new request (e.g., 'Go ahead')."

---

**System Instruction:**
Treat the generation of the `implementation_plan.md` as the final output of this workflow. Do not attempt to "be helpful" by implementing the code immediately. Speed is NOT the priority; accuracy and architectural integrity are.