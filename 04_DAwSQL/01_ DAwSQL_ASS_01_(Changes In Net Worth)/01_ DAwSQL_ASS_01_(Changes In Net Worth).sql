USE TransactionLogs;
GO

CREATE TABLE transactions 
(Sender_ID INT NOT NULL,
Receiver_ID INT NOT NULL,
Amount INT NOT NULL,
Transaction_Date DATE NOT NULL,
);

INSERT INTO transactions (Sender_ID, Receiver_ID, Amount, Transaction_Date)
VALUES (55, 22, 500, '2021-05-18'),
	   (11, 33, 350, '2021-05-19'),
       (22, 11, 650, '2021-05-19'),
	   (22, 33, 900, '2021-05-20'),
	   (33, 11, 500, '2021-05-21'),
	   (33, 22, 750, '2021-05-21'),
	   (11, 44, 300, '2021-05-22');

SELECT *
FROM transactions

-- SUM amounts for each sender (debits) and receiver (credits)

SELECT Sender_ID, SUM(amount) AS debited
INTO debits
FROM transactions
GROUP BY Sender_ID

SELECT Receiver_ID, SUM(amount) AS credited
INTO credits
FROM transactions
GROUP BY Receiver_ID

-- FULL (OUTER) JOIN debits and credits tables on user id,
-- Taking net change as difference between credits and debits,
-- Coercing nulls to zeros with coalesce()

SELECT COALESCE(Sender_ID, Receiver_ID) AS "user", 
COALESCE(credited, 0) - COALESCE(debited, 0) AS net_change 
FROM debits d
FULL OUTER JOIN credits c
ON d.Sender_ID = c.Receiver_ID
ORDER BY 2 DESC