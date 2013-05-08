# Adam Radomski  Kody pocztowe

Plik: http://piotr.eldora.pl/weblog/wp-content/plugins/download-monitor/download.php?id=8


## Co zostało zrobione?
Plik pobrany wyeksportowany z sql do csv. Następnie wrzucony do google refine tam poprawiony (zmiana nazw kolumn wyrzucony timestamp).

## Przykładowy dokument i ilość:
```js
{"id": 1, "kod": "00-001", "nazwa": "FUP Warszawa 1", "miejscowosc": "Warszawa (Śródmieście)", "wojewodztwo": "mazowieckie", "adres": "Al. Jana Pawła II", "powiat": "m. st. Warszawa", "zakres": "numer 82", "gmina": "M. st. Warszawa"} 
```


# Aggregation

* [Biblioteka potrzebna do obsługi json](http://code.google.com/p/google-gson/)


Ilość kodów pocztowych w Małym Trójmieście

```
{
  "serverUsed": "/153.19.1.202:27017",
  "result": [
    {
      "_id": "Reda",
      "count_field": 3.0
    },
    {
      "_id": "Rumia",
      "count_field": 7.0
    },
    {
      "_id": "Wejherowo",
      "count_field": 5.0
    }
  ],
  "ok": 1.0
}
```
