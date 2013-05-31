##Damian Wieliczko – Budownictwo mieszkalne

##Jakie Dane ?

Ilość Budynków mieszkalnych w roku 2011 w rejonie Pomorskim

##Co Zostało zrobione ?

* Odnalazłem dane na witrynie GUS
* Oczyściłem dane za pomocą Data Wranglera
* Export do JSON

##Przykładowe dane: 

```json
{"Budownictwo_mieszkaniowe": "wg PKD 2007","Jednostka": "","Ilosc": ""},
{"Budownictwo_mieszkaniowe": "ogółem","Jednostka": "mln zł","Ilosc": "14357,4"},
{"Budownictwo_mieszkaniowe": "na 1 mieszkańca","Jednostka": "zł","Ilosc": 28474},
{"Budownictwo_mieszkaniowe": "BUDOWNICTWO MIESZKANIOWE","Jednostka": "","Ilosc": ""},
{"Budownictwo_mieszkaniowe": "Mieszkania oddane do u¿ytkowania","Jednostka": "","Ilosc": ""},
{"Budownictwo_mieszkaniowe": "ogółem","Jednostka": "","Ilosc": ""},
{"Budownictwo_mieszkaniowe": "mieszkania","Jednostka": "mieszk.","Ilosc": 1551},
{"Budownictwo_mieszkaniowe": "izby","Jednostka": "izba","Ilosc": 7029},
{"Budownictwo_mieszkaniowe": "powierzchnia użytkowa","Jednostka": "m2","Ilosc": 163848},
{"Budownictwo_mieszkaniowe": "spółdzielcze","Jednostka": "","Ilosc": ""},
{"Budownictwo_mieszkaniowe": "mieszkania","Jednostka": "mieszk.","Ilosc": 77},
{"Budownictwo_mieszkaniowe": "izby","Jednostka": "izba","Ilosc": 298},
{"Budownictwo_mieszkaniowe": "powierzchnia użytkowa","Jednostka": "m2","Ilosc": 3754},
{"Budownictwo_mieszkaniowe": "komunalne","Jednostka": "","Ilosc": ""},
{"Budownictwo_mieszkaniowe": "mieszkania","Jednostka": "mieszk.","Ilosc": 54},
{"Budownictwo_mieszkaniowe": "izby","Jednostka": "izba","Ilosc": 162},
{"Budownictwo_mieszkaniowe": "powierzchnia użytkowa","Jednostka": "m2","Ilosc": 2620},
{"Budownictwo_mieszkaniowe": "społeczne czynszowe","Jednostka": "","Ilosc": ""},
{"Budownictwo_mieszkaniowe": "mieszkania","Jednostka": "mieszk.","Ilosc": 117},
{"Budownictwo_mieszkaniowe": "izby","Jednostka": "izba","Ilosc": 309},
{"Budownictwo_mieszkaniowe": "powierzchnia użytkowa","Jednostka": "m2","Ilosc": 5930},
{"Budownictwo_mieszkaniowe": "przeznaczone na sprzedaż lub wynajem","Jednostka": "","Ilosc": ""},
{"Budownictwo_mieszkaniowe": "mieszkania","Jednostka": "mieszk.","Ilosc": 249},
```

##Agregacja danych : 

wykorzystałem dane [zips.json](http://media.mongodb.org/zips.json)

Stany z najmniejszą populacją : 
```json
coll.aggregate(
  { $group: {_id: {state: "$state", city: "$city"}, pop: {$sum: "$pop"}} },
  { $group: {_id: "$_id.state", minCityPop: {$min: "$pop"} } },
  { $sort: {minCityPop: 1} },
  { $limit: 50 }
)
```
wyniki (nie wszystkie): 

```json
{
			"_id" : "MN",
			"minCityPop" : 12
		},
		{
			"_id" : "IA",
			"minCityPop" : 15
		},
		{
			"_id" : "MA",
			"minCityPop" : 16
		},
		{
			"_id" : "NJ",
			"minCityPop" : 17
		},
		{
			"_id" : "DC",
			"minCityPop" : 21
		},
		{
			"_id" : "IN",
			"minCityPop" : 23
		},
		{
			"_id" : "CT",
			"minCityPop" : 25
		},
		{
			"_id" : "NH",
			"minCityPop" : 27
		},
		{
			"_id" : "MD",
			"minCityPop" : 32
		},
		{
			"_id" : "IL",
			"minCityPop" : 38
		},
		{
			"_id" : "OH",
			"minCityPop" : 38
		},
		{
			"_id" : "MO",
			"minCityPop" : 44
		},
		{
			"_id" : "RI",
			"minCityPop" : 45
		},
		{
			"_id" : "MS",
			"minCityPop" : 79
		}
```

[wykres] http://chart.googleapis.com/chart?chxs=0,000000,0&chxt=x&chs=300x245&cht=p3&chco=008000|FF0000|49188F|7777CC|990066|BBCCED|80C65A|00FF00|AA0033|E8F4F7|224499|0000FF|000000|FF9900&chd=s:wbbXXXUQPONKKJH&chdl=MS|RI|MO|RI|OH|IL|MD|NH|CT|IN|DC|NJ|MA|IA|MN&chp=2.3&chl=+&chtt=states+with+the+lowest+population&chts=676767,12.5

pogrupowane by state o średniej populacji większej niż 1000 , posortowane malejąco

```json
coll.aggregate(
  { $group: {_id: "$state", totalPop: {$sum: "$pop"}, avgPop: {$avg: "$pop"}} },
  { $match: {avgPop: {$gte: 1000}} },
  { $sort: {totalPop: -1}}
)
```
5 pogrupowanych miejscowości z największą popularnością 

```json
coll.aggregate(
  { $group: {_id: {state : "$state",city: "$city"} ,largestPop: {$last: "$pop"}} },
  { $sort: { largestPop : -1}},
  { $limit: 5}
)
```

