# Oczyszczanie danych


## Opis
Dane zostały pobrane ze strony IT Dashboard. Wybrałem dane o wskaźnikach wydajności.

Dane surowe są tutaj: [link](http://www.itdashboard.gov/data_feeds) (z listy Select Data Source wybrać Preformance Metrics. W kroku drugim kliknąć Add all, a następnie na dole strony wybrać plik CSV)


## Co zostało zrobione
W kilku kolumnach puste pola zastąpiłem sensownymi wartościami. Z kolumną "Metric Description" było najwięcej do zrobienia, ponieważ było w niej wiele pozycji zapisanych różnie, lecz oznaczających to samo. Poza tym było wiele literówek. Użyłem do tego Google Refine.


## Przykładowy rekord

```js
  {
    "Unique Investment Identifier":"005-000001723",
    "Business Case ID":212,
    "Agency Code":5,
    "Agency Name":"Department of Agriculture",
    "Investment Title":"AMS Infrastructure WAN and DMZ (AMSWAN)",
    "Performance Metric ID":1073,
    "Agency Performance Metric ID":"unknown",
    "Metric Description":"% time system available",
    "Unit of Measure":"hours of up-time",
    "FEA Performance Measurement Category Mapping":"115-Customer Results - Service Accessibility",
    "Baseline":99.0,
    "Target for PY":99.0,
    "Actual for PY":99.1,
    "Target for CY":99.1,
    "Measurement Condition":"Over target",
    "Reporting Frequency":"Quarterly",
    "Most Recent Actual Results":100.0,
    "Actuals have Met/Not Met Target":"Met",
    "Comment":"",
    "Updated Date":"08/01/2012",
    "Updated Time":"15:32:25"
  }
```


## Dane
Link do gotowego pliku z danymi (wersje: CSV i JSON) - [link](https://skydrive.live.com/redir?resid=3BDE303B2D273EC6!110&authkey=!AL8hldB0hUHsEdE)



# Agregacje

### Średnia cena wszystkich produktów w każdym roku. 
Liczone od 2003 roku, ponieważ we wcześniejszych latach jest dużo mniej towarów.

```
db.ceny.aggregate(
  { $match: { rok: { $gte: 2003 } } },
  { $group: { _id: "$rok", srednia_cena: {$avg: "$cena"} } },
  { $project: { _id: 0, rok: "$_id", srednia_cena: 1 } }, 
  { $sort: { rok: 1 } }
)
```


Dane wynikowe:


![1. agregacja - wykres](http://chart.apis.google.com/chart?chs=400x200&chbh=30,10&cht=lc&chtt=Srednia+cena+produktow+w+danym+roku&chd=t:55.22,61.67,68.28,79.83,75.97,79.48,81.54,84.09,90.33&chxt=x,y&chxl=0:|2003|2004|2005|2006|2007|2008|2009|2010|2011|1:|0|50|100|150|200|250|300)


```
{
        "result" : [
                {
                        "srednia_cena" : 165.66878737846176,
                        "rok" : 2003
                },
                {
                        "srednia_cena" : 185.02154650522843,
                        "rok" : 2004
                },
                {
                        "srednia_cena" : 204.84727886057044,
                        "rok" : 2005
                },
                {
                        "srednia_cena" : 239.50884887952537,
                        "rok" : 2006
                },
                {
                        "srednia_cena" : 227.91266692546535,
                        "rok" : 2007
                },
                {
                        "srednia_cena" : 238.46502741872257,
                        "rok" : 2008
                },
                {
                        "srednia_cena" : 244.63047826087035,
                        "rok" : 2009
                },
                {
                        "srednia_cena" : 252.29090563013287,
                        "rok" : 2010
                },
                {
                        "srednia_cena" : 271.0070374115251,
                        "rok" : 2011
                }
        ],
        "ok" : 1
}
```


### 5 religii z najwyższą średnią wieku wśród wyznawców.

```
db.census1881.aggregate(
  { $group: { _id: "$religion", sredni_wiek: { $avg: "$age" } } },
  { $sort: { sredni_wiek: -1 } },
  { $project: { _id: 0, religia: "$_id", sredni_wiek: 1 } },
  { $limit: 5 }
)
```


Dane wynikowe:


![2. agregacja - wykres](http://chart.apis.google.com/chart?chs=500x300&chbh=60,10&cht=bvo&chtt=Najwyzszy+sredni+wiek+wyznawcow&chd=t:95,91,91,89,89&chxt=x,y&chxl=0:|f|proestant|scandinavian|bbl christ|moroviun|1:|0|20|40|60|80|100)


```
{
        "result" : [
                {
                        "sredni_wiek" : 95,
                        "religia" : "f"
                },
                {
                        "sredni_wiek" : 91,
                        "religia" : "proestant"
                },
                {
                        "sredni_wiek" : 91,
                        "religia" : "scandinavian"
                },
                {
                        "sredni_wiek" : 89,
                        "religia" : "bbl christ"
                },
                {
                        "sredni_wiek" : 89,
                        "religia" : "moroviun"
                }
        ],
        "ok" : 1
}
```


### Lista 5 najdroższych aut, które zmieszczą się w moim małym garażu garażu.

```
db.car_market.aggregate(
  { $match: { height: { $lte: 85 }, length: { $lte: 165 }, width: { $lte: 75 } } },
  { $project: { _id: 0, make: 1, model: 1, price: 1, length: 1, width: 1, height: 1 } },
  { $sort: { price: -1 } },
  { $limit: 5 }
)
```

Dane wynikowe:


![3. agregacja - wykres](http://chart.apis.google.com/chart?chs=500x300&chbh=30,10&cht=bvo&chtt=Najdrozsze+samochody+-+Mercedes&chd=t:86.145,70.395,56.195,55.848,53.645&chxt=x,y&chxl=0:|C1500|E55|CLK430|E430|C43|1:|0|20000|40000|60000|80000|100000)


```
{
        "result" : [
                {
                        "make" : "mercedes-benz",
                        "model" : "cl500",
                        "price" : 86145,
                        "length" : 113.6,
                        "width" : 73.1,
                        "height" : 55
                },
                {
                        "make" : "mercedes-benz",
                        "model" : "e55",
                        "price" : 70395,
                        "length" : 111.5,
                        "width" : 70.8,
                        "height" : 56.7
                },
                {
                        "make" : "mercedes-benz",
                        "model" : "clk430",
                        "price" : 56195,
                        "length" : 105.9,
                        "width" : 67.8,
                        "height" : 53.4
                },
                {
                        "make" : "mercedes-benz",
                        "model" : "e430",
                        "price" : 55848,
                        "length" : 111.5,
                        "width" : 70.8,
                        "height" : 56.7
                },
                {
                        "make" : "mercedes-benz",
                        "model" : "c43",
                        "price" : 53645,
                        "length" : 105.9,
                        "width" : 67.7,
                        "height" : 56.1
                }
        ],
        "ok" : 1
}
```
