-- Query1: Top 5 Clienti per Fatturato
-- Obiettivo: identificare i clienti più redditizi

SELECT clienti.nome, clienti.cognome, clienti.citta,
    SUM(ordini.totale_ordine) as totale_cliente,
    COUNT(ordini.id_ordine) as numero_ordini
FROM clienti
INNER JOIN ordini 
ON clienti.id_cliente = ordini.id_cliente
WHERE ordini.stato_ordine = 'Completato'
GROUP BY clienti.id_cliente, clienti.nome, clienti.cognome, clienti.citta
ORDER BY totale_cliente DESC
LIMIT 5;