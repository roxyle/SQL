-- Query2: Fornitori più affidabili
-- Obiettivo: identificare i fornitori che non consegnano in ritardo

SELECT fornitori.nome_fornitore, fornitori.paese, fornitori.rating_affidabilita,
COUNT(*) as tot_ordini_consegnati,
SUM( 
    CASE 
    WHEN ordini_rifornimento.data_consegna_effettiva > ordini_rifornimento.data_consegna_prevista 
    THEN 1 
    ELSE 0 
    END
) as ordini_in_ritardo,
ROUND(
    (COUNT(*)-SUM(
        CASE
        WHEN ordini_rifornimento.data_consegna_effettiva > ordini_rifornimento.data_consegna_prevista 
        THEN 1 
        ELSE 0 
        END
    )) * 100.0 / COUNT(*), 2
) as percentuale_puntualita
FROM fornitori
INNER JOIN ordini_rifornimento 
ON fornitori.id_fornitore = ordini_rifornimento.id_fornitore
WHERE ordini_rifornimento.stato_ordine = 'Consegnato'
GROUP BY fornitori.id_fornitore, fornitori.nome_fornitore, fornitori.paese, fornitori.rating_affidabilita
ORDER BY percentuale_puntualita DESC;
