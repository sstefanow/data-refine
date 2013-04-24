#Lista lotów programu Apollo
--------------------------------

## Przygotowania
* dane do pobrania z Wikipedii: http://en.wikipedia.org/w/index.php?title=Apollo_program&action=edit&section=28
* narzędzie Google Refine: https://code.google.com/p/google-refine/

## Oczyszczanie danych
* import danych do programu (Line-based text files)
* usunięcie niepotrzebnych wierszy (Text Filter)
* oczyszczenie z wierszy z niepotrzebnych danych tak, żeby każda kolumna oddzielona była znkaiem | (Transform)
* mając kolejne kolumny oddzielone znakiem | możemy teraz dodawać kolumny (Add column based on this column) korzystając ze split i wybierać dane
* usuwamy początkową kolumnę
* eksportujemy

## Przykładowe dane o locie

```json
{
  "Designation" : "Apollo 7",
  "Date" : "Oct. 11-22, 1968",
  "Description" : "Earth orbital demonstration of Block II CSM, launched on Saturn IB. First live television publicly broadcast from a manned mission",
  "Crew" : "Wally Schirra, Walt Cunningham, Donn Eisele"
}
```
Cały plik: [jmartin.json](/data/json/jmartin.json)

#Agregacje
--------------------------------

## Przygotowania
* Pobranie danych - imieniny

```sh
wget https://raw.github.com/nosql/data-refine/master/data/csv/imieniny.csv
```

* import do mongo

```sh
mongoimport --drop --headerline --type csv --collection imieniny < imieniny.csv
```

* zmiana formatu danych w rubym

```ruby
require 'mongo'
include Mongo

db = MongoClient.new("localhost", 27017, w: 1, wtimeout: 200, j: true).db("test")
coll = db.collection("imieniny")

coll.find({}, {snapshot: true}).each do |doc|
  doc["names"] = doc["names"].split(" ")
  doc["date"] = "%02d/%02d" % [doc["day"], doc["month"]]
  doc.delete("day") ; doc.delete("month")
  coll.save(doc)
end
```

## Agregacje

* kto musi świętować jednocześnie sylwester i swoje imieniny?

``` js
db.imieniny.aggregate(
  { $project: { names: 1, date : 2} },
  { $unwind: "$names" },
  { $group: { _id : "$date", count: {$sum : 1}} },
  { $match: {_id: "31/12"} }
)
```
