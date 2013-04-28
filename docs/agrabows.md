## Statystyki NBA - Adam Grabowski
------------------------------


## Co zostało zrobione?
1. Pobranie danych w formacie CSV ze strony www.spxn.com/Stats.asp
2. Oczyszczenie dane przy użyciu Google-Refine - usunięcie pustych kolumn, zmiana nazw kolumn, posortowanie
3. Export z Google-Refine w postaci JSON

## Kilka przykładów

```json
    {
      "Player Name" : "Kobe Bryant",
      "Games Played" : 78,
      "Field Goal %" : 46.3,
      "Three Point %" : 32.4,
      "Free Throw %" : 83.9,
      "Points Per Game" : 27.3
    }
    {
      "Player Name" : "Tim Duncan",
      "Games Played" : 69,
      "Field Goal %" : 50.2,
      "Three Point %" : 28.6,
      "Free Throw %" : 81.7,
      "Points Per Game" : 17.8
    }
    {
      "Player Name" : "Marcin Gortat",
      "Games Played" : 61,
      "Field Goal %" : 52.1,
      "Three Point %" : 0,
      "Free Throw %" : 65.2,
      "Points Per Game" : 11.1
    }
```

* Wynikowy plik .json :
https://github.com/AGR89/test/blob/master/NBA-2012-2013-Players-Stats.json

