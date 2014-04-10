<?php

/**
listen in terminal linux
$ apt-get install socket
$ socket -sl 91195
use
console::log($_POST, $_GET);
 */

class console {
	private static $socket;
	public static function log(){
		if (empty(self::$socket)){
			self::$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
			socket_connect(self::$socket, 'localhost', 8989);
		}
		$args = func_get_args();
		$result = '';
		foreach ($args as $dump) {
			$result .= PHP_EOL;
			$result .= '** DUMP BEGIN '.date('H:i:s').' **'.PHP_EOL;
			$result .= var_export($dump, true).PHP_EOL;
			$result .= '** DUMP END '.date('H:i:s').' **'.PHP_EOL;
		}
		socket_write(self::$socket, $result);
	}
}
