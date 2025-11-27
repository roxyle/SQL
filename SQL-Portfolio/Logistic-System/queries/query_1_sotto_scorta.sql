-- Query1: Prodotti sotto scorta
-- Obiettivo: identificare i prodotti da ordinare

SELECT fornitori.nome_fornitore, prodotti.nome_prodotto, prodotti.codice_prodotto, magazzini.nome_magazzino,
inventario.quantita_disponibile, prodotti.scorta_minima,
(prodotti.scorta_minima - inventario.quantita_disponibile) as "differenza"
FROM prodotti
INNER JOIN inventario
ON prodotti.id_prodotto = inventario.id_prodotto
INNER JOIN magazzini
ON inventario.id_magazzino = magazzini.id_magazzino
INNER JOIN fornitori
ON prodotti.id_fornitore_principale = fornitori.id_fornitore
WHERE inventario.quantita_disponibile < prodotti.scorta_minima
ORDER BY differenza DESC
