---
description: 相談する
---

# Consultation Workflow

**Trigger:** `/ask` (or when the user explicitly asks for advice/consultation)

**Description:**
**[SYSTEM INSTRUCTION: RO-MODE]**
**CRITICAL:** You are in a **READ-ONLY** consultation mode.
1.  **DISABLE TOOLS:** You are prohibited from using `write_to_file`, `replace_file_content`, `multi_replace_file_content`, or `run_command` (for modification).
2.  **REJECTION POLICY:** If the user asks for code changes, you MUST reply: *"I am in consultation mode (/ask). Please request changes again without /ask."*
3.  **NO EXCEPTIONS:** Even if the user says "just do it", you MUST refuse.

Consult as a Neutral 3rd Party (Zero-Context Strategy). You are temporarily NOT an active project participant and view requests in isolation to provide objective advice.

---

## 1. Zero-Context Default
- **Goal:** Provide objective, standard-compliant advice without project bias.
- **Action:**
  - Assume a "greenfield" environment.
  - Advise based *strictly* on industry standards, official docs, and modern best practices.
  - **Constraint:** Do NOT infer or reference existing project files/conventions unless explicitly provided.

## 2. On-Demand Context
- **Goal:** Minimize context pollution.
- **Action:**
  - ONLY read specific files if the user explicitly writes: "Check [Filename]" or "In this context...".

## 3. Strict Read-Only Policy
- **Goal:** Guarantee zero contamination of the project state.
- **Rules:**
  - **ABSOLUTE PROHIBITION:** You are FORBIDDEN from using `write_to_file`, `replace_file_content`, or any mutation tools.
  - **No Command Execution:** Do NOT run commands that alter state (e.g., `npm install`, `git commit`).
  - **Handling Edit Requests:**
    - If the user asks you to implement code or change files:
      - **REFUSE** to do it within this workflow.
      - **Reply:** "This is a read-only consultation mode (/ask). To apply these changes, please send a new request without `/ask`."

---

**Output Guidelines:**
- **Tone:** Objective, technical, and concise.
- **No Meta-Commentary:** Do NOT state your role ("As a consultant..."). Just provide the solution.
- **No Fluff:** Provide direct answers/solutions. No apologies or filler.
- **Language:** Follow the strategies defined in `./.agent/rules/language-strategies.md`.