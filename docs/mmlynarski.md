Zawodnicy UFC
====================

Lista zawodników największej organizacji MMA na świecie. Dane znalezione na [Wiki](http://wikipedia.org). Dane oczyściłem i stworyłem dodatkoew kolumny. Przykładowo dla zapisu "3-2-1 (4NC)" podzieliłem dane na kolumny: Wins-Loses-Draws (No contests).

## Przykładowe dane:
```json
{ "_id" : ObjectId("519285b409f2c36427483957"), "ISO" : "USA", "Name" : "Frank Mir", "Nickname" : null, "Wins" : 14, "Loses" : 7, "Draws" : null, "No contests" : null }
{ "_id" : ObjectId("519285b409f2c36427483958"), "ISO" : "BRA", "Name" : "Gabriel Gonzaga", "Nickname" : "Napão", "Wins" : 9, "Loses" : 6, "Draws" : null, "No contests" : null }
{ "_id" : ObjectId("519285b409f2c36427483959"), "ISO" : "NED", "Name" : "Stefan Struve", "Nickname" : "Skyscraper", "Wins" : 9, "Loses" : 4, "Draws" : null, "No contests" : null }
{ "_id" : ObjectId("519285b409f2c3642748395a"), "ISO" : "BRA", "Name" : "Junior dos Santos", "Nickname" : "Cigano", "Wins" : 9, "Loses" : 1, "Draws" : null, "No contests" : null }
{ "_id" : ObjectId("519285b409f2c3642748395b"), "ISO" : "USA", "Name" : "Cain Velasquez", "Nickname" : null, "Wins" : 9, "Loses" : 1, "Draws" : null, "No contests" : null }
{ "_id" : ObjectId("519285b409f2c3642748395c"), "ISO" : "USA", "Name" : "Pat Barry", "Nickname" : "HD", "Wins" : 5, "Loses" : 5, "Draws" : null, "No contests" : null }

* Plik json z danymi: [UFC_Fighters.json](/data/json/UFC_Fighters.json)

Import do mongoDB:

```bash
mongoimport --db nosql --collection UFC_Fighters --type json --file UFC_Fighters.json --jsonArray
```

## Agregacje

### 3 kraje z najwiekszą ilością zawodników
```
db.UFC_Fighters.aggregate( 
	{ $group : { _id : "$ISO", ilosc : { $sum : 1}}},
	{ $sort : { ilosc: -1} },
	{ $limit : 5 }
)
```
### Zawodnicy z największą ilością wygranych
```
db.UFC_Fighters.aggregate(
	{ $group : { _id : "$Wins"}},
	{ $sort : { ilosc: -1} },
	{ $limit : 5 }
)
```
### Liczba zawodników z USA
```
db.UFC_Fighters.aggregate( 
	{ $match : { ISO : "USA"}},
	{ $group : { _id : "$ISO", liczbaZawodnikowUSA : { $sum : 1}}}
)
```
