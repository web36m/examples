Справочник
========

### Установка php-fpm
`apt-get install php5-cli php5-common php5-mysql php5-suhosin php5-gd php5-fpm php5-cgi php-pear php5-mcrypt`

### Моя конфигурация редактора sublime_text
```json
{
	"color_scheme": "Packages/Color Scheme - Default/Twilight.tmTheme",
	"font_size": 10,
	"soda_classic_tabs": true,
	"soda_folder_icons": true,
	"theme": "Soda Dark.sublime-theme"
}
```
### PHP DEBUG    
```sh
apt-get install php5-xdebug
nano /etc/php5/conf.d/xdebug.ini
```
Вставить в конфигурацию xdebug.ini    
```
xdebug.max_nesting_level=1000 ; the default nesting level of 100 isn't very mediawiki friendly
xdebug.show_mem_delta=1
xdebug.collect_params=4
xdebug.dump_globals=on
xdebug.collect_vars=on
xdebug.show_local_vars=on
xdebug.collect_includes=1
xdebug.dump.REQUEST=*
xdebug.dump.SESSION=*
xdebug.dump.SERVER=REMOTE_ADDR,REQUEST_METHOD
xdebug.dump_globals=1
xdebug.manual_url=http://www.php.su/functions/?
xdebug.show_exception_trace=1
xdebug.auto_trace=1
xdebug.collect_assignments=1
xdebug.collect_return=1
xdebug.trace_format=1
xdebug.extended_info=1
```

### Изменения формата часов для GNOME2 Ubuntu
``` sh
gsettings set com.canonical.indicator.datetime time-format custom && gsettings set com.canonical.indicator.datetime custom-time-format "%Y-%m-%d %H:%M:%S"
```

### Сделать кнопки управления окном справа в GNOME2 Ubuntu    
``` sh
gconftool-2 --set /apps/metacity/general/button_layout --type string "menu:minimize,maximize,close"
```

### Сборка Nginx
(по моему сейчас проблема с http_ssl_module)    
``` sh
wget http://downloads.sourceforge.net/pcre/pcre-8.34.tar.bz2
wget http://zlib.net/zlib-1.2.8.tar.gz
wget http://nginx.org/download/nginx-1.5.10.tar.gz
tar xvjf pcre-8.34.tar.bz2
tar xvfz zlib-1.2.8.tar.gz
tar xvfz nginx-1.5.10.tar.gz
cd nginx-1.5.10
./configure --sbin-path=/usr/sbin/nginx \
--conf-path=/etc/nginx/nginx.conf \
--pid-path=/var/run/nginx.pid \
--with-http_ssl_module \
--with-pcre=../pcre-8.34 \
--with-zlib=../zlib-1.2.8
make
make install
```

### Изменение ID3 тэгов для mp3 файлов для всей папки
``` sh
for i in *.mp3; do eyeD3 -a 'ArtistName' "$i"; done
```

### Компиляция исходников локализации
``` sh
msgfmt -cv -o domain-ru_RU.mo domain-ru_RU.po
```

### Оформление терминала (ред .bashrc)
``` sh
PS1="\[\033[1;34m\][\[\033[0m\]\t\[\033[1;30m\] \[\033[34m\]\W\[\033[1;34m\]]\[\033[32;1m\]:>\[\033[0m\] "
```
### Виртуальная машина qemu    
``` sh
qemu --enable-kvm -boot d image.vdi -m 1000 -redir tcp:80::80
```
### Вырезать кусок видео при помощи ffmpeg    
``` sh
ffmpeg -ss 00:02:15 -t 00:00:25 -i input.mov -vcodec copy -acodec copy out.mov
```
### Отправка файла по ftp через curl
``` sh
curl -T filename ftp://hostname --user username:password || while ! curl -C- -T filename ftp://hostname --user username:password ; do true ; done
```
### Работа с архивами
создать .tar.gz    
``` sh
tar -czvf file.tar.gz /full/path
```
создать .tar.bz2    
``` sh
tar -cjvf file.tar.bz2 /full/path
```
распаковать tar.gz    
``` sh
tar -xvf file.tar.gz -C /full/path
```
распаковать tar.bz2    
``` sh
tar -xvjf file.tar.bz2 -C /full/path
```
