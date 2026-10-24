-- Clienti con saldo positivo
SELECT
    username,
    nome,
    cognome,
    saldo
FROM
    Cliente
WHERE
    saldo > 0;

-- Lista piatti che non contengono funghi presso il ristorante: “Mon Amour”
SELECT
    P.nome
FROM
    Piatto P
    JOIN Ristorante R ON P.ristorante = R.id
WHERE
    R.nome = 'Mon Amour'
    AND P.nome NOT IN (
        SELECT
            C.nome_piatto
        FROM
            ComposizionePiatto C
        WHERE
            C.ristorante = R.id
            AND C.ingrediente = 'funghi'
    );

-- Clienti nati tra 1989 e 2004
SELECT
    P.nome
FROM
    Piatto P
    JOIN Ristorante R ON P.ristorante = R.id
WHERE
    R.nome = 'Mon Amour'
    AND P.nome NOT IN (
        SELECT
            C.nome_piatto
        FROM
            ComposizionePiatto C
        WHERE
            C.ristorante = R.id
            AND C.ingrediente = 'funghi'
    );

-- Clienti nati tra 1989 e 2004
SELECT
    username,
    nome,
    cognome,
    data_nascita
FROM
    Cliente
WHERE
    data_nascita BETWEEN '1998 -01 -01' AND '2003 -12 -31';

-- Numero ordini per ristorante
SELECT
    ristorante,
    COUNT(*) AS num_ordini
FROM
    Ordine
GROUP BY
    ristorante

-- Ordini con media voto servizio più alto di 4
SELECT
    ristorante,
    AVG(voto_servizio) AS voto_medio
FROM
    Ordine
GROUP BY
    ristorante
HAVING
    AVG(voto_servizio) >= 4;

-- Clienti che hanno fatto almeno un ordine
SELECT
    username,
    nome,
    cognome
FROM
    Cliente
WHERE
    username IN (
        SELECT
            cliente
        FROM
            Ordine
    );

-- Clienti che non hanno mai effettuato ordini
SELECT
    username,
    nome,
    cognome
FROM
    Cliente
WHERE
    username NOT IN (
        SELECT
            cliente
        FROM
            Ordine
    );

-- Lista ristoranti di tipo pizzeria a Trapani
SELECT
    nome,
    via,
    numero_civico
FROM
    Ristorante
WHERE
    tipologia = 'pizzeria'
    AND cap = '91100'

-- Lista piatti in promozione dei ristoranti a Palermo
SELECT
    P.nome_piatto,
    P.sconto,
    P.periodo,
    R.nome AS nome_ristorante
FROM
    PromozionePiatto P
    JOIN Ristorante R ON P.ristorante = R.id
WHERE
    R.cap BETWEEN '90121' AND '90151'

-- Lista rider residenti a Palermo con salario più alto di 1000€
SELECT
    nome,
    cognome,
    salario,
    matricola
FROM
    Rider
WHERE
    salario > 1000
    AND cap BETWEEN '90121' AND '90151'

-- Dettagli ordini dal più recente al meno recente
SELECT
    O.id AS ordine,
    O.data_ordinazione,
    O.orario_ordinazione,
    C.username AS cliente,
    C.nome AS nome_cliente,
    C.cognome AS cognome_cliente,
    R.nome AS nome_ristorante,
    D.nome AS nome_rider,
    D.cognome AS cognome_rider
FROM
    Ordine O
    JOIN Cliente C ON O.cliente = C.username
    JOIN Ristorante R ON O.ristorante = R.id
    JOIN Rider D ON O.rider = D.matricola
ORDER BY
    O.data_ordinazione DESC;

-- Numero ordini effettuati dal cliente Mario Rossi negli ultimi tre mesi del 2025
SELECT
    COUNT(*) AS num_ordini
FROM
    Ordine o
    JOIN Cliente c ON c.username = o.cliente
WHERE
    c.nome = 'Mario'
    AND c.cognome = 'Rossi'
    AND o.data_ordinazione BETWEEN '2025 -10 -01' AND '2025 -12 -31';