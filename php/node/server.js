var express = require('express'),
http = require('http'),
path = require('path'),
phpExpress = require('php-express')({
  binPath: '/usr/bin/php'
});

var app = express();
app.set('port', process.env.PORT || 7345);
app.use(express.bodyParser());

app.set('views', path.join(__dirname, 'dev'));
app.engine('php', phpExpress.engine);
app.set('view engine', 'php');
app.use(app.router);

app.all(/.+\.php$/, phpExpress.router);
http.createServer(app).listen(app.get('port'));
