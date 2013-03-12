# Kody pocztowe, Dorian Sawa
------------------------------
Oryginalny plik z danymi do pobrania przez:
`wget -O kody_pocztowe.csv.bz2 http://piotr.eldora.pl/weblog/wp-content/plugins/download-monitor/download.php?id=7`

## Co zostało zrobione?
1. Pobrano oryginalny plik CSV, kody pocztowe GUS.
2. Przeczyszczono dane przy użyciu Google-Refine (głównie usunięto zbędne kolumny, czy zmieniono ich nazwe).
3. Export z Google-Refine danych do postaci JSON.
4. Export odbył się do pliku .txt, więc poprawiono plik na .json, dopasowany do importu do bazy.
5. Rozdzielenie pliku .json na 3 pomniejsze, gdyż pojedyńczy był za duży dla mongoimport.
6. Zaimportowanie do lokalnej bazy:
* Użycie mojego skryptu (importer) z [mongo-easy-scripts](https://github.com/dsawa/mongo-easy-scripts)
* Ewentualnie: `mongoimport --db nosql --collection zipcodes --type json --file zipcodes_part3.json --jsonArray`

## Przykładowy dokument:
```js
{
      "kod" : "85-519",
      "miejsce" : "Bydgoszcz",
      "ulica" : "Ul. Żeglarska",
      "zakres" : "numer 30",
      "wojewodztwo" : "Kujawsko-Pomorskie",
      "powiat" : "m. bydgoszcz",
      "gmina" : "M. Bydgoszcz"
}
```
