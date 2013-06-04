# Raporty na teamt pojawień się ufo w USA (2013), Marek Dubrawa
------------------------------
Dane ściągnąłem ze strony [National UFO Reporting Center](http://www.nuforc.org/webreports/ndxevent.html)

## Opis
* plik oczyściłem oraz posortowałem korzystając z [Google refine](http://code.google.com/p/google-refine/)
* następnie wyeksportowałem do pliku JSON

## Przykładowe dane:
```js
    {
      "Description" : "5 minutes Six orange lights in the S. Eastern sky",
      "Shape" : "Circle",
      "State" : "IL",
      "City" : "Edwardsville",
      "Date/Time" : "3/2/13 21:55"
    },
    {
      "Description" : "10 minutes Amber lights moving around and then disappeared.",
      "Shape" : "Light",
      "State" : "FL",
      "City" : "Brandon",
      "Date/Time" : "3/2/13 21:10"
    },
```
* [plik JSON](/data/json/mdubrawa.json)

## Agregacje

Agregacje zostały wykonane bezpośrednio w konsoli mongoDB.
Jako dane wykorzystałem zbiór informacji na temat [rynku nowych samochodów osobowych w USA w 2000 roku](/data/json/car_market.json) dostarczony przez Macieja Stanika. 
Do stworzenia wykresów wykorzystałem narzędzie [Google charts](https://developers.google.com/chart/)

### Średnia moc silników (horese power) dla wszystkich samochodów poszczególnych marek

```js
db.Cars.aggregate( 
	{ $group:
		{ 
		_id: { make: "$make" },
		hp: { $avg: "$horse_power" }
		} 
	},
	{ $sort: 
		{
		hp: 1
		}
	},
	{ $project: 
		{
		marka: "$_id.make",
		sredniaMoc: "$hp"
		}
	});
```

Klauzual project możemy dodać np. tak jak w tym przypadku w calu podmiany nazw zmiennych zywkłymi polskimi nazwami.

![Srednia moc silnika](https://raw.github.com/Socr4tes/data-refine/master/images/mdubrawa/mocsilnika.png) 

### Średnia liczba mil jakie mogą przejachać samochody z automatyczną i manualną skrzynią biegów w mieście i na autostradzie

```js
db.Cars.aggregate( 
	{ $group:
		{ 
		_id: { transmission: "$transmission" },
		avgMpgCity: { $avg: "$mpg_city" },
		avgMpgHighway: { $avg: "$mpg_highway" }
		} 
	});
```

Wynik agregacji

```json
{
       "result" : [
                {
                        "_id" : {
                                "transmission" : "manual"
                        },
                        "avgMpgCity" : 24.1265306122449,
                        "avgMpgHighway" : 31.853061224489796
                },
                {
                        "_id" : {
                                "transmission" : "automatic"
                        },
                        "avgMpgCity" : 18.88888888888889,
                        "avgMpgHighway" : 26.970760233918128
                }
        ],
        "ok" : 1
}
```

Dane przedstawione na wykresie

![Srednie spalanie w zaleznosci od skrzyni](https://raw.github.com/Socr4tes/data-refine/master/images/mdubrawa/mpg2.png) 

### Liczba samochodów z manualną oraz automatyczną skrzynią biegów

```js
db.Cars.aggregate( 
	{ $group:
		{
		_id: { transmission: "$transmission" },
		sum: { $sum: 1 }
		}
	});
```

Wynik agregacji

```json
{
        "result" : [
                {
                        "_id" : {
                                "transmission" : "manual"
                        },
                        "sum" : 245
                },
                {
                        "_id" : {
                                "transmission" : "automatic"
                        },
                        "sum" : 171
                }
        ],
        "ok" : 1
}
```

Dane przedstawione na wykresie

![Automatyczna i manualna skrzynia](https://raw.github.com/Socr4tes/data-refine/master/images/mdubrawa/transsmision.png) 

Jeżeli Maciej poczuł się dotknięty tym że wykożystałem dostarczone przez niego dane to z góry przepraszm :).

