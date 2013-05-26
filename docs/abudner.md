# Adresy IP

### *Aneta Budner*

## Konfiguracja skryptu


Trzeba pobrać klucz do API ze strony http://www.ipinfodb.com a nastepnie wpisać klucz do pliku php.


## Opis

Pobieramy baze polskich adresów ip ze strony http://www.nirsoft.net/countryip/pl.csv a nastepnie do każdego adresu ip pobieramy dane geograficzne.



## Przykładowe dane 

```json
{
  "ipAddress": "217.17.32.0",
  "countryCode": "PL",
  "countryName": "POLAND",
  "regionName": "MAZOWIECKIE",
  "cityName": "WARSAW",
  "latitude": "52.2298",
  "longitude": "21.0118",
  "timeZone": "+01:00"
},
{
  "ipAddress": "217.28.144.0",
  "countryCode": "PL",
  "countryName": "POLAND",
  "regionName": "MAZOWIECKIE",
  "cityName": "PLOCK",
  "latitude": "52.5468",
  "longitude": "19.7064",
  "timeZone": "+01:00"
},
{
  "ipAddress": "217.30.128.0",
  "countryCode": "PL",
  "countryName": "POLAND",
  "regionName": "DOLNOSLASKIE",
  "cityName": "WROCLAW",
  "latitude": "51.1",
  "longitude": "17.0333",
  "timeZone": "+01:00"
},
{
  "ipAddress": "217.30.144.0",
  "countryCode": "PL",
  "countryName": "POLAND",
  "regionName": "DOLNOSLASKIE",
  "cityName": "WROCLAW",
  "latitude": "51.1",
  "longitude": "17.0333",
  "timeZone": "+01:00"
},
{
  "ipAddress": "217.67.192.0",
  "countryCode": "PL",
  "countryName": "POLAND",
  "regionName": "MAZOWIECKIE",
  "cityName": "WARSAW",
  "latitude": "52.2298",
  "longitude": "21.0118",
  "timeZone": "+01:00"
}
```

##Przykładowe Agregacje

###1\. Liczba zakresów IP w danym województwie posortowane malejąco

```js
collection.aggregate([
	{ $group : {
		_id : "$regionName",
		suma : {$sum: 1}
	}},
	{ $sort : { suma : -1 }
	},
])
```

Wynik :
	
```js
[ { _id: 'MAZOWIECKIE', suma: 235 },
  { _id: 'SLASKIE', suma: 53 },
  { _id: 'MALOPOLSKIE', suma: 44 },
  { _id: 'POMORSKIE', suma: 42 },
  { _id: 'WIELKOPOLSKIE', suma: 40 },
  { _id: 'DOLNOSLASKIE', suma: 27 },
  { _id: 'ZACHODNIOPOMORSKIE', suma: 27 },
  { _id: 'LUBELSKIE', suma: 23 },
  { _id: 'LODZKIE', suma: 20 },
  { _id: 'PODLASKIE', suma: 17 },
  { _id: 'KUJAWSKO-POMORSKIE', suma: 16 },
  { _id: '-', suma: 14 },
  { _id: 'PODKARPACKIE', suma: 12 },
  { _id: 'WARMINSKO-MAZURSKIE', suma: 6 },
  { _id: 'LUBUSKIE', suma: 6 },
  { _id: 'SWIETOKRZYSKIE', suma: 5 },
  { _id: 'OPOLSKIE', suma: 3 },
  { _id: 'OVERIJSSEL', suma: 1 } ]
```

Niektóre adresy IP nie są przypisane do żadnego województwa oraz jak widać jeden adres jest przypisany do wojewódzwa nie należacego do Polski

Wykres: 

![Wykres](https://raw.github.com/nosql/data-refine/master/images/abudner/ilosc_adresow_ip_abudner.png)

```
//chart.googleapis.com/chart
   ?chs=620x482
   &cht=map:auto=0,0,0,10
   &chco=B3BCC0|2251C5|E0E8FC|C0D1FC|2B64F0|2251C5|2251C5|5786FA|12126C|7CA1FC|4B7DF8|7CA1FC|B9CCFC|133DA6|99B6FC|B9CCFC|2B64F0
   &chld=PL-WP|PL-OP|PL-SK|PL-DS|PL-PM|PL-MA|PL-LD|PL-MZ|PL-KP|PL-LU|PL-PD|PL-LB|PL-SL|PL-PK|PL-WN|PL-ZP
   &chdl=Wielkopolskie|Opolskie|Świętokrzyskie|Dolnośląskie|Pomorskie|Małopolskie|Łódzkie|Mazowieckie|Kujawsko-Pomorskie|Lubelskie|Podlaskie|Lubuskie|Śląskie|Podkarpackie|Warmińsko-Mazurskie|Zachodniopomorskie
   &chm=f235,000000,0,7,13|f53,000000,0,12,13|f44,000000,0,5,13|f42,000000,0,4,13|f40,000000,0,0,13|f27,000000,0,3,13|f27,000000,0,16,13|f23,000000,0,9,13|f20,000000,0,6,13|f17,000000,0,10,13|f16,000000,0,8,13|f12,000000,0,13,13|f6,000000,0,14,13|f6,000000,0,11,13|f5,000000,0,2,13|f3,000000,0,1,13
   &chtt=Liczba+zakresów+IP+w+danym+województwie
```

Powyższy link do wykresu został wygenerowany na stronie https://developers.google.com/chart/image/ użyłam w tym przypadku MapChart.

Link posiadza wszystkie informacje dotyczące mojego wykresu :

	chs - rozmiar wykresu
	cht - typ wykresu
	chco - seria kolorów
	chld - dane etykiet wykresów , w moim przypadku są to regiony
	chdl - legenda wykresu
	chm - linia markera 
	chtt - tytuł wykresu

 
###2\. Wyświetlenie 10 miast z największą liczbą zakresów IP

```js
	collection.aggregate([
	{ $group : {
		_id : "$cityName",
		suma : {$sum: 1}
	}},
	{ $sort : { suma : -1 }
	},
	{ $limit: 10
	},
])
```

Wynik : 

```js
[ { _id: 'WARSAW', suma: 219 },
  { _id: 'KRAKOW', suma: 29 },
  { _id: 'POZNAN', suma: 24 },
  { _id: 'SZCZECIN', suma: 20 },
  { _id: 'GDYNIA', suma: 19 },
  { _id: 'WROCLAW', suma: 19 },
  { _id: 'LUBLIN', suma: 17 },
  { _id: 'BIALYSTOK', suma: 16 },
  { _id: 'GDANSK', suma: 15 },
  { _id: 'LODZ', suma: 15 } ]
```

Wykres: 

![Wykres](https://raw.github.com/nosql/data-refine/master/images/abudner/ilosc_adresow_ip2_abudner.png)

```
//chart.googleapis.com/chart
   ?chxr=0,0,250
   &chxt=y
   &chbh=a
   &chs=702x405
   &cht=bvg
   &chco=FF0000,5BC300,3072F3,EA00FF,FFEE00,C000E7,FF9900,B2F8E8,FF1D8A,FFCF39
   &chds=0,250,0,250,0,250,0,250,0,250,0,250,0,250,0,250,0,250,0,250
   &chd=t:219|29|24|20|19|19|17|16|15|15
   &chdl=Warszawa|Kraków|Poznań|Szczecin|Gdynia|Wrocław|Lublin|Białystok|Gdańsk|Łódź
   &chtt=10+miast+z+największą+liczbą+zakresów+IP
```

Powyższy link do wykresu także został wygenerowany na stronie https://developers.google.com/chart/image/ użyłam w tym przypadku BarChar.

Link posiadza wszystkie informacje dotyczące mojego wykresu :

	chxr - zakres osi
	chbh - szerokość i rozstaw słupków
	chs - rozmiar wykresu
	cht - typ wykresu
	chco - seria kolorów
	chds - skala dla formatowania tekstu
	chd - dane wykresu
	chdl - legenda wykresu
	chtt - tytuł wykresu

###3\. Miasta w województwie, które posiadają najmniej i najwięcej zakresów IP

```js
	collection.aggregate([
	{ $group : {
		_id : {wojewodztwo: "$regionName", miasto: "$cityName"},
		suma : {$sum: 1}
	}},
	{ $sort : { suma : 1 }
	},
	{ $group : {
			_id: "$_id.wojewodztwo",
			najmniejszeMiasto: {$first: "$_id.miasto"},
			najmniejszeMiastoSuma: {$first: "$suma"},
			najwiekszeMiasto: {$last: "$_id.miasto"},
			najwiekszeMiastoSuma: {$last: "$suma"}
		}
	},
])
```

Wynik :

```js
[ { _id: 'POMORSKIE',
    najmniejszeMiasto: 'REDA',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'GDYNIA',
    najwiekszeMiastoSuma: 19 },
  { _id: 'LUBELSKIE',
    najmniejszeMiasto: 'LUKOW',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'LUBLIN',
    najwiekszeMiastoSuma: 17 },
  { _id: 'DOLNOSLASKIE',
    najmniejszeMiasto: 'OLESNICA',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'WROCLAW',
    najwiekszeMiastoSuma: 19 },
  { _id: 'LUBUSKIE',
    najmniejszeMiasto: 'ZIELONA GORA',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'GORZOW WIELKOPOLSKI',
    najwiekszeMiastoSuma: 5 },
  { _id: 'SWIETOKRZYSKIE',
    najmniejszeMiasto: 'OSTROWIEC SWIETOKRZYSKI',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'KIELCE',
    najwiekszeMiastoSuma: 4 },
  { _id: 'MAZOWIECKIE',
    najmniejszeMiasto: 'WYSZKOW',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'WARSAW',
    najwiekszeMiastoSuma: 219 },
  { _id: 'OVERIJSSEL',
    najmniejszeMiasto: 'ZWOLLE',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'ZWOLLE',
    najwiekszeMiastoSuma: 1 },
  { _id: '-',
    najmniejszeMiasto: '-',
    najmniejszeMiastoSuma: 14,
    najwiekszeMiasto: '-',
    najwiekszeMiastoSuma: 14 },
  { _id: 'MALOPOLSKIE',
    najmniejszeMiasto: 'MOSZCZENICA',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'KRAKOW',
    najwiekszeMiastoSuma: 29 },
  { _id: 'KUJAWSKO-POMORSKIE',
    najmniejszeMiasto: 'GRUDZIADZ',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'BYDGOSZCZ',
    najwiekszeMiastoSuma: 8 },
  { _id: 'WIELKOPOLSKIE',
    najmniejszeMiasto: 'TRZEMESZNO',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'POZNAN',
    najwiekszeMiastoSuma: 24 },
  { _id: 'ZACHODNIOPOMORSKIE',
    najmniejszeMiasto: 'KOLOBRZEG',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'SZCZECIN',
    najwiekszeMiastoSuma: 20 },
  { _id: 'LODZKIE',
    najmniejszeMiasto: 'PAJECZNO',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'LODZ',
    najwiekszeMiastoSuma: 15 },
  { _id: 'OPOLSKIE',
    najmniejszeMiasto: 'OPOLE',
    najmniejszeMiastoSuma: 3,
    najwiekszeMiasto: 'OPOLE',
    najwiekszeMiastoSuma: 3 },
  { _id: 'WARMINSKO-MAZURSKIE',
    najmniejszeMiasto: 'MRAGOWO',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'OLSZTYN',
    najwiekszeMiastoSuma: 3 },
  { _id: 'PODLASKIE',
    najmniejszeMiasto: 'HAJNOWKA',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'BIALYSTOK',
    najwiekszeMiastoSuma: 16 },
  { _id: 'SLASKIE',
    najmniejszeMiasto: 'ORZESZE',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'KATOWICE',
    najwiekszeMiastoSuma: 13 },
  { _id: 'PODKARPACKIE',
    najmniejszeMiasto: 'OSTROW',
    najmniejszeMiastoSuma: 1,
    najwiekszeMiasto: 'RZESZOW',
    najwiekszeMiastoSuma: 3 } ]
```

Wykres: 

![Wykres](https://raw.github.com/nosql/data-refine/master/images/abudner/ilosc_adresow_ip_abudner3.png)

Wykres został stworzony w Excelu.


Dane IP [dane.json](https://github.com/abudner/nosql/blob/master/dane.json)
