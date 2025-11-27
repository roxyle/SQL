-- Query2: Prodotti mai venduti
-- Obiettivo: identificare nel catalogo i prodotti da rimuovere o da promuovere

SELECT prodotti.nome_prodotto, prodotti.prezzo_unitario, prodotti.stock_disponibile, categorie.nome_categoria
FROM prodotti
LEFT JOIN categorie 
ON prodotti.id_categoria = categorie.id_categoria
LEFT JOIN dettagli_ordini 
ON prodotti.id_prodotto = dettagli_ordini.id_prodotto
WHERE dettagli_ordini.id_dettaglio IS NULL
