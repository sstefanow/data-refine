KODY_POCZTOWE
=============

##Dane dotyczą miast w których jest mniej niż 100 obszarów doręczeń.

1)Dane do oczyszczenia można pobrać ze [strony](http://pl.wikisource.org/wiki/Lista_kod%C3%B3w_pocztowych_w_Polsce/%C5%9Arednie_miasta). 

2)Dane zostały oczyszczone narzędziem  "Google Refine", dostępnym na [stronie](https://code.google.com/p/google-refine/).

##Opis działania.

- Należy pobrać narzędzie Google Refine. 
- Pobrać wybrane przez siebie dane i zapisać w pliku tekstowym. 
- Uruchomić narzędzie google refine i wczytać plik tekstowy. 
- Dane oczyścić.
- Wynik eksportowac do pliku.json


## Przykładowe dane:
```json
 {
      "Miasto" : "Jelenia Góra",
      "Oddiał" : "Instytucja Rejonowy Urząd Poczty w Jeleniej Górze",
      "Lokalizacja" : " ul. Pocztowa 9/10",
      "Kod" : "58-500"
    }
    {
      "Miasto" : "Jelenia Góra",
      "Oddiał" : "Poczta Jelenia Góra 001",
      "Lokalizacja" : " ul. Pocztowa 9/10",
      "Kod" : "58-500"
    }
    {
      "Miasto" : "Jelenia Góra",
      "Oddiał" : "Poczta Jelenia Góra 003",
      "Lokalizacja" : " ul. Wolności 58",
      "Kod" : "58-501"
    }
```

Oczyszczone dane znajdują się tu: [dane_6i6ant.json](/data/dane_6i6ant.json).
