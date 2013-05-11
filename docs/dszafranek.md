# Przeciętne miesięczne wynagrodzenia brutto lata 2002 - 2011 według powiatów w Polsce

## Źródło 
Strona Głównego Urzędu Statystycznego [GUS](http://www.stat.gov.pl/bdl/app/strona.html?p_name=indeks)

## Co zostało zrobione

* Wyszukanie interesujących danych statystycznych
* Pobranie danych w formacie csv
* Import danych do Google Refine
* Wyczyszczenie danych, usunięcie zbędnych rekordów oraz edycja danych za pomocą Google Refine
* Eksport danych w postaci JSON

## Przykładowe dane (json):
```js
    {
      "Kod" : "1101506000",
      "Województwo" : "Łódzkie",
      "Region" : "Powiat Łódzki Wschodni",
      "2002" : 1647.74,
      "2003" : 1762.31,
      "2004" : 1791.79,
      "2005" : 1836.05,
      "2006" : 1939.69,
      "2007" : 2126.36,
      "2008" : 2303.11,
      "2009" : 2447.97,
      "2010" : 2554.12,
      "2011" : 2677.69
    },
    {
      "Kod" : "1101508000",
      "Województwo" : "Łódzkie",
      "Region" : "Powiat Pabianicki",
      "2002" : 1763.97,
      "2003" : 1857.39,
      "2004" : 1913.13,
      "2005" : 1980.37,
      "2006" : 2045.07,
      "2007" : 2158.65,
      "2008" : 2430.88,
      "2009" : 2519.87,
      "2010" : 2622.52,
      "2011" : 2812.11
    }
```
## Przykładowe agregacje:
Coming soon

## Odnośniki do plików:
[Plik csv przed oczyszczeniem] (/data/csv/wynagrodzenia_brutto-dszafranek.csv)
[Oczyszczony JSON](/data/json/dszafranek.json)
