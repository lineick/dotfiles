#!/bin/sh
# ping desktop + record pane when claude in a tmux pane wants attention
# suppressed only when the pane is on screen AND the terminal window has focus
[ -n "$TMUX_PANE" ] || exit 0
input=$(cat)
info=$(tmux display-message -p -t "$TMUX_PANE" \
  '#{session_id} #{?#{&&:#{pane_active},#{window_active}},1,0} #S:#I.#P') || exit 0
sid=${info%% *}
rest=${info#* }
visible=${rest%% *}
loc=${rest#* }
if [ "$visible" = "1" ] && tmux list-clients -t "$sid" -F '#{client_flags}' 2>/dev/null | grep -q focused; then
  exit 0
fi
tmux set-environment -g CLAUDE_ATTENTION_PANE "$TMUX_PANE"
event=$(printf '%s' "$input" | jq -r '.hook_event_name // ""')
if [ "$event" = "Stop" ]; then
  msg="finished, waiting for you"
else
  msg=$(printf '%s' "$input" | jq -r '.message // "needs attention"')
fi
notify-send -e "Claude [$loc]" "$msg"
