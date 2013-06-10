# Lotniska

### *Anna Łońska*

## Dane

Plik airports.csv pobrałam ze strony http://www.ourairports.com/data.

Dane oczyściłam za pomocą Google Refine i zapisałam do pliku json.

### Przykładowe dane

```js
{
  "id" : 6523,
  "type" : "heliport",
  "name" : "Total Rf Heliport",
  "latitude_deg" : 40.07080078125,
  "longitude_deg" : -74.9336013793945,
  "elevation_ft" : 11,
  "continent" : "NA",
  "iso_country" : "US",
  "iso_region" : "US-PA",
  "municipality" : "Bensalem",
  "scheduled_service" : "no",
  "gps_code" : "00A"
}
```

Plik z oczyszczonymi danymi

[airports.json](https://github.com/Iskratgz/lotniska/blob/master/data/json/alonska_airports.json)

## Agregacje

### Największa liczba typu lotnisk na kontynentach

```js
db.airports.aggregate(
	{ $group :
		{ _id : { kontynent : "$continent", typ : "$type" },
		ilosc : { $sum : 1 }}
	},
	{ $sort : { ilosc : -1 }},
	{ $group :
		{ _id : "$_id.kontynent",
		typ : { $first : "$_id.typ" },
		ilosc : { $first : "$ilosc" }}
	},
	{ $sort : { _id : 1 }}
)
```

Wynik

```js
{
	"result" : [
		{ "_id" : "AF", "typ" : "small_airport", "ilosc" : 2017 },
		{ "_id" : "AN", "typ" : "small_airport", "ilosc" : 21 },
		{ "_id" : "AS", "typ" : "small_airport", "ilosc" : 1758 },
		{ "_id" : "EU", "typ" : "small_airport", "ilosc" : 2677 },
		{ "_id" : "NA", "typ" : "small_airport", "ilosc" : 15544 },
		{ "_id" : "OC", "typ" : "small_airport", "ilosc" : 2039 },
		{ "_id" : "SA", "typ" : "small_airport", "ilosc" : 5082 }
	],
	"ok" : 1
}
```

Wykres

![kontynenty](https://raw.github.com/Iskratgz/lotniska/master/images/alonska/kontynenty.png)

### Liczba lotnisk w regionach w Polsce

```js
db.airports.aggregate(
	{ $match : { iso_country : "PL" }},
	{ $group : { _id : "$iso_region", ilosc : { $sum : 1 }}},
	{ $sort : { _id : 1 }}
)
```

Wynik:

```js
{
	"result" : [
		{ "_id" : "PL-DS", "ilosc" : 16 },
		{ "_id" : "PL-KP", "ilosc" : 10 },
		{ "_id" : "PL-LB", "ilosc" : 8 },
		{ "_id" : "PL-LD", "ilosc" : 10 },
		{ "_id" : "PL-LU", "ilosc" : 9 },
		{ "_id" : "PL-MA", "ilosc" : 5 },
		{ "_id" : "PL-MZ", "ilosc" : 15 },
		{ "_id" : "PL-OP", "ilosc" : 4 },
		{ "_id" : "PL-PD", "ilosc" : 4 },
		{ "_id" : "PL-PK", "ilosc" : 10 },
		{ "_id" : "PL-PM", "ilosc" : 14 },
		{ "_id" : "PL-SK", "ilosc" : 2 },
		{ "_id" : "PL-SL", "ilosc" : 9 },
		{ "_id" : "PL-WN", "ilosc" : 8 },
		{ "_id" : "PL-WP", "ilosc" : 19 },
		{ "_id" : "PL-ZP", "ilosc" : 25 }
	],
	"ok" : 1
}
```

Wykres

![regiony](https://raw.github.com/Iskratgz/lotniska/master/images/alonska/regiony.png)

