### Ставим gentoo на qemu

#### Виртуальная машина
\# apt-get install qemu    
$ qemu-img create -f qcow2 GentooVM.img 15G    
$ nano -w GentooVM    
``` sh
#!/bin/sh
exec qemu-system-i386 \
	-cpu core2duo \
	-drive file=GentooVM.img,if=virtio \
	-net nic -net user,hostname=gentoovm \
	-m 512M \
	-monitor stdio \
	-name "Gentoo VM" \
	$@
```
$ wget http://distfiles.gentoo.org/releases/x86/autobuilds/current-stage3-i686/install-x86-minimal-20140408.iso    
$ ./GentooVM -boot d -cdrom install-x86-minimal-20140408.iso    

#### Установка системы
\# cfdisk /dev/vda    
/dev/vda1 512 MB    
/dev/vda2 7000 MB    
/dev/vda3 1024 MB    
/dev/vda4 ~6500 MB    

\# mkfs.ext2 /dev/vda1    
\# mkfs.ext4 /dev/vda2    
\# mkfs.ext2 /dev/vda4    
\# mkswap /dev/vda3    
\# swapon /dev/vda3    

\# mount /dev/vda2 /mnt/gentoo    
\# mkdir /mnt/gentoo{/boot,/home}    
\# mount /dev/vda1 /mnt/gentoo/boot    
\# mount /dev/vda4 /mnt/gentoo/home    

\# cd /mnt/gentoo    
\# links http://www.gentoo.org/main/ru/mirrors.xml    
download stage    
\# tar xvjpf stage*.tar.bz2    
\# nano -w /mnt/gentoo/etc/portage/make.conf    
```
CFLAGS="-O2 -march=i686 -pipe"
CXXFLAGS="${CFLAGS}"
```
