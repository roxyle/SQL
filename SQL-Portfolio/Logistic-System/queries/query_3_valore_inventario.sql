-- Query3: Valore inventario
-- Obiettivo: calcolo valore immobilizzato

SELECT magazzini.nome_magazzino, magazzini.citta,
COUNT(DISTINCT inventario.id_prodotto) as prodotti_diversi,
SUM(inventario.quantita_disponibile) as quantita_totale,
SUM(inventario.quantita_disponibile * prodotti.prezzo_acquisto) as valore_acquisto,
SUM(inventario.quantita_disponibile * prodotti.prezzo_vendita) as valore_vendita
FROM inventario
INNER JOIN magazzini 
ON inventario.id_magazzino = magazzini.id_magazzino
INNER JOIN prodotti 
ON inventario.id_prodotto = prodotti.id_prodotto
GROUP BY magazzini.id_magazzino, magazzini.nome_magazzino, magazzini.citta
ORDER BY valore_vendita DESC;

