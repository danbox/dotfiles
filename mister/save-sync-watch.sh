#!/bin/sh
# save-sync-watch (inotify) — sync saves shortly after they settle on disk.
# watches the save dirs and fires one sync QUIET seconds after the last write.
#
# install to: /media/fat/Scripts/save-sync-watch.sh   (chmod +x)

set -eu

SYNC="/media/fat/Scripts/save-sync.sh"
INW="inotifywait"                       # or full path from `command -v inotifywait`
WATCH_DIRS="/media/fat/saves /media/fat/savestates"
LOG="/media/fat/linux/save-sync.log"
QUIET=8                                 # seconds of silence before firing one sync

log() { echo "$(date '+%F %T') watch: $*" >>"$LOG"; }

log "watching: $WATCH_DIRS"

# -m monitor, -r recurse (new per-core subdirs auto-watched),
# close_write + moved_to = a finished save write (not partial writes).
"$INW" -m -r -e close_write -e moved_to --format '%w%f' $WATCH_DIRS | while read -r f; do
    # First event arrived; keep draining until QUIET seconds of silence, then sync once.
    while read -r -t "$QUIET" _; do :; done
    log "change settled, syncing"
    "$SYNC" >/dev/null 2>&1 || true
done
