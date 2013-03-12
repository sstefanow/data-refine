Obszary Natura 2000 na terenie województwa pomorskiego
=============

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
{"nazwa": "Zatoka Pucka", "wojewodztwo": "pomorskie", "powiat": "obszar morski poza NUTS", "gmina": "obszar morski poza NUTS", "powierzchnia": 62430.4}
{"nazwa": "Lasy Lęborskie", "wojewodztwo": "pomorskie", "powiat": "gdański", "gmina": "Choczewo, Gniewino, Luzino, Łęczyce", "powierzchnia": 8565.3}
{"nazwa": "Puszcza Darżlubska", "wojewodztwo": "pomorskie", "powiat": "gdański", "gmina": "Puck, Reda, Wejherowo", "powierzchnia": 6452.6}
```


[Plik z danymi](https://github.com/mfrankowski/data-refine/blob/master/natura2000.json)
