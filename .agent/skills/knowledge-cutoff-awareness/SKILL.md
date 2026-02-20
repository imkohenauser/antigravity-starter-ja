---
name: knowledge-cutoff-awareness
description: Get current date, time, and calculate relative dates using system tools.
---

# knowledge-cutoff-awareness

This skill allows you to get the current date and time, and perform date calculations.
It uses the system's `date` command via a wrapper script to provide consistent current time output.

## Usage

### Get Current Date/Time
To get the current date and time in ISO 8601 format (recommended for machine parsing):

```bash
node scripts/get_date.js
# Output: 2026-02-16T16:55:00+09:00
```

To get a human-readable format:

```bash
node scripts/get_date.js --human
# Output: Mon Feb 16 2026 16:55:00 GMT+0900 (JST)
```

### Relative Dates & Calculations
You can easily calculate relative dates using simple arguments. The output will be in ISO 8601 format by default.

- **Get tomorrow:**
  ```bash
  node scripts/get_date.js +1d
  ```

- **Get date 2 weeks ago:**
  ```bash
  node scripts/get_date.js -2w
  ```

- **Get date 1 month from now:**
  ```bash
  node scripts/get_date.js +1m
  ```

- **Get yesterday (keyword):**
  ```bash
  node scripts/get_date.js yesterday
  ```

**Supported units:** `d` (days), `w` (weeks), `m` (months), `y` (years).

### Help
To see all available options:

```bash
node scripts/get_date.js --help
```

## Limitations

- **System Time Dependency**: This skill relies on the underlying system time. If the system clock is incorrect, the output will be incorrect.
- **Timezone**: The ISO 8601 output includes the local timezone offset of the machine running the script.

