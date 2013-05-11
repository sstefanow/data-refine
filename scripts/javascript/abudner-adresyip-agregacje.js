var mongodb = require('mongodb');
var server = new mongodb.Server("127.0.0.1", 27017, {});
new mongodb.Db('test', server, {w: 1}).open(function (error, client) {
	if (error) throw error;
	var collection = new mongodb.Collection(client, 'adresyip');
	// ilość zakresów adresów IP w danym województwie posortowane malejąco
	collection.aggregate([
	{ $group : {
		_id : "$regionName",
		suma : {$sum: 1}
	}},
	{ $sort : { suma : -1 }
	},
	], function(err, result) {
		console.dir(result);
		//client.close();
	});
	// wyświetla 10 miast z największą ilością zakresów IP
	collection.aggregate([
	{ $group : {
		_id : "$cityName",
		suma : {$sum: 1}
	}},
	{ $sort : { suma : -1 }
	},
	{ $limit: 10
	},
	], function(err, result) {
		console.log("\n\n\n");
		console.dir(result);
	});
	// miasta w województwie które posiadają najmniej i najwięcej zakresów IP
	collection.aggregate([
	{ $group : {
		_id : {wojewodztwo: "$regionName", miasto: "$cityName"},
		suma : {$sum: 1}
	}},
	{ $sort : { suma : 1 }
	},
	{ $group : {
			_id: "$_id.wojewodztwo",
			najmniejszeMiasto: {$first: "$_id.miasto"},
			najmniejszeMiastoSuma: {$first: "$suma"},
			najwiekszeMiasto: {$last: "$_id.miasto"},
			najwiekszeMiastoSuma: {$last: "$suma"}
		}
	},
	], function(err, result) {
		console.log("\n\n\n");
		console.dir(result);
		client.close();
	});
});