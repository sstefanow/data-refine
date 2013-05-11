var mongodb = require('mongodb');

new mongodb.Db('test', new mongodb.Server("127.0.0.1", 27017, {}), {w: 1}).open(function (error, client) {
	if (error) throw error;

	var collection = new mongodb.Collection(client, 'panstwa');

//liczba ludnosci na kazdym kontynencie
collection.aggregate([
	{ $group :
              { _id : "$kontynent",
                ludnosc : { $sum : "$liczba_ludnosci" } } }
	], function(error, result) {
		if (error) throw error;
		console.log("Liczba ludnosci na kazdym kontynencie:");
		console.dir(result);
	});



//Najludniejsze panstwo na kazdym z kontynentow


collection.aggregate([
	{ $group:
              { _id: { kontynent: "$kontynent", panstwo: "$panstwo" },
                liczba_ludnosci: { $sum: "$liczba_ludnosci" } } },
                  { $sort: { liczba_ludnosci: 1 } },
                   { $group:
                    { _id : "$_id.kontynent",
                      najwieksze_panstwo:  { $last: "$_id.panstwo" },
                      ludnosc:   { $last: "$liczba_ludnosci" } } }
	], function(error, result) {
		if (error) throw error;
		console.log("\nNajludniejsze panstwo na kazdym z kontynentow:");
		console.dir(result);
	});



//Powierzchnia kazdego z kontynentow
collection.aggregate([
	{ $group :
              { _id : "$kontynent",
                powierzchnia : { $sum : "$powierzchnia" }, }},
			

	], function(error, result) {
		if (error) throw error;
		console.log("\nPowierzchnia kazdego z kontynentow");
		console.dir(result);
	});
});
