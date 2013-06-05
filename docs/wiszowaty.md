### *Maciej Wiszowaty*

# Oczyszczanie danych
## Krok po kroku

1. Pobrać dane. [link](http://pl.wikisource.org/wiki/Lista_kod%C3%B3w_pocztowych_w_Polsce)
   (dla Okregu warszawskiego)
2. Pobrać Google Refine. [link](https://code.google.com/p/google-refine/wiki/Downloads?tm=2)
3. Oczyścić oraz posortować dane przy pomocy Google Refine.
   (Ustalic nazwy kolumn,podzielic dane na kolumny,odfiltrowac zawiruszone dane)
4. Wyeksportować powyższe dane do pliku csv przy pomocy Google Refine.
  (Najlepiej zastosowac customowy separator w postaci np ";", ktory nie wystepuje orginalnie w danych)



## Pliki

1. [oryginalne dane](/data/raw/wiszowaty_dane_raw.txt)
2. [plik csv](/data/csv/wiszowaty_dane_refined.csv)
3. [plik csv](/data/csv/wiszowaty_dane_refined_semicolon.csv)

## Przykładowe dane

```csv
00-020; ul. Szpitalna od 1 do 1; Warszawa; Województwo mazowieckie; Miasto Warszawa na prawach powiatu
00-021; ul. Chmielna od 1 do 35; Warszawa; Województwo mazowieckie; Miasto Warszawa na prawach powiatu
```

##Importowanie do mongodb
```csv
mongoimport --collection kody_pocztowe --type csv --file data-refine/data/csv/wiszowatydane_refined.txt -f kod,Adres,miasto,wojewodzto,komentarz
```
