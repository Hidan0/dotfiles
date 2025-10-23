#!/usr/bin/env zsh

# Parse command line arguments to directly call the script without having to wait the `PUSH_INTERVAL`
NOWAIT=false
while [[ "$#" -gt 0 ]]; do
  case $1 in
  --nowait) NOWAIT=true ;;
  *)
    echo "Unknown parameter: $1"
    exit 1
    ;;
  esac
  shift
done

PUSH_INTERVAL=300 # 5min

NOTES_DIR="$HOME/notes/second_brain/"

# Navigate to dir
cd $NOTES_DIR || {
	notify-send -u critical "Can not navigate to Notes directory"
	return 
}

if [[ $(git status --porcelain) ]]; then
	notify-send "Unstaged files detected..."
	# TODO: log
else
	# Pull the latest changes
	if ! git pull --rebase >>/tmp/git_error.log 2>&1; then
		notify-send -u critical "Pull failed - check logs"
		return
	else
		# TODO: log
	fi
fi

# Check for recent modifications only if `NOWAIT` is false
if ! $NOWAIT; then
	RECENT_MOD=$(find . -type f -not -path './.git/*' -newermt "-${PUSH_INTERVAL} seconds" 2>/dev/null)
	if [[ "$RECENT_MOD" ]]; then
		# TODO: log
		return
	fi
fi

UNCOMMITTED_CHANGES=$(git status --porcelain)
UNPUSHED_COMMITS=$(git rev-list --count origin/$(git rev-parse --abbrev-ref HEAD)..HEAD)
