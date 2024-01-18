import mysql.connector
import unittest
import threading # moduł symulujący moduł threading na javie

class TestConcurrency(unittest.TestCase):
    def setUp(self):
        self.db = mysql.connector.connect(
            # Uzupełnij swoimi danymi lokalnymi
            host="localhost",
            user="your_username",
            password="your_password",
            database="liga"
        )
        self.cursor = self.db.cursor()

    def tearDown(self):
        self.cursor.close()
        self.db.close()

    def test_concurrent_transactions(self):
        lock = threading.Lock()

        def user_U1():
            lock.acquire()
            try:
                self.cursor.execute("SELECT * FROM Osoby")
                result = self.cursor.fetchall()
                self.assertEqual(len(result), 1)
            finally:
                lock.release()

        def user_U2():
            lock.acquire()
            try:
                self.cursor.execute("UPDATE Osoby SET imie = 'xxxx' WHERE id_osoba = 1")
                self.db.commit()
            finally:
                lock.release()

        thread_U1 = threading.Thread(target=user_U1)
        thread_U2 = threading.Thread(target=user_U2)
        thread_U1.start()
        thread_U2.start()
        thread_U1.join()
        thread_U2.join()

if __name__ == '__main__':
    unittest.main()