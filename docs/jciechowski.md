# Najniższe bezrobocie w Polsce, Jakub Ciechowski
------------------------------
Dane ściągnąłem ze strony [GUS](http://www.stat.gov.pl/cps/rde/xbcr/gus/PW_bezrobotni_stopa_wg_powiat_01m_2013.xls)

## Opis
* plik oczyściłem oraz posortowałem korzystając z [Google refine](http://code.google.com/p/google-refine/)
* następnie wyeksportowałem do pliku JSON

## Przykładowe dane:
```js
{ "Miasto": "Poznań", "bezrobotni (%)": 4.5, "bezrobotni (tysiące)": 14.6 },
{ "Miasto": "Warszawa", "bezrobotni (%)": 4.6, "bezrobotni (tysiące)": 52.2 },
{ "Miasto": "Sopot", "bezrobotni (%)": 5, "bezrobotni (tysiące)": 0.9 },
```
* [plik JSON](/data/json/jciechowski.json)
