var mongodb = require('mongodb');
var server = new mongodb.Server("127.0.0.1", 27017, {});

var displayOrNot = function(error, result) {
	if (error) throw error;
	console.dir(result);
};

new mongodb.Db('test', server, {w: 1}).open(function (error, client) {
	if (error) throw error;
	
	var collection = new mongodb.Collection(client, 'nosql');
	
	//1.
	collection.aggregate([
	{ 
		$group : { 
			_id : "$Supplier",
			suma : { $sum : "$Amount" },
			srednia : { $avg : "$Amount" }
		} 
	},{ 
		$match : {
			suma : { $gte : 10000 }
		} 
	},
	], displayOrNot);
	
	//2.
	collection.aggregate([
	{ 
		$group : { 
			_id : "$Supplier",
			suma : { $sum : "$Amount" },
			srednia : { $avg : "$Amount" }
		} 
	}, { 
		$match : {
			suma : { $gte : 10000 }
		} 
	}, { 
		$sort: { 
			suma: -1, 
			srednia: -1 
		} 
	},
	], displayOrNot);
	
	//3.
	collection.aggregate([
	{ 
		$group : { 
			_id : "$Supplier",
			suma : { $sum : "$Amount" },
			srednia : { $avg : "$Amount" }
		} 
	}, { 
		$match : {
			suma : { $gte : 10000 }
		} 
	}, { 
		$sort: { srednia: -1 } 
	}, { 
		$limit : 5 
	},
	], function(error, result){ displayOrNot(error, result); client.close();});
});