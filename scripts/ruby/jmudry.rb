# encoding: UTF-8
require 'mongo'
require 'uri'
include Mongo

def get_chart_url(tab,x_label,y_label)
  max_value = tab.first[x_label]
  ratio = 100.to_f/max_value.to_f
  chd = []
  chxl =[]
  tab.count.times{|i|
    chd << (tab[i][x_label].to_f*ratio)
    chxl << tab[i][y_label]
  }
  chart_params = {
    chs: "600x#{tab.count*38}",
    cht: "bhg",
    chxt: "x,y",
    chxr: "0,0,#{max_value}",
    chg: "#{ratio},20,1,5",
    chd: "t:#{chd.join(",")}",
    chxl: "1:|#{chxl.reverse.join("|")}"
  }
  "#{GOOGLE_CHARTS_URL}?#{URI.encode_www_form(chart_params)}"
end

GOOGLE_CHARTS_URL = "http://chart.apis.google.com/chart"
GOOGLE_API_URL = 'http://maps.googleapis.com/maps/api/staticmap'
separator = "----------------------------------------------------------------------------------\n"


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

puts separator*3 + "10 najbliższych zabytków UNESCO względem Gdańska" + separator

monuments = unesco.aggregate([ {'$geoNear' => { near: gdansk_location , distanceField: 'distance', limit: 10 }},
                               {'$sort' => {distance: 1}},
                               {'$project' => {_id: 0, site: '$site', country: '$country', location: '$location', distance: '$distance'}}
                             ])
puts monuments

maps_params = {
  size: "600x600",
  maptype: "roadmap",
  sensor: false,
  format: "png"
}



puts separator + "Link do mapki z zaznaczonymi punktami"
monuments_params = []
k=0
monuments.each{|x|
  k+=1
  monuments_params << [:markers, "color:red|label:#{k}|#{x['location'].join(",")}"]
}
puts "#{GOOGLE_API_URL}?#{URI.encode_www_form(maps_params)}&#{URI.encode_www_form(monuments_params)}"
puts separator + "Legenda do mapki"

k=0
monuments.each{|x|
  k+=1
  puts "#{k}. #{x['site']} (#{(x['distance'].to_f*100).round(2)} km)"
}


puts separator*3+'Państwa z największą liczbą zabytków unescu w europie wschodniej'
count_monuments =  unesco.aggregate([ {'$group' => {_id: '$country', count: {'$sum' => 1}}},
                                      {'$sort' => {count: -1}},
                                      {'$project' => {_id: 0,  country: '$_id', count: '$count'}},
                                      {'$limit' => 5}
                                    ])
puts count_monuments
puts separator + "Link to obrazka:\n"
puts get_chart_url(count_monuments,'count','country')



host = '153.19.1.202'
port = 27017
db = 'test'
collection = 'car_market'
user = 'student'
pass = 'sesja2013'

sigma = MongoClient.new(host, port, w: 1, wtimeout: 200, j: true).db(db)
sigma.authenticate(user, pass)
car_market = sigma.collection(collection)

puts  separator*3 + 'Średnia cena samochodu dla dziesięciu najdroższych marek'
average_price_in_car_market =  car_market.aggregate([ {'$group' => { _id: '$make', avg_price: {'$avg' => '$price'}}} ,
                                                      {'$project' => {_id: 0, make: '$_id', avg_price: '$avg_price'}},
                                                      {'$sort' => { avg_price: -1 }},
                                                      {'$limit' => 10}
                                                    ])
puts average_price_in_car_market
puts separator + "Link to obrazka:\n"
puts get_chart_url(average_price_in_car_market,'avg_price','make')


puts separator*3 + 'Najtańszy samochód dla każdej z marek'
cheapest_model_in_make = []
car_market.aggregate([  {'$group' => { _id: '$make', min_price: {'$min' => '$price'}}} ,
                        {'$project' => {_id: 0, make: '$_id', min_price: '$min_price', model: '$model'}},
                        {'$sort' => { min_price: 1 }}
                     ]).each{|x| cheapest_model_in_make << car_market.find({price: x['min_price'], make: x['make']}).first }

puts cheapest_model_in_make

table_markdown = ''
table_markdown += "| Make | Model | Price |\n"
table_markdown += "|---|---|--:|\n"
cheapest_model_in_make.each{ |x|
  table_markdown += "| #{x['make']} | #{x['model']} | #{x['price']} |\n"
}
puts
puts separator + "Tableka w postaci markdown"
puts table_markdown

