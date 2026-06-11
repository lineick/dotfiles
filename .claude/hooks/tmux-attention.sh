#!/bin/sh
# ping desktop + record pane when claude in a non-focused tmux pane wants attention
[ -n "$TMUX_PANE" ] || exit 0
input=$(cat)
info=$(tmux display-message -p -t "$TMUX_PANE" \
  '#S:#I.#P #{?#{&&:#{pane_active},#{&&:#{window_active},#{session_attached}}},1,0}') || exit 0
loc=${info% *}
focused=${info##* }
[ "$focused" = "1" ] && exit 0
tmux set-environment -g CLAUDE_ATTENTION_PANE "$TMUX_PANE"
event=$(printf '%s' "$input" | jq -r '.hook_event_name // ""')
if [ "$event" = "Stop" ]; then
  msg="finished, waiting for you"
else
  msg=$(printf '%s' "$input" | jq -r '.message // "needs attention"')
fi
notify-send -e "Claude [$loc]" "$msg"
