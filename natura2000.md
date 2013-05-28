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
![Chart1](https://github.com/mfrankowski/data-refine/blob/master/images/mfrankowski1.png)
