Produkty dostawców korzystających z Vend
==========================
Urszula Sawicka
--------------------------

Na rynku zagranicznym dostępny jest produkt [Vend](http://www.vendhq.com/) ułatwiający małym przedsiębiorstwom zarządzanie biznesem. Wykorzystałam przykładowe dane w formacie csv, na których pracuje to oprogramowanie.

Surowe dane dostępne są na stronie [Vend Partner Community](http://support.vendhq.com/entries/21265746-Sample-CSV-file-to-upload-into-trial-account). Do oczyszczania użyłam [Google Refine](http://code.google.com/p/google-refine/).

Podczas pracy przydatnym okazał się [Google Refine Expression Language](https://code.google.com/p/google-refine/wiki/GRELFunctions).
 

## Poszczególne kroki

* Wczytanie pliku csv ze strony producenta Vend.
* Poprawienie literówek w kolumnach skategoryzowanych.
* Wypełnienie pustych komórek domyślnymi wartościami.
* Usunięcie zduplikowanych wierszy.
* Usunięcie znaczników HTML w opisie produktu za pomocą GREL.
* Usunięcie nadmiarowych kolumn.
* Usunięcie niepotrzebnych wierszy za pomocą flag.
* Eksport do pliku JSON.
* Import do MongoDB za pomocą mongoimport.

## Struktura pojedynczego JSON'a

* name - nazwa produktu
* description - opis produktu
* type - dział sprzedaży
* tags - tagi
* retail_price - cena detaliczna
* supply_price - cena dostawy
* tax_name - podatek nałożony na produkt
* brand_name - marka produktu
* supplier_name - nazwa dostawcy
* track_inventory - zapasy produktu
* inventory_auckland - stan po inwentaryzacji

## Przykładowe dane
```json
{"name" : "Surfboard 7 foot","description" : "Surf board recommended for starters, very stable in the big waves.","type" : "surf","variant_option_one_name" : "unknown","variant_option_one_value" : "unknown","tags" : "handmade","supply_price" : 180,"retail_price" : 355,"tax_name" : "nz gst","brand_name" : "unknown","supplier_name" : "unknown","active" : 1,"track_inventory" : 1,"inventory_auckland" : 26,"reorder_point_auckland" : 9,"restock_level_auckland" : 8}
{"name" : "Anzac biscuit","description" : "A really nice home made biscuit","type" : "bistro","variant_option_one_name" : "size","variant_option_one_value" : "red","tags" : "food","supply_price" : 1,"retail_price" : 3,"tax_name" : "nz gst","brand_name" : "home made","supplier_name" : "italia","active" : 1,"track_inventory" : 1,"inventory_auckland" : 22,"reorder_point_auckland" : 12,"restock_level_auckland" : 20}
{"name" : "Apple Juice","description" : "Freshly squeezed apple juice","type" : "food and beverage","variant_option_one_name" : "size","variant_option_one_value" : "red","tags" : "food","supply_price" : 1,"retail_price" : 3,"tax_name" : "nz gst","brand_name" : "coke","supplier_name" : "food & beverage supplies","active" : 1,"track_inventory" : 1,"inventory_auckland" : 0,"reorder_point_auckland" : 56,"restock_level_auckland" : 50}
{"name" : "Beret","description" : "This is a lovely beret that goes with the 2011 fashion really well.","type" : "clothing","variant_option_one_name" : "colour","variant_option_one_value" : "black","tags" : "accessories","supply_price" : 25,"retail_price" : 44.85,"tax_name" : "nz gst","brand_name" : "woolly heads","supplier_name" : "berets are best","active" : 1,"track_inventory" : 1,"inventory_auckland" : 7,"reorder_point_auckland" : 4,"restock_level_auckland" : 6}
```

* Oczyszczone dane: [vendor_products_usawicka.json](/data/json/vendor_products_usawicka.json)

# Agregacje

## Import danych

Pierwszym krokiem jest zaimportowanie danych z pliku w formacie JSON do MongoDB.

```bash
mongoimport --db nosql --collection vend --type json --file vend.json --jsonArray
```

## Stworzenie aplikacji w Node.js

Na początku stworzyłam za pomocą framework'a Express przykładową aplikację w Node.js.
Pomocnym okazał się Eclipse dla JavaScript Web Developerów z rozszerzeniem [Nodeclipse](http://www.nodeclipse.org/).

[Aplikacja z agregacjami](https://github.com/urszulasawicka/aggregation-demo)

## Stworzenie agregacji

Agregacja pokazująca tablicę produktów dla danego dostawcy.

```js
Product.aggregate({
    $match: {
        name: {
            $ne: "unknown"
        },
        supplier_name: {
            $ne: "unknown"
        }
    }
}, {
    $group: {
        _id: "$supplier_name",
        products: {
            $addToSet: "$name"
        }
    }
}
});
```

Przykładowy wynik agregacji:

```json
{"_id":"we love ponchos","products":["Sweatshirt","Poncho"]}
```

Agregacja pokazująca jak duże koszty dostawy i przeceny produktów ponieśli sprzedawcy w danym dziale, aby pokazać ile aktywa musieli sprzedawcy włożyć w tranzakcje.

```js
Product.aggregate({
    $sort: {
        type: 1
    }
}, {
    $match: {
        retail_price: {
            $gte: 1
        },
        supply_price: {
            $gte: 1
        }
    }
}, {
    $group: {
        _id: "$type",
        retail_price: {
            $sum: "$retail_price"
        },
        supply_price: {
            $sum: "$supply_price"
        }
    }
}
});
```

Przykładowy wynik agregacji:

```json
{"_id":"food and beverage","retail_price":154.05,"supply_price":65.7}
```

Wykres obrazujący efekt agregacji:

![](https://github.com/urszulasawicka/data-refine/blob/master/images/usawicka/cena_do_kosztow_dostawy.png?raw=true)

Agregacja pokazująca ile stracił sprzedawca na danym produkcie.

```js
Product.aggregate({
    $sort: {
        type: 1
    }
}, {
    $match: {
        retail_price: {
            $gte: 1
        },
        supply_price: {
            $gte: 1
        }
    }
}, {
    $project: {
        _id: {
            $toLower: "$name"
        },
        loss: {
            $add: ["$retail_price", "$supply_price"]
        }
    }
}
});
```

Przykładowy wynik agregacji:

```json
{"_id":"anzac biscuit","loss":4}
```

Wykres obrazujący efekt agregacji:

![](https://github.com/urszulasawicka/data-refine/blob/master/images/usawicka/koszt_zakupu.png?raw=true)

Agregacja podająca sumę przecen dla każdego działu sprzedarzy.

```js
Product.aggregate({
    $sort: {
        type: 1
    }
}, {
    $match: {
        retail_price: {
            $gte: 1
        }
    }
}, {
    $group: {
        _id: "$type",
        retail_price: {
            $sum: "$retail_price"
        }
    }
}
});
```

Przykładowy wynik agregacji:

```json
{"_id":"bistro","retail_price":47.55}
```

Dla podanego działu możemy użyć takiej agregacji:

```js
Product.aggregate({
    $sort: {
        type: 1
    }
}, {
    $match: {
        retail_price: {
            $gte: 1
        },
        type: "clothing"
    }
}, {
    $group: {
        _id: "$type",
        retail_price: {
            $sum: "$retail_price"
        }
    }
}
});
```