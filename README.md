# Data Wranglers

![Data Wranglers](https://raw.github.com/nosql/data-refine/master/images/data-wrangler.jpg)

1. Ano Nim, [Imieniny](/docs/anon.md).
1. Michał Mroczkowski, [Kody pocztowe sejmometr](/docs/mmroczkowski.md).
1. Marcin Głombiowski, [Kody pocztowe sejmometr](/docs/mglombiowski.md).
1. Pawel Kaminski, [Sacramento crimes](/docs/pkamin.md).
1. Marcin Gigołło, [Kody pocztowe](/docs/6i6ant.md).
1. Daniel Szymczak, [Wskaźniki wydajności](/docs/dszymczak.md).
1. Alicja Kopczyńska, [Zabytki romańskie w Polsce](/docs/alka74a.md).
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
1. Łukasz Wasak, [Ceny Towarów w Polsce](/docs/lwasak.md)
1. Damian Wieliczko, [Budownictwo mieszkaniowe](/docs/wielik17.md).


## Ściąga z Gita

* Scott Chacon, [Pro Git](http://git-scm.com/book);
  [pl](http://git-scm.com/book/pl) (niekompletne tłumaczenie).

```sh
git shortlog --no-merges

git remote add pjz90 git://github.com/pjz90/data-refine.git
git fetch pjz90
git merge pjz99/master
  .. edycja .. rozwiązywanie konfliktów
git remote rm pjz90
```

Undo różnych rzeczy:

```sh
git reset --merge           # merge
git reset --hard ORIG_HEAD  # rebase
```

Jak zmniejszyć liczbę commitów, zmienić ich kolejność i przeredagować wpisy log:

```sh
git checkout issue16                       # o ile commity są na tej gałęzi
git log --pretty=oneline HEAD~6..HEAD      # sprawdzamy które commity będziemy zmieniać
git rebase -i HEAD~6                       # poprawiamy ostatnich 6 commitów

.. edycja ..
....  edit -- jeśli chcemy poprawić ten commit lub coś do niego dodać
........  git checkout HEAD^  # zazwyczaj tak zaczynamy poprawki
........  git status
........  git add --patch     # lub dodajemy/edytujemy pliki
........
........  git rebase --contiune
....  reword -- poprawiamy tekst wpisu do log

git log --pretty=oneline
git rebase master                          # o ile jesteśmy na gałęzi issue16
git checkout master
git merge issue16
git branch -d issue16                      # możemy usunąć scaloną gałąź
```

Stashing:

```sh
git stash
git stash list
git stash apply stash@{0}  # przykłady
git stash drop  stash@{0}
```

Zobacz też:

* Mark Dominus, [My Git Habits ](http://blog.plover.com/prog/git-habits.html).
* Bert Belder, [Checkout github pull requests locally](https://gist.github.com/piscisaureus/3342247)
* Chris Wanstrath,[hub makes git better with GitHub](http://defunkt.io/hub/)
