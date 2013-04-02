# Kody pocztowe, Dorian Sawa
------------------------------
Oryginalny plik z danymi do pobrania przez:
`wget -O kody_pocztowe.csv.bz2 http://piotr.eldora.pl/weblog/wp-content/plugins/download-monitor/download.php?id=7`

## Co zostało zrobione?
1. Pobrano oryginalny plik CSV, kody pocztowe GUS.
* Przeczyszczono dane przy użyciu Google-Refine (głównie usunięto zbędne kolumny, czy zmieniono ich nazwe).
* Export z Google-Refine danych do postaci JSON.
* Export odbył się do pliku .txt, więc poprawiono plik na .json, dopasowany do importu do bazy.
* Rozdzielenie pliku .json na 2 pomniejsze, gdyż pojedyńczy był za duży dla mongoimport.
* Zaimportowanie do lokalnej bazy:
 * Użycie mojego skryptu (importer) z [mongo-easy-scripts](https://github.com/dsawa/mongo-easy-scripts)
 * Ewentualnie: `mongoimport --db nosql --collection zipcodes --type json --file zipcodes_part3.json --jsonArray`

## Oczyszczone JSON-y w postaci (jednolinijkowej):
```js
{"kod": "71-212", "miejsce": "Szczecin", "ulica": "Ul. Janka Muzykanta", "zakres": "numery od 1 do końca obie strony", "wojewodztwo": "zachodniopomorskie", "powiat": "m. szczecin", "gmina": "M. Szczecin"}
{"kod": "65-057", "miejsce": "Zielona Góra", "ulica": "Ul. Podgórna", "zakres": "numery od 3 do 7 nieparzyste", "wojewodztwo": "lubuskie", "powiat": "m. zielona góra", "gmina": "M. Zielona Góra"}
```
## Przykładowy dokument po zaimportowaniu do bazy oraz ilość wszystkich:
```
> db.zipcodes.count()
140076
> db.zipcodes.find().limit(1).pretty()
{
      "_id" : ObjectId("513f837e98971044ab940b22"),
	"kod" : "06-410",
	"miejsce" : "Ciechanów",
	"ulica" : "Ul. Jastruna Mieczysława",
	"zakres" : "numery od 1 do końca obie strony",
	"wojewodztwo" : "mazowieckie",
	"powiat" : "ciechanowski",
	"gmina" : "Ciechanów"
}
```
* Oczyszczone JSONy z racji wagi do ściągnięcia z dropboxa:
[Klik](https://www.dropbox.com/sh/6rq54na5velgqxr/v4FkNM-eXO)
