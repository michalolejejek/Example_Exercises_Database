import mysql.connector
import unittest

# zmienne globalne które należy uzupełnić samemu

host = "localhost"
user = "yourusername"
password = "yourpassword"


class DatabaseTests(unittest.TestCase):
    def setUp(self):
        self.db = mysql.connector.connect(
            host=host
            user=user
            password=password,
            database="wypozycz_auto"
        )
        self.cursor = self.db.cursor()

    def tearDown(self):
        self.cursor.close()
        self.db.close()

    def test_klienci_table(self):
        self.cursor.execute("SELECT * FROM klienci")
        result = self.cursor.fetchall()
        self.assertGreater(len(result), 0, "No data found in klienci table")

    def test_pracownicy_table(self):
        self.cursor.execute("SELECT * FROM pracownicy")
        result = self.cursor.fetchall()
        self.assertGreater(len(result), 0, "No data found in pracownicy table")

    def test_klasy_samochodow_table(self):
        self.cursor.execute("SELECT * FROM klasy_samochodow")
        result = self.cursor.fetchall()
        self.assertGreater(len(result), 0, "No data found in klasy_samochodow table")

    def test_samochody_table(self):
        self.cursor.execute("SELECT * FROM samochody")
        result = self.cursor.fetchall()
        self.assertGreater(len(result), 0, "No data found in samochody table")

    def test_wypozyczenia_table(self):
        self.cursor.execute("SELECT * FROM wypozyczenia")
        result = self.cursor.fetchall()
        self.assertGreater(len(result), 0, "No data found in wypozyczenia table")

    def test_dane_wypozyczen_table(self):
        self.cursor.execute("SELECT * FROM dane_wypozyczen")
        result = self.cursor.fetchall()
        self.assertGreater(len(result), 0, "No data found in dane_wypozyczen table")

if __name__ == '__main__':
    unittest.main()