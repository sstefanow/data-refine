#Obszary Natura 2000 na terenie województwa pomorskiego

### *Michał Frankowski*

##Pobranie danych

1) Dane znalazem na stronie [http://natura2000.gdos.gov.pl](http://natura2000.gdos.gov.pl/datafiles). 

2) Do pobrania danych użyłem [ScraperWik](https://scraperwiki.com/), po napisaniu krótkiego [skrytpu](https://scraperwiki.com/scrapers/natura2000/) specjalnie nie oczyszczone dane zapisałem do pliku csv.

##Oczyszczenie danych

1) Do oczyszenia danych użyłem narzędzia Google Refine.

2) Wcześniej wspomniany plik csv załadowałem do Google Refine.

3) Pogrupowałem dane w odpowiednie kolumny, wartości kolumny z powierzchnią zamieniłem na wartości liczbowe oraz usunąłem niepotrzebne znaki.

4) Tak przygotowane dane skonwertowałem do fomatu JSON.

## Przykładowe dane:
```json
    {
      "powierzchnia" : 18.7,
      "gmina" : "Cieszków",
      "nazwa" : "Chłodnia w Cieszkowie",
      "powiat" : "milicki",
      "wojewodztwo" : "dolnośląskie"
    }
```


[Plik z danymi](https://github.com/mfrankowski/data-refine/blob/master/natura2000.json)

#Agregacje

##Samochody z najlepszym stosunkiem mocy do ceny
(Pięć samochodów mających powyżej 200 koni mechanicznych z najniższą ceną jednego konia mechanicznego ze zbioru "car_market" (M. Stanik))

###Kod agregacji w JavaScript

```js
db.cars.aggregate([ {$match: { price: { $gt: 0 }, horse_power: { $gt: 200 } } },
    				{$project : {_id: 0, make: 1, model: 1, price: 1, horse_power: 1, 
                    count: {$divide : ["$price", "$horse_power"]}}},
                    {$sort : {count: 1}},
					{$limit : 5}
                ],function (err, results) {
    console.log(results);
})
```
###Wynik agregacji
```
  { make: 'chevrolet',
    model: 'camaro z28',
    price: 22065,
    horse_power: 305,
    count: 72.34426229508196 },
  { make: 'pontiac',
    model: 'firebird formula',
    price: 24320,
    horse_power: 305,
    count: 79.73770491803279 },
  { make: 'ford',
    model: 'mustang gt',
    price: 21565,
    horse_power: 260,
    count: 82.9423076923077 },
  { make: 'ford',
    model: 'mustang svt cobra',
    price: 28155,
    horse_power: 320,
    count: 87.984375 },
  { make: 'pontiac',
    model: 'firebird trans am',
    price: 27430,
    horse_power: 305,
    count: 89.93442622950819 }
```
###Wykres
![Chart1](https://raw.github.com/mfrankowski/data-refine/master/images/mfrankowski1.png)

##Najdroższe marki samochodów
(Średnia cena samochodów poszczególnych marek ze zbioru "car_market" (M. Stanik))

###Kod agregacji w JavaScript
```js
db.cars.aggregate([ {$group : {_id: "$make", count: {$avg: "$price"}}},
	       	{$sort : {count: -1}},
                {$project : {_id: 0,  make: "$_id", count: 1}},
                {$limit : 5}
	],function (err, results) {
		console.log(results);
})
```

###Wynik agregacji
```
  { count: 65758.63636363637, make: 'jaguar' },
  { count: 64655, make: 'porsche' },
  { count: 59300.15, make: 'mercedes-benz' },
  { count: 46922.94117647059, make: 'bmw' },
  { count: 45183.333333333336, make: 'lexus' }
```

###Wykres
![Chart2](https://raw.github.com/mfrankowski/data-refine/master/images/mfrankowski2.png)

###Link do wykresu
```
//chart.googleapis.com/chart
   ?chxr=0,0,100000
   &chxt=x
   &chbh=a
   &chs=500x300
   &cht=bhg
   &chco=FFEAC0,C2BDDD,C3D9FF,DDF8CC,E0E0E0
   &chd=s:o,n,k,c,b
   &chdl=Jaguar|Porsche|Mercedes+Benz|BMW|Lexus
   &chtt=Najdroższe+marki+samochodów
   &chts=76A4FB,16.5
```

##Liczba czynnych lotnisk w Europie bez uwzględnienia lądowisk helikopterów ze zbioru "bbedra_airports_csv"

###Kod agregacji w JavaScript
```js
db.airports.aggregate([ {$match: { continent: "EU", type: { $ne: "heliport", $ne: "closed"}} },
						{$group : {_id: "$iso_country", suma: {$sum: 1}}},
						{$sort : {suma: 1}},
						{$project : {_id: 0,  iso_country: "$_id", suma: 1}},
                ],function (err, results) {
    console.log(results);
})
```

###Wynik agregacji
```
  { suma: 1, iso_country: 'VA' },
  { suma: 1, iso_country: 'LI' },
  { suma: 1, iso_country: 'AD' },
  { suma: 1, iso_country: 'JE' },
  { suma: 1, iso_country: 'MC' },
  { suma: 1, iso_country: 'GI' },
  { suma: 2, iso_country: 'SM' },
  { suma: 2, iso_country: 'IM' },
  { suma: 2, iso_country: 'MT' },
  { suma: 2, iso_country: 'GG' },
  { suma: 4, iso_country: 'KS' },
  { suma: 6, iso_country: 'ME' },
  { suma: 7, iso_country: 'TR' },
  { suma: 8, iso_country: 'MD' },
  { suma: 8, iso_country: 'AL' },
  { suma: 8, iso_country: 'FO' },
  { suma: 9, iso_country: 'LU' },
  { suma: 11, iso_country: 'BA' },
  { suma: 13, iso_country: 'MK' },
  { suma: 19, iso_country: 'EE' },
  { suma: 20, iso_country: 'SK' },
  { suma: 20, iso_country: 'LV' },
  { suma: 21, iso_country: 'RS' },
  { suma: 23, iso_country: 'RO' },
  { suma: 23, iso_country: 'SI' },
  { suma: 26, iso_country: 'BY' },
  { suma: 28, iso_country: 'HR' },
  { suma: 37, iso_country: 'LT' },
  { suma: 45, iso_country: 'IE' },
  { suma: 55, iso_country: 'HU' },
  { suma: 67, iso_country: 'PT' },
  { suma: 67, iso_country: 'DK' },
  { suma: 68, iso_country: 'BG' },
  { suma: 70, iso_country: 'NL' },
  { suma: 70, iso_country: 'GR' },
  { suma: 73, iso_country: 'CH' },
  { suma: 82, iso_country: 'IS' },
  { suma: 105, iso_country: 'UA' },
  { suma: 105, iso_country: 'FI' },
  { suma: 116, iso_country: 'BE' },
  { suma: 133, iso_country: 'AT' },
  { suma: 144, iso_country: 'CZ' },
  { suma: 152, iso_country: 'NO' },
  { suma: 155, iso_country: 'IT' },
  { suma: 155, iso_country: 'PL' },
  { suma: 161, iso_country: 'SE' },
  { suma: 170, iso_country: 'ES' },
  { suma: 344, iso_country: 'GB' },
  { suma: 541, iso_country: 'DE' },
  { suma: 555, iso_country: 'RU' },
  { suma: 780, iso_country: 'FR' } 
```

###Wykres
![Chart3](https://raw.github.com/mfrankowski/data-refine/master/images/mfrankowski3.png)

###Link do wykresu
```
//chart.googleapis.com/chart
   ?chs=650x350
   &cht=map:auto
   &chco=B3BCC0|8B0707|651067|329262|5574A6|3B3EAC|16D620|B91383|F4359E|9C5935|A9C413|668D1C|BEA413|0C5922
   &chld=AT|BE|CH|CZ|DE|FR|NL|PL|SK|LT|BY|UA|LU
   &chdl=Austria|Belgia|Szwajcaria|Czechy|Niemcy|Francja|Holandia|Polska|Słowacja|Litwa|Białoruś|Ukraina|Luksemburg
   &chm=f133,FF0000,0,0,10|f116,FF0000,0,1,10|f73,FF0000,0,2,10|f144,FF0000,0,3,10|f541,FF0000,0,4,10|f780,FF0000,0,5,10|f70,FF0000,0,6,10|f155,FF0000,0,7,10|f20,FF0000,0,8,10|f37,FF0000,0,9,10|f26,FF0000,0,10,10|f105,FF0000,0,11,10|f9,FF0000,0,12,10
   &chtt=Liczba+lotnisk
   &chts=76A4FB,16.5
```
