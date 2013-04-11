Lista lotnisk na swiecie - Bartłomiej Bedra
================================
Dane pobrane ze [strony](http://www.ourairports.com/data/airports.csv)
Oczyściłem za pomocą Google Refine

Lista wykonanych kroków
------------------------
1. Pobranie pliku airports.csv z powyższego linku.
2. Załadowanie pliku do Google Refine
3. Usunięcie niepotrzebnych kolumn, ustawienie kodowania
4. Zapisanie pliku do postaci json

Przykładowe dane
---------------------

```
    {
      "id" : 6523,
      "type" : "heliport",
      "name" : "Total Rf Heliport",
      "latitude_deg" : 40.07080078125,
      "longitude_deg" : -74.9336013793945,
      "elevation_ft" : 11,
      "continent" : "NA",
      "iso_country" : "US",
      "iso_region" : "US-PA",
      "municipality" : "Bensalem",
      "gps_code" : "00A"
    }
```

Plik z oczyszczonymi danymi
-----------------------------
[link](https://github.com/nosql/data-refine/blob/master/data/json/bbedra_airports_csv.json)
