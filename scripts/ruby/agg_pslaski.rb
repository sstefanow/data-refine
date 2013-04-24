# encoding: UTF-8

require 'mongo'
include Mongo

host = 'localhost'
port = 27017
db = 'nosql'
collection = 'wig20'

db = MongoClient.new(host, port, w: 1, wtimeout: 200, j: true).db(db)
wig20 = db.collection(collection)

puts "Liczba wszystkich wpisów wig20: #{wig20.count}"

sep = '-------------------------------------------'

# 5 najwyzszych zamkniec WIG20 z roku 2005

highest_exits = wig20.aggregate([{'$project' => {:_id => 0, :Data => 1, :Zamkniecie => 1}},
                                 {'$match' => {:Data => /2005-.*/}},
                                 {'$sort' => {:Zamkniecie => -1}},
                                 {'$limit' => 5}
                                ])

puts sep
puts highest_exits

puts sep

host = '153.19.1.202'
port = 27017
db = 'test'
collection = 'kody_pocztowe'
user = 'student'
pass = 'sesja2013'

sigma = MongoClient.new(host, port, w: 1, wtimeout: 200, j: true).db(db)
auth = sigma.authenticate(user, pass)
zipcodes = sigma.collection(collection)

puts "Liczba wszystkich wpisów zipcodes: #{zipcodes.count}"

count = 'count'
# srednia liczba kodow pocztowych. dla powiatu w danym wojewodztwie

county_avg = zipcodes.aggregate([{'$group' => {:_id => {:powiat => '$powiat', :wojewodztwo => '$wojewodztwo'}, count => {'$sum' => 1}}},
                                 {'$group' => {:_id => '$_id.wojewodztwo', :avg => {'$avg' => '$' + count}}},
                                 {'$sort' => {:avg => -1}},
                                 {'$project' => {:_id => 0, :wojewodztwo => '$_id', :avg => 1}}])

puts sep
puts county_avg

# ulice z najwieksza liczba kodow w Polsce (>= 200)

max_streets = zipcodes.aggregate([{'$match' => {:ulica => /.*/}},
                                  {'$group' => {:_id => {:ulica => '$ulica'}, count => {'$sum' => 1}}},
                                  {'$match' => {:count => {'$gte' => 200}}},
                                  {'$sort' => {:count => -1}},
                                  {'$project' => {:_id => 0, :ulica => '$_id.ulica', :count => 1}}])

puts sep
puts max_streets

#  znalezienie miejscowosci z kodem w postaci xx-xxx np. 11-111, 22-222 itp

zip_with_same_digits = zipcodes.aggregate([{'$match' => {:kod => /(\d)\1-\1\1\1/}},
                                           {'$sort' => {:kod => -1}},
                                           {'$project' => {:_id => 0, :kod => 1, :miejsce => 1}}])
puts sep
puts zip_with_same_digits

# liczba kodow dla poszczegolnych dzielnic aglomeracji warszawskiej

warsaw_zips = zipcodes.aggregate([{'$match' => {:miejsce => /Warszawa/}},
                                  {'$group' => {:_id => {:miejsce => '$miejsce'}, count => {'$sum' => 1}}},
                                  {'$project' => {:_id => 0, :miejsce => '$_id.miejsce', count => 1}},
                                  {'$sort' => {count => -1}}])

puts sep
puts warsaw_zips