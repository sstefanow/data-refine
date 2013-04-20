# Kody pocztowe

## Konfiguracja php
```
max_execution_time = 90
```

Link do API, powinno być w folderze ePF_API - https://github.com/epforgpl/ePF_API 

Należy ustawić w pliku ep_API.php swoje klucze do API ze strony http://sejmometr.pl

## Opis

Do pobrania kodów pocztowych wykorzystałem API sejmometru w PHP, całością zajmuje się prosty skrypcik php pobierający wszystkie rekordy

## Sposób użycia

Ściągnij API, skonfiguruj klucze API, skonfiguruj PHP a następnie na wybranym serwerze uruchom plik index.php, pobieranie kodów następuje odrazu

## Przykadowe dane

Przykadowe dane w pliku [data.json](https://github.com/misiom1/sejmometr/blob/master/data.json)

## Agregacje

### 5 miast z największą ilością kodów pocztowych

```
$db->aggregate(array(
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
```

Wynik:

```
array(5) {
  [0]=>
  array(2) {
    ["_id"]=>
    string(8) "Warszawa"
    ["suma"]=>
    int(4001)
  }
  [1]=>
  array(2) {
    ["_id"]=>
    string(7) "Łódź"
    ["suma"]=>
    int(1618)
  }
  [2]=>
  array(2) {
    ["_id"]=>
    string(8) "Wrocław"
    ["suma"]=>
    int(1248)
  }
  [3]=>
  array(2) {
    ["_id"]=>
    string(7) "Poznań"
    ["suma"]=>
    int(1214)
  }
  [4]=>
  array(2) {
    ["_id"]=>
    string(8) "Szczecin"
    ["suma"]=>
    int(1126)
  }
}
```

### Ilość kodów pocztowych w każdym województwie

```
$db->aggregate(array(
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
```
Wynik:

```
array(17) {
  [0]=>
  array(2) {
    ["_id"]=>
    string(11) "mazowieckie"
    ["suma"]=>
    int(4432)
  }
  [1]=>
  array(2) {
    ["_id"]=>
    string(18) "zachodniopomorskie"
    ["suma"]=>
    int(1857)
  }
  [2]=>
  array(2) {
    ["_id"]=>
    string(9) "łódzkie"
    ["suma"]=>
    int(1795)
  }
  [3]=>
  array(2) {
    ["_id"]=>
    string(13) "wielkopolskie"
    ["suma"]=>
    int(1628)
  }
  [4]=>
  array(2) {
    ["_id"]=>
    string(14) "dolnośląskie"
    ["suma"]=>
    int(1560)
  }
  [5]=>
  array(2) {
    ["_id"]=>
    string(9) "pomorskie"
    ["suma"]=>
    int(1484)
  }
  [6]=>
  array(2) {
    ["_id"]=>
    string(12) "małopolskie"
    ["suma"]=>
    int(1431)
  }
  [7]=>
  array(2) {
    ["_id"]=>
    string(9) "śląskie"
    ["suma"]=>
    int(1055)
  }
  [8]=>
  array(2) {
    ["_id"]=>
    string(18) "kujawsko-pomorskie"
    ["suma"]=>
    int(872)
  }
  [9]=>
  array(2) {
    ["_id"]=>
    string(9) "lubelskie"
    ["suma"]=>
    int(789)
  }
  [10]=>
  array(2) {
    ["_id"]=>
    string(20) "warmińsko-mazurskie"
    ["suma"]=>
    int(770)
  }
  [11]=>
  array(2) {
    ["_id"]=>
    string(9) "podlaskie"
    ["suma"]=>
    int(722)
  }
  [12]=>
  array(2) {
    ["_id"]=>
    string(8) "opolskie"
    ["suma"]=>
    int(627)
  }
  [13]=>
  array(2) {
    ["_id"]=>
    string(16) "świętokrzyskie"
    ["suma"]=>
    int(601)
  }
  [14]=>
  array(2) {
    ["_id"]=>
    string(8) "lubuskie"
    ["suma"]=>
    int(490)
  }
  [15]=>
  array(2) {
    ["_id"]=>
    string(12) "podkarpackie"
    ["suma"]=>
    int(472)
  }
  [16]=>
  array(2) {
    ["_id"]=>
    string(0) ""
    ["suma"]=>
    int(8)
  }
}
```

Jak widać niektóre miasta nie są przypisane do żadnego województwa

### Miasta we wszystkich województwach z największą ilością kodów

```
$db->aggregate(array(
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
```

Wynik:

```
array(17) {
  [0]=>
  array(5) {
    ["_id"]=>
    string(0) ""
    ["NajwiecejKodow"]=>
    string(0) ""
    ["NajwiecejKodowIlosc"]=>
    int(8)
    ["NajmniejKodow"]=>
    string(0) ""
    ["NajmniejKodowIlosc"]=>
    int(8)
  }
  [1]=>
  array(5) {
    ["_id"]=>
    string(12) "podkarpackie"
    ["NajwiecejKodow"]=>
    string(8) "Rzeszów"
    ["NajwiecejKodowIlosc"]=>
    int(145)
    ["NajmniejKodow"]=>
    string(80) "Chlewiska, Dębiny, Huta-Złomy, Jędrzejówka, Kadłubiska oraz 9 miejscowości"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [2]=>
  array(5) {
    ["_id"]=>
    string(18) "zachodniopomorskie"
    ["NajwiecejKodow"]=>
    string(8) "Szczecin"
    ["NajwiecejKodowIlosc"]=>
    int(1126)
    ["NajmniejKodow"]=>
    string(87) "Jamienko, Lubiesz, Marcinkowice, Marcinkowice (Bytyń), Płociczno oraz 4 miejscowości"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [3]=>
  array(5) {
    ["_id"]=>
    string(9) "lubelskie"
    ["NajwiecejKodow"]=>
    string(6) "Lublin"
    ["NajwiecejKodowIlosc"]=>
    int(562)
    ["NajmniejKodow"]=>
    string(96) "Aleksandrów, Anonin, Borowina, Celiny Szlacheckie, Celiny Włościańskie oraz 32 miejscowości"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [4]=>
  array(5) {
    ["_id"]=>
    string(14) "dolnośląskie"
    ["NajwiecejKodow"]=>
    string(26) "Wrocław (Wrocław-Krzyki)"
    ["NajwiecejKodowIlosc"]=>
    int(343)
    ["NajmniejKodow"]=>
    string(9) "Zabrodzie"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [5]=>
  array(5) {
    ["_id"]=>
    string(9) "łódzkie"
    ["NajwiecejKodow"]=>
    string(25) "Łódź (Łódź-Bałuty)"
    ["NajwiecejKodowIlosc"]=>
    int(351)
    ["NajmniejKodow"]=>
    string(81) "Brzezie, Bukowie Dolne, Bukowie Górne, Chynów, Czarny Las oraz 43 miejscowości"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [6]=>
  array(5) {
    ["_id"]=>
    string(13) "wielkopolskie"
    ["NajwiecejKodow"]=>
    string(26) "Poznań (Poznań-Grunwald)"
    ["NajwiecejKodowIlosc"]=>
    int(341)
    ["NajmniejKodow"]=>
    string(97) "Gralewo, Kamionna, Kamionna (Kamionna-Folwark), Kamionna (Wiktorowo), Mnichy oraz 2 miejscowości"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [7]=>
  array(5) {
    ["_id"]=>
    string(8) "lubuskie"
    ["NajwiecejKodow"]=>
    string(13) "Zielona Góra"
    ["NajwiecejKodowIlosc"]=>
    int(354)
    ["NajmniejKodow"]=>
    string(66) "Czarnowice, Gębice, Koperno, Kujawa, Sieńsk oraz 3 miejscowości"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [8]=>
  array(5) {
    ["_id"]=>
    string(16) "świętokrzyskie"
    ["NajwiecejKodow"]=>
    string(6) "Kielce"
    ["NajwiecejKodowIlosc"]=>
    int(497)
    ["NajmniejKodow"]=>
    string(66) "Borki, Borowiec, Borów, Brus, Brynica Sucha oraz 51 miejscowości"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [9]=>
  array(5) {
    ["_id"]=>
    string(18) "kujawsko-pomorskie"
    ["NajwiecejKodow"]=>
    string(9) "Bydgoszcz"
    ["NajwiecejKodowIlosc"]=>
    int(664)
    ["NajmniejKodow"]=>
    string(7) "Gruczno"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [10]=>
  array(5) {
    ["_id"]=>
    string(9) "pomorskie"
    ["NajwiecejKodow"]=>
    string(7) "Gdańsk"
    ["NajwiecejKodowIlosc"]=>
    int(598)
    ["NajmniejKodow"]=>
    string(29) "Ciecholewy, Janin, Kokoszkowy"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [11]=>
  array(5) {
    ["_id"]=>
    string(9) "podlaskie"
    ["NajwiecejKodow"]=>
    string(10) "Białystok"
    ["NajwiecejKodowIlosc"]=>
    int(592)
    ["NajmniejKodow"]=>
    string(82) "Aleksandrowo, Biszewo, Bogusze Stare, Bogusze-Litewka, Czaje oraz 42 miejscowości"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [12]=>
  array(5) {
    ["_id"]=>
    string(20) "warmińsko-mazurskie"
    ["NajwiecejKodow"]=>
    string(7) "Olsztyn"
    ["NajwiecejKodowIlosc"]=>
    int(638)
    ["NajmniejKodow"]=>
    string(6) "Wadąg"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [13]=>
  array(5) {
    ["_id"]=>
    string(8) "opolskie"
    ["NajwiecejKodow"]=>
    string(5) "Opole"
    ["NajwiecejKodowIlosc"]=>
    int(476)
    ["NajmniejKodow"]=>
    string(33) "Dziergowice, Lubieszów, Solarnia"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [14]=>
  array(5) {
    ["_id"]=>
    string(11) "mazowieckie"
    ["NajwiecejKodow"]=>
    string(25) "Warszawa (Śródmieście)"
    ["NajwiecejKodowIlosc"]=>
    int(598)
    ["NajmniejKodow"]=>
    string(72) "Batogowo, Chełchy, Dylewo, Glącka, Glinki-Rafały oraz 9 miejscowości"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [15]=>
  array(5) {
    ["_id"]=>
    string(12) "małopolskie"
    ["NajwiecejKodow"]=>
    string(27) "Kraków (Kraków-Podgórze)"
    ["NajwiecejKodowIlosc"]=>
    int(344)
    ["NajmniejKodow"]=>
    string(48) "Berest, Czyrna, Krynica-Zdrój, Piorunka, Polany"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
  [16]=>
  array(5) {
    ["_id"]=>
    string(9) "śląskie"
    ["NajwiecejKodow"]=>
    string(8) "Katowice"
    ["NajwiecejKodowIlosc"]=>
    int(629)
    ["NajmniejKodow"]=>
    string(9) "Koniaków"
    ["NajmniejKodowIlosc"]=>
    int(1)
  }
}
```
