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
	private static $foreground_colors = array(
		'green' => '0;32',
		'cyan' => '0;36',
		'red' => '0;31'
	);
	private static function colored($str, $color = NULL){
		$result = '';
		if (isset(self::$foreground_colors[$color])) {
			$result .= "\033[".self::$foreground_colors[$color].'m';
		}
		$result .=  $str."\033[0m";
		return $result;
	}
	public static function log(){
		if (empty(self::$socket)){
			self::$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
			socket_connect(self::$socket, 'localhost', 8989);
		}
		$args = func_get_args();
		$result = '';
		foreach ($args as $dump) {
			$text = var_export($dump, true);
			preg_match_all('/\'(.*)\'\s=>\s/imU', $text, $array_keys);
			if (!empty($array_keys[1])){
				$array_keys[1] = array_unique($array_keys[1]);
				foreach($array_keys[1] as $key){
					$text = str_replace('\''.$key.'\' => ', '\''.self::colored($key, 'cyan').'\' => ', $text);
				}
			}
			$text = str_replace('array', self::colored('array', 'green'), $text);
			$text = str_replace('(', self::colored('(', 'green'), $text);
			$text = str_replace(')', self::colored(')', 'green'), $text);
			$text = str_replace(' => ', self::colored(' => ', 'green'), $text);
			$text = str_replace('true', self::colored('true', 'red'), $text);
			$text = str_replace('false', self::colored('false', 'red'), $text);
			$text = str_replace('NULL', self::colored('NULL', 'red'), $text);
			$result .= PHP_EOL;
			$result .= '** DUMP BEGIN '.date('H:i:s').' **'.PHP_EOL;
			$result .= $text.PHP_EOL;
			$result .= '** DUMP END '.date('H:i:s').' **'.PHP_EOL;
		}
		socket_write(self::$socket, $result);
	}
}
