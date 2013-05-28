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
(Pięć samochodów mających powyżej 200 koni mechanicznych z najniższą ceną jednego konia mechanicznego)

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
