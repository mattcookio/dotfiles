#!/bin/bash
# Hook to enforce git hygiene: conventional commits, emoji, no Claude citations, no checklists

# Read all stdin
input=$(cat)

# Only run on tool_input (Bash tool calls)
if ! echo "$input" | grep -q '"tool_input"'; then
  exit 0
fi

is_commit=false
is_pr=false

echo "$input" | grep -qE 'git[[:space:]]+commit' && is_commit=true
echo "$input" | grep -qE 'gh[[:space:]]+(pr|issue)[[:space:]]+(create|edit)' && is_pr=true

if ! $is_commit && ! $is_pr; then
  exit 0
fi

# --- Check for AI tool attribution patterns (commits + PRs) ---
if echo "$input" | grep -qiE "(Co-Authored-By:.*(Claude|Codex|opencode|aider)|Generated with.*(Claude Code|opencode|Codex)|noreply@(anthropic|openai)\.com|noreply@opencode\.ai|noreply@aider\.chat|aider@aider\.chat|claude (sonnet|opus|haiku) [0-9.]+)"; then
  cat >&2 << 'EOF'
❌ Blocked: AI tool attribution detected

Remove AI co-author/attribution lines. Blocked patterns:
  • Co-Authored-By: Claude/Codex/opencode/aider
  • 🤖 Generated with [Claude Code|opencode|Codex](...)
  • noreply@anthropic.com, noreply@openai.com, noreply@opencode.ai, *@aider.chat
EOF
  exit 2
fi

# --- Check for checklists in PR/issue bodies ---
if $is_pr; then
  if echo "$input" | grep -qE '\-[[:space:]]*\[[ x]\]'; then
    cat >&2 << 'EOF'
❌ Blocked: Checklist detected in PR/issue body

Remove markdown checklists (- [ ] items) from the description.
Use plain bullet points instead.
EOF
    exit 2
  fi
fi

# --- Enforce conventional commit format + emoji ---
if $is_commit; then
  # Extract the commit message from -m "..." or -m '...' or heredoc
  msg=""

  # Try heredoc pattern: cat <<'EOF' ... EOF wrapped in -m "$(...)"
  msg=$(echo "$input" | grep -oE "\-m \"\\\$\(cat <<'EOF'[^)]+EOF[^)]*\)" | head -1 | sed "s/-m \"\\\$(//" | sed "s/)\"$//" | sed "1d;\$d")

  # Fallback: try -m "..." or -m '...'
  if [ -z "$msg" ]; then
    msg=$(echo "$input" | grep -oE '\-m "([^"]+)"' | head -1 | sed 's/-m "//;s/"$//')
  fi
  if [ -z "$msg" ]; then
    msg=$(echo "$input" | grep -oE "\-m '([^']+)'" | head -1 | sed "s/-m '//;s/'$//")
  fi

  # If we extracted a message, validate it
  if [ -n "$msg" ]; then
    # Get first line only
    first_line=$(echo "$msg" | head -1 | sed 's/^[[:space:]]*//')

    # Conventional commit pattern: type(scope): description  OR  type: description
    if ! echo "$first_line" | grep -qE '^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert)(\(.+\))?!?:[[:space:]]+.+'; then
      cat >&2 << 'EOF'
❌ Blocked: Commit message must follow conventional commit format

Expected: <type>[(scope)]: <emoji> <description>
Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert

Examples:
  • feat(auth): ✨ add SSO login support
  • fix: 🐛 resolve null pointer in claims worker
  • chore(deps): 📦 upgrade typescript to 5.4
EOF
      exit 2
    fi

    # Require at least one emoji in the first line
    if ! echo "$first_line" | python3 -c "
import sys, unicodedata
text = sys.stdin.read()
has_emoji = any(unicodedata.category(c).startswith(('So',)) or ord(c) >= 0x1F000 for c in text)
sys.exit(0 if has_emoji else 1)
"; then
      cat >&2 << 'EOF'
❌ Blocked: Commit message must include an emoji

Add an emoji after the colon, e.g.:
  • feat: ✨ add new feature
  • fix: 🐛 squash a bug
  • docs: 📝 update README
  • refactor: ♻️ clean up auth module
EOF
      exit 2
    fi
  fi
fi

exit 0
