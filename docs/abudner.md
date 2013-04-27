# Adresy IP

## Konfiguracja skryptu


Trzeba pobrać klucz do API ze strony http://www.ipinfodb.com a nastepnie wpisać klucz do pliku php


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

###1\. Ilość zakresów adresów IP w danym województwie posortowane malejąco

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


###2\. Wyświetlenie 10 miast z największą ilością zakresów IP

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

##3\. Miasta w województwie, które posiadają najmniej i najwięcej zakresów IP

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


Dane IP [dane.json](https://github.com/abudner/nosql/blob/master/dane.json)
