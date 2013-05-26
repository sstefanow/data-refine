#Ludność w gminach. Stan w dniu 31 marca 2011 r. - wyniki spisu ludności i mieszkań 2011 r.

### *Andrzej Thiel*

##Źródło:
  
1) Dane podbraem ze strony GUS: [http://www.stat.gov.pl/gus/](http://www.stat.gov.pl/gus/5840_13169_PLK_HTML.htm). 

##Proces oczyszczenia danych:

1) Do oczyszenia danych poslużylo mi narzedzie Google Refine

2) Zawartosć pliku CSV zaladowalem do Google Refine

3) Oczyscilem zaladowane dane do takiej postaci by móc póżniej skonwertować je do formatu json

4) Przygotowane dane skonwertowałem do fomatu JSON.

## Przykładowe dane po skonwertowaniu:

```json
{
"Gmina": "G.Borzytuchom                         ",
"Symbol_terytorialny": 2201012,
"Ogółem": 2954,
"Miasto": "                 -",
"Wieś": 2954
}
```

#Agregacje

###Stany z populacją wiekszą niż 7000000 i mniejszą niż 15000000

```js
coll.aggregate(
  { $group: {_id: "$state", totalPop: {$sum: "$pop"}} },
  { $match: {totalPop: {$gte: 7000000, $lte: 15000000}} }
)
```

```json
{
        "result" : [
                {
                        "_id" : "PA",
                        "totalPop" : 11881643
                },
                {
                        "_id" : "OH",
                        "totalPop" : 10847115
                },
                {
                        "_id" : "MI",
                        "totalPop" : 9295297
                },
                {
                        "_id" : "FL",
                        "totalPop" : 12937926
                },
                {
                        "_id" : "NJ",
                        "totalPop" : 7730188
                },
                {
                        "_id" : "IL",
                        "totalPop" : 11430602
                }
        ],
        "ok" : 1
}
```

[wykres](http://chart.googleapis.com/chart
   ?chxr=0,0,15000000
   &chxt=x
   &chbh=a
   &chs=540x220
   &cht=bhg
   &chco=4D89F9,A2C180,3D7930,FF9900,BBCCED,7777CC
   &chds=-5,15000000,0,15000000,0,15000000,0,15000000,0,15000000,0,15000000
   &chd=t:11881643|10847115|9295297|12937926|7730188|11430602
   &chdl=PA|OH|MI|FL|NJ|IL
   &chtt=Stany+z+populacja+wieksza+niz+7000000+i+mniejsza+niz+15000000)
   
![1. agregacja - wykres](https://raw.github.com/nosql/data-refine/master/images/wykres1.png)


###Pięć miast z najwiekszą populacją:

```js
coll.aggregate(
   { $group: {_id: {state: "$state", city: "$city"}, maxPop: {$sum: "$pop"}} },
   { $sort: {maxPop: -1} },
   { $limit: 5 }
)
```

```json
{
        "result" : [
                {
                        "_id" : {
                                "state" : "IL",
                                "city" : "CHICAGO"
                        },
                        "maxPop" : 2452177
                },
                {
                        "_id" : {
                                "state" : "NY",
                                "city" : "BROOKLYN"
                        },
                        "maxPop" : 2300504
                },
                {
                        "_id" : {
                                "state" : "CA",
                                "city" : "LOS ANGELES"
                        },
                        "maxPop" : 2102295
                },
                {
                        "_id" : {
                                "state" : "TX",
                                "city" : "HOUSTON"
                        },
                        "maxPop" : 2095918
                },
                {
                        "_id" : {
                                "state" : "PA",
                                "city" : "PHILADELPHIA"
                        },
                        "maxPop" : 1610956
                }
        ],
        "ok" : 1
}
```
[wykres](http://chart.googleapis.com/chart
   ?chxr=0,0,2600000
   &chxt=y
   &chbh=a
   &chs=400x325
   &cht=bvg
   &chco=A2C180|3D7930|FF9900|BBCCED|7777CC
   &chdl=IL CHICAGO|NY BROOKLYN|CA LOS ANGELES|TX HOUSTON|PA PHILADELPHIA
   &chds=0,2500000
   &chd=t:2452177,2300504,2102295,2095918,1610956|50,60,100,40,20,40,30 
   &chtt=Pięć+miast+z+największą+populacją)
   
![2. agregacja - wykres](https://raw.github.com/nosql/data-refine/master/images/wykres2.png)

###Trzy stany z najmnejszą srednią populacją i sumą populacji wiekszą wiekszą niz 600000

```js
coll.aggregate(
   { $group: {_id: {state: "$state", city: "$city"}, pop: {$sum: "$pop"}} },
   { $group: {_id: "$_id.state", avgCityPop: {$avg: "$pop"}, totalSum: {$sum: "$pop"}} },
   { $match: {totalSum: {$gte: 600000}} },
   { $sort: {avgCityPop: 1} },
   { $limit: 3 }
)
```

```json
{
        "result" : [
                {
                        "_id" : "ND",
                        "avgCityPop" : 1629.591836734694,
                        "totalSum" : 638800
                },
                {
                        "_id" : "SD",
                        "avgCityPop" : 1826.7821522309712,
                        "totalSum" : 696004
                },
                {
                        "_id" : "MT",
                        "avgCityPop" : 2585.970873786408,
                        "totalSum" : 799065
                }
        ],
        "ok" : 1
}
```
[wykres](http://chart.apis.google.com/chart?chs=600x200&cht=p&chd=t:1629.591836734694,1826.7821522309712,2585.970873786408&chl=ND%201629.591836734694|SD%201826.7821522309712|MT%202585.970873786408   &chtt=Trzy+stany+z+najmnejsza+srednia+populacja+i+sumą populacji+wiekszą+wieksza+niz+600000)

![3. agregacja - wykres](https://raw.github.com/nosql/data-refine/master/images/wykres3.png)

