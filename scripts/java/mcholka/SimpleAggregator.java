package com.nosql;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.mongodb.*;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;

import java.io.File;
import java.io.IOException;
import java.net.UnknownHostException;

/**
 * Created with IntelliJ IDEA.
 * User: mcholka
 * Date: 26.05.13
 * Time: 16:48
 */
public class SimpleAggregator {
    private static final Logger logger = Logger.getLogger(SimpleAggregator.class);
    private static final String PATH = "C:/mongodb/db/";
    private static final String ENCODING = "UTF-8";
    private static DB db;
    private static DBCollection dbCollection;
    private static String output;
    private static Gson gson;


    public static void main(String[] args) {
        connectDB();

        matchCollection("zipcodes");
        getStatesWithAveragePopulationGreaterThan10000();
        storeToFile();

        matchCollection("kody_pocztowe");
        get5CitiesWithHighestNumberOfPostalCodes();
        storeToFile();

        matchCollection("car_market");
        getMakeListSortedByModelsNumber();
        storeToFile();
    }

    private static void connectDB() {
        Boolean auth;
        try {
            MongoClient client = new MongoClient("153.19.1.202");
            db = client.getDB("test");
            auth = db.authenticate("student", "sesja2013".toCharArray());
            if(!auth){
                throw new RuntimeException("Can't connect do db...");
            }
        } catch (UnknownHostException e) {
            logger.error(e,e);
        }
    }

    private static void matchCollection(String collection) {
        dbCollection = db.getCollection(collection);
    }

    private static void getStatesWithAveragePopulationGreaterThan10000() {
        DBObject groupFields = new BasicDBObject("_id", "$state");
        groupFields.put("totalPopulation", new BasicDBObject("$sum", "$pop"));
        groupFields.put("averagePopulation", new BasicDBObject("$avg", "$pop"));

        DBObject match = new BasicDBObject("$match", new BasicDBObject("averagePopulation", new BasicDBObject("$gte", 10000)));
        DBObject group = new BasicDBObject("$group", groupFields);
        DBObject sort = new BasicDBObject("$sort", new BasicDBObject("averagePopulation", -1));

        output = dbCollection.aggregate(group, match, sort).toString();
    }

    private static void storeToFile() {
        String fullPath = PATH.concat(System.currentTimeMillis() + ".json");
        logger.info("Store file: " + fullPath);
        File file = new File(fullPath);
        try {
            FileUtils.writeStringToFile(file, formatOutput(output), ENCODING);
        } catch (IOException e) {
            logger.error(e,e);
        }
    }

    private static String formatOutput(String output){
        return getGson().toJson(gson.fromJson(output, Object.class));
    }

    private static Gson getGson(){
        if(gson == null){
            gson = new GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create();
        }
        return gson;
    }

    private static void get5CitiesWithHighestNumberOfPostalCodes() {
        DBObject groupFields = new BasicDBObject("_id", "$wojewodztwo");
        groupFields.put("numberOfCodes", new BasicDBObject("$sum", 1));

        DBObject sort = new BasicDBObject("$sort", new BasicDBObject("numberOfCodes", 1));

        DBObject group = new BasicDBObject("$group", groupFields);
        DBObject limit = new BasicDBObject("$limit", 9);

        output = dbCollection.aggregate(sort, group, limit).toString();
    }

    private static void getMakeListSortedByModelsNumber() {
        DBObject groupFields = new BasicDBObject("_id", "$make");
        groupFields.put("numberOfModels", new BasicDBObject("$sum", 1));

        DBObject group = new BasicDBObject("$group", groupFields);
        DBObject sort = new BasicDBObject("$sort", new BasicDBObject("numberOfModels", -1));
        DBObject limit = new BasicDBObject("$limit", 9);

        output = dbCollection.aggregate(group, sort, limit).toString();
    }
}