var mongodb = require('mongodb');
var server = new mongodb.Server("127.0.0.1", 27017, {});
new mongodb.Db('test', server, {w: 1}).open(function (error, client) {
	if (error) throw error;
	var collection = new mongodb.Collection(client, 'cars');
	
//10 modeli samochodów o najwyższej mocy silnika

collection.aggregate([
    {'$group' : { _id: {make: '$make' , model: '$model'}, horse_power: {'$max' : '$horse_power'}}}, 
	{'$project' : {
		_id : 0 ,
		car : '$_id' ,
		horse_power : 1
		}
	},
	{'$sort' : { horse_power: -1 }},
	{'$limit' : 10}
    ], 
	function(err, result) {
        console.dir(result);
     //  client.close();
    });
    
// Zależność pomiędzy mocą silnika, a średnim spalaniem
	collection.aggregate([
	{'$group' : { _id: '$horse_power', avg_mpg: {'$avg' : '$mpg_city'}}}, 
	{'$project' : {
		_id : 0 ,
		horse_power : '$_id' ,
		avg_mpg : 1
		}
	},
	{'$sort' : { horse_power: 1 }},
	],
	function(err, result) {
		console.dir(result);
		//client.close();
	});