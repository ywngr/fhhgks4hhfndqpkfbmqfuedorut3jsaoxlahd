#!/usr/bin/env bash

if [ ! -f {{ home }}/dropbox/workspace/bootstrap/ywngr_mac.kdbx ]; then
	echo "Error: KeePassXC database file not found." >&2
	exit 1
fi

inotifywait -m -q -e moved_to {{ home }}/dropbox/workspace/bootstrap/ |
   while read -r directory events filename; do
      rclone copy "{{ home }}/dropbox" db:
      if [[ $? == 0 ]]; then
         notify-send -t 3000 -i "Dropbox_Icon_Blue" "Successfully synced" "All files are synced"
      else
         notify-send -t 3000 -i "cloud-cant-update-icon" "Can't update" "Something goes wrong"
      fi
   done
