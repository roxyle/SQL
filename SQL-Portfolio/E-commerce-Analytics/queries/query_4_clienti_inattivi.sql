-- Query4: Clienti inattivi
-- Obiettivo: identificare i clienti registrati che non hanno ancora completato un ordine

SELECT clienti.nome, clienti.cognome, clienti.email, clienti.data_registrazione,
DATEDIFF(CURDATE(), clienti.data_registrazione) as "giorni_inattivi"
FROM clienti 
WHERE clienti.id_cliente 
NOT IN (
    SELECT DISTINCT ordini.id_cliente 
    FROM ordini 
    WHERE ordini.stato_ordine = 'Completato'
);
