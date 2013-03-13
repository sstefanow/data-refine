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
{"kod":6000000000,"jednostka_terytorialna":"Region polnocny","lata":2004,"jednostka_miary":"ha","wartosc_lasy":"1819802","wartosc_rolne":"3362428"}
{"kod":6000000000,"jednostka_terytorialna":"Region polnocny","lata":2005,"jednostka_miary":"ha","wartosc_lasy":"1836406","wartosc_rolne":"3359431"}
```
Po imporcie:
```
{
	"_id" : ObjectId("514066f8788baac425452484"),
	"kod" : 2000000000,
	"jednostka_terytorialna" : "Region poludniowy",
	"lata" : 2003,
	"jednostka_miary" : "ha",
	"wartosc_lasy" : "841204",
	"wartosc_rolne" : "1422745"
}
```

[Exportowane dane](/data/json/dane_xjedam.json)

## Odczucia/Wnioski
Chciałem sprawdzić, czy wzrost/spadek powierzchni użytków rolnych jest powiązany z powierzchnią lasów. Faktycznie wydaje się,że taka zależność zachodzi, chociaż zapewne jest to bardziej skomplikowany temat ;)
Niektóre operacje transformacji danych nie były łatwe, na szczęście dość duża ilość materiałów nt. Google-Refine umożliwiła w miarę szybkie zapoznanie się z narzędziem i poznanie różnych sposobów osiągnięcia porządanego efektu. Przyznaję że google-refine to dość ciekawe narzędzie, gdyż przy ręcznej obróbce danych(na bazie danych) łatwo zniszczyć posiadane dane, natomiast tutaj zawsze jest możliwość cofnięcia błędnych kroków, co robiłem nieraz.
