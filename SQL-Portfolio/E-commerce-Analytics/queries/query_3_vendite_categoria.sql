-- Query3: Analisi vendite per categoria
-- Obiettivo: identificare nel catalogo le categorie più redditizie

SELECT categorie.nome_categoria,
SUM(dettagli_ordini.quantita) as "tot_prod_venduti",
SUM(dettagli_ordini.quantita * dettagli_ordini.prezzo_unitario) as "tot_fatturato",
COUNT(DISTINCT dettagli_ordini.id_ordine) as "num_ordini"
FROM dettagli_ordini
INNER JOIN prodotti 
ON dettagli_ordini.id_prodotto = prodotti.id_prodotto
INNER JOIN categorie 
ON prodotti.id_categoria = categorie.id_categoria
INNER JOIN ordini 
ON dettagli_ordini.id_ordine = ordini.id_ordine
WHERE ordini.stato_ordine = 'Completato'
GROUP BY categorie.id_categoria, categorie.nome_categoria
ORDER BY tot_fatturato DESC;
