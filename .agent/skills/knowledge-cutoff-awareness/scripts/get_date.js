#!/usr/bin/env node
/**
 * Cross-platform date utility for AI agents.
 * 
 * Usage:
 *   node get_date.js [options] [offset]
 * 
 * Options:
 *   -h, --help    Show help message
 *   --iso         Output in ISO 8601 format (default)
 *   --human       Output in human-readable format
 * 
 * Offset:
 *   Relative date adjustment vs current time.
 *   Examples: 
 *     "+1d" (add 1 day)
 *     "-2w" (subtract 2 weeks)
 *     "yesterday"
 *     "tomorrow"
 *   Supported units: d (days), w (weeks), m (months), y (years)
 */

function printHelp() {
  console.log(`
Usage: node get_date.js [options] [offset]

Options:
  -h, --help    Show help message
  --iso         Output in ISO 8601 format (default)
  --human       Output in human-readable format

Offset:
  Relative date adjustment.
  Examples: 
    "+1d" (add 1 day)
    "-2w" (subtract 2 weeks)
    "yesterday"
    "tomorrow"
  Supported units: d (days), w (weeks), m (months), y (years)
`);
}

function formatDateISO(date) {
  const pad = (n) => n.toString().padStart(2, '0');
  const YYYY = date.getFullYear();
  const MM = pad(date.getMonth() + 1);
  const DD = pad(date.getDate());
  const HH = pad(date.getHours());
  const mm = pad(date.getMinutes());
  const ss = pad(date.getSeconds());

  const tzOffset = -date.getTimezoneOffset();
  const diffSign = tzOffset >= 0 ? '+' : '-';
  const diffHours = pad(Math.floor(Math.abs(tzOffset) / 60));
  const diffMinutes = pad(Math.abs(tzOffset) % 60);

  return `${YYYY}-${MM}-${DD}T${HH}:${mm}:${ss}${diffSign}${diffHours}:${diffMinutes}`;
}

function main() {
  try {
    const args = process.argv.slice(2);
    let targetDate = new Date();
    let format = 'iso';
    let offsetApplied = false;

    // Parse arguments
    for (const arg of args) {
      if (arg === '--help' || arg === '-h') {
        printHelp();
        process.exit(0);
      }

      if (arg === '--iso') {
        format = 'iso';
        continue;
      }
      
      if (arg === '--human') {
        format = 'human';
        continue;
      }

      // Handle keywords
      if (arg === 'yesterday') {
        targetDate.setDate(targetDate.getDate() - 1);
        offsetApplied = true;
        continue;
      }
      if (arg === 'tomorrow') {
        targetDate.setDate(targetDate.getDate() + 1);
        offsetApplied = true;
        continue;
      }
      if (arg === 'today' || arg === 'now') {
        continue;
      }

      // Handle "+1d", "-2w", etc.
      const match = arg.match(/^([+-])(\d+)([dwmy])$/);
      if (match) {
        const sign = match[1] === '+' ? 1 : -1;
        const value = parseInt(match[2], 10);
        const unit = match[3];

        switch (unit) {
          case 'd':
            targetDate.setDate(targetDate.getDate() + (sign * value));
            break;
          case 'w':
            targetDate.setDate(targetDate.getDate() + (sign * value * 7));
            break;
          case 'm':
            targetDate.setMonth(targetDate.getMonth() + (sign * value));
            break;
          case 'y':
            targetDate.setFullYear(targetDate.getFullYear() + (sign * value));
            break;
        }
        offsetApplied = true;
      } else {
        console.warn(`Warning: Unrecognized argument "${arg}" ignored.`);
      }
    }

    // Checking if date is valid
    if (isNaN(targetDate.getTime())) {
      throw new Error('Invalid date calculation result.');
    }

    // Output
    if (format === 'human') {
      console.log(targetDate.toString());
    } else {
      console.log(formatDateISO(targetDate));
    }

  } catch (error) {
    console.error(`Error: ${error.message}`);
    process.exit(1);
  }
}

main();
