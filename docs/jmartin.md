#Lista lotów programu Apollo
--------------------------------

## Przygotowania
* dane do pobrania z Wikipedii: http://en.wikipedia.org/w/index.php?title=Apollo_program&action=edit&section=28
* narzędzie Google Refine: https://code.google.com/p/google-refine/

## Oczyszczanie danych
* import danych do programu (Line-based text files)
* usunięcie niepotrzebnych wierszy (Text Filter)
* oczyszczenie z wierszy z niepotrzebnych danych tak, żeby każda kolumna oddzielona była znkaiem | (Transform)
* mając kolejne kolumny oddzielone znakiem | możemy teraz dodawać kolumny (Add column based on this column) korzystając ze split i wybierać dane
* usuwamy początkową kolumnę
* eksportujemy

## Przykładowe dane o locie

```json
{
  "Designation" : "Apollo 7",
  "Date" : "Oct. 11-22, 1968",
  "Description" : "Earth orbital demonstration of Block II CSM, launched on Saturn IB. First live television publicly broadcast from a manned mission",
  "Crew" : "Wally Schirra, Walt Cunningham, Donn Eisele"
}
```
Cały plik: [jmartin.json](/data/json/jmartin.json)
