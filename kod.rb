# encoding: UTF-8
require 'mongo'
include Mongo

host = 'localhost'
port = 27017
db = 'test'
collection = 'unesco'

db = MongoClient.new(host, port, w: 1, wtimeout: 200, j: true).db(db)
unesco = db.collection(collection)

puts unesco.aggregate([  {'$geoNear' => { near: [54.366667, 18.633333] , distanceField: 'distance', limit: 10 }},
                    {'$sort' => {distance: 1}},
                    {'$project' => {_id: 0, site: '$site', country: '$country', location: '$location', distance: '$distance'}}
                ])
