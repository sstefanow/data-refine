# Lista UNESCO w Europie Wschodniej

## Zródło danych
[Wikipedia](http://en.wikipedia.org/wiki/List_of_World_Heritage_Sites_in_Eastern_Europe)

## Co zostało zrobione?

* Pobranie surowych danych ze strony: [Wikipedia - raw data](http://en.wikipedia.org/w/index.php?title=List_of_World_Heritage_Sites_in_Eastern_Europe&action=edit&section=2)
* Import danych do Google-Refine
* Oczyszczenie danych w licznych krokach (wybranie interesujacych nas danych)
* export danych do postaci JSON 


## Przykładowy dokument i ilość:
```js
    {
      "site" : "Architectural Ensemble of the Trinity Sergius Lavra in Sergiev Posad",
      "coordinates": {
         "latitude" : {
            "degress" : 56,
            "minutes" : 18,
            "seconds" : 37,
            "direction" : "N",
         },
         "longitude" : {
            "degress" : 38,
            "minutes" : 7,
            "seconds" : 52,
            "direction" : "E",
         }
      },
      "country" : "Russia",
      "type" : "Cultural",
      "year" : "1993",
      "description" : " This is a fine example of a working Orthodox monastery, with military features that are typical of the 15th to the 18th century, the period during which it developed. The main church of the Lavra, the Cathedral of the Assumption (echoing the Kremlin Cathedral of the same name), contains the tomb of Boris Godunov. Among the treasures of the Lavra is the famous icon, The Trinity, by Andrei Rublev."
    }
```
Więcej: [Klik](/data/json/unesco_eastern_europe.json)
