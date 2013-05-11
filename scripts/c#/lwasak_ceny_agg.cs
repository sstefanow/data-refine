using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MongoAggregations.Model;
using MongoDB.Bson;
using MongoDB.Bson.Serialization;
using MongoDB.Driver;
using MongoDB.Driver.Builders;

namespace MongoAggregations
{
    class Program
    {
        static void Main(string[] args)
        {
            var client = new MongoClient("mongodb://localhost");

            var server = client.GetServer();
            var database = server.GetDatabase("Ceny");
            var collection = database.GetCollection<Product>("Prices");

            //zmiany cen
            var priceFluctuation = new BsonDocument
                {
                    { "$project", new BsonDocument
                            {
                                { "towar", 1 },
                                { "cena", 1 },
                                { "rok", 1},
                                { "region", 1}
                            }
                    },
                    { "$group", new BsonDocument
                        {
                            { "_id", new BsonDocument
                                {
                                    { "product", "$towar"},
                                    { "region", "$region"}
                                }
                            },
                            { "values", new BsonDocument
                                {
                                    { "$addToSet", new BsonDocument
                                        {
                                            { "year", "$rok" },
                                            { "price", "$cena"}
                                        }
                                    }
                                }
                            }
                        }
                    }
                };

            var regionAveragePrice = new BsonDocument
                {
                    { "$project", new BsonDocument
                        {
                            { "cena", 1 },
                            { "rok", 1 },
                            { "region", 1 },
                        }
                    }, 
                    { "$group", new BsonDocument
                        {
                            { "_id", new BsonDocument
                                {
                                    { "region", "$region"},
                                    { "year", "$rok"}
                                }
                            },
                            { "value", new BsonDocument
                                {
                                    { "$avg", "$cena"}
                                }
                            }
                        }
                    }
                };

            var pipeline = new[] { regionAveragePrice };
            var result = collection.Aggregate(pipeline);
            Console.WriteLine(result.ResultDocuments.Count() + " documents found.");
            Console.ReadKey();
        }
    }
}
