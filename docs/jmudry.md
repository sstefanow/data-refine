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
wynik
```js 
{"country"=>"Poland", "location"=>[54.041666666666664, 19.033333333333335], "site"=>"Castle of the Teutonic Order in Malbork", "distance"=>0.5153886721044205}
{"country"=>"Poland", "location"=>[53.01, 18.619444444444444], "site"=>"Medieval Town of Toruń", "distance"=>1.3567380885286682}
{"country"=>"Russia", "location"=>[55.27444444444444, 20.9625], "site"=>"Curonian Spit", "distance"=>2.499815753716876}
{"country"=>"Poland", "location"=>[52.26638888888889, 21.011666666666667], "site"=>"Historic Centre of Warsaw", "distance"=>3.172954329014611}
{"country"=>"Poland", "location"=>[51.106944444444444, 17.076944444444443], "site"=>"Centennial Hall in Wrocław", "distance"=>3.6122204355578793}
{"country"=>"Poland", "location"=>[51.05416666666667, 16.195833333333333], "site"=>"Churches of Peace in Jawor and Świdnica", "distance"=>4.112671040009589}
{"country"=>"Poland", "location"=>[50.06666666666667, 19.35], "site"=>"Auschwitz Birkenau, German Nazi Concentration and Extermination Camp (1940-1945)", "distance"=>4.359313530311367}
{"country"=>"Poland", "location"=>[50.06666666666667, 19.959722222222222], "site"=>"Cracow's Historic Centre", "distance"=>4.499923469959685}
{"country"=>"Poland", "location"=>[49.979166666666664, 20.06388888888889], "site"=>"Wieliczka Salt Mine", "distance"=>4.614829284625252}
{"country"=>"Poland", "location"=>[49.86666666666667, 19.666666666666668], "site"=>"Kalwaria Zebrzydowska: the Mannerist Architectural and Park Landscape Complex and Pilgrimage Park", "distance"=>4.617118307631599}
```

### Państwa z największą liczbą zabytków unescu w europie wschodniej

```ruby
unesco.aggregate([  {'$group' => {_id: '$country', count: {'$sum' => 1}}},
                    {'$sort' => {count: -1}},
                    {'$project' => {_id: 0,  country: '$_id', count: '$count'}},
                    {'$limit' => 5}
                ])
```
wynik
```js
{"count"=>16, "country"=>"Russia"}
{"count"=>13, "country"=>"Poland"}
{"count"=>12, "country"=>"Czech"}
{"count"=>9, "country"=>"Bulgaria"}
{"count"=>8, "country"=>"Hungary"}

```

### Średnia cena samochodu dla marki (z kolekcji car_market na sigmie)

```ruby
car_market.aggregate([  {'$group' => { _id: '$make', avg_price: {'$avg' => '$price'}}} ,
                        {'$project' => {_id: 0, make: '$_id', avg_price: '$avg_price'}},
                        {'$sort' => { avg_price: 1 }}
                    ])
```
wynik
```js
{"avg_price"=>11645.0, "make"=>"kia"}
{"avg_price"=>12759.0, "make"=>"hyundai"}
{"avg_price"=>13105.6, "make"=>"daewoo"}
{"avg_price"=>13658.57142857143, "make"=>"saturn"}
{"avg_price"=>13719.0, "make"=>"suzuki"}
{"avg_price"=>18670.4, "make"=>"nissan"}
{"avg_price"=>19303.103448275862, "make"=>"honda"}
{"avg_price"=>19744.85714285714, "make"=>"mitsubishi"}
{"avg_price"=>19875.470588235294, "make"=>"toyota"}
{"avg_price"=>20242.272727272728, "make"=>"mercury"}
{"avg_price"=>20546.81818181818, "make"=>"mazda"}
{"avg_price"=>20587.272727272728, "make"=>"oldsmobile"}
{"avg_price"=>20606.2, "make"=>"volkswagen"}
{"avg_price"=>20892.083333333332, "make"=>"chevrolet"}
{"avg_price"=>20893.958333333332, "make"=>"ford"}
{"avg_price"=>21010.0, "make"=>"subaru"}
{"avg_price"=>22318.695652173912, "make"=>"pontiac"}
{"avg_price"=>23968.5, "make"=>"chrysler"}
{"avg_price"=>24281.666666666668, "make"=>"plymouth"}
{"avg_price"=>26566.25, "make"=>"buick"}
{"avg_price"=>30337.777777777777, "make"=>"dodge"}
{"avg_price"=>34655.833333333336, "make"=>"infiniti"}
{"avg_price"=>34962.5, "make"=>"volvo"}
{"avg_price"=>36541.153846153844, "make"=>"saab"}
{"avg_price"=>37008.5, "make"=>"audi"}
{"avg_price"=>38595.833333333336, "make"=>"lincoln"}
{"avg_price"=>42367.307692307695, "make"=>"acura"}
{"avg_price"=>42470.625, "make"=>"cadillac"}
{"avg_price"=>45183.333333333336, "make"=>"lexus"}
{"avg_price"=>46922.94117647059, "make"=>"bmw"}
{"avg_price"=>59300.15, "make"=>"mercedes-benz"}
{"avg_price"=>64655.0, "make"=>"porsche"}
{"avg_price"=>65758.63636363637, "make"=>"jaguar"}
```

### Najtańszy samochód dla każdej z marek (z kolekcji car_market na sigmie)
```ruby
car_market.aggregate([  {'$group' => { _id: '$make', min_price: {'$min' => '$price'}}} ,
                        {'$project' => {_id: 0, make: '$_id', min_price: '$min_price', model: '$model'}},
                        {'$sort' => { min_price: 1 }}
                     ]).each{|x| puts car_market.find({price: x['min_price'], make: x['make']}).first }
```
wynik
```js
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8ecf'), "make"=>"daewoo", "model"=>"lanos s", "price"=>8999, "wheel_base"=>99.2, "length"=>160.4, "width"=>66.1, "height"=>56.4, "curb_weight"=>2447, "horse_power"=>105, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>26, "mpg_highway"=>36}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8f17'), "make"=>"hyundai", "model"=>"accent l", "price"=>9434, "wheel_base"=>96.1, "length"=>166.7, "width"=>65.7, "height"=>54.9, "curb_weight"=>2255, "horse_power"=>92, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>28, "mpg_highway"=>36}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8fd1'), "make"=>"suzuki", "model"=>"swift ga", "price"=>9499, "wheel_base"=>93.1, "length"=>93.1, "width"=>62.6, "height"=>54.7, "curb_weight"=>1929, "horse_power"=>79, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>36, "mpg_highway"=>42}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8ebe'), "make"=>"chevrolet", "model"=>"metro", "price"=>9585, "wheel_base"=>93.1, "length"=>149.4, "width"=>62.6, "height"=>54.7, "curb_weight"=>1895, "horse_power"=>55, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>39, "mpg_highway"=>46}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8f30'), "make"=>"kia", "model"=>"sephia", "price"=>10445, "wheel_base"=>100.8, "length"=>174.4, "width"=>66.9, "height"=>55.5, "curb_weight"=>2478, "horse_power"=>125, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>23, "mpg_highway"=>29}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8fe8'), "make"=>"toyota", "model"=>"echo", "price"=>10450, "wheel_base"=>99.3, "length"=>163.3, "width"=>65.4, "height"=>59.1, "curb_weight"=>2020, "horse_power"=>108, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>34, "mpg_highway"=>41}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8fbd'), "make"=>"saturn", "model"=>"sl", "price"=>11125, "wheel_base"=>102.4, "length"=>178.1, "width"=>66.4, "height"=>55, "curb_weight"=>2359, "horse_power"=>100, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>29, "mpg_highway"=>40}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8f09'), "make"=>"honda", "model"=>"civic cx", "price"=>11165, "wheel_base"=>103.2, "length"=>164.5, "width"=>67.1, "height"=>57.3, "curb_weight"=>2359, "horse_power"=>106, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>32, "mpg_highway"=>37}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8f7c'), "make"=>"nissan", "model"=>"sentra xe", "price"=>12169, "wheel_base"=>99.8, "length"=>177.5, "width"=>67.3, "height"=>55.5, "curb_weight"=>2458, "horse_power"=>126, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>27, "mpg_highway"=>35}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8f74'), "make"=>"mitsubishi", "model"=>"mirage de", "price"=>12182, "wheel_base"=>95.1, "length"=>168.1, "width"=>66.5, "height"=>52.4, "curb_weight"=>2183, "horse_power"=>92, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>33, "mpg_highway"=>40}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8ee8'), "make"=>"ford", "model"=>"escort zx2", "price"=>12200, "wheel_base"=>98.4, "length"=>175.2, "width"=>67.4, "height"=>52.3, "curb_weight"=>2478, "horse_power"=>130, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>25, "mpg_highway"=>33}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8f48'), "make"=>"mazda", "model"=>"protégé dx", "price"=>12420, "wheel_base"=>102.8, "length"=>102.8, "width"=>67.1, "height"=>55.5, "curb_weight"=>2434, "horse_power"=>105, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>29, "mpg_highway"=>34}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8edd'), "make"=>"dodge", "model"=>"neon highline", "price"=>12970, "wheel_base"=>105, "length"=>174.4, "width"=>67.4, "height"=>56, "curb_weight"=>2567, "horse_power"=>132, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>28, "mpg_highway"=>35}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8f8e'), "make"=>"plymouth", "model"=>"neon highline", "price"=>12970, "wheel_base"=>105, "length"=>174.4, "width"=>67.4, "height"=>56, "curb_weight"=>2567, "horse_power"=>132, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>28, "mpg_highway"=>35}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8fa3'), "make"=>"pontiac", "model"=>"sunfire se", "price"=>14515, "wheel_base"=>104.1, "length"=>182, "width"=>68.4, "height"=>53, "curb_weight"=>2630, "horse_power"=>115, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>24, "mpg_highway"=>34}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8ff9'), "make"=>"volkswagen", "model"=>"golf gl", "price"=>15425, "wheel_base"=>98.9, "length"=>163.3, "width"=>68.3, "height"=>56.7, "curb_weight"=>2767, "horse_power"=>115, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>24, "mpg_highway"=>31}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8fcb'), "make"=>"subaru", "model"=>"impreza l", "price"=>16390, "wheel_base"=>99.2, "length"=>172.2, "width"=>67.1, "height"=>55.5, "curb_weight"=>2730, "horse_power"=>142, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>23, "mpg_highway"=>29}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8f82'), "make"=>"oldsmobile", "model"=>"alero gx", "price"=>16555, "wheel_base"=>107, "length"=>186.7, "width"=>70.1, "height"=>54.5, "curb_weight"=>3026, "horse_power"=>150, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>22, "mpg_highway"=>31}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8ec6'), "make"=>"chrysler", "model"=>"cirrus lx", "price"=>16625, "wheel_base"=>108, "length"=>186.7, "width"=>71.7, "height"=>54.9, "curb_weight"=>2950, "horse_power"=>132, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>26, "mpg_highway"=>37}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8f63'), "make"=>"mercury", "model"=>"mystique gs", "price"=>16705, "wheel_base"=>106.5, "length"=>184.7, "width"=>69.1, "height"=>54.5, "curb_weight"=>2805, "horse_power"=>125, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>24, "mpg_highway"=>34}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8e76'), "make"=>"acura", "model"=>"integra ls", "price"=>19755, "wheel_base"=>101.2, "length"=>172.4, "width"=>67.3, "height"=>52.6, "curb_weight"=>2643, "horse_power"=>140, "rpm"=>6300, "transmission"=>"manual", "mpg_city"=>25, "mpg_highway"=>31}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8e9d'), "make"=>"buick", "model"=>"century custom", "price"=>20285, "wheel_base"=>109, "length"=>194.6, "width"=>72.7, "height"=>56.6, "curb_weight"=>3368, "horse_power"=>175, "rpm"=>5200, "transmission"=>"automatic", "mpg_city"=>20, "mpg_highway"=>30}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8f1f'), "make"=>"infiniti", "model"=>"g20", "price"=>21920, "wheel_base"=>102.4, "length"=>177.5, "width"=>66.7, "height"=>55.1, "curb_weight"=>2923, "horse_power"=>145, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>23, "mpg_highway"=>31}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b9005'), "make"=>"volvo", "model"=>"s40 1.9t", "price"=>23475, "wheel_base"=>100.4, "length"=>176.4, "width"=>55.5, "height"=>67.7, "curb_weight"=>2990, "horse_power"=>160, "rpm"=>nil, "transmission"=>"automatic", "mpg_city"=>21, "mpg_highway"=>28}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8e82'), "make"=>"audi", "model"=>"a4 1.8t", "price"=>24515, "wheel_base"=>103, "length"=>178, "width"=>68.2, "height"=>55.8, "curb_weight"=>2998, "horse_power"=>150, "rpm"=>5700, "transmission"=>"manual", "mpg_city"=>24, "mpg_highway"=>32}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8fad'), "make"=>"saab", "model"=>"9-3", "price"=>26475, "wheel_base"=>102.6, "length"=>182.2, "width"=>67.4, "height"=>56.2, "curb_weight"=>2990, "horse_power"=>185, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>22, "mpg_highway"=>29}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8e91'), "make"=>"bmw", "model"=>"323i", "price"=>27560, "wheel_base"=>107.3, "length"=>176, "width"=>68.5, "height"=>55.7, "curb_weight"=>3153, "horse_power"=>170, "rpm"=>5500, "transmission"=>"manual", "mpg_city"=>20, "mpg_highway"=>29}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8ea5'), "make"=>"cadillac", "model"=>"catera", "price"=>31500, "wheel_base"=>107.4, "length"=>194.8, "width"=>70.3, "height"=>56.3, "curb_weight"=>3770, "horse_power"=>192, "rpm"=>3600, "transmission"=>"automatic", "mpg_city"=>18, "mpg_highway"=>24}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8f34'), "make"=>"lexus", "model"=>"es300", "price"=>31900, "wheel_base"=>105.1, "length"=>190.2, "width"=>70.5, "height"=>54.9, "curb_weight"=>3373, "horse_power"=>210, "rpm"=>nil, "transmission"=>"automatic", "mpg_city"=>19, "mpg_highway"=>26}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8f3b'), "make"=>"lincoln", "model"=>"ls v6", "price"=>32275, "wheel_base"=>114.5, "length"=>193.9, "width"=>73.2, "height"=>56.1, "curb_weight"=>3598, "horse_power"=>210, "rpm"=>nil, "transmission"=>"automatic", "mpg_city"=>17, "mpg_highway"=>25}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8f4b'), "make"=>"mercedes-benz", "model"=>"c230 kompressor", "price"=>32395, "wheel_base"=>105.9, "length"=>105.9, "width"=>67.7, "height"=>56.1, "curb_weight"=>3250, "horse_power"=>185, "rpm"=>nil, "transmission"=>"automatic", "mpg_city"=>21, "mpg_highway"=>29}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8fa7'), "make"=>"porsche", "model"=>"boxter", "price"=>42195, "wheel_base"=>95.2, "length"=>171, "width"=>70.1, "height"=>50.8, "curb_weight"=>2778, "horse_power"=>217, "rpm"=>nil, "transmission"=>"manual", "mpg_city"=>20, "mpg_highway"=>28}
{"_id"=>BSON::ObjectId('5165b116c20a89f0145b8f25'), "make"=>"jaguar", "model"=>"s-type 3.0", "price"=>43095, "wheel_base"=>114.5, "length"=>191.4, "width"=>80.3, "height"=>55.7, "curb_weight"=>3650, "horse_power"=>240, "rpm"=>nil, "transmission"=>"automatic", "mpg_city"=>18, "mpg_highway"=>26}
```

