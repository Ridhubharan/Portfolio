read -p "Enter username " username
read -p "Enter password " userpass
read -p "Enter system name " usersys
read -p "Enter continent (eg: Asia) " region 	#check
read -p "Enter time zone (eg: Kolkata) " zone	#check
pacman -S reflector sudo vim --noconfirm
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
ln -sf /usr/share/zoneinfo/$region/$zone /etc/localtime 
hwclock --systohc
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo $usersys > /etc/hostname 
echo -e "127.0.0.1\tlocalhost" > /etc/hosts
echo -e "::1\t\tlocalhost" >> /etc/hosts
echo -e " 127.0.1.1\t$usersys.localdomain\t$usersys" >> /etc/hosts 
mkinitcpio -P
echo "created system"
printf "$userpass\n$userpass" | passwd
useradd -m $username
printf "$userpass\n$userpass" | passwd $username
usermod --append --groups wheel $username
echo $username "ALL=(ALL) ALL" >> /etc/sudoers # check
pacman -S grub
echo "Added user $username ..."
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
echo "Installed grub ..."
pacman -S xorg plasma plasma-wayland-session kde-applications networkmanager --noconfirm
systemctl enable sddm.service
systemctl enable NetworkManager.service
exit
shutdown now
