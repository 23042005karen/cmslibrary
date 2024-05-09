<?php
	define('DB_HOST', 'localhost');
	define('DB_USER', 'root');
	define('DB_PASSOWRD', '');
	define('DB_NAME', 'diplom');

	$mysql = new mysqli(DB_HOST, DB_USER, DB_PASSOWRD, DB_NAME);
	if ($mysql->connect_errno) exit('Ошибка подключения к БД');
	$mysql->set_charset('utf8');
	$mysql->close();
?>