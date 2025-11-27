-- Query4: Performance mensile
-- Obiettivo: identificare trend stagionali di vendita

SELECT MONTHNAME(ordini.data_ordine) as mese,
COUNT(DISTINCT ordini.id_ordine) as "num_ordini",
COUNT(DISTINCT ordini.id_cliente) as "clienti_unici",
SUM(dettagli_ordini.quantita * dettagli_ordini.prezzo_unitario) as "tot_fatturato"
FROM ordini
INNER JOIN dettagli_ordini 
ON ordini.id_ordine = dettagli_ordini.id_ordine
WHERE YEAR(ordini.data_ordine) = 2024 
AND ordini.stato_ordine = 'Completato'
GROUP BY MONTH(ordini.data_ordine), MONTHNAME(ordini.data_ordine)
ORDER BY MONTH(ordini.data_ordine) DESC
