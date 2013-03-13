# Powierzchnia lasów i użytków rolnych - Ryszard Madejski

Dane pobrane z [GUS](http://www.stat.gov.pl/bdl/app/strona.html?p_name=indeks), użyto 2 zestawów danych:
* [lasy.csv](http://sigma.ug.edu.pl/~rmadejski/lasy.csv)
* [uzrolne.csv](http://sigma.ug.edu.pl/~rmadejski/uzrolne.csv)

## Opis
Obydwa w/w zestawy danych zostały zaimportowane do narzędzia Google-Refine, następnie mocno oczyszczone/zmienione:
* Poprawiłem błędy w importowaniu,
* Usunąłem nadmiarowe kolumny, 
* Utworzyłem nową kolumnę łączącą region i rok pomiaru,
* Na podstawie w/w kolumny połączyłem dane dot. powierzchni lasów i użytków rolnych,
* Usunąłem nadmiarowe wiersze "śmieciowe",
* Wyexportowałem dane w postaci json do pliku tekstowego
* Zaimportowałem dane używając mongoimport: `mongoimport --db lasy_uzytki --collection pow_pol --type json --file lasy-rolne.json`

## Przykładowy JSON lub CSV.
Wyexportowany JSON
```
{"Kod" : 5000000000,"Jednostka terytorialna" : "Region poludniowo-zachodni","Lata" : 2003,"Jednostka miary" : "ha","Wartosc-lasy" : "840710","Wartosc-rolne" : "1739746"}
{"Kod" : 5000000000,"Jednostka terytorialna" : "Region poludniowo-zachodni","Lata" : 2004,"Jednostka miary" : "ha","Wartosc-lasy" : "840369","Wartosc-rolne" : "1744954"}
{"Kod" : 5000000000,"Jednostka terytorialna" : "Region poludniowo-zachodni","Lata" : 2005,"Jednostka miary" : "ha","Wartosc-lasy" : "845239","Wartosc-rolne" : "1744276"}
{"Kod" : 6000000000,"Jednostka terytorialna" : "Region polnocny","Lata" : 1995,"Jednostka miary" : "ha","Wartosc-lasy" : "1742163","Wartosc-rolne" : "3388948"}
{"Kod" : 6000000000,"Jednostka terytorialna" : "Region polnocny","Lata" : 1996,"Jednostka miary" : "ha","Wartosc-lasy" : "1749375","Wartosc-rolne" : "3387092"}
{"Kod" : 6000000000,"Jednostka terytorialna" : "Region polnocny","Lata" : 1997,"Jednostka miary" : "ha","Wartosc-lasy" : "1757736","Wartosc-rolne" : "3382370"}
{"Kod" : 6000000000,"Jednostka terytorialna" : "Region polnocny","Lata" : 1998,"Jednostka miary" : "ha","Wartosc-lasy" : "1762789","Wartosc-rolne" : "3382081"}
```
Po imporcie:
```
{
        "_id" : ObjectId("513cb954788baac425452442"),
        "Kod" : 2000000000,
        "Jednostka terytorialna" : "Region poludniowy",
        "Lata" : 2003,
        "Jednostka miary" : "ha",
        "Wartosc-lasy" : "841204",
        "Wartosc-rolne" : "1422745"
}
```

[Exportowane dane](/data/json/dane_xjedam.json)

## Odczucia/Wnioski
Chciałem sprawdzić, czy wzrost/spadek powierzchni użytków rolnych jest powiązany z powierzchnią lasów. Faktycznie wydaje się,że taka zależność zachodzi, chociaż zapewne jest to bardziej skomplikowany temat ;)
Niektóre operacje transformacji danych nie były łatwe, na szczęście dość duża ilość materiałów nt. Google-Refine umożliwiła w miarę szybkie zapoznanie się z narzędziem i poznanie różnych sposobów osiągnięcia porządanego efektu. Przyznaję że google-refine to dość ciekawe narzędzie, gdyż przy ręcznej obróbce danych(na bazie danych) łatwo zniszczyć posiadane dane, natomiast tutaj zawsze jest możliwość cofnięcia błędnych kroków, co robiłem nieraz.
