# Lista lotnisk na swiecie - Bartłomiej Bedra

Dane pobrane ze [strony](http://www.ourairports.com/data/airports.csv)
Oczyściłem za pomocą Google Refine

## Lista wykonanych kroków

1. Pobranie pliku airports.csv z powyższego linku.
2. Załadowanie pliku do Google Refine
3. Usunięcie niepotrzebnych kolumn, ustawienie kodowania
4. Zapisanie pliku do postaci json

## Przykładowe dane


```
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
      "gps_code" : "00A"
    }
```

## Plik z oczyszczonymi danymi

[link](https://github.com/nosql/data-refine/blob/master/data/json/bbedra_airports_csv.json)

## Agregacje


### Liczba lotnisk w Polsce
```
	db.lotniska.aggregate( 
		{ $match : { iso_country : "PL"}},
		{ $group : { _id : "$iso_country", liczbaLotnisk : { $sum : 1}}}
	)
```
Wynik:
```
	{
		"result" : [
			{
				"_id" : "PL",
				"liczbaLotnisk" : 168
			}
		],
		"ok" : 1
	}
```

### Liczba lotnisk wg typów, malejąco
```
	db.lotniska.aggregate( 
		{ $group : { _id : "$type", ilosc : { $sum : 1}}},
		{ $sort : { ilosc: -1} }
	)
```
Wynik:
```
	{
		"result" : [
			{
				"_id" : "small_airport",
				"liczbaLotnisk" : 29026
			},
			{
				"_id" : "heliport",
				"liczbaLotnisk" : 8731
			},
			{
				"_id" : "medium_airport",
				"liczbaLotnisk" : 4528
			},
			{
				"_id" : "closed",
				"liczbaLotnisk" : 1221
			},
			{
				"_id" : "seaplane_base",
				"liczbaLotnisk" : 895
			},
			{
				"_id" : "large_airport",
				"liczbaLotnisk" : 562
			},
			{
				"_id" : "balloonport",
				"liczbaLotnisk" : 17
			}
		],
		"ok" : 1
	}
```

### 5 krajów z największą liczbą lotnisk
```
	db.lotniska.aggregate( 
		{ $group : { _id : "$iso_country", ilosc : { $sum : 1}}},
		{ $sort : { ilosc: -1} },
		{ $limit : 5 }
	)
```
Wynik:
```
	{
		"result" : [
			{
				"_id" : "US",
				"ilosc" : 21403
			},
			{
				"_id" : "BR",
				"ilosc" : 3800
			},
			{
				"_id" : "CA",
				"ilosc" : 2397
			},
			{
				"_id" : "AU",
				"ilosc" : 1725
			},
			{
				"_id" : "RU",
				"ilosc" : 910
			}
		],
		"ok" : 1
	}
```