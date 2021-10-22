#!/bin/bash
## Remote backup script. Requires duplicity.

. /etc/backups/backup.config

dest_local_path=${destination##*://} 
backend=${destination%://*}
for src in "${sources[@]}"
do
  full_dest="$dest_local_path"/"$src"
  mkdir -p "$full_dest"
  if [[ "$encrypt" == 1 ]]
  then
      duplicity --gpg-options="--homedir=$gpg_homedir" --encrypt-key="$gpg_encrypt_key" \
           --verbosity notice \
           --full-if-older-than 30D \
           --num-retries 3 \
           --archive-dir /root/.cache/duplicity \
           --log-file /var/log/duplicity.log \
           "$src" "$backend://$full_dest"
      duplicity --gpg-options="--homedir=$gpg_homedir" --encrypt-key="$gpg_encrypt_key" remove-all-but-n-full 12 --force "$backend://$full_dest"
      duplicity --gpg-options="--homedir=$gpg_homedir" --encrypt-key="$gpg_encrypt_key" remove-all-inc-of-but-n-full 6 --force "$backend://$full_dest"
  else
      duplicity --verbosity notice \
           --no-encryption \
           --full-if-older-than 30D \
           --num-retries 3 \
           --archive-dir /root/.cache/duplicity \
           --log-file /var/log/duplicity.log \
           "$src" "$backend://$full_dest"
      duplicity remove-all-but-n-full 12 --force "$backend://$full_dest"
      duplicity remove-all-inc-of-but-n-full 6 --force "$backend://$full_dest"
  fi
done
