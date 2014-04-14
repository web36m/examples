// Поиск слов, которые необходимо перевести
class MyWords {
	static public $words = array();
}
add_filter('gettext', function($new, $old, $domain){
	if ($domain === 'my-lang-domain'){
		MyWords::$words[] = $old;
	}
	return $new;
}, 1000, 3 );
add_action('shutdown', function(){
	if (!empty(MyWords::$words)){
		var_dump(MyWords::$words);
	}
});
