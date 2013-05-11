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

50 pogrupowanych o najmniejszej populacji : 
```json
coll.aggregate(
  { $group: {_id: {state: "$state", city: "$city"}, pop: {$sum: "$pop"}} },
  { $group: {_id: "$_id.state", minCityPop: {$min: "$pop"} } },
  { $sort: {minCityPop: 1} },
  { $limit: 50 }
)
```
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

