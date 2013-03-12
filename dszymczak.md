Dane zostały pobrane ze strony IT Dashboard. Wybrałem dane o wskaźnikach wydajności.


Dane surowe są tutaj: [link](http://www.itdashboard.gov/data_feeds) (z listy Select Data Source wybrać Preformance Metrics. W kroku drugim kliknąć Add all, a następnie na dole strony wybrać plik CSV)


W kilku kolumnach puste pola zastąpiłem sensownymi wartościami. Z kolumną "Metric Description" było najwięcej do zrobienia, ponieważ było w niej wiele pozycji zapisanych różnie, lecz oznaczających to samo. Poza tym było wiele literówek. Użyłem do tego Google Refine.


Przykładowy rekord:

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


Link do gotowego pliku z danymi (wersje: CSV i JSON) - [link](https://skydrive.live.com/redir?resid=3BDE303B2D273EC6!110&authkey=!AL8hldB0hUHsEdE)
