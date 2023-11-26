text
# Lock root password
rootpw --lock

keyboard --xlayouts=us,ru --switch=grp:alt_shift_toggle
lang en_US --addsupport=ru_RU

timezone Europe/Moscow --utc

url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-39&arch=x86_64

repo --name=fedora-updates --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f39&arch=x86_64" --cost=0
repo --name=rpmfusion-free --mirrorlist="https://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-39&arch=x86_64"
repo --name=rpmfusion-free-updates --mirrorlist="https://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-39&arch=x86_64" --cost=0
repo --name=rpmfusion-nonfree --mirrorlist="https://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-39&arch=x86_64"
repo --name=rpmfusion-nonfree-updates --mirrorlist="https://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-39&arch=x86_64" --cost=0

zerombr
bootloader --driveorder=vda
clearpart --all --drives=vda --initlabel
reqpart
part /boot --fstype=ext4 --size=1024 --ondisk=vda
part btrfs.main --fstype=btrfs --encrypted --grow --fsoptions="compress=zstd:1,discard=async,space_cache=v2" --passphrase="fedora" --ondisk=vda

btrfs none --label=fedora-btrfs btrfs.main
btrfs / --subvol --name=root fedora-btrfs
btrfs /home --subvol --name=home fedora-btrfs
btrfs /var/log --subvol --name=var_log fedora-btrfs
btrfs /var/lib/libvirt/images --subvol --name=libvirt_images fedora-btrfs

# Configure Firewall
firewall --enabled

# Configure Network Interfaces
network --onboot=yes --bootproto=dhcp --hostname=fedora-virt

%packages
@^minimal-environment
neovim
git
gh
zram-generator
zram-generator-defaults
%end

%post
# https://unix.stackexchange.com/a/351755 for handling TTY in anaconda
printf "Press Alt-F3 to view post-install logs\r\n" > /dev/tty1
{
echo "Turning off copy-on-write for libvirt images directory"
chattr +C /var/lib/libvirt/images
} 2>&1 | tee -a /root/postinstall.log > /dev/tty3
%end
