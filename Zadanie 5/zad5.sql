-- Dotyczy pliku Liga_Piłkarska/liga

USE liga;

CREATE TABLE Osoby (id_osoby INT auto_increment PRIMARY KEY, imie VARCHAR (30);

CREATE USER 'sędzia' IDENTIFIED BY 'haslo1';
CREATE USER 'gość' IDENTIFIED BY 'haslo2';

GRANT SELECT ON *.* TO 'sędzia', 'gość';
GRANT ALL ON `liga`.`bramka` TO 'sędzia';
GRANT UPDATE ON `liga`.`mecz` TO 'sędzia';

REVOKE ALL ON `liga`.`bramka` FROM 'sędzia';
GRANT INSERT, UPDATE ON `liga`.`bramka` TO 'sędzia';
DROP USER 'gość';

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;
SELECT * FROM Osoby;

-- Użytkownik U2 wykonuje operację aktualizacji
START TRANSACTION;
UPDATE Osoby SET imie = 'xxxx' WHERE id_osoba = 1;
COMMIT;

-- Użytkownik U1 ponownie wykonuje operację zapytania
SELECT * FROM Osoby;
COMMIT;

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;
SELECT * FROM Osoby;

-- Użytkownik U2 wykonuje operację aktualizacji
START TRANSACTION;
UPDATE Osoby SET imie = 'xxxx' WHERE id_osoba = 1;
COMMIT;

-- Użytkownik U1 ponownie wykonuje operację zapytania
SELECT * FROM Osoby;

-- Zerwanie sesji użytkownika U1
ROLLBACK;


/* 
W zależności od poziomu izolacji, efektem tego scenariusza będzie:

    REPEATABLE READ: Użytkownik U1 zobaczy w wyniku zapytania dane przed aktualizacją wykonaną przez użytkownika U2.
    READ COMMITTED: Użytkownik U1 zobaczy w wyniku zapytania dane po aktualizacji wykonanej przez użytkownika U2.
    READ UNCOMMITTED: Użytkownik U1 zobaczy w wyniku zapytania dane, które były aktualne w momencie wykonywania zapytania, niezależnie od tego, czy zostały one już zapisane na dysku.
    SERIALIZABLE: Sesja użytkownika U1 zostanie zablokowana do czasu, aż użytkownik U2 zakończy transakcję.

Podsumowanie

W zależności od poziomu izolacji, wyniki współbieżnych operacji odczytu i zapisu mogą być różne. 
Poziom izolacji określa, w jaki sposób transakcje są izolowane od siebie. 
Im wyższy poziom izolacji, tym bardziej transakcje są izolowane, ale tym również mniej wydajne.

*/