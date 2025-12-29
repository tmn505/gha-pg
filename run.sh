#!/usr/bin/env bash

mkdir alarm
wget http://os.archlinuxarm.org/os/ArchLinuxARM-armv7-latest.tar.gz
bsdtar -x -f ArchLinuxARM-armv7-latest.tar.gz -C alarm
#resolvectl status eth0 | awk '/Current DNS Server.*/ {print "nameserver " $4}' >> alarm/etc/resolv.conf
#cat /run/systemd/resolve/stub-resolv.conf >> alarm/etc/resolv.conf
mount -t proc /proc alarm/proc/
mount -t sysfs /sys alarm/sys/
mount -o bind /dev alarm/dev/
mount -o bind /run alarm/run/
cat alarm/etc/resolv.conf
printf "en_US.UTF-8 UTF-8\n" > alarm/etc/locale.gen
#chroot alarm /bin/bash -c ". /etc/profile; ping -c 4 8.8.8.8; ping -c 4 mirror.archlinuxarm.org"
linux32 chroot alarm /bin/bash -c ". /etc/profile; curl -L -O https://dl-cdn.alpinelinux.org/alpine/v3.23/releases/aarch64/alpine-minirootfs-3.23.2-aarch64.tar.gz; ls -l"
linux32 chroot alarm /bin/bash -c ". /etc/profile; curl -L -O http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz; ls -l"
linux32 chroot alarm /bin/bash -c ". /etc/profile; pacman-key --init; pacman-key --populate archlinuxarm; pacman -S -y -u --noconfirm base-devel; locale-gen; uname -a"
