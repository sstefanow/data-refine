require "mongo"
require "uri"
include Mongo

mongodb = MongoClient.new("localhost", 27017, w: 1, wtimeout: 200, j: true).db("test")

poland_collection = mongodb.collection("poland")

result = poland_collection.aggregate([
  { "$geoNear" => { near: [18.573622,54.395732], distanceField: "distance", limit: 5, query: { "tags.amenity" => "restaurant" } } },
  { "$project" => { _id: 0, location: "$location.coordinates", tags: "$tags", distance: "$distance" } }
])

params = {
  center: "54.395732,18.573622",
  zoom: "12",
  size: "400x400",
  maptype: "roadmap",
  sensor: "false",
  format: "png"
}

markers = []
markers << [:markers, "color:blue|label:S|54.395732,18.573622"]

puts "\n"

result.each_with_index do |item, index|
  markers << [:markers, "color:red|label:#{index + 1}|#{item['location'][1]},#{item['location'][0]}"]
  
  puts "##########\n"
  puts index + 1
  puts "##########\n\n"
  puts item["tags"]
  puts "\n\n"
end

puts "##########\n"
puts "link"
puts "##########\n\n"

puts "http://maps.googleapis.com/maps/api/staticmap?#{URI.encode_www_form(params)}&#{URI.encode_www_form(markers)}"

puts "\n"