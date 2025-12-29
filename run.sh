#!/usr/bin/env bash

mkdir alpine
wget https://dl-cdn.alpinelinux.org/alpine/v3.23/releases/aarch64/alpine-minirootfs-3.23.2-aarch64.tar.gz
bsdtar -x -f alpine-minirootfs-3.23.2-aarch64.tar.gz -C alpine
resolvectl status eth0 | awk '/Current DNS Server.*/ {print "nameserver " $4}' >> alpine/etc/resolv.conf
cat /run/systemd/resolve/stub-resolv.conf >> alpine/etc/resolv.conf
cat alpine/etc/resolv.conf
mount -t proc /proc alpine/proc/
mount -t sysfs /sys alpine/sys/
mount -o bind /dev alpine/dev/
chroot alpine /bin/ash -c ". /etc/profile; ping -c 4 8.8.8.8; ping -c 4 mirror.archlinuxarm.org"
chroot alpine /bin/ash -c ". /etc/profile; apk update; apk upgrade"
#chroot alarm /bin/bash -c "source /etc/profile; pacman-key --init; pacman-key --populate archlinuxarm; pacman -S -y -u --noconfirm base-devel; locale-gen; uname -a"
