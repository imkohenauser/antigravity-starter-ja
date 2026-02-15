/**
 * Cross-platform date utility for AI agents.
 * 
 * Usage:
 *   node get_date.js [offset] [format]
 * 
 * Arguments:
 *   offset: Optional. Relative date adjustment.
 *           Examples: "+1d" (add 1 day), "-2w" (subtract 2 weeks), "yesterday", "tomorrow"
 *           Supported units: d (days), w (weeks), m (months), y (years)
 *   format: Optional. Output format. Currently only supports "iso" (default) or "human".
 *           If not provided, ISO 8601 format is used.
 */

const args = process.argv.slice(2);
let targetDate = new Date();
let format = 'iso';

// Parse arguments
for (const arg of args) {
  if (arg === 'iso' || arg === 'human') {
    format = arg;
    continue;
  }

  // Handle keywords
  if (arg === 'yesterday') {
    targetDate.setDate(targetDate.getDate() - 1);
    continue;
  }
  if (arg === 'tomorrow') {
    targetDate.setDate(targetDate.getDate() + 1);
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
        break; // Note: This might have edge cases for end-of-month, but standard JS behavior applies
      case 'y':
        targetDate.setFullYear(targetDate.getFullYear() + (sign * value));
        break;
    }
  }
}

// Output
if (format === 'human') {
  console.log(targetDate.toString());
} else {
  // ISO 8601 with timezone offset (similar to `date "+%Y-%m-%dT%H:%M:%S%z"`)
  // Standard toISOString() uses UTC (Z). We want local time with offset if possible to match original script intent,
  // but toISOString() is generally better for machine parsing.
  // The original script used `date "+%Y-%m-%dT%H:%M:%S%z"` which is local time.
  // Let's try to preserve local time with offset.

  const pad = (n) => n.toString().padStart(2, '0');
  const YYYY = targetDate.getFullYear();
  const MM = pad(targetDate.getMonth() + 1);
  const DD = pad(targetDate.getDate());
  const HH = pad(targetDate.getHours());
  const mm = pad(targetDate.getMinutes());
  const ss = pad(targetDate.getSeconds());

  const tzOffset = -targetDate.getTimezoneOffset();
  const diffSign = tzOffset >= 0 ? '+' : '-';
  const diffHours = pad(Math.floor(Math.abs(tzOffset) / 60));
  const diffMinutes = pad(Math.abs(tzOffset) % 60);

  console.log(`${YYYY}-${MM}-${DD}T${HH}:${mm}:${ss}${diffSign}${diffHours}:${diffMinutes}`);
}
