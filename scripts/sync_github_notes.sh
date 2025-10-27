#!/usr/bin/env zsh

# Original script from linkarzu: https://github.com/linkarzu/dotfiles-latest/blob/main/scripts/macos/mac/400-autoPushGithub.sh

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

# Configure logging
LOG_DIR="$HOME/notes/.logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/autopush_$(date '+%Y-%m').log"

ERROR_LOG="/tmp/git_autopush_error.log"

log_message() {
	local level="$1"
	local message="$2"
	local timestamp=$(date '+%Y-%m-%d %H:%M:%s')
	echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
}

PUSH_INTERVAL=300 # 5min

NOTES_DIR="$HOME/notes/second_brain/"

# Navigate to dir
cd $NOTES_DIR || {
	log_message "ERROR" "Failed to navigate to $NOTES_DIR"
	notify-send -u critical "Can not navigate to Notes directory"
	return 
}

if [[ $(git status --porcelain) ]]; then
	log_message "INFO" "Unstaged file detected. Skipping pull."
else
	# Pull the latest changes
	if ! git pull --rebase 2>"$ERROR_LOG"; then
		ERROR_MSG=$(cat "$ERROR_LOG")
		log_message "ERROR" "Pull failed: $ERROR_MSG"

		notify-send -u critical "Pull failed - check logs"
		return
	else
		log_message "INFO" "Pull completed successfully"
	fi
fi

# Check for recent modifications only if `NOWAIT` is false
if ! $NOWAIT; then
	RECENT_MOD=$(find . -type f -not -path './.git/*' -newermt "-${PUSH_INTERVAL} seconds" 2>"$ERROR_LOG")
	if [[ "$RECENT_MOD" ]]; then
		log_message "INFO" "Skipping push due to recent modifications"
		log_message "WARN" "Modified files: $RECENT_MOD"
		return
	fi
fi

# Check for changes or commits not pushed
UNCOMMITTED_CHANGES=$(git status --porcelain)
UNPUSHED_COMMITS=$(git rev-list --count origin/$(git rev-parse --abbrev-ref HEAD)..HEAD)

if [[ -n "$UNCOMMITTED_CHANGES" || "$UNPUSHED_COMMITS" -gt 0 ]]; then
	if [[ -n "$UNCOMMITTED_CHANGES" ]]; then
		log_message "INFO" "Staging changes..."
		# Stage all changes
		git add .

		TIMESTAMP=$(date '+%Y-%m-%d %H:%M')
		if ! git commit -m "Last Sync: $TIMESTAMP" 2>"$ERROR_LOG"; then
			ERROR_MSG=$(cat "$ERROR_LOG")
		  log_message "ERROR" "Commit failed: $ERROR_MSG"

			notify-send -u critical "Commit failed - check logs"
			return
		else
		  log_message "INFO" "Changes committed successfully"
		fi
	fi

	if ! git push 2>"$ERROR_LOG"; then
	  ERROR_MSG=$(cat "$ERROR_LOG")
		log_message "ERROR" "Push failed: $ERROR_MSG"

		notify-send -u critical "Push failed - check logs"
	else
		log_message "INFO" "Push completed successfully"
	fi
else
  log_message "INFO" "No changes to push"
fi

find "$LOG_DIR" -name "*.log" -mtime +7 -delete
