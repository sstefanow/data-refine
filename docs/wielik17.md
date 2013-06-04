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

![wykres] (http://chart.googleapis.com/chart?chxs=0,000000,0&chxt=x&chs=300x245&cht=p3&chco=008000|FF0000|49188F|7777CC|990066|BBCCED|80C65A|00FF00|AA0033|E8F4F7|224499|0000FF|000000|FF9900&chd=s:wbbXXXUQPONKKJH&chdl=MS|RI|MO|RI|OH|IL|MD|NH|CT|IN|DC|NJ|MA|IA|MN&chp=2.3&chl=+&chtt=states+with+the+lowest+population&chts=676767,12.5)

10 Miast o najmniejszej średniej populacji:

```json
coll.aggregate(
  { $group: {_id: {state: "$state", city: "$city"}, pop: {$sum: "$pop"}} },
  { $group: {_id: "$_id.state", avgCityPop: {$avg: "$pop"} } },
  { $sort: {avgCityPop: 1} },
  { $limit: 10 }
)
```

wyniki : 
```json 
{
	"result" : [
		{
			"_id" : "ND",
			"avgCityPop" : 1629.591836734694
		},
		{
			"_id" : "SD",
			"avgCityPop" : 1826.7821522309712
		},
		{
			"_id" : "VT",
			"avgCityPop" : 2315.8765432098767
		},
		{
			"_id" : "MT",
			"avgCityPop" : 2585.970873786408
		},
		{
			"_id" : "WV",
			"avgCityPop" : 2759.1953846153847
		},
		{
			"_id" : "AK",
			"avgCityPop" : 2989.3641304347825
		},
		{
			"_id" : "ME",
			"avgCityPop" : 2994.9463414634147
		},
		{
			"_id" : "NE",
			"avgCityPop" : 3029.5297504798464
		},
		{
			"_id" : "IA",
			"avgCityPop" : 3119.949438202247
		},
		{
			"_id" : "WY",
			"avgCityPop" : 3359.911111111111
		}
	],
	"ok" : 1
}

```
![wykres](http:////chart.googleapis.com/chart?chxr=0,0,3354&chxt=x&chbh=23,27,28&chs=540x244&cht=bvg&chco=80C65A&chds=0,3359&chd=t:1629,1826,2315,2585,2759,2989,2994,3029,3119,3359&chg=-1,-1,0,0&chma=|50)

Miasta z populacją większą niż 800000 a mniejszą niż 1000000.

```json
coll.aggregate(
  { $group: {_id: "$city", totalPop: {$sum: "$pop"}} },
  { $match: {totalPop: {$gte: 800000, $lte: 1000000}} }
)

```

wyniki : 

```json
{
	"result" : [
		{
			"_id" : "COLUMBUS",
			"totalPop" : 825448
		},
		{
			"_id" : "SAN JOSE",
			"totalPop" : 817497
		},
		{
			"_id" : "DETROIT",
			"totalPop" : 967468
		},
		{
			"_id" : "DALLAS",
			"totalPop" : 999042
		},
		{
			"_id" : "SAN ANTONIO",
			"totalPop" : 813188
		},
		{
			"_id" : "PHOENIX",
			"totalPop" : 902249
		},
		{
			"_id" : "MIAMI",
			"totalPop" : 848436
		}
	],
	"ok" : 1
}

```

![wykres](//chart.googleapis.com/chart?chs=440x200&cht=p&chco=000000,008000,49188F,0000FF,990066,FF0000&chds=0,999042&chd=t:825448,817497,967468,999042,813188,902249,848436&chdl=COLUMBUS|SAN+JOSE|DETROIT|DALLAS|SAN+ANTONIO|PHOENIX|MIAMI&chl=825448|817497|967468|999042|813188|902249|848436)

