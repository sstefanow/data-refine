<?php
$m = new Mongo();
$db = $m->selectDB('test')->selectCollection('kodypocztowe');
$c = $db->find();
// top 5 miast z największą liczbą kodów pocztowych
$out = $db->aggregate(array(
	array(
		'$group' => array(
			'_id' => '$gminy',
			'suma' => array('$sum' => 1)
		)
	),
	array(
		'$sort' => array(
			'suma' => -1
		)
	),
	array(
		'$limit' => 5
	)
));
foreach($out as $id => $value)
{
	var_dump($value);
}
// ilość kodów pocztowych w każdym województwie
$out = $db->aggregate(array(
	array(
		'$group' => array(
			'_id' => '$wojewodztwo',
			'suma' => array('$sum' => 1)
		)
	),
	array(
		'$sort' => array(
			'suma' => -1
		)
	)
));
foreach($out as $id => $value)
{
	var_dump($value);
}
// miasto w województwie z najwieksza ilościa kodów
$out = $db->aggregate(array(
	array(
		'$group' => array(
			'_id' => array('wojewodztwo' => '$wojewodztwo', 'miasto' => '$miejscowosci_str'),
			'suma' => array('$sum' => 1)
		)
	),
	array(
		'$sort' => array(
			'suma' => -1
		)
	),
	array(
		'$group' => array(
			'_id' => '$_id.wojewodztwo',
			'NajwiecejKodow' => array('$first' => '$_id.miasto'),
			'NajwiecejKodowIlosc' => array('$first' => '$suma'),
			'NajmniejKodow' => array('$last' => '$_id.miasto'),
			'NajmniejKodowIlosc' => array('$last' => '$suma'),
		)
	)
));
foreach($out as $id => $value)
{
	var_dump($value);
}
?>