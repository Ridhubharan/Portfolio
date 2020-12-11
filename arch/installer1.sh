timedatectl set-ntp true
printf 'o\nn\np\n1\n\n+2G\nn\np\n2\n\n\nt\n1\n82\nw' | fdisk /dev/sda
mkswap /dev/sda1
swapon /dev/sda1
mkfs.ext4 /dev/sda2
mount /dev/sda2 /mnt
pacman -Sy
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
echo "Now download "installer2.sh" and run it"
read -p "Press enter to continue!" okk
