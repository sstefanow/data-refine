package pl.radomski.aggregation;

import java.io.File;
import java.net.UnknownHostException;

import javax.security.sasl.AuthenticationException;

import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;

public class Aggregation {

	private static final String PATH = "/home/adam/Pulpit/a/";
	private static final boolean USE_SIGMA = true;
	private static final boolean DEBUG = false;

	public static void main(String[] args) throws UnknownHostException,
			AuthenticationException {
		MongoClient mongoClient;
		DB db;
		DBCollection coll;
		if (USE_SIGMA) {
			mongoClient = new MongoClient("153.19.1.202");
			db = mongoClient.getDB("test");
			// Chrzanić bezpieczeństwo!
			boolean auth = db
					.authenticate("student", "sesja2013".toCharArray());
			if (!auth) {
				throw new AuthenticationException("Sie nie zalogowało");
			}
			coll = db.getCollection("kody_pocztowe");

		} else {
			mongoClient = new MongoClient("localhost");
			db = mongoClient.getDB("dane");
			coll = db.getCollection("dane");
		}
		if (DEBUG) {
			DBObject myDoc = coll.findOne();
			System.out.println(myDoc);
		}

		iloscKodowPocztowychWWoj(coll);
		iloscKodowPocztowychWkazdymMiescie(coll);
		sredniaIloscKodowWWoj(coll);
		iloscKodowWMalymTrojmiescie(coll);
		System.out.println("=================end==============");
	}

	private static void iloscKodowWMalymTrojmiescie(DBCollection coll) {
		DBObject match = new BasicDBObject("$match", new BasicDBObject(
				"miejsce", new BasicDBObject("$in", new String[] { "Rumia",
						"Reda", "Wejherowo" })));
		DBObject sumFields = new BasicDBObject("_id", "$miejsce");
		sumFields.put("count_field", new BasicDBObject("$sum", 1));
		DBObject sum = new BasicDBObject("$group", sumFields);

		AggregationOutput output = coll.aggregate(match, sum);

		String string = Support.prettyPrint(output);
		System.out.println(string);
		File file = new File(PATH + "a.json");
		Support.saveToFile(file, string);
	}

	private static void sredniaIloscKodowWWoj(DBCollection coll) {
		DBObject fields = new BasicDBObject("wojewodztwo", "$wojewodztwo");
		fields.put("miejsce", "$miejsce");
		DBObject groupFields = new BasicDBObject("_id", fields);
		groupFields.put("count_field", new BasicDBObject("$sum", 1));
		DBObject group = new BasicDBObject("$group", groupFields);

		DBObject avgFields = new BasicDBObject("_id", "$_id.wojewodztwo");
		avgFields
				.put("avg_zipcodes", new BasicDBObject("$avg", "$count_field"));
		DBObject avg = new BasicDBObject("$group", avgFields);

		AggregationOutput output = coll.aggregate(group, avg);

		String string = Support.prettyPrint(output);
		System.out.println(string);
		File file = new File(PATH + "b.json");
		Support.saveToFile(file, string);
	}

	private static void iloscKodowPocztowychWkazdymMiescie(DBCollection coll) {
		DBObject fields = new BasicDBObject("wojewodztwo", "$wojewodztwo");
		fields.put("miejsce", "$miejsce");
		DBObject groupFields = new BasicDBObject("_id", fields);
		groupFields.put("count_field", new BasicDBObject("$sum", 1));
		DBObject group = new BasicDBObject("$group", groupFields);

		AggregationOutput output = coll.aggregate(group);

		String string = Support.prettyPrint(output);
		System.out.println(string);

		File file = new File(PATH + "c.json");
		Support.saveToFile(file, string);
	}

	private static void iloscKodowPocztowychWWoj(DBCollection coll) {
		DBObject groupFields = new BasicDBObject("_id", "$wojewodztwo");
		groupFields.put("count_field", new BasicDBObject("$sum", 1));
		DBObject group = new BasicDBObject("$group", groupFields);
		DBObject sort = new BasicDBObject("$sort", new BasicDBObject(
				"count_field", -1));
		AggregationOutput output = coll.aggregate(group, sort);

		String string = Support.prettyPrint(output);
		System.out.println(string);

		File file = new File(PATH + "d.json");
		Support.saveToFile(file, string);
	}

}
