Data Wranglers

![Data Wranglers](https://raw.github.com/nosql/data-refine/master/images/data-wrangler.jpg)

1. Ano Nim, [Klęski żywiołowe](/docs/anon.md).
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


## Ściąga z Gita

* Scott Chacon, [Pro Git](http://git-scm.com/book);
  [pl](http://git-scm.com/book/pl) (niekompletne).


```sh
git shortlog --no-merges

git remote add pjazdzewski1990 git://github.com/pjazdzewski1990/data-refine.git
git fetch pjazdzewski1990
git merge pjazdzewski1990/master
  .. edycja .. rozwiązywanie konfliktów
git remote rm pjazdzewski1990
```

Undo różnych rzeczy:

```sh
git reset --merge
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

Zobacz też,
Mark Dominus, [My Git Habits ](http://blog.plover.com/prog/git-habits.html).
