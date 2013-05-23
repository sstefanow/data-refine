<?php
$m = new Mongo();
$c = $m->selectDB("test")->selectCollection("ceny");
// Œrednia cena wszystkich produktów w ka¿dym roku. Liczone od 2003 roku, poniewa¿ we wczeœniejszych latach jest du¿o mniej towarów.
$ops = array(
	array(
		'$match' => array(
			"rok" => array('$gte' => 2003),
		)
	),
	array(
		'$group' => array(
			"_id" => '$rok',
			"srednia_cena" => array('$avg' => '$cena'),
		)
	),
	array(
		'$project' => array(
			"_id" => 0,
			"rok" => '$_id',
			"srednia_cena" => 1,
		)
	),
	array(
		'$sort' => array(
			"rok" => 1
		)
	)
));
$results = $c->aggregate($ops);
var_dump($results);

//----------------------------------------------------

$c = $m->selectDB("test")->selectCollection("census1881");
// 5 religii, którzych œrednia liczba wyznawców jest najwy¿sza.
$ops = array(
	array(
		'$group' => array(
			"_id" => '$religion',
			"sredni_wiek" => array('$avg' => '$age'),
		)
	),
	array(
		'$sort' => array(
			"sredni_wiek" => -1
		)
	),
	array(
		'$project' => array(
			"_id" => 0,
			"religia" => '$_id',
			"sredni_wiek" => 1,
		)
	),
	array(
		'$limit' => 5
		)
	)
));
$results = $c->aggregate($ops);
var_dump($results);

//----------------------------------------------------

$c = $m->selectDB("test")->selectCollection("car_market");
// Lista 5 najdro¿szych aut, które zmieszcz¹ siê w moim ma³ym gara¿u.
$ops = array(
	array(
		'$match' => array(
			"height" => array('$lte' => 85),
			"length" => array('$lte' => 165),
			"width" => array('$lte' => 75),
		)
	),
	array(
		'$project' => array(
			"_id" => 0,
			"make" => 1,
			"model" => 1,
			"price" => 1,
			"length" => 1,
			"width" => 1,
			"height" => 1,
		)
	),
	array(
		'$sort' => array(
			"price" => -1
		)
	),
	array(
		'$limit' => 5
		)
	)
));
$results = $c->aggregate($ops);
var_dump($results);
?>