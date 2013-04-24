# Ceny Towarów i Usług Agregację - Łukasz Wasak

## Import Danych

Impotujemy baze cen do mongoDB
```bash
mongoimport --db Ceny --collection Prices --type json --file Ceny.json
```

## Agregację C♯

Do agregacji użyłem drivera dla C# i bazy mongoDB.

Na poczatku musimy jakoś podłaczyć się do naszej bazy danych:

```c#
var client = new MongoClient("mongodb://localhost");
var server = client.GetServer();
```

Nastepnie podłanczamy sie pod kolekcje ktorej chcemy używać, w moim przypadku jest to kolekcja Cen rowarów i usług

```c#
var database = server.GetDatabase("Ceny");
var collection = database.GetCollection<Product>("Prices");
```

Teraz jak już jestemy połączeni to możemy zacząć zabawę z agregacjami.

Agregacja ta pokazuje jak ceny produktów zmieniały sie na przestrzeni lat w polskich województwach.
```c#
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
```

Ta agregacja pokazuje średnią cen w roku w danym województwie. 
```c#
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
```

Gdy juz mamy swoje agregację teraz wystarczy wrzucić je na pipeline i ja odpalić. Możemy wrzucić kilka agregacji na pipeline, wtedy po skonczonej pierwszej agregacji,
dane z niej przejda do drugiej gdzie będą obrobione. Ja napisałem pojedyncze agregację tak by nie potrzebowaly dodatkowej obróbki. 
```c#
var pipeline = new[] { regionAveragePrice };
var result = collection.Aggregate(pipeline);
```

Teraz nasze wyniki rezyduja w zmiennej result, dojsc do nich mozemy przez result.ResultDocuments, jest to kolekcja zwierajaca rekordy z naszej agregacji.

* [ Link do pliku źródłowego ](/scripts/c#/lwasak_ceny_agg.cs)
