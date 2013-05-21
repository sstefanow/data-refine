# encoding: UTF-8
require 'mongo'
require 'uri'
include Mongo

def get_pie_chart_url(tab,x_label,y_label, title = "")
  sum = 0
  tab.count.times{|i|
  	sum += tab[i][x_label]
  }
  chd = []
  chdl =[]
  tab.count.times{|i|
    chd << (((tab[i][x_label]).to_f/sum.to_f)*100).round(2)
    chdl << tab[i][y_label]
  }
  chart_params = {
    chs: "600x#{tab.count*25}",
    cht: "p3",
    chd: "t:#{chd.join(",")}",
    chl: chd.join("%|") + "%",
    chdl: chdl.join("|"),
    chtt: title
  }
  "#{GOOGLE_CHARTS_URL}?#{URI.encode_www_form(chart_params)}"
end

def get_chart_url(tab,x_label,y_label, title = "")
  max_value = tab.first[x_label]
  tab.count.times{|i|
  	if tab[i][x_label] > max_value
  	  max_value = tab[i][x_label] 	
  	end
  }
  ratio = 100.to_f/max_value.to_f
  chd = []
  chxl =[]
  tab.count.times{|i|
    chd << (tab[i][x_label].to_f).round(2) * ratio
    chxl << tab[i][y_label]
  }
  chart_params = {
    chs: "600x#{tab.count*38}",
    cht: "bhg",
    chxt: "x,y",
    chxr: "0,0,#{max_value}",
    chg: "#{ratio},20,1,5",
    chd: "t:#{chd.join(",")}",
    chxl: "1:|#{chxl.reverse.join("|")}",
    chtt: title
  }
  "#{GOOGLE_CHARTS_URL}?#{URI.encode_www_form(chart_params)}"
end

GOOGLE_CHARTS_URL = "http://chart.apis.google.com/chart"
GOOGLE_API_URL = 'http://maps.googleapis.com/maps/api/staticmap'
separator = "----------------------------------------------------------------------------------\n"

host = '153.19.1.202'
port = 27017
db = 'test'
collection = 'census1881'
user = 'student'
pass = 'sesja2013'

sigma = MongoClient.new(host, port, w: 1, wtimeout: 200, j: true).db(db)
sigma.authenticate(user, pass)
census = sigma.collection(collection)

religion =  census.aggregate([ 
{'$group' => { _id: '$religion', count: {'$sum' => 1}}},
{'$project' => {_id: 0, religion: '$_id', count: '$count'}},
{'$sort' => { count: -1 }},
{'$limit' => 10}
])

religion2 =  census.aggregate([ {'$group' => { _id: '$religion', avg_age: {'$avg' => '$age'}, count: {'$sum' => 1}}} ,
{'$project' => {_id: 0, religion: '$_id', avg_age: '$avg_age', count: '$count'}},
{'$sort' => { count: -1, avg_age: -1 }},
{'$limit' => 10}
])

religion3 =  census.aggregate([ {'$group' => { _id: '$religion', avg_age: {'$avg' => '$age'}, count: {'$sum' => 1}}} ,
{'$project' => {_id: 0, religion: '$_id', avg_age: '$avg_age', count: '$count'}},
{'$match' => {count: {'$gte' => 100}}},
{'$sort' => { avg_age: -1 }},
{'$limit' => 10}
])

puts  separator*3 + 'Ilość wyznawców 10 najpopularniejszych religii'
puts religion
puts  "Wykres slupkowy"
puts  separator

puts get_chart_url(religion,'count','religion', "Wyznawcy najpopularniejszych religii w 1881")
puts "\n"
puts  "Przekrój procentowy"
puts  separator
puts get_pie_chart_url(religion,'count','religion', 'Przekrój religii w 1881')


puts  separator*3 + 'Srednia wieku w 10 religiach'
puts religion2
puts  "Wykres slupkowy"
puts  separator

puts get_chart_url(religion2,'avg_age','religion', "Srednia wieku najpopularniejszych religii w 1881")

puts  separator*3 + 'Religie o najstarszych wyznawcach (>=100)'
puts religion3
puts  "Wykres slupkowy"
puts get_chart_url(religion3,'avg_age','religion', "Religie o najstarszych wyznawcach (100 i więcej wiernych)")