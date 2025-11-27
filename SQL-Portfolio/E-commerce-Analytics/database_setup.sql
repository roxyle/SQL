-- ========================================
-- E-COMMERCE DATABASE SETUP
-- ========================================
-- Importa questo file in phpMyAdmin per creare il database

CREATE DATABASE IF NOT EXISTS ecommerce_analytics;
USE ecommerce_analytics;

-- Tabella Clienti
CREATE TABLE clienti (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    citta VARCHAR(50),
    paese VARCHAR(50),
    data_registrazione DATE NOT NULL
);

-- Tabella Categorie Prodotti
CREATE TABLE categorie (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(50) NOT NULL,
    descrizione TEXT
);

-- Tabella Prodotti
CREATE TABLE prodotti (
    id_prodotto INT PRIMARY KEY AUTO_INCREMENT,
    nome_prodotto VARCHAR(100) NOT NULL,
    id_categoria INT,
    prezzo_unitario DECIMAL(10, 2) NOT NULL,
    stock_disponibile INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorie(id_categoria)
);

-- Tabella Ordini
CREATE TABLE ordini (
    id_ordine INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_ordine DATE NOT NULL,
    stato_ordine VARCHAR(20) NOT NULL,
    totale_ordine DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES clienti(id_cliente)
);

-- Tabella Dettagli Ordini (prodotti acquistati in ogni ordine)
CREATE TABLE dettagli_ordini (
    id_dettaglio INT PRIMARY KEY AUTO_INCREMENT,
    id_ordine INT NOT NULL,
    id_prodotto INT NOT NULL,
    quantita INT NOT NULL,
    prezzo_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_ordine) REFERENCES ordini(id_ordine),
    FOREIGN KEY (id_prodotto) REFERENCES prodotti(id_prodotto)
);

-- ========================================
-- INSERIMENTO DATI DI ESEMPIO
-- ========================================

-- Categorie
INSERT INTO categorie (nome_categoria, descrizione) VALUES
('Elettronica', 'Dispositivi elettronici e accessori'),
('Abbigliamento', 'Vestiti e accessori moda'),
('Casa e Cucina', 'Articoli per la casa'),
('Sport', 'Attrezzatura sportiva'),
('Libri', 'Libri fisici e digitali');

-- Prodotti
INSERT INTO prodotti (nome_prodotto, id_categoria, prezzo_unitario, stock_disponibile) VALUES
('Laptop HP', 1, 899.99, 15),
('Mouse Wireless', 1, 25.50, 150),
('Tastiera Meccanica', 1, 120.00, 80),
('Smartphone Samsung', 1, 699.00, 45),
('Cuffie Bluetooth', 1, 89.90, 200),
('Jeans Levi''s', 2, 79.99, 60),
('T-shirt Basic', 2, 19.99, 300),
('Giacca Invernale', 2, 150.00, 35),
('Set Pentole', 3, 199.99, 25),
('Frullatore', 3, 45.50, 70),
('Tappetino Yoga', 4, 29.99, 100),
('Pesi Palestra 10kg', 4, 55.00, 50),
('Il Nome della Rosa', 5, 15.50, 120),
('1984 - Orwell', 5, 12.00, 90);

-- Clienti
INSERT INTO clienti (nome, cognome, email, citta, paese, data_registrazione) VALUES
('Marco', 'Rossi', 'marco.rossi@email.it', 'Milano', 'Italia', '2023-01-15'),
('Laura', 'Bianchi', 'laura.bianchi@email.it', 'Roma', 'Italia', '2023-02-20'),
('Giuseppe', 'Verdi', 'giuseppe.verdi@email.it', 'Napoli', 'Italia', '2023-03-10'),
('Anna', 'Ferrari', 'anna.ferrari@email.it', 'Torino', 'Italia', '2023-01-25'),
('Paolo', 'Esposito', 'paolo.esposito@email.it', 'Bologna', 'Italia', '2023-04-05'),
('Francesca', 'Romano', 'francesca.romano@email.it', 'Firenze', 'Italia', '2023-02-14'),
('Andrea', 'Colombo', 'andrea.colombo@email.it', 'Venezia', 'Italia', '2023-05-20'),
('Giulia', 'Ricci', 'giulia.ricci@email.it', 'Milano', 'Italia', '2023-03-30'),
('Luca', 'Marino', 'luca.marino@email.it', 'Genova', 'Italia', '2023-01-08'),
('Sofia', 'Greco', 'sofia.greco@email.it', 'Palermo', 'Italia', '2023-06-12');

-- Ordini
INSERT INTO ordini (id_cliente, data_ordine, stato_ordine, totale_ordine) VALUES
(1, '2024-01-10', 'Completato', 925.49),
(1, '2024-03-15', 'Completato', 89.90),
(2, '2024-01-12', 'Completato', 699.00),
(2, '2024-02-20', 'Completato', 199.99),
(3, '2024-01-18', 'Completato', 79.99),
(3, '2024-04-10', 'Annullato', 0.00),
(4, '2024-02-05', 'Completato', 1019.99),
(5, '2024-02-15', 'Completato', 45.50),
(5, '2024-03-20', 'Completato', 29.99),
(6, '2024-01-22', 'Completato', 150.00),
(7, '2024-03-25', 'Completato', 15.50),
(7, '2024-05-10', 'In lavorazione', 120.00),
(8, '2024-02-28', 'Completato', 145.49),
(9, '2024-04-15', 'Completato', 899.99),
(10, '2024-05-20', 'Completato', 55.00);

-- Dettagli Ordini
INSERT INTO dettagli_ordini (id_ordine, id_prodotto, quantita, prezzo_unitario) VALUES
-- Ordine 1 (Marco Rossi)
(1, 1, 1, 899.99),  -- Laptop
(1, 2, 1, 25.50),   -- Mouse
-- Ordine 2 (Marco Rossi)
(2, 5, 1, 89.90),   -- Cuffie
-- Ordine 3 (Laura Bianchi)
(3, 4, 1, 699.00),  -- Smartphone
-- Ordine 4 (Laura Bianchi)
(4, 9, 1, 199.99),  -- Set Pentole
-- Ordine 5 (Giuseppe Verdi)
(5, 6, 1, 79.99),   -- Jeans
-- Ordine 7 (Anna Ferrari)
(7, 1, 1, 899.99),  -- Laptop
(7, 3, 1, 120.00),  -- Tastiera
-- Ordine 8 (Paolo Esposito)
(8, 10, 1, 45.50),  -- Frullatore
-- Ordine 9 (Paolo Esposito)
(9, 11, 1, 29.99),  -- Tappetino Yoga
-- Ordine 10 (Francesca Romano)
(10, 8, 1, 150.00), -- Giacca
-- Ordine 11 (Andrea Colombo)
(11, 13, 1, 15.50), -- Libro
-- Ordine 12 (Andrea Colombo - In lavorazione)
(12, 3, 1, 120.00), -- Tastiera
-- Ordine 13 (Giulia Ricci)
(13, 7, 5, 19.99),  -- 5 T-shirt
(13, 2, 2, 25.50),  -- 2 Mouse
-- Ordine 14 (Luca Marino)
(14, 1, 1, 899.99), -- Laptop
-- Ordine 15 (Sofia Greco)
(15, 12, 1, 55.00); -- Pesi

