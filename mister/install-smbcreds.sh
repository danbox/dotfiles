#!/usr/bin/env bash
# install-smbcreds — build the MiSTer SMB credentials file from 1Password and
# scp it to a MiSTer. Runs on the desktop (needs the `op` CLI signed in).
#
# Usage: ./install-smbcreds.sh <mister-ip> [ssh-user]
#        ssh-user defaults to root.

set -euo pipefail

OP_ITEM="MiSTer dan-nas"                 # 1Password login item (username + password)
REMOTE_PATH="/media/fat/linux/.smbcreds"

IP="${1:?usage: $0 <mister-ip> [ssh-user]}"
SSH_USER="${2:-root}"

# Make sure 1Password is reachable before we touch the MiSTer.
op whoami >/dev/null 2>&1 || { echo "op CLI not signed in — run 'op signin' first" >&2; exit 1; }

# Pull username + password from the login item.
username=$(op item get "$OP_ITEM" --fields label=username --reveal)
password=$(op item get "$OP_ITEM" --fields label=password --reveal)
[ -n "$username" ] && [ -n "$password" ] || { echo "empty username/password from 1Password item '$OP_ITEM'" >&2; exit 1; }

# Build the creds file in a private temp file (never written world-readable).
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
chmod 600 "$tmp"
printf 'username=%s\npassword=%s\n' "$username" "$password" > "$tmp"

# Ship it.
ssh "$SSH_USER@$IP" 'mkdir -p /media/fat/linux'
scp "$tmp" "$SSH_USER@$IP:$REMOTE_PATH"
ssh "$SSH_USER@$IP" "chmod 600 '$REMOTE_PATH'"

echo "installed $REMOTE_PATH on $SSH_USER@$IP"
