<?php

require_once('ep_API/ep_API.php');

set_time_limit(0);
$break = 0;
$i = 0;
$_kody = new ep_Dataset('kody_pocztowe');

$result_kody[] = "";
$kody = $_kody->find_all(100,$i*100);
$i+=1;
while($i<350&&$break!=1) {
	$ret = "";
	if(sizeof($kody)<2) {
		$break = 1;
	}
	foreach ($kody as $row) {

		$ret[] = $row->data;


	}


	$result_kody = array_merge((array)$result_kody, (array)$ret);

	$ret =null;
	$kody = $_kody->find_all(100,$i*100);
	$i+=1;

	

}

$fp = fopen('zips.json', 'a');
fwrite($fp, json_encode($result_kody));
fclose($fp);


?>