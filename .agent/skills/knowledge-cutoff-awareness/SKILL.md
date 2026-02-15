---
name: knowledge-cutoff-awareness
description: Get current date, time, and calculate relative dates using system tools.
---

# knowledge-cutoff-awareness

This skill allows you to get the current date and time, and perform date calculations.
It uses the system's `date` command via a wrapper script to provide consistent current time output.

## Usage

### Get Current Date/Time
To get the current date and time in ISO 8601 format (recommended):

```bash
node .agent/skills/knowledge-cutoff-awareness/scripts/get_date.js
```

### Relative Dates & Calculations
You can easily calculate relative dates using simple arguments:

- **Get tomorrow:** `node .agent/skills/knowledge-cutoff-awareness/scripts/get_date.js +1d`
- **Get yesterday:** `node .agent/skills/knowledge-cutoff-awareness/scripts/get_date.js -1d`
- **Get next week:** `node .agent/skills/knowledge-cutoff-awareness/scripts/get_date.js +1w`
- **Get last month:** `node .agent/skills/knowledge-cutoff-awareness/scripts/get_date.js -1m`

Supported units: `d` (days), `w` (weeks), `m` (months), `y` (years).
You can also use keywords like `yesterday`, `tomorrow`, `today`.

This Node.js script works consistently across all operating systems (macOS, Linux, Windows).
