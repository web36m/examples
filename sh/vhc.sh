#! /bin/sh
USER=yourname
DIR=/home/$USER/work/
mkdir -p $DIR$1/project/public
mkdir $DIR$1/logs
chown -R $USER $DIR$1
echo > $DIR$1/nginx.conf 'server {
	listen		80;
	charset		utf-8;
	server_name	'$1' www.'$1';
	root		'$DIR$1'/project/public;
	index		index.html;
	access_log	'$DIR$1'/logs/access.log;
	error_log	'$DIR$1'/logs/error.log;
		location = /favicon.ico {
		log_not_found off;
		access_log off;
	}
	location /api/ {
		proxy_pass http://127.0.0.1:8080;
		proxy_set_header Host $host;
	}
	location ~* \.php$ {
		fastcgi_pass        unix:/tmp/phpfpm.sock;
		fastcgi_index       index.php;
		fastcgi_param       SCRIPT_FILENAME  '$DIR$1'/public$fastcgi_script_name;
		include             fastcgi_params;
	}
}'
ln -s $DIR$1/nginx.conf /etc/nginx/sites-enabled/$1
echo >>/etc/hosts '127.0.0.1    '$1
echo >>/etc/hosts '127.0.0.1    www.'$1
/etc/init.d/nginx restart
