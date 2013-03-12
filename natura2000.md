Obszary Natura 2000 na terenie województwa pomorskiego
=============

##Pobranie danych

1) Dane znalazem na [stronie](http://natura2000.gdos.gov.pl/datafiles). 

2) Do pobrania danych użyłem [ScraperWik](https://scraperwiki.com/), po napisaniu krótkiego [skrytpu](https://scraperwiki.com/scrapers/natura2000/) specjanie nie oczyszczone zapisałem je do pliku csv.

##Oczyszczenie danych

1) Do oczyszenia danych użyłem narzędzia Google Refine.

2) Wcześniej wspomniany plik csv załadowałem do Google Refine.

3) Pogrupowałem dane w odpowiednie kolumny, wartości kolumny z powierzchnią zamieniem na wartości liczbowe oraz usunąłem niepotrzebne znaki.

4) Tak przygotowane dane skonwertowałem do fomatu JSON.

## Przykładowe dane:
```json
{
  "rows" : [
    {
      "Nazwa" : "Bagna Izbickie",
      "Województwo" : "pomorskie",
      "Powiat" : "słupski",
      "Gmina" : "Główczyce",
      "Powierzchnia" : 786.4
    },
    {
      "Nazwa" : "Białe Błoto",
      "Województwo" : "pomorskie",
      "Powiat" : "słupski, gdański",
      "Gmina" : "Cewice Linia",
      "Powierzchnia" : 43.4
    },
    {
      "Nazwa" : "Białogóra",
      "Województwo" : "pomorskie",
      "Powiat" : "gdański",
      "Gmina" : "Krokowa, Choczewo",
      "Powierzchnia" : 1132.8
    },
```
