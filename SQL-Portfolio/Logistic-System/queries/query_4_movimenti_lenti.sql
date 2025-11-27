-- Query4: Prodotti stazionari
-- Obiettivo: identificare i prodotti fermi da più tempo

SELECT prodotti.codice_prodotto, prodotti.nome_prodotto, categorie_prodotti.nome_categoria,
SUM(inventario.quantita_disponibile) as quantita_totale,
MAX(movimenti_magazzino.data_movimento) as data_ultimo_movimento,
DATEDIFF(CURDATE(), MAX(movimenti_magazzino.data_movimento)) as giorni_fermo
FROM prodotti
LEFT JOIN inventario 
ON prodotti.id_prodotto = inventario.id_prodotto
LEFT JOIN movimenti_magazzino 
ON prodotti.id_prodotto = movimenti_magazzino.id_prodotto
LEFT JOIN categorie_prodotti 
ON prodotti.id_categoria = categorie_prodotti.id_categoria
GROUP BY prodotti.id_prodotto, prodotti.codice_prodotto, prodotti.nome_prodotto, categorie_prodotti.nome_categoria
HAVING DATEDIFF(CURDATE(), MAX(movimenti_magazzino.data_movimento)) > 30
OR MAX(movimenti_magazzino.data_movimento) IS NULL
ORDER BY giorni_fermo DESC;
