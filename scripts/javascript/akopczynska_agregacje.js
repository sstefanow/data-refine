var mongodb = require('mongodb');
var server = new mongodb.Server("127.0.0.1", 27017, {});
new mongodb.Db('test', server, {w: 1}).open(function (error, client)
 { 
	if (error) throw error;
	var collection = new mongodb.Collection(client, 'car');

// Agregacja pokazująca najtańszy samochód dla każdej z marek
	collection.aggregate([
	{$group : { 
		_id : "$make", 
		min_cena: {$min: "$price"}, 
		       }
	},
	{$project : {
		_id: 0,
		marka: "$_id",
		min_cena: "$min_cena"		
	            }
	},
	{$sort : { 
		min_cena : 1 
	          }
	},
	], function(err, result) {
		console.dir(result);
	});

// Agregacja pokazująca średnią liczbę koni mechanicznych dla każej z marek
	collection.aggregate([
	{$group : {
		_id : "$make",
	    horse_power: {$avg: "$horse_power"},
	          }
	},
	{$project : {
		_id: 0,
		make: "$_id",
		horse_power: "$horse_power"
	            }
	},
	{ $sort : { 
		horse_power : -1 
			  }
	},
	], function(err, result) {
		console.dir(result);
		client.close();
	});
});
		
//------------------------------------------

var mongodb = require('mongodb');
var server = new mongodb.Server("127.0.0.1", 27017, {});
new mongodb.Db('test', server, {w: 1}).open(function (error, client) 
 {
	if (error) throw error;
	var collection = new mongodb.Collection(client, 'zipcodes');

// Agregacja pokazująca 5 województw z największą liczbą kodów pocztowych  
	collection.aggregate([
	{ $group : {
		_id : "$wojewodztwo",
	    ilosc_kodow: {$sum: 1}
	           }
	},
	{$project : {
		_id: 0,
		wojewodztwo: "$_id",
		ilosc_kodow :  1
	            }
	},
	{$sort : { 
		ilosc_kodow : -1 
	          }
	},
	{$limit : 5 }
	
	], function(err, result) {
		console.dir(result);
		client.close();
	});
});
