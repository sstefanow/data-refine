# encoding: UTF-8
require 'mongo'
include Mongo

host = 'localhost'
port = 27017
db = 'test'
collection = 'unesco'

db = MongoClient.new(host, port, w: 1, wtimeout: 200, j: true).db(db)
unesco = db.collection(collection)

# Przeliczenie współżędnych geograficznych w odpowiedni format
unesco.find.each { |x|
  latitude = (x["latitude_seconds"] || 0 )/3600.to_f + (x["latitude_minutes"] || 0 )/60.to_f + (x["latitude_degress"] || 0)
  longitude = (x["longitude_seconds"] || 0 )/3600.to_f + (x["longitude_minutes"] || 0 )/60.to_f + (x["longitude_degress"] || 0)
  unesco.update({ "_id" => x["_id"]} ,
                {'$set' => {'location' => [latitude, longitude]}}
  )
}

gdansk_location = [54.366667, 18.633333]
unesco.ensure_index({ location: '2d'})

puts "10 najbliższych zabytków UNESCO względem Gdańska"
puts unesco.aggregate([ {'$geoNear' => { near: gdansk_location , distanceField: 'distance', limit: 10 }},
                        {'$sort' => {distance: 1}},
                        {'$project' => {_id: 0, site: '$site', country: '$country', location: '$location', distance: '$distance'}}
                      ])

puts 'Państwa z największą liczbą zabytków unescu w europie wschodniej'
puts unesco.aggregate([ {'$group' => {_id: '$country', count: {'$sum' => 1}}},
                        {'$sort' => {count: -1}},
                        {'$project' => {_id: 0,  country: '$_id', count: '$count'}},
                        {'$limit' => 5}
                      ])

host = '153.19.1.202'
port = 27017
db = 'test'
collection = 'car_market'
user = 'student'
pass = 'sesja2013'

sigma = MongoClient.new(host, port, w: 1, wtimeout: 200, j: true).db(db)
sigma.authenticate(user, pass)
car_market = sigma.collection(collection)

puts  'Średnia cena samochodu dla marki'
puts car_market.aggregate([ {'$group' => { _id: '$make', avg_price: {'$avg' => '$price'}}} ,
                            {'$project' => {_id: 0, make: '$_id', avg_price: '$avg_price'}},
                            {'$sort' => { avg_price: 1 }}
                          ])

puts 'Najtańszy samochód dla każdej z marek'
car_market.aggregate([  {'$group' => { _id: '$make', min_price: {'$min' => '$price'}}} ,
                        {'$project' => {_id: 0, make: '$_id', min_price: '$min_price', model: '$model'}},
                        {'$sort' => { min_price: 1 }}
                     ]).each{|x| puts car_market.find({price: x['min_price'], make: x['make']}).first }