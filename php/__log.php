<?php

/**
listen in terminal linux
$ apt-get install socket
$ socket -sl 91195
 */

function __log(){
	$args = func_get_args();
	$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
	socket_connect($socket, 'localhost', 91195);
	$result = '';
	foreach ($args as $dump) {
		$result .= PHP_EOL;
		$result .= '** DUMP BEGIN '.date('H:i:s').' **'.PHP_EOL;
		$result .= var_export($dump, true).PHP_EOL;
		$result .= '** DUMP END '.date('H:i:s').' **'.PHP_EOL;
	}
	socket_write($socket, $result);
}