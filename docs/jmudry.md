# Lista UNESCO w Europie Wschodniej

## Zródło danych
[Wikipedia](http://en.wikipedia.org/wiki/List_of_World_Heritage_Sites_in_Eastern_Europe)

## Co zostało zrobione?

* Pobranie surowych danych ze strony: [Wikipedia - raw data](http://en.wikipedia.org/w/index.php?title=List_of_World_Heritage_Sites_in_Eastern_Europe&action=edit&section=2)
* Import danych do Google-Refine
* Oczyszczenie danych w licznych krokach (wybranie interesujacych nas danych)
* export danych do postaci JSON 


## Przykład:
```js
    {
        "_id" : ObjectId("51837819d9175361bffb10bd"),
    	"country" : "Czech",
    	"description" : "",
    	"latitude_degress" : 48,
    	"latitude_direction" : "N",
    	"latitude_minutes" : 49,
    	"latitude_seconds" : 0,
    	"longitude_degress" : 14,
    	"longitude_minutes" : 19,
    	"longitude_seconds" : 0,
    	"longtitude_direction" : "E",
    	"site" : "Historic Centre of Český Krumlov",
    	"type" : "Cultural",
    	"year" : "1992"
    }
```
Więcej: [Klik](/data/json/unesco_eastern_europe.json)

## Import danych do bazy (z katalogu projektu)
```bash
mongoimport --db test2 --collection unesco --file data/json/unesco_eastern_europe.json
```
### Dodanie wyliczonej lokalizacji
```ruby
unesco.find.each { |x|
  latitude = (x["latitude_seconds"] || 0 )/3600.to_f + (x["latitude_minutes"] || 0 )/60.to_f + (x["latitude_degress"] || 0)
  longitude = (x["longitude_seconds"] || 0 )/3600.to_f + (x["longitude_minutes"] || 0 )/60.to_f + (x["longitude_degress"] || 0)
  unesco.update({ "_id" => x["_id"]} ,
                {'$set' => {'location' => [latitude, longitude]}}
  )
}
```

## Agregacje

Link to skrytu [Klik](/scripts/ruby/jmudry.rb)

### 10 najbliższych zabytków UNESCO względem Gdańska

```ruby
unesco.aggregate([  {'$geoNear' => { near: [54.366667, 18.633333] , distanceField: 'distance', limit: 10 }},
                    {'$sort' => {distance: 1}},
                    {'$project' => {_id: 0, site: '$site', country: '$country', location: '$location', distance: '$distance'}}
                ])
```
wynik zwrócony ze skrytu:

![](http://maps.googleapis.com/maps/api/staticmap?size=600x600&maptype=roadmap&sensor=false&format=png&markers=color%3Ared%7Clabel%3A1%7C54.041666666666664%2C19.033333333333335&markers=color%3Ared%7Clabel%3A2%7C53.01%2C18.619444444444444&markers=color%3Ared%7Clabel%3A3%7C55.27444444444444%2C20.9625&markers=color%3Ared%7Clabel%3A4%7C52.26638888888889%2C21.011666666666667&markers=color%3Ared%7Clabel%3A5%7C51.106944444444444%2C17.076944444444443&markers=color%3Ared%7Clabel%3A6%7C51.05416666666667%2C16.195833333333333&markers=color%3Ared%7Clabel%3A7%7C50.06666666666667%2C19.35&markers=color%3Ared%7Clabel%3A8%7C50.06666666666667%2C19.959722222222222&markers=color%3Ared%7Clabel%3A9%7C49.979166666666664%2C20.06388888888889&markers=color%3Ared%7Clabel%3A10%7C49.86666666666667%2C19.666666666666668
)

Legenda do mapki

1. Castle of the Teutonic Order in Malbork (51.54 km)
2. Medieval Town of Toruń (135.67 km)
3. Curonian Spit (249.98 km)
4. Historic Centre of Warsaw (317.3 km)
5. Centennial Hall in Wrocław (361.22 km)
6. Churches of Peace in Jawor and Świdnica (411.27 km)
7. Auschwitz Birkenau, German Nazi Concentration and Extermination Camp (1940-1945) (435.93 km)
8. Cracow's Historic Centre (449.99 km)
9. Wieliczka Salt Mine (461.48 km)
10. Kalwaria Zebrzydowska: the Mannerist Architectural and Park Landscape Complex and Pilgrimage Park (461.71 km)


### Państwa z największą liczbą zabytków UNESCO w europie wschodniej

```ruby
unesco.aggregate([  {'$group' => {_id: '$country', count: {'$sum' => 1}}},
                    {'$sort' => {count: -1}},
                    {'$project' => {_id: 0,  country: '$_id', count: '$count'}},
                    {'$limit' => 5}
                ])
```
wynik zwrócony ze skrytu:

![](http://chart.apis.google.com/chart?chs=600x190&cht=bhg&chxt=x%2Cy&chxr=0%2C0%2C16&chg=6.25%2C20%2C1%2C5&chd=t%3A100.0%2C81.25%2C75.0%2C56.25%2C50.0&chxl=1%3A%7CHungary%7CBulgaria%7CCzech%7CPoland%7CRussia)

### Średnia cena samochodu dla dziesięciu najdroższych marek (z kolekcji car_market na sigmie)

```ruby
car_market.aggregate([  {'$group' => { _id: '$make', avg_price: {'$avg' => '$price'}}} ,
                        {'$project' => {_id: 0, make: '$_id', avg_price: '$avg_price'}},
                        {'$sort' => { avg_price: -1 }},
                        {'$limit' => 10}
                    ])
```
wynik zwrócony ze skrytu:

![](http://chart.apis.google.com/chart?chs=600x380&cht=bhg&chxt=x%2Cy&chxr=0%2C0%2C65758.63636363637&chg=0.0015207127995631405%2C20%2C1%2C5&chd=t%3A100.0%2C98.32168605575485%2C90.17849712101417%2C71.35631724020715%2C68.71087332692791%2C64.58562304294631%2C64.42850709072222%2C58.693177759805714%2C56.27929964263249%2C55.568600364652035&chxl=1%3A%7Csaab%7Caudi%7Clincoln%7Cacura%7Ccadillac%7Clexus%7Cbmw%7Cmercedes-benz%7Cporsche%7Cjaguar)

### Najtańszy samochód dla każdej z marek (z kolekcji car_market na sigmie)
```ruby
cheapest_model_in_make = []
car_market.aggregate([  {'$group' => { _id: '$make', min_price: {'$min' => '$price'}}} ,
                        {'$project' => {_id: 0, make: '$_id', min_price: '$min_price', model: '$model'}},
                        {'$sort' => { min_price: 1 }}
                     ]).each{|x| cheapest_model_in_make << car_market.find({price: x['min_price'], make: x['make']}).first }
```
wynik zwrócony ze skrytu:

| Make | Model | Price |
|---|---|--:|
| daewoo | lanos s | 8999 |
| hyundai | accent l | 9434 |
| suzuki | swift ga | 9499 |
| chevrolet | metro | 9585 |
| kia | sephia | 10445 |
| toyota | echo | 10450 |
| saturn | sl | 11125 |
| honda | civic cx | 11165 |
| nissan | sentra xe | 12169 |
| mitsubishi | mirage de | 12182 |
| ford | escort zx2 | 12200 |
| mazda | protégé dx | 12420 |
| dodge | neon highline | 12970 |
| plymouth | neon highline | 12970 |
| pontiac | sunfire se | 14515 |
| volkswagen | golf gl | 15425 |
| subaru | impreza l | 16390 |
| oldsmobile | alero gx | 16555 |
| chrysler | cirrus lx | 16625 |
| mercury | mystique gs | 16705 |
| acura | integra ls | 19755 |
| buick | century custom | 20285 |
| infiniti | g20 | 21920 |
| volvo | s40 1.9t | 23475 |
| audi | a4 1.8t | 24515 |
| saab | 9-3 | 26475 |
| bmw | 323i | 27560 |
| cadillac | catera | 31500 |
| lexus | es300 | 31900 |
| lincoln | ls v6 | 32275 |
| mercedes-benz | c230 kompressor | 32395 |
| porsche | boxter | 42195 |
| jaguar | s-type 3.0 | 43095 |
