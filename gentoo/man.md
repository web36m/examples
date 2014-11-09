```
mkfs.ext2 -L boot /dev/sda1
mkfs.ext4 -L root /dev/sda2
mkfs.ext4 -L home /dev/sda4
mkswap -L swap /dev/sda3
swapon /dev/sda3
mount /dev/sda2 /mnt/gentoo
mkdir /mnt/gentoo/{boot,home}
mount /dev/sda1 /mnt/gentoo/boot
mount /dev/sda4 /mnt/gentoo/home
cd /mnt/gentoo
```
```
links mirror.yandex.ru
tar xvjpf stage3-*.tar.bz2
nano /mnt/gentoo/etc/portage/make.conf
```
```
CFLAGS="-O2 -march=native -ftree-vectorize -mssse3 -pipe -g0 -Wno-all -mmmx -fomit-frame-pointer"
CXXFLAGS="${CFLAGS}"
MAKEOPTS="-j3"
CHOST="i686-pc-linux-gnu"
USE="bindist"
PORTDIR="/usr/portage"
DISTDIR="${PORTDIR}/distfiles"
PKGDIR="${PORTDIR}/packages"
VIDEO_CARDS="intel"
ALSA_CARDS="intel-hda"
SUPPORT_ALSA=1
INPUT_DEVICES="evdev"
LINGUAS="ru"
LANG="ru_RU.UTF-8"
ACCEPT_KEYWORDS="~x86"
FEATURES="ccache buildsyspkg"
```
```
mirrorselect -i -o >>/mnt/gentoo/etc/portage/make.conf
cp -L /etc/resolv.conf /mnt/gentoo/etc/
mount -t proc none /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) $PS1"
mkdir /usr/portage
emerge-webrsync
emerge --sync
```
```
cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime
echo "Europe/Moscow" > /etc/timezone
emerge freefonts corefonts cronyx-fonts terminus-font
nano /etc/locale.gen
```
```
en_US.UTF-8 UTF-8
en_US ISO-8859-1
ru_RU.UTF-8 UTF-8
ru_RU.KOI8-R KOI8-R
ru_RU.CP1251 CP1251
ru_RU ISO-8859-5
```
```
locale-gen
emerge gentoo-sources
emerge genkernel
genkernel all
emerge udev syslog-ng grub dhcpcd vixie-cron
ls /boot/kernel* /boot/initramfs*
rc-update add udev boot
nano /etc/fstab
```
```
/dev/sda1               /boot           ext2            noauto,noatime  1 2
/dev/sda2               /               ext4            noatime         0 1
/dev/sda3               none            swap            sw              0 0
/dev/sda4               /home           ext4            noatime         0 0
/dev/cdrom              /mnt/cdrom      auto            noauto,ro       0 0
```
```
emerge pcmciautils pciutils
passwd
nano /etc/conf.d/consolefont
```
```
consolefont="UniCyr_8x16"
```
```
nano /etc/conf.d/keymaps
```
```
keymap="-u ru"
windowkeys="YES"
dumpkeys_charset="koi8-r"
```
```
nano /etc/env.d/02locale
```
```
LC_ALL="ru_RU.UTF-8"
LANG="ru_RU.UTF-8"
LC_MESSAGES="POSIX"
LC_NUMERIC="POSIX"
LC_TIME="POSIX"
```
```
nano /etc/conf.d/hwclock
```
```
clock="local"
clock_args=""
```
```
rc-update add syslog-ng default
rc-update add vixie-cron default
grep -v rootfs /proc/mounts > /etc/mtab
grub2-install /dev/sda
grub2-mkconfig -o /boot/grub/grub.cfg
rm /stage3-*.tar.bz2*
rc-update add sshd default
exit
reboot
```
```
echo Y > /sys/module/usbcore/parameters/old_scheme_first
useradd -m -G users,wheel,audio -s /bin/bash username
passwd username
```
```
emerge -pv xorg-x11
echo "x11-base/xorg-server udev" >> /etc/portage/package.use
emerge --ask xorg-x11
emerge xterm
emerge twm
nano /etc/portage/make.conf
```
```
USE="-gtk -gnome qt4 kde dbus polkit polkit udisksdvd alsa cdr unicode"
```
```
emerge --sync
emerge --with-bdeps y -uDN world
# возможно проблема с perl
emerge --ask gentoolkit
eselect profile list
emerge --unmerge dev-lang/perl
emerge dev-lang/perl
emerge --ask gentoolkit
emerge -1v `equery list -f '.*perl.*' -F '$cp'`
perl-cleaner --all
nano /etc/portage/package.use
```
```
dev-db/mariadb -xml
```
```
nano /etc/portage/package.mask
```
```
>=media-video/libav-9.14
```
```
emerge --with-bdeps y -uDN world
emerge --ask kdebase-meta
```
```
---------
emerge -uavDN world
```
