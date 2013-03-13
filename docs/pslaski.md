# Dane historyczne notowań WIG20
------------------------------
##Źródło danych

Oryginalne dane pobrałem w formacie csv z serwisu [stooq.pl](http://stooq.pl/q/d/?s=wig20&c=0)

## Oczyszczanie danych
1. Pobranie danych w formacie csv z podanego wyżej serwisu.
* Import danych do Google-Refine (kosmetyczne zmiany).
* Export danych do postaci JSON.

## Przykładowe rekordy:
```json
{
      "Data" : "2013-03-07",
      "Otwarcie" : 2478.96,
      "Najwyzszy" : 2485,
      "Najnizszy" : 2471.46,
      "Zamkniecie" : 2474.7,
      "Wolumen" : 29561629
    },
    {
      "Data" : "2013-03-08",
      "Otwarcie" : 2485.48,
      "Najwyzszy" : 2505.66,
      "Najnizszy" : 2480.86,
      "Zamkniecie" : 2490.7,
      "Wolumen" : 26154320
    },
    {
      "Data" : "2013-03-11",
      "Otwarcie" : 2491.79,
      "Najwyzszy" : 2494.14,
      "Najnizszy" : 2476.03,
      "Zamkniecie" : 2479.2,
      "Wolumen" : 21245329
    }
```
* Oczyszczone Dane:
[Klik](/data/json/pslaski_WIG20.json)

