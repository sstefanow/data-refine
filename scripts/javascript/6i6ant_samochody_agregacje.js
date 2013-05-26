var mongodb = require('mongodb');
var server = new mongodb.Server("127.0.0.1", 27017, {});
new mongodb.Db('test', server, {w: 1}).open(function (error, client) {
	if (error) throw error;
	var collection = new mongodb.Collection(client, 'samochody');
	
//Średnie spalanie dla poszczególnych marek. Posortowane malejąco.

collection.aggregate([
    {$group : {_id : "$make", mpg_city: {$avg: "$mpg_city"}}},
    {$project : {_id: 0, producent: "$_id", mpg_city: "$mpg_city"}},
    { $sort : { mpg_city : -1 }},
    ], 


	function(err, result) {
        console.dir(result);
     //  client.close();
    });
//Ilość modeli przypadająca na każdą markę. Posortowana malejąco.
	collection.aggregate([
	{ $group : {
		_id : "$make",
		suma : {$sum: 1}
	}},
	{ $sort : { suma : -1 }
	},
	
	], function(err, result) {
		console.dir(result);
		//client.close();
	});
//Ile jest modeli z automatyczną a ile z manualną skrzynią biegów.

	collection.aggregate([
	{ $group : {
		_id : "$transmission",
		suma : {$sum: 1}
	}},
	{ $sort : { suma : -1 }
	},
	
	], function(err, result) {
		console.dir(result);
		client.close();
	});

});
