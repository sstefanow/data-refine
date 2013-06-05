# Data Wranglers

![Data Wranglers](https://raw.github.com/nosql/data-refine/master/images/data-wrangler.jpg)

W kwietniu zajmujemy się aggregacją danych. Należy zaimplementować
3–5 aggregacji. Opisy agregacji należy dopisać do swoich plików.

Do aggregacji można wykorzystać kolekcje:

* *census1881*
* *zipcodes*, [przykładowe agregacje](/Aggregation-Framework-Examples-in-Javascript.md)
* *kody_pocztowe* (D. Sawa)
* *imieniny*, [przykładowe agregacje](/Aggregation-Framework-Examples-in-Javascript.md)
* *ceny* (Ł. Wasak)
* *car_market* (M. Stanik)
* *poland* – Open Street Data dla Polski
* *ukgov* (P. Jażdżewski)
* *airports* (B. Bedra)


Te kolekcje zostały zaimportowane do bazy MongoDB działającej
na mojej maszynie wirtualnej na UG.

Do bazy logujemy się w ten sposób:

```sh
mongo --username student --password sesja2013 153.19.1.202/test
```

Na rozgrzewkę powinniśmy wykonać kilka poleceń, przykładowo:

```js
db.census1881.count()     // 4_277_807 rekordów
db.zipcodes.count()       //    29_467
db.kody_pocztowe.count()  //   140_076
db.imieniny.count()       //       364

db.census1881.findOne()
// {
//   "_id": ObjectId("51630b8b31f30759f2f32061"),
//   "last": "richard",
//   "first": "joseph",
//   "age": 40,
//   "religion": "catholic"
// }
```

*Uwaga:* Użytkownik *student* ma uprawnienia tylko do odczytu w bazie
 *test*.


## Nasze dane

1. Włodzimierz Bzyl, [Imieniny](/docs/anon.md),
   [Open Street Map Data dla Polski](/docs/osm.md),
   [GeoBytes](/docs/geobytes.md) – państwa i miasta.
1. Michał Mroczkowski, [Kody pocztowe sejmometr](/docs/mmroczkowski.md).
1. Marcin Głombiowski, [Kody pocztowe sejmometr](/docs/mglombiowski.md).
1. Pawel Kaminski, [Sacramento crimes](/docs/pkamin.md).
1. Marcin Gigołło, [Kody pocztowe](/docs/6i6ant.md).
1. Daniel Szymczak, [Wskaźniki wydajności](/docs/dszymczak.md).
1. Alicja Kopczyńska, [Lista bazylik na świecie](/docs/alka74a.md).
1. Michał Frankowski, [Natura 2000](/docs/mfrankowski.md).
1. Dorian Sawa, [Kody pocztowe](/docs/dsawa.md).
1. Jakub Ciechowski [Najbardziej pracowici](/docs/jciechowski.md).
1. Patryk Jażdżewski, [Wydatki Home Office w 2010](/docs/pjazdzewski.md).
1. Paweł Śląski, [Dane historyczne notowań WIG20](/docs/pslaski.md).
1. Aneta Budner, [Adresy IP](/docs/abudner.md).
1. Ryszard Madejski, [Powierzchnia lasów i użytków rolnych](/docs/xjedam.md).
1. Adam Radomski, [Kody pocztowe](/docs/aradomski.md).
1. Jan Mudry, [Lista UNESCO w Europie Wschodniej](/docs/jmudry.md).
1. Andrzej Thiel, [Spis ludności](/docs/athiel.md).
1. Bartłomiej Bedra, [Lista lotnisk na świecie](/docs/bbedra.md).
1. Jakub Martin, [Lista lotów programu Apollo](/docs/jmartin.md).
1. Urszula Sawicka, [Produkty dostawców korzystających z Vend](/docs/usawicka.md).
1. Maciej Stanik, [Rynek nowych samochodów osobowych w USA w 2000 roku](/docs/180.md).
1. Łukasz Wasak, [Ceny Towarów w Polsce](/docs/lwasak.md).
1. Damian Wieliczko, [Budownictwo mieszkaniowe](/docs/wielik17.md).
1. Jan Pawlukiewicz, [Pomniki przyrody w Raciborzu](/docs/joshuaBE.md).
1. Damian Szafranek, [Przeciętne miesięczne wynagrodzenia brutto](/docs/dszafranek.md).
1. Adrian Szulc, [Ilość pomieszczeń szkolnych w szkołach podstawowych](/docs/aszulc.md).
1. Daniel Landowski, [Kody pocztowe wg powiatów dla województwa pomorskiego](/docs/dlandows.md).
1. Dawid Wiśniewski, [Statystyki meczowe angielskiej Premier League sezonu 05/06](/docs/dwisniewski.md).
1. Adam Grabowski, [Statystyki NBA 2012/2013](/docs/agrabows.md).
1. Przemysław Jakuła, [GeoNames](/docs/pjakula.md).
1. Adam Dąbrowski, [Czołgi II wojny światowej] (/docs/ww2tanks.md).
1. Mateusz Skorb, [Monety okolicznościowe 2 złote] (/docs/mskorb.md).
1. Michał Chołka, [Bezrobotni] (docs/mcholka.md).
1. Wojciech Szymański, [Wypadki drogowe] (docs/wszymanski.md).
1. Adam Szuliński, [Agregacje] (docs/aszulinski.md).
1. Maciej Młynarski, [Zawodnicy UFC] (docs/mmlynarski.md).
1. Łukasz Kępiński, [Transfery zawodników] (docs/lkepinsk.md).
1. Romuald Łuczyk, [Państwa świata] (docs/rluczyk.md).
1. Maciej Wiszowaty, [Kody pocztowe województwa Mazowieckiego] (docs/wiszowaty.md).
1. Przemysław Klawikowski [Waga ankietowanych] (docs/klawikowski.md).
1. Marek Dubrawa, [Raporty na teamt pojawień się ufo w USA](/docs/mdubrawa.md)


## Ściąga z Gita

* Scott Chacon, [Pro Git](http://git-scm.com/book);
  [niekompletne tłumaczenie na język polski](http://git-scm.com/book/pl).

Dwa sposoby radzenia sobie z taką sytuacją:
**This pull request can be automatically merged**.

Sposób 1:

```sh
git remote add pjz90 git://github.com/pjz90/data-refine.git
git fetch pjz90
git merge pjz90/master
  .. edycja .. rozwiązywanie konfliktów
git remote rm pjz90
```

Sposób 2 (sugerowany przez GitHub Team):

```sh
git checkout -b bbedra-master master
git pull git://github.com/bbedra/data-refine.git master
git checkout master
git merge bbedra-master
git push origin master
git branch -d bedra-master
```

Undo różnych rzeczy:

```sh
git reset --merge           # merge
git reset --hard ORIG_HEAD  # rebase
```

> Another common practice is to rebase
> the last few commits in your current branch
>
> [Interactive rebase](https://help.github.com/articles/interactive-rebase) on GitHub

Jak zmniejszyć liczbę commitów, zmienić ich kolejność i przeredagować wpisy log:

```sh
git checkout issue16                       # o ile commity są na tej gałęzi
git log --pretty=oneline HEAD~6..HEAD      # sprawdzamy które commity będziemy zmieniać
git rebase -i HEAD~6                       # poprawiamy ostatnich 6 commitów

.. edycja ..
....  edit -- jeśli chcemy poprawić ten commit lub coś do niego dodać
........  git reset HEAD^  # rollback the last commit
........  git status
........  git add --patch  # lub dodajemy/edytujemy pliki
........
........  git rebase --contiune
....  reword -- poprawiamy tekst wpisu do log

git log --pretty=oneline
git rebase master                          # o ile jesteśmy na gałęzi issue16
git checkout master
git merge issue16
git branch -d issue16                      # możemy usunąć scaloną gałąź
```

Na stronie manuala *gitrevisions* jest opisane znaczenie:
`HEAD^`, `^HEAD`, `HEAD~n`.

Stashing:

```sh
git stash
git stash list
git stash apply stash@{0}  # przykłady
git stash drop  stash@{0}
```

Zobacz też:

* Mark Dominus, [My Git Habits](http://blog.plover.com/prog/git-habits.html)
* Bert Belder, [Checkout github pull requests locally](https://gist.github.com/piscisaureus/3342247)
* Chris Wanstrath, [hub makes git better with GitHub](http://defunkt.io/hub/)
* Scott Chacon, [6.4 Git Tools - Rewriting History](http://git-scm.com/book/en/Git-Tools-Rewriting-History)
