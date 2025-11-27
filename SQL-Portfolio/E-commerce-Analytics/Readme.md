# Progetto SQL per portfolio: e-commerce analytics

## Descrizione
Progetto di analisi dati per un'azienda e-commerce fittizia. 
L'obiettivo è rispondere a domande business attraverso query SQL su un database relazionale con 5 tabelle contenenti informazioni su clienti, prodotti, ordini e vendite.

Analisi richieste:
- performance dei clienti per identificare i più redditizi
- quali sono i prodotti rimasti invenduti da rimuovere dal catalogo
- quali sono le categorie di prodotto più performanti su cui investire
- chi sono i clienti inattivi da invogliare con campagne marketing
- trovare trend di vendita mensili per identificarne la stagionalità

## Struttura Database

Il database si chiama `ecommerce_analytics` e contiene 5 tabelle principali:

![relazione tabelle](designer.png)

- **clienti**: informazioni anagrafiche e data di registrazione dell'account
  ![tabella clienti](clienti.png)
- **prodotti**: catalogo prodotti con prezzi e categoria
  ![tabella prodotti](prodotti.png)
- **categorie**: categorie dei prodotti presenti in catalogo
  ![tabella categorie](categorie.png)
- **ordini**: ordini effettuati dai clienti, con stato dell'ordine (completato, annullato, ecc) e prezzo totale
  ![tabella ordini](ordini.png)
- **dettagli_ordini**: dettagli aggiuntivi sui prodotti acquistati in ogni singolo ordine (quantità e prezzo)
  ![tabella dettaglio ordini](dettaglio.png)

## Tecnologie Utilizzate
**Database:** MySQL, **Tool:** MAMP, phpMyAdmin, **Linguaggio:** SQL

## File del Progetto
- `database_setup.sql` script di creazione database e inserimento dei dati
- `query_1_top_clienti.sql` query top 5 clienti
- `query_2_prodotti_invenduti.sql` query prodotti mai venduti
- `query_3_vendite_categoria.sql` query analisi categorie
- `query_4_clienti_inattivi.sql` query clienti senza ordini
- `query_5_performance_mensile.sql` query trend mensili
- `README.md` documentazione progetto

## Come Utilizzare
1. Importare `database_setup.sql` in MySQL/phpMyAdmin
2. Eseguire le query presenti nella cartella `queries/`
3. Analizzare i risultati

## Query Implementate

### 1. Top 5 clienti per fatturato
**Obiettivo:** identificare i clienti più redditizi 
Serviranno: anagrafica del cliente (nome, cognome, città), il totale che ha speso (somma di tutti gli ordini) e il numero di ordini da lui effettuati.
Consideriamo solo ordini effettivamente completati (escludendo "Annullato" e "In lavorazione").
Utilizzerò: INNER JOIN, aggregazioni (SUM, COUNT), WHERE, GROUP BY, ORDER BY con LIMIT a 5, filtri su stato ordine

**Risultato:** 5 migliori clienti con totale speso e numero ordini
![risultato query 1](query1.png)

---

### 2. Prodotti mai venduti
**Obiettivo:** identificare prodotti a catalogo che non generano vendite per considerare promozione o rimozione
Serviranno: nome del prodotto, la sua categoria d'appartenenza, il suo prezzo unitario e lo stock disponibile
Bisogna trovare i prodotti dove id_dettaglio è NULL (cioè non presenti in dettagli_ordini)
Utilizzerò: LEFT JOIN, filtro con IS NULL, JOIN tra 3 tabelle, gestione di relazioni molti-a-molti

**Risultato:** un prodotto mai venduto ("1984 - Orwell", categoria Libri)
![risultato query 2](query2.png)

---

### 3. Analisi vendite per categoria
**Obiettivo:** identificare le categorie più redditizie per investimenti mirati
Serviranno: nome categoria, quantità tot di prodotti venduti, fatturato generale, numero di ordini distinti che hanno al loro interno prodotti di quella categoria
Come per la query1, consideriamo solo ordini effettivamente completati (escludendo "Annullato" e "In lavorazione").
Utilizzerò: JOIN concatenati, calcoli (quantità × prezzo unitario), aggregazioni multiple (SUM, COUNT DISTINCT), GROUP BY su categorie, filtri su ordini completati

**Risultato:** elettronica è la categoria più redditizia (3685€), seguita da Abbigliamento (330€)
![risultato query 3](query3.png)

---

### 4. Clienti inattivi
**Obiettivo:** trovare clienti che si sono registrati ma che non hanno completato ordini per invogliarli con promozioni mirate 
Serviranno: nome e cognome del cliente, email su cui inviare le promozioni, data di registrazione, giorni trascorsi dalla registrazione
Utilizzerò: subquery con NOT IN, calcoli con date (DATEDIFF), logica negativa (trovare assenze), ragionamento su "dati mancanti"

**Risultato:** 3 clienti inattivi identificati
![risultato query 4](query4.png)

---

### 5. Performance mensile 2024
**Obiettivo:** analizzare i trend stagionali e le performance mensili
Serviranno: nome del mese, numero di ordini completati e fatturato totale in tale mese, numero di clienti unici che hanno acquistato in quel periodo.
Utilizzerò: funzioni su date (YEAR, MONTH, MONTHNAME), aggregazioni temporali, COUNT DISTINCT per clienti unici, JOIN per calcolare fatturato da dettagli, GROUP BY su periodi temporali

**Risultato:** gennaio è il mese più forte, mentre c'è un calo significativo da marzo a maggio
![risultato query 5](query5.png)

---


## Note
Progetto realizzato come portfolio per dimostrare competenze SQL e capacità di analisi dati.
I dati utilizzati all'interno delle tabelle (come nomi, cognomi, ordini effettuati, ecc) sono fittizi, generati tramite AI per rappresentare scenari business realistici. 
Le query che ho creato le ho ottimizzate per leggibilità e manutenibilità.