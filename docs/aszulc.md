# Ilość pomieszczeń szkolnych w szkołach podstawowych poszczególnych województw oraz powiatów lat 2007 - 2011.

## Dane ze strony Głównego Urzędu Statystycznego 

[GUS](http://www.stat.gov.pl/bdl/app/strona.html?p_name=indeks)

## Opis

* Pobranie danych statystycznych w formacie csv
* Zaimportowanie danych do Google Refine
* Wyczyszczenie danych oraz edycja danych za pomocą Google Refine
* Eksport danych w formacie JSON

## Przykład danych w formacie JSON:

```js
    {
      "Kod" : 1100000000,
      "Jednostka terytorialna" : " ŁÓDZKIE",
      "pomieszczenia szkolne 2007" : 10941,
      "pomieszczenia szkolne 2008" : 10932,
      "pomieszczenia szkolne 2009" : 11161,
      "pomieszczenia szkolne 2010" : 11168,
      "pomieszczenia szkolne 2011" : 10971
    },
    {
      "Kod" : 1101506000,
      "Jednostka terytorialna" : "Powiat łódzki wschodni",
      "pomieszczenia szkolne 2007" : 254,
      "pomieszczenia szkolne 2008" : 260,
      "pomieszczenia szkolne 2009" : 280,
      "pomieszczenia szkolne 2010" : 278,
      "pomieszczenia szkolne 2011" : 276
    },
    {
      "Kod" : 1101508000,
      "Jednostka terytorialna" : "Powiat pabianicki",
      "pomieszczenia szkolne 2007" : 371,
      "pomieszczenia szkolne 2008" : 379,
      "pomieszczenia szkolne 2009" : 386,
      "pomieszczenia szkolne 2010" : 386,
      "pomieszczenia szkolne 2011" : 385
    },
    {
      "Kod" : 1101520000,
      "Jednostka terytorialna" : "Powiat zgierski",
      "pomieszczenia szkolne 2007" : 583,
      "pomieszczenia szkolne 2008" : 611,
      "pomieszczenia szkolne 2009" : 638,
      "pomieszczenia szkolne 2010" : 621,
      "pomieszczenia szkolne 2011" : 619
    }
```

## Pliki:

[plik csv przed użyciem Google Refine] (/data/csv/pomieszczenia_szkolne.csv)
[Po użyciu Google Refine w formacie JSON](/data/json/pomieszczenia_szkolne.json)
