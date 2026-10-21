#!/bin/sh
# Claude Code status line script

input=$(cat)

# --- CWD (preserve real path for git, shorten for display) ---
cwd_real=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
home="$HOME"
case "$cwd_real" in
  "$home"*)
    cwd="~${cwd_real#$home}"
    ;;
  *)
    cwd="$cwd_real"
    ;;
esac

# --- Git branch (skip optional locks) ---
branch=$(git -C "$cwd_real" --no-optional-locks branch --show-current 2>/dev/null)
if [ -n "$branch" ]; then
  branch_part=" ($branch)"
else
  branch_part=""
fi

# --- Model ---
model=$(echo "$input" | jq -r '.model.display_name // ""')
model_id=$(echo "$input" | jq -r '.model.id // ""')

# Highlight Mythos as a bold white-on-brick-red badge so it's obvious when it's active
case "$(echo "$model_id $model" | tr '[:upper:]' '[:lower:]')" in
  *mythos*)
    esc=$(printf '\033')
    model="${esc}[1;38;2;255;255;255;48;2;166;61;64m ${model} ${esc}[0m"
    ;;
esac

# --- Context usage ---
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
remaining_pct=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
input_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')

# Humanize a token count with k/M suffix (e.g. 382 -> 382, 38910 -> 39k, 1200000 -> 1.2M)
humanize() {
  awk -v n="$1" 'BEGIN {
    if (n >= 1000000)      printf "%.1fM", n / 1000000
    else if (n >= 10000)   printf "%.0fk", n / 1000
    else if (n >= 1000)    printf "%.1fk", n / 1000
    else                   printf "%.0f", n
  }'
}

if [ -n "$used_pct" ] && [ -n "$remaining_pct" ] && [ -n "$input_tokens" ]; then
  ctx_part="$(humanize "$input_tokens") tok | $(printf '%.0f' "$remaining_pct")% left"
elif [ -n "$remaining_pct" ]; then
  ctx_part="$(printf '%.0f' "$remaining_pct")% left"
else
  ctx_part="no context yet"
fi

# --- Assemble ---
printf "%s%s | %s | %s\n" "$cwd" "$branch_part" "$model" "$ctx_part"
