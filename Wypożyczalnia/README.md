
# Wypożyczalnia - stworzenie bazy danych

    DROP DATABASE IF EXISTS wypozycz_auto;
        Jeśli baza danych o nazwie "wypozycz_auto" istnieje, to ją usuwa. To jest opcjonalne, aby upewnić się, że przed utworzeniem nowej bazy danych stara zostanie usunięta.

    CREATE DATABASE wypozycz_auto;
        Tworzy nową bazę danych o nazwie "wypozycz_auto".

    USE wypozycz_auto;
        Wybiera nowo utworzoną bazę danych jako aktualnie używaną.

    CREATE TABLE klienci (id_klienta INT auto_increment PRIMARY KEY, ...);
        Tworzy tabelę "klienci" z kolumnami:
            id_klienta: Unikalny identyfikator klienta (klucz główny), automatycznie inkrementowany.
            imie_klienta, nazwisko_klienta, ulica_klienta, numer_domu_klienta, miasto_klienta, kod_klienta, telefon_klienta, email_klienta, plec: Informacje o kliencie.

    CREATE TABLE pracownicy (id_pracownika INT auto_increment PRIMARY KEY, ...);
        Tworzy tabelę "pracownicy" z informacjami o pracownikach, podobnie jak w przypadku tabeli "klienci".

    CREATE TABLE klasy_samochodow (id_klasy INT auto_increment PRIMARY KEY, ...);
        Tworzy tabelę "klasy_samochodow" z informacjami o klasach samochodów.

    CREATE TABLE samochody (id_samochodu INT auto_increment PRIMARY KEY, ...);
        Tworzy tabelę "samochody" z informacjami o samochodach, w tym informacje o klasie samochodu (poprzez klucz obcy "id_klasy").

    CREATE TABLE wypozyczenia (id_wypozyczenia INT auto_increment PRIMARY KEY, ...);
        Tworzy tabelę "wypozyczenia" z informacjami o wypożyczeniach, zawierającymi daty wypożyczenia i zwrotu, a także informacje o kliencie i pracowniku obsługującym wypożyczenie (poprzez klucze obce "id_klienta" i "id_pracownika").

    CREATE TABLE dane_wypozyczen (id_wypozyczenia INT, id_samochodu INT, ...);
        Tworzy tabelę "dane_wypozyczen" zawierającą szczegółowe dane o wypożyczeniach, takie jak cena za dobę, ilość dni wypożyczenia itp. (poprzez klucze obce "id_wypozyczenia" i "id_samochodu").

# Trigger 

Trigger pracownik_zwolnienie jest wywoływany przed usunięciem rekordu z tabeli pracownicy. Działa to tak, że gdy pracownik zostanie zwolniony (DELETE z pracownicy), trigger ten oblicza łączną kwotę wypożyczeń danego pracownika (laczna_kwota_wypozyczenia) i dodaje informacje o tym pracowniku do tabeli były_pracownik. Następnie usuwa pracownika z tabeli pracownicy.