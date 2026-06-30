#!/bin/sh
# save-sync (SMB) — bidirectional save sync between MiSTer units via a Synology SMB share.
# Needs only kernel CIFS support (grep cifs /proc/filesystems); the mount.cifs
# helper is NOT required — we mount with `mount -i` and pass creds inline.
#
# install to: /media/fat/Scripts/save-sync.sh   (chmod +x)

set -eu

### ---- config ----------------------------------------------------------------
NAS_HOST="192.168.1.2"                  # Synology IP (must be an IP — no helper = no DNS)
NAS_SHARE="mister-saves"                # the SMB shared-folder name
SMB_VERS="3.0"                          # 3.0 for modern DSM; try 2.1 if mount fails

CREDS="/media/fat/linux/.smbcreds"      # file with username=/password= (chmod 600)
MOUNT="/tmp/nas-saves"                  # local mountpoint

# Directories to keep in sync, relative to /media/fat (mirrored under the share root).
SYNC_DIRS="saves savestates"
# SYNC_DIRS="saves savestates config"   # <- add configs too if you want them shared

MISTER_ROOT="/media/fat"
LOG="/media/fat/linux/save-sync.log"
LOCK="/tmp/mister-save-sync.lock"
### ---------------------------------------------------------------------------

DRY=""
[ "${1:-}" = "--dry-run" ] && DRY="--dry-run"

log() { echo "$(date '+%F %T') $*" >>"$LOG"; }

# Prevent overlapping runs.
if [ -e "$LOCK" ] && kill -0 "$(cat "$LOCK" 2>/dev/null)" 2>/dev/null; then
    log "another sync is running, skipping"; exit 0
fi
echo $$ >"$LOCK"

# Always clean up: unmount + drop lock on exit.
cleanup() { mountpoint -q "$MOUNT" && umount "$MOUNT" 2>/dev/null; rm -f "$LOCK"; }
trap cleanup EXIT

log "=== sync start (host $(hostname)) ==="

# Read creds ourselves and pass them inline: this MiSTer has no mount.cifs helper,
# and the kernel can't parse credentials= (that's a helper-only option).
SMB_USER=$(sed -n 's/^username=//p' "$CREDS")
SMB_PASS=$(sed -n 's/^password=//p' "$CREDS")
[ -n "$SMB_USER" ] && [ -n "$SMB_PASS" ] || { log "could not read creds from $CREDS — aborting"; exit 1; }

# Mount the share (idempotent). `mount -i` => don't invoke /sbin/mount.cifs;
# go straight to the kernel cifs module, which parses username=/password= itself.
# NAS_HOST must be an IP here (no helper => no hostname resolution).
mkdir -p "$MOUNT"
if ! mountpoint -q "$MOUNT"; then
    if ! mount -i -t cifs "//$NAS_HOST/$NAS_SHARE" "$MOUNT" \
            -o "username=$SMB_USER,password=$SMB_PASS,vers=$SMB_VERS,uid=0,gid=0,file_mode=0666,dir_mode=0777,nounix,noserverino,iocharset=utf8"; then
        log "MOUNT FAILED for //$NAS_HOST/$NAS_SHARE — aborting"; exit 1
    fi
fi
log "mounted //$NAS_HOST/$NAS_SHARE at $MOUNT"

STAMP=$(date '+%Y%m%d-%H%M%S')

# rsync flags:
#   -rt           recurse, preserve mtimes (mtime is what -u compares)
#   -u            skip files NEWER on the receiver  <-- the newest-wins safety net
#   --modify-window=2   FAT/exFAT + SMB timestamp slop; avoids false "changed"
#   --no-perms --no-owner --no-group --omit-dir-times   don't fight FS metadata diffs
#   --inplace     write directly (no temp file) — friendlier to SMB/FAT
#   --backup --backup-dir   keep displaced copies; never a silent loss
#   (NO --delete — saves are append/update only)
COMMON="-rtu --inplace --modify-window=2 --no-perms --no-owner --no-group --omit-dir-times $DRY"

for d in $SYNC_DIRS; do
    local_dir="$MISTER_ROOT/$d/"
    remote_dir="$MOUNT/$d/"

    [ -d "$local_dir" ] || { log "no local $local_dir, skipping"; continue; }
    mkdir -p "$remote_dir"

    # PULL: NAS -> local, keeping anything newer locally.
    log "pull $d"
    rsync $COMMON \
        --backup --backup-dir="$MISTER_ROOT/.save-sync-backup/$STAMP/$d" \
        "$remote_dir" "$local_dir" >>"$LOG" 2>&1 || log "pull $d FAILED"

    # PUSH: local -> NAS, keeping anything newer on the NAS.
    log "push $d"
    rsync $COMMON \
        --backup --backup-dir="$MOUNT/.save-sync-backup/$STAMP/$d" \
        "$local_dir" "$remote_dir" >>"$LOG" 2>&1 || log "push $d FAILED"
done

log "=== sync done ==="
