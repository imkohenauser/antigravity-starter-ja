# When to Use This Skill

Use this skill whenever the response depends on the **current date, time, or relative dates**.

Typical scenarios include:

- Determining **today's date**
- Checking whether an event is **in the future or past**
- Calculating **relative dates** (yesterday, tomorrow, +7d, etc.)
- Verifying **time-sensitive information**
- Handling questions that may be affected by **AI knowledge cutoff**

Example user queries:

- "What day is it today?"
- "What date will it be 3 weeks from now?"
- "How many days until March 1?"
- "Is today's date after the release of Node 22?"
- "What is the current date?"

Always retrieve the current date from the system rather than assuming it.

# When NOT to Use This Skill

Do NOT use this skill when:

- The question refers to **fixed historical dates**
- The date is **explicitly provided by the user**
- The answer does not require **current time awareness**

Examples:

- "When was the first iPhone released?"
- "What day was January 1, 2000?"

# Agent Instructions

When this skill is invoked:

1. Retrieve the **current system date** using the provided script.
2. Use **ISO 8601 format** unless a human-readable format is required.
3. If a relative date is needed, apply the offset using the script arguments.
4. Use the returned date as the authoritative time reference for reasoning.

Important guidelines:

- Do **not assume the current date**.
- Always prefer **machine-readable ISO 8601 output** for calculations.
- Only convert to human-readable format when presenting results to users.

Run the following commands from the **skill root directory** (e.g. `.agent/skills/knowledge-cutoff-awareness` or `skills/knowledge-cutoff-awareness`). The path `scripts/get_date.js` is relative to that directory.

# Examples for Agents

## Get today's date

```bash
node scripts/get_date.js
```

Example output:

```
2026-02-16T16:55:00+09:00
```

## Calculate tomorrow

```bash
node scripts/get_date.js +1d
```

## Calculate one week ago

```bash
node scripts/get_date.js -1w
```

## Human readable format

```bash
node scripts/get_date.js --human
```

Example output:

```
Mon Feb 16 2026 16:55:00 GMT+0900 (JST)
```

# Reliability Notes

This skill relies on the system clock of the machine executing the script. If the system time is incorrect, the output will also be incorrect.

For critical workflows, ensure that:

- The system clock is synchronized (e.g., via NTP)
- The correct timezone is configured
