no_sql
======

Skrypt do pobierania kodów wraz z danymi(.json) oraz wersja .csv utworzona przy pomocy narzêdzia google-refine.
Dane to kody-pocztowe gmin.


Skrypt php wykorzystuje api strony sejmometr.pl, po zarejestrowaniu siê na stronie, pobraniu kluczy œci¹gamy bibliotekê do api (folder ep_API), osadzamy klucze. Po za³¹czeniu biblioteki do skryptu mo¿emy ju¿ korzystaæ z wszystkich funkcjonalnoœci udostêpnianych przez sejmometr.

Fragment CSV:
```csv
kod,kod_int,liczba_gmin,wojewodztwo_id,liczba_powiatow,gminy,wojewodztwo,miejscowosci_str

00-002,2,1,7,1,Warszawa,mazowieckie,Warszawa (Œródmieœcie)

00-003,3,1,7,1,Warszawa,mazowieckie,Warszawa (Œródmieœcie)

00-004,4,1,7,1,Warszawa,mazowieckie,Warszawa (Œródmieœcie)

00-005,5,1,7,1,Warszawa,mazowieckie,Warszawa (Œródmieœcie)

00-006,6,1,7,1,Warszawa,mazowieckie,Warszawa (Œródmieœcie)

00-007,7,1,7,1,Warszawa,mazowieckie,Warszawa (Œródmieœcie)

00-008,8,1,7,1,Warszawa,mazowieckie,Warszawa (Œródmieœcie)
```
