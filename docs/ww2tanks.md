# Czołgi II wojny światowej -- Adam Dąbrowski

## Opis
Dane pobrałem ze strony http://ww2db.com/vehicle.php?list=T . Napisałem program, który czytał tabelki ze specyfikacją czołgów i przetwarzał je na CSV. Wyczyściłem je przy pomocy Google Refine:
* Usunąłem jednostki długości, szerokości, wysokości i ciężaru oraz przetworzyłem je na wartość numeryczną.
* Podzieliłem prędkość i zasięg na drodze i w terenie na dwie kolumny
* Przy pomocy opcji Facets usunąłem błędne dane
* Eksportowałem do postaci JSON

## Przykładowy JSON
```json
{
	"Name":"7TP jw",
	"Type":"Light tank",
	"Country":"Poland",
	"Engine":"One Saurer VGLD diesel engine rated at 110hp",
	"Suspension":"Leaf spring bogie",
	"Armament":"1x37mm Bofors wz. 37 gun, 1x7.92mm Ckm wz.30 machine gun",
	"Armor":"17mm",
	"Crew":3,
	"Length":4.6,
	"Width":2.4,
	"Height":2.27,
	"Weight":9,
	"Speed":
	{
		"OnTerrain":null,
		"OnRoad":37
	},
	"Range":
	{
		"OnTerrain":null,
		"OnRoad":150
	}
}
```

##Agregacja

Generuję listę państw, biorących udział w II wojnie światowej wraz z najcięższym czołgiem, wyprodukowanym przez to państwo.

```js
db.tanks.aggregate(
  {$project: {Name: "$Name", Country: "$Country, Weight: "$Weight"}},
  {$sort: { Weight: 1}},
  {$group: {_id: "$Country", HeaviestTank: {$last: "$Name"}, HeaviestTankWeight: {$last: "$Weight"}}},
  {$sort: {_id: 1}}
);
```
