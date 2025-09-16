setxkbmap -layout us,ara -option grp:shifts_toggle,caps:swapescape

doas mount -t ntfs-3g /dev/sda6 /mnt/media -o uid=1000,gid=1000,umask=022

sxhkd &

redshift -O 2500

$HOME/bin/dwmstatus &

exec dwm
