# Pomniki przyrody w Raciborzu

### *Jan Pawlukiewicz*

## Źródło danych
[Wikipedia](http://pl.wikipedia.org/wiki/Pomniki_przyrody_w_Raciborzu)

## Co zostało zrobione?

* Pobranie surowych danych ze strony: [Wikipedia - raw data](http://pl.wikipedia.org/w/index.php?title=Pomniki_przyrody_w_Raciborzu&action=edit&section=1)
* Import danych do Google-Refine
* Oczyszczenie danych w licznych krokach (wybranie interesujacych nas danych)
* Eksport danych do postaci JSON 


## Fragment danych wyeksportowanych do JSON-a:
```json
    {
      "nazwa" : "Dąb biały",
      "inna_nazwa" : "Quercus alba, odmiana łyżkowata Elongata",
      "wysokosc" : 24,
      "korona_drzewa" : 22,
      "piersnica" : 107,
      "obwod" : 336,
      "wiek" : "ok. 120 lat",
      "ustanowiono" : "17 grudnia 1992",
      "opis" : "Jest to najprawdopodobniej najgrubszy dąb biały w Polsce. Znajduje się w dobrym stanie zdrowotnym. Objęto go ochroną w celach naukowo-dydaktycznych, ze względu na atrakcyjny pokrój drzewa oraz budowę morfologiczną liści i kory drzewa, a także ze względu na pokaźne rozmiary. Jest to również egzotyczny gatunek pochodzący z Ameryki Północnej, rzadko spotykany w Polsce."
    }
```
Więcej: [Tutaj](/data/json/pomniki_przyrody_w_raciborzu.json)


## Import danych do bazy (z katalogu projektu)
```bash
mongoimport --db test --collection pomniki --file data/json/pomniki_przyrody_w_raciborzu.json
```

## Agregacje

Link to skryptu: [Tutaj](/scripts/ruby/jpawlukiewicz.rb).

### Ilość wyznawców 10 najpopularniejszych religii

```ruby
religion =  census.aggregate([ 
  {'$group' => { _id: '$religion', count: {'$sum' => 1}}},
  {'$project' => {_id: 0, religion: '$_id', count: '$count'}},
  {'$sort' => { count: -1 }},
  {'$limit' => 10}
])
```

Wynik Google Chart API:

![](https://raw.github.com/joshuaBE/data-refine/master/images/jpawlukiewicz/chart1.png)
