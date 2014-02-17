examples
========
my examples

install php-fpm
`apt-get install php5-cli php5-common php5-mysql php5-suhosin php5-gd php5-fpm php5-cgi php-pear php5-mcrypt`

sublime text    
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
insert config into xdebug.ini    
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

set time format
``` sh
gsettings set com.canonical.indicator.datetime time-format custom && gsettings set com.canonical.indicator.datetime custom-time-format "%Y-%m-%d %H:%M:%S"
```

compile nginx    
``` sh
./configure --sbin-path=/usr/local/nginx/nginx --conf-path=/usr/local/nginx/nginx.conf --pid-path=/var/run/nginx.pid --with-http_ssl_module --with-pcre=./pcre-8.34 --with-zlib=./zlib-1.2.8
```
