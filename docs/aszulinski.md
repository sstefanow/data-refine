## Agregacje


###1\. Ilość lotnisk typu heliport położonych powyżej 500 stóp

```js
db.airports.aggregate({$project: {
                _id: 0,
                elevation: "$elevation_ft",
                type: "$type",
                name: "$name"}},
        {$match: {
                elevation: {$gt: 500},
                type: "heliport"}},
        {$group: {
                _id: {
                        name: "$name",
                        elevation: "$elevation"}}}
)
```
###wynik:
Wyniki zostały ograniczone ze względu na ilość danych otrzymywanych na wyjściu.
```
{
	"result" : [
		{
			"_id" : {
				"name" : "Guadalupe Hospital Heliport",
				"elevation" : 530
			}
		},
		{
			"_id" : {
				"name" : "University Health System Heliport",
				"elevation" : 994
			}
		},
		{
			"_id" : {
				"name" : "Department of Public Safety Heliport",
				"elevation" : 650
			}
		},
		{
			"_id" : {
				"name" : "Methodist Hospital Heliport",
				"elevation" : 1078
			}
		},
		{
			"_id" : {
				"name" : "Del Rio Heliport",
				"elevation" : 707
			}
		}
	],
	"ok" : 1
}
```

###2\. Ilość poszczególnych znaków w bazie akapitów Dostojewskiego

```js
db.dostojewski.aggregate({$project: {
                _id: 0,
                letters: "$letters"}},
        {$unwind: "$letters"},
        {$group: {
                _id: "$letters",
                total: {$sum: 1}}},
        {$sort: {total: -1}}
)
```
###wynik:

```
{
	"result" : [
		{
			"_id" : "e",
			"total" : 51260
		},
		{
			"_id" : "i",
			"total" : 34932
		},
		{
			"_id" : "n",
			"total" : 34431
		},
		{
			"_id" : "a",
			"total" : 34396
		},
		{
			"_id" : "r",
			"total" : 33801
		},
		{
			"_id" : "t",
			"total" : 30776
		},
		{
			"_id" : "s",
			"total" : 28245
		},
		{
			"_id" : "o",
			"total" : 27305
		},
		{
			"_id" : "d",
			"total" : 24971
		},
		{
			"_id" : "l",
			"total" : 23262
		},
		{
			"_id" : "c",
			"total" : 17031
		},
		{
			"_id" : "g",
			"total" : 15037
		},
		{
			"_id" : "u",
			"total" : 14942
		},
		{
			"_id" : "p",
			"total" : 14699
		},
		{
			"_id" : "h",
			"total" : 13676
		},
		{
			"_id" : "m",
			"total" : 12529
		},
		{
			"_id" : "y",
			"total" : 9833
		},
		{
			"_id" : "f",
			"total" : 8775
		},
		{
			"_id" : "b",
			"total" : 6877
		},
		{
			"_id" : "v",
			"total" : 6819
		},
		{
			"_id" : "w",
			"total" : 5563
		},
		{
			"_id" : "k",
			"total" : 5207
		},
		{
			"_id" : "x",
			"total" : 1731
		},
		{
			"_id" : "j",
			"total" : 1021
		},
		{
			"_id" : "-",
			"total" : 874
		},
		{
			"_id" : "q",
			"total" : 803
		},
		{
			"_id" : "z",
			"total" : 705
		},
		{
			"_id" : "_",
			"total" : 519
		}
	],
	"ok" : 1
}
```
###3\. Najpopularniejsze tagi/typy muzyki

```js
db.genres.aggregate({$project: {
                _id: 0,
                tag: 1,
                names: 1}},
        {$unwind: "$names"},
        {$group: {
                _id: "$tag",
                popularity: {$sum: 1}}},
        {$sort: {popularity: -1}}
)

```
###wynik:

```
{
	"result" : [
		{
			"_id" : "rock",
			"popularity" : 101
		},
		{
			"_id" : "classicrock",
			"popularity" : 97
		},
		{
			"_id" : "hardrock",
			"popularity" : 61
		},
		{
			"_id" : "british",
			"popularity" : 52
		},
		{
			"_id" : "70s",
			"popularity" : 42
		},
		{
			"_id" : "80s",
			"popularity" : 39
		},
		{
			"_id" : "heavymetal",
			"popularity" : 30
		},
		{
			"_id" : "bluesrock",
			"popularity" : 30
		},
		{
			"_id" : "metal",
			"popularity" : 25
		},
		{
			"_id" : "blues",
			"popularity" : 25
		}
	],
	"ok" : 1
}
```
