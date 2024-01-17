# Diagram






# Ogólne omówienie 

Projekt jest przykładową bazą danych do przechowywania danych meczów piłkarskich w danej lidze. 
Istnieją tabele:
* liga
* drużyna
* zawodnik
* mecz
* wynik
* termin
* bramki

W danej lidze nie może wystąpić dwa razy ta sama drużyna, tak samo jeden zawodnik, nie może grać dla dwóch różnych drużyn w tej samej lidze. 
W jednym terminie nie ma możliwości rozegrania meczu przez 2 takie same drużyny.

# Wyjaśnienie (raport)

Kod rozpoczyna się od zdefiniowania ograniczenia klucza obcego dla tabeli drużyny (co po polsku oznacza „zespół”), które odwołuje się do tabeli ligi. 
To ograniczenie zapewnia, że kolumna id_liga w tabeli drużyn zawiera tylko wartości, które istnieją w kolumnie id_liga tabeli liga.

Następnie blokuje tabelę drużyny do zapisu, co uniemożliwia innym procesom modyfikowanie tabeli podczas działania tego kodu.

Potem wstawia do tabeli drużyny osiem wierszy danych, z których każdy reprezentuje inną drużynę piłkarską. Kolumna id_liga w każdym wierszu jest ustawiona na 1 lub 2, co odpowiada wartościom id_liga w tabeli liga.

Po odblokowaniu tabeli drużyn, kod usuwa tabelę ligi, jeśli już istnieje.
Następnie tworzy nową tabelę ligową z dwiema kolumnami: id_liga i nazwa. Kolumna id_liga jest kluczem podstawowym i posiada unikalne ograniczenie, które zapewnia, że każda liga ma unikalną wartość id_liga.

Następnie kod blokuje tabelę lig do zapisu i wstawia dwa wiersze danych, każdy reprezentujący inną ligę.
Po odblokowaniu tabeli ligowej, kod usuwa tabelę meczową, jeśli już istnieje.
Następnie tworzy nową tabelę meczów z pięcioma kolumnami: id_mecz, id_termin, id_druzyna_1, id_druzyna_2 i wynik_druzyna_1, wynik_druzyna_2. 
Kolumna id_mecz jest kluczem podstawowym i ma ograniczenie automatycznego przyrostu, które zapewnia, że każde dopasowanie ma unikalną wartość id_mecz. Kolumna id_termin jest kluczem obcym odwołującym się do tabeli terminy.

Ostatecznie kod blokuje tabelę meczową do zapisu.
Ogólnie rzecz biorąc, ten kod tworzy schemat bazy danych dla ligi piłkarskiej z tabelami dla drużyn, lig i meczów. Do kodu wstawiane są także pewne początkowe dane do tabel drużyn i ligi. Dane pochodzą ze strony ekstraklasy.




