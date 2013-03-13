# Najniższe bezrobocie w Polsce, Jakub Ciechowski
------------------------------
Dane ściągnąłem ze strony [GUS](http://www.stat.gov.pl/cps/rde/xbcr/gus/PW_bezrobotni_stopa_wg_powiat_01m_2013.xls)

## Opis
* plik oczyściłem oraz posortowałem korzystając z [Google refine](http://code.google.com/p/google-refine/)
* następnie wyeksportowałem do pliku JSON

## Przykładowe dane:
```js
{ "Miasto": "Poznań", "bezrobotni_(%)": 4.5, "bezrobotni_(tysiace)": 14.6 },
{ "Miasto": "Warszawa", "bezrobotni_(%)": 4.6, "bezrobotni_(tysiace)": 52.2 },
```
* [plik JSON](/data/json/bezrobotni_jciechowski.json)
