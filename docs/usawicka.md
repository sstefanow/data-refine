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


## Przykładowe dane
```json
{"name" : "Surfboard 7 foot","description" : "Surf board recommended for starters, very stable in the big waves.","type" : "surf","variant_option_one_name" : "unknown","variant_option_one_value" : "unknown","tags" : "handmade","supply_price" : 180,"retail_price" : 355,"tax_name" : "nz gst","brand_name" : "unknown","supplier_name" : "unknown","active" : 1,"track_inventory" : 1,"inventory_auckland" : 26,"reorder_point_auckland" : 9,"restock_level_auckland" : 8}
{"name" : "Anzac biscuit","description" : "A really nice home made biscuit","type" : "bistro","variant_option_one_name" : "size","variant_option_one_value" : "red","tags" : "food","supply_price" : 1,"retail_price" : 3,"tax_name" : "nz gst","brand_name" : "home made","supplier_name" : "italia","active" : 1,"track_inventory" : 1,"inventory_auckland" : 22,"reorder_point_auckland" : 12,"restock_level_auckland" : 20}
{"name" : "Apple Juice","description" : "Freshly squeezed apple juice","type" : "food and beverage","variant_option_one_name" : "size","variant_option_one_value" : "red","tags" : "food","supply_price" : 1,"retail_price" : 3,"tax_name" : "nz gst","brand_name" : "coke","supplier_name" : "food & beverage supplies","active" : 1,"track_inventory" : 1,"inventory_auckland" : 0,"reorder_point_auckland" : 56,"restock_level_auckland" : 50}
{"name" : "Beret","description" : "This is a lovely beret that goes with the 2011 fashion really well.","type" : "clothing","variant_option_one_name" : "colour","variant_option_one_value" : "black","tags" : "accessories","supply_price" : 25,"retail_price" : 44.85,"tax_name" : "nz gst","brand_name" : "woolly heads","supplier_name" : "berets are best","active" : 1,"track_inventory" : 1,"inventory_auckland" : 7,"reorder_point_auckland" : 4,"restock_level_auckland" : 6}
```

* Oczyszczone dane: [vendor_products_usawicka.json](https://github.com/urszulasawicka/data-refine/blob/master/data/json/vendor_products_usawicka.json)