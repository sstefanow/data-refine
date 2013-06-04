# Statystyki NBA 2012/2013

### *Adam Grabowski*


## Co zostało zrobione?
1. Pobranie danych w formacie CSV ze strony www.spxn.com/Stats.asp
2. Oczyszczenie dane przy użyciu Google-Refine - usunięcie pustych kolumn, zmiana nazw kolumn, posortowanie
3. Export z Google-Refine w postaci JSON

## Kilka przykładów

```json
    {
      "Player Name" : "Kobe Bryant",
      "Games Played" : 78,
      "Field Goal %" : 46.3,
      "Three Point %" : 32.4,
      "Free Throw %" : 83.9,
      "Points Per Game" : 27.3
    }
    {
      "Player Name" : "Tim Duncan",
      "Games Played" : 69,
      "Field Goal %" : 50.2,
      "Three Point %" : 28.6,
      "Free Throw %" : 81.7,
      "Points Per Game" : 17.8
    }
    {
      "Player Name" : "Marcin Gortat",
      "Games Played" : 61,
      "Field Goal %" : 52.1,
      "Three Point %" : 0,
      "Free Throw %" : 65.2,
      "Points Per Game" : 11.1
    }
```

* Wynikowy plik .json :
https://github.com/AGR89/test/blob/master/NBA-2012-2013-Players-Stats.json

## Agregacje

import do bazy:

```
mongoimport --db test --collection players --type json --file players.json --jsonArray
```


Ilu jest zawodników w lidze: 

```
db.players.count()
477
```

Zawodnicy ze średnią punktów na mecz powyżej 25:
```
db.players.group( { 
key: { name: 1, games: 1, PPG: 1 }
, cond: { PPG: {$gt: 25} }
, reduce: function ( curr, result ) { }
, initial: {} } )
```
```json
[
    {
    	"name" : "Carmelo Anthony",
		"games" : 67,
		"PPG" : 28.7
	},
	{
		"name" : "Kevin Durant",
		"games" : 81,
		"PPG" : 28.1
	},
	{
		"name" : "Kobe Bryant",
		"games" : 78,
		"PPG" : 27.3
	},
	{
		"name" : "LeBron James",
		"games" : 76,
		"PPG" : 26.8
	},
	{
		"name" : "James Harden",
		"games" : 78,
		"PPG" : 25.9
	}
]
```

Najlepiej wykonujący rzuty osobiste (powyżej 90% skuteczności):
```
db.players.group( { 
key: { name: 1, games: 1, "FT%": 1 }
, cond: { "FT%": {$gt: 90}, games: {$gt: 50} }
, reduce: function ( curr, result ) { }
, initial: {} } )
```

```json
[
	{
		"name" : "Kevin Durant",
		"games" : 81,
		"FT%" : 90.5
	},
	{
		"name" : "Wayne Ellington",
		"games" : 78,
		"FT%" : 90.7
	},
	{
		"name" : "Toney Douglas",
		"games" : 71,
		"FT%" : 90.5
	},
	{
		"name" : "Brian Roberts",
		"games" : 78,
		"FT%" : 90.9
	},
	{
		"name" : "Steve Novak",
		"games" : 81,
		"FT%" : 90.9
	},
	{
		"name" : "Roger Mason",
		"games" : 69,
		"FT%" : 90.7
	},
	{
		"name" : "Darius Miller",
		"games" : 52,
		"FT%" : 100
	}
]
```

Najsłabiej wykonujący rzuty osobiste (poniżej 50% skuteczności):
```
db.players.group( { 
key: { name: 1, games: 1, "FT%": 1 }
, cond: { "FT%": {$lt: 50}, games: {$gt: 50} }
, reduce: function ( curr, result ) { }
, initial: {} } )
```

```json
[
	{
		"name" : "Dwight Howard",
		"games" : 76,
		"FT%" : 49.2
	},
	{
		"name" : "DeAndre Jordan",
		"games" : 82,
		"FT%" : 38.6
	},
	{
		"name" : "Andre Drummond",
		"games" : 60,
		"FT%" : 37.1
	},
	{
		"name" : "Lamar Odom",
		"games" : 82,
		"FT%" : 47.6
	},
	{
		"name" : "Gustavo Ayon",
		"games" : 55,
		"FT%" : 40
	},
	{
		"name" : "Brendan Haywood",
		"games" : 61,
		"FT%" : 45.5
	},
	{
		"name" : "Ronnie Brewer",
		"games" : 60,
		"FT%" : 41
	},
	{
		"name" : "Ish Smith",
		"games" : 52,
		"FT%" : 42.9
	},
	{
		"name" : "Ronny Turiaf",
		"games" : 65,
		"FT%" : 36.5
	},
	{
		"name" : "Andris Biedrins",
		"games" : 53,
		"FT%" : 30.8
	}
]
```
