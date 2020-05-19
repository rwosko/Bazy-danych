-- Usuń bazę danych sda 
DROP DATABASE sda;

-- Utwórz bazę danych sda
CREATE DATABASE sda;

-- Użyj bazy danych sda 
USE sda;

-- Tabela: Kategorie
CREATE TABLE sda.categories
(
    cat_id      SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    cat_name    VARCHAR(32) NOT NULL,
    cat_desc    VARCHAR(64) DEFAULT 'Brak opisu kategorii',
    PRIMARY KEY (cat_id)
);

-- Tabela: Oddziały
CREATE TABLE sda.departments
(
    dep_id          SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    dep_name        VARCHAR(64) NOT NULL UNIQUE,
    dep_location    VARCHAR(128) NOT NULL,
    dep_city        VARCHAR(64) NOT NULL,
    PRIMARY KEY     (dep_id)
);

-- Tabela: Klienci
CREATE TABLE sda.customers
(
    cus_id      SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    cus_name    VARCHAR(64) NOT NULL,
    cus_surname VARCHAR(64) NOT NULL,
    cus_phone   VARCHAR(9),
    cus_email   VARCHAR(32),
    PRIMARY KEY (cus_id)
);

-- Tabela: Pracownicy
CREATE TABLE sda.employees
(
    ep_id           SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    ep_man_id       SMALLINT UNSIGNED,
    ep_dep_id       SMALLINT UNSIGNED,
    ep_name         VARCHAR(64) NOT NULL,
    ep_surname      VARCHAR(64) NOT NULL,
    ep_hire_date    DATE NOT NULL,
    ep_salary       SMALLINT UNSIGNED NOT NULL,
    ep_phone        VARCHAR(9),
    ep_email        VARCHAR(32) NOT NULL UNIQUE,
    PRIMARY KEY     (ep_id),
    FOREIGN KEY     (ep_dep_id) REFERENCES sda.departments(dep_id),
    FOREIGN KEY     (ep_man_id) REFERENCES sda.employees(ep_id)
);

-- Tabela: Książki
CREATE TABLE sda.books
(
    bk_id           VARCHAR(5) NOT NULL,
    bk_cat_id       SMALLINT UNSIGNED NOT NULL,
    bk_name         VARCHAR(64) NOT NULL,
    bk_author       VARCHAR(64) NOT NULL,
    bk_release      VARCHAR(4) NOT NULL,
    bk_publisher    VARCHAR(32) NOT NULL,
    PRIMARY KEY     (bk_id),
    FOREIGN KEY     (bk_cat_id) REFERENCES sda.categories(cat_id)
);

-- Tabela: Wypożyczenia
CREATE TABLE sda.rents
(
    rn_id           SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    rn_bk_id        VARCHAR(5) NOT NULL,
    rn_cus_id       SMALLINT UNSIGNED NOT NULL,
    rn_rent_date    DATE NOT NULL,
    rn_return_date  DATE,
    PRIMARY KEY     (rn_id),
    FOREIGN KEY     (rn_bk_id) REFERENCES sda.books(bk_id),
    FOREIGN KEY     (rn_cus_id) REFERENCES sda.customers(cus_id)
);

-- Dodanie oddziałów
INSERT INTO sda.departments(dep_id, dep_name, dep_city, dep_location)
VALUES (NULL, 'Alpha', 'Warszawa', 'Ostatnia 10/20'),
    (NULL, 'Beta', 'Warszawa', 'Cukierkowa 65'),
    (NULL, 'Gamma', 'Gdynia', 'Wojska Polskiego 1'),
    (NULL, 'Epsilon', 'Lodz', 'Wektorowa 1/70'),
    (NULL, 'Omega', 'Lodz', 'Zamkowa 23/20');

-- Dodanie kategorii
INSERT INTO sda.categories
VALUES (NULL, 'Fantastyka', 'Wielotomowe, epickie dzieła'),
    (NULL, 'Sensacyjne i Kryminały', 'Dział dla miłośników silnych emocji'),
    (NULL, 'Naukowe', DEFAULT),
    (NULL, 'Dla dzieci', 'Coś dla naszych pociech');

-- Dodanie pracowników
-- Department 1
INSERT INTO sda.employees
VALUES (NULL, NULL, 1, 'Jan', 'Boss', '2018-01-01', 15000, '154978100', 'jan_boss@alpha.pl');
-- Department 2
INSERT INTO sda.employees
VALUES (NULL, 1, 2, 'Ewelina', 'Wice', '2018-02-01', 12500, '345890112', 'ewelina_wice@beta.pl');
INSERT INTO sda.employees
VALUES (NULL, 1, 2, 'Agnieszka', 'Kowalik', '2018-04-01', 12500, '123567455', 'agnieszka_kowalik@beta.pl');
-- Department 3
INSERT INTO sda.employees
VALUES (NULL, 3, 3, 'Adam', 'Nowakowski', '2018-07-01', 3500, '234675112', 'adam_nowakowski@gamma.pl');
INSERT INTO sda.employees
VALUES (NULL, 3, 3, 'Jakub', 'Nazwisko', '2018-04-01', 3500, '900767433', 'jakub_nazwisko@gamma.pl');
-- Department 4
INSERT INTO sda.employees
VALUES (NULL, 2, 4, 'Karolina', 'Polka', '2019-01-01', 3500, '231564786', 'karolina_polka@epsilon.pl');
INSERT INTO sda.employees
VALUES (NULL, 5, 4, 'Jakub', 'Drugi', '2019-03-01', 4000, '111222333', 'jakub_drugi@epsilon.pl');
INSERT INTO sda.employees
VALUES (NULL, 5, 4, 'Karolina', 'Wierna', '2019-05-01', 5000, '123456980', 'karolina_wierna@epsilon.pl');

-- Dodanie klientów
INSERT INTO sda.customers
VALUES (NULL, 'Adam', 'Nowak', '371980245', 'adam.nowak@email.pl'),
    (NULL, 'Ewelina', 'Oczytana', '244908121', NULL),
    (NULL, 'Jakub', 'Mol', '322657100', 'jakub_mol@o3.pl');

-- Dodanie książek
-- Fantastyka
INSERT INTO sda.books
VALUES ('JP101', 1, 'Ja, Inkwizytor. Przeklęte krainy', 'Jacek Piekara', '2019', 'Fabryka Słów'),
    ('SJM01', 1, 'Szklany Tron. Tom 5.5. Wieża świtu.', 'Sarah J. Maas', '2018', 'Uroboros'),
    ('AS210', 1, 'Wiedźmin. Tom 1. Ostatnie życzenie.', 'Andrzej Sapkowski', '2014', 'SuperNowa');

-- Kryminały
INSERT INTO sda.books
VALUES ('TF567', 2, 'Bad Mommy. Zła mama.', 'Tarryn Fisher', '2017', 'Sine Qua Non'),
('AC989', 2, 'Pajęczyna', 'Agatha Christie', '2013', 'Literackie'),
('TL367', 2, 'Login', 'Tomasz Lipko', '2019', 'Literackie'),
('WC666', 2, 'Rana', 'Wojciech Chmielarz', '2019', 'Marginesy');

-- Dla dzieci
INSERT INTO sda.books
VALUES ('RG345', 4, 'Mikołajek. Jak to się zaczęło', 'Rene Goscinny', '2019', 'Znak');

Zadania

/* 
Dodaj za pomocą polecenia INSERT poniższe wypożyczenia:
ID Klienta: 1
Książka o ID JP101 została wypożyczona przez Adama Nowaka dnia 2019-05-01 i zwrócona 2019-06-01
Książka o ID TF567 została wypożyczona przez Adama Nowaka dnia 2019-06-01 i zwrócona 2019-07-01
Książka o ID RG345 została wypożyczona przez Adama Nowaka dnia 2019-07-01 i nie została zwrócona
*/
SELECT * FROM sda.rents;
INSERT INTO sda.rents VALUES (NULL, 'JP101', 1, '2019-05-01', '2019-06-01'), 
(NULL, 'TF567', 1, '2019-06-01', '2019-07-01'), 
(NULL, 'RG345', 1, '2019-07-01', NULL);
/*
ID Klienta: 2
Książka o ID SJM01 została wypożyczona przez Ewelinę Oczytana dnia 2019-07-01 i nie została zwrócona (to jest NULL)
Książka o ID JP101 została wypożyczona przez Ewelinę Oczytana dnia 2019-07-01 i zwrócona 2019-09-01
Książka o ID WC666 zostala wypożyczona przez Ewelinę Oczytana dnia 2019-08-01 i zwrócona 2019-09-01
*/
SELECT * FROM rents;
INSERT INTO rents VALUES (NULL, 'SJM01', 2, '2019-07-01', NULL), 
(NULL, 'JP101', 2, '2019-07-01', '2019-09-01'), 
(NULL, 'WC666', 2, '2019-08-01', '2019-09-01');
/*
ID Klienta: 3
Książka o ID WC666 została wypożyczona przez Jakuba Mola dnia 2019-02-01 i zwrócona 2019-05-01
*/
SELECT * FROM rents;
INSERT INTO rents VALUES (NULL, 'WC666', 3, '2019-02-01', '2019-05-01');

-- Wyświetl wszystkie wiersze tabeli customers
SELECT * FROM customers;

-- Wyświetl 3 wiersze z tabeli books
SELECT * FROM customers LIMIT 3;

-- Wyświetl unikalne ID departamentu z tabeli employees
SELECT * FROM employees;
SELECT DISTINCT ep_dep_id FROM employees;

-- Wyświetl kolumnę ep_name jako imię oraz ep_surname jako nazwisko
SELECT * FROM employees;
SELECT ep_name AS imię, ep_surname AS nazwisko FROM employees;

-- Wyświetl dane z employees alfabetycznie po nazwisku
SELECT * FROM employees;
SELECT * FROM employees ORDER BY ep_surname ASC;

-- Wyświetl dane z tabeli books, zaczynając od najmłodszego wydania
SELECT * FROM books;
SELECT * FROM books ORDER BY bk_release DESC;

-- Wyświetl klientów w tabeli customers po ID w sposób malejący, wyswietlając jedynie imiona oraz nazwiska
SELECT * FROM customers;
SELECT cus_name, cus_surname FROM customers ORDER BY cus_id DESC;

-- Wyświetl wiersze w tabeli rents posorotwane po ID książki w sposób narastający, a ID wypożyczenia w sposób malejący
SELECT * FROM rents;
SELECT * FROM rents ORDER BY rn_bk_id ASC, rn_id DESC;

-- Połącz kolumny ep_name oraz ep_surname jako “pracownik” z tabeli employees
SELECT * FROM employees;
SELECT concat(ep_name,' ',ep_surname) AS pracownik FROM employees;

-- Wyświetl dlugości nazw miast z tabeli departments
SELECT * FROM departments;
SELECT DISTINCT length(dep_city) FROM departments;

-- Wyświetl pierwsze 3 cyfry telefonu z tabeli customers
SELECT * FROM customers;
SELECT substring(cus_phone,1,3) FROM customers;

-- Wyświetl tytuły książek napisane samymi drukowanymi literami
SELECT * FROM books;
SELECT upper(bk_name) FROM books;

-- Wyświetl tytuły książek napisane samymi małymi literami
SELECT lower(bk_name) FROM books;

-- Wyświetl 4 znaki z kolumny adresu z tabeli departments, pomijając pierwsze 2 znaki
SELECT * FROM departments;
SELECT substring(dep_location,3,4) FROM departments;

-- Wyświetl miesiąc z daty wypożyczenia książki z tabeli rents
SELECT * FROM rents;
SELECT month(rn_rent_date) FROM rents;
SELECT monthname(rn_rent_date) FROM rents;

-- Wyświetl różnicę pomiędzy dzisiejszą datą, a datą Twojego urodzenia
SELECT datediff(curdate(),'1992-01-10');

-- Wyświetl bieżącą datę i czas
SELECT curdate();		-- sama data
SELECT curtime();		-- sam czas
SELECT now();
SELECT current_timestamp();

-- Wyświetl pracowników, których wynagrodzenie jest większe bądź równe 10000
SELECT * FROM employees;
SELECT * FROM employees WHERE ep_salary>=10000;

-- Wyświetl książki nie zaczynające się na literę J
SELECT * FROM books;
SELECT * FROM books WHERE bk_name NOT LIKE "J%";

-- Wyświetl książki, które mają fragment "ja" w tytule
SELECT * FROM books WHERE bk_name LIKE "%ja%"; 

-- Wyświetl książki, których autorem jest Andrzej Sapkowski lub wydawcą jest wydawnictwo Dolnośląskie
SELECT * FROM books;
SELECT * FROM books WHERE bk_author="Andrzej Sapkowski" OR bk_publisher="wydawnictwo Dolnośląskie";

-- Wyświetl książki, których autorem jest Andrzej Sapkowski i wydawcą jest wydawnictwo Dolnośląskie
SELECT * FROM books WHERE bk_author="Andrzej Sapkowski" AND bk_publisher="wydawnictwo Dolnoslaskie";

-- Wyświetl książki, które zostały wypożyczone dnia 2019-03-01
SELECT * FROM rents WHERE rn_rent_date="2019-03-01"; 

-- Wyświetl książki, które zostały wypożyczone w inny dzień niż 2019-03-01
SELECT * FROM rents;
SELECT * FROM rents WHERE rn_rent_date!="2019-03-01";

-- Wyświetl książki wypożyczone pomiędzy 5 oraz 7 miesiącem 2019 roku
SELECT * FROM rents;
SELECT * FROM rents WHERE rn_rent_date BETWEEN "2019-05-01" AND "2019-07-31";
SELECT * FROM rents WHERE month(rn_rent_date)>=5 AND month(rn_rent_date)<=7;

-- Wyświetl użytkowników, którzy kiedykolwiek wypożyczyli książki i podaj ilość wypożyczonych książek przez każdego klienta jako "suma_wypozyczen"
SELECT * FROM rents;
SELECT * FROM customers;
SELECT * FROM rents CROSS JOIN customers WHERE rn_cus_id=cus_id;
SELECT cus_name, cus_surname, count(*) FROM rents CROSS JOIN customers WHERE rn_cus_id=cus_id GROUP BY cus_name;

-- Wyświetl książki, które nigdy nie zostaly wypożyczone
SELECT * FROM books;
SELECT * FROM rents;
SELECT * FROM books LEFT JOIN rents ON bk_id=rn_bk_id WHERE rn_bk_id IS NULL;

-- Wyświetl za pomocą jednego zapytania imię, nazwisko, nazwę oddziału, miasto oddziału wszystkich pracowników
SELECT * FROM employees;
SELECT * FROM departments;
SELECT ep_name, ep_surname, dep_name, dep_city FROM employees CROSS JOIN departments WHERE ep_dep_id=dep_id;

-- Wyświetl wszystkich pracowników oraz klientów biblioteki w jednym zapytaniu
SELECT * FROM employees;
SELECT * FROM customers;
SELECT ep_name, ep_surname FROM employees UNION SELECT cus_name, cus_surname FROM customers;

-- Zmień nazwę działu Alpha na Ajin
SELECT * FROM departments;
UPDATE departments SET dep_name="Ajin" WHERE dep_name="Alpha";

-- Ustaw nowy telefon wymyślony przez Ciebie dla klienta o ID rownym 3
SELECT * FROM customers;
UPDATE customers SET cus_phone="123456789" WHERE cus_id=3;

-- Ustaw wynagrodzenie o 10% wyższe dla pracowników, których menadżer ma ID równe 2 lub którzy pracują w oddziale o ID 4
SELECT * FROM employees;
UPDATE employees SET ep_salary=1.1*ep_salary WHERE ep_man_id=2 OR ep_dep_id=4;

-- Ustaw datę oddania wypożyczenia z 2019-10-10 na NULL
SELECT * FROM rents;
UPDATE rents SET rn_return_date=NULL WHERE rn_return_date='2019-10-10';

-- Wyświetl najmniejszą oraz najwiekszą pensję z tabeli employees
SELECT * FROM employees;
SELECT DISTINCT min(ep_salary), max(ep_salary) FROM employees;

-- Wyświetl średni rok wydania z tabeli books
SELECT * FROM books;
SELECT avg(bk_release) FROM books;

-- Wyświetl ilość pracowników w poszczególnych oddziałach z tabeli employees
SELECT * FROM employees;
SELECT DISTINCT count(*), ep_dep_id FROM employees GROUP BY ep_dep_id;

-- Wyświetl książki, które zostały wypożyczone więcej niż jeden raz
SELECT * FROM rents;
SELECT * FROM books;
SELECT * FROM rents CROSS JOIN books WHERE rn_bk_id=bk_id;
SELECT bk_name, COUNT(*), rn_bk_id FROM rents CROSS JOIN books WHERE rn_bk_id=bk_id GROUP BY rn_bk_id HAVING COUNT(*)>1;