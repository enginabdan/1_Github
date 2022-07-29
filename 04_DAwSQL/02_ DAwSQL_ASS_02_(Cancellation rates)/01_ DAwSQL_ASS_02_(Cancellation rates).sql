USE CancellationRates
GO

CREATE TABLE users (User_id INT NOT NULL,Action TEXT NOT NULL,date DATE NOT NULL,);

SELECT*
FROM users;

INSERT INTO CancellationRates.dbo.users (User_id, Action, date) 
VALUES 
(1,'start', CAST('1-1-20' AS date)), 
(1,'cancel', CAST('1-2-20' AS date)), 
(2,'start', CAST('1-3-20' AS date)), 
(2,'publish', CAST('1-4-20' AS date)), 
(3,'start', CAST('1-5-20' AS date)), 
(3,'cancel', CAST('1-6-20' AS date)), 
(1,'start', CAST('1-7-20' AS date)), 
(1,'publish', CAST('1-8-20' AS date))

SELECT*
FROM users;

SELECT User_id,
sum(CASE WHEN Action like 'start' THEN 1 ELSE 0 END) as starts,
sum(CASE WHEN Action like 'cancel' THEN 1 ELSE 0 END) as cancels, 
sum(CASE WHEN Action like 'publish' THEN 1 ELSE 0 END) as publishes
INTO rates
FROM users
GROUP BY User_id

select*
from rates

SELECT  User_id,
		CAST(publishes AS FLOAT)/CAST(starts AS FLOAT) AS Publish_rate,
		CAST(cancels AS FLOAT)/CAST(starts AS FLOAT) AS Cancel_rate 
FROM rates
ORDER BY User_id ASC
---------------------------------------------------------------------------------------

			--- METHOD 2 --- WITH USING 'CAST' AS DECIMAL ---

SELECT  User_id,
		CAST(publishes AS DECIMAL (2,1))/CAST(starts AS DECIMAL (2,1)) AS Publish_rate,
		CAST(cancels AS DECIMAL (2,1))/CAST(starts AS DECIMAL (2,1)) AS Cancel_rate 
FROM rates
ORDER BY User_id ASC

---------------------------------------------------------------------------------------

			--- METHOD 3 --- WITH USING 'CONVERT', 'CAST AS NUMERIC' & 'ROUND' ---

SELECT *
FROM rates

SELECT  User_id,
		CONVERT(NUMERIC(5,1), starts) AS Starts,
		CONVERT(NUMERIC(5,1), cancels) AS Cancels,
		CONVERT(NUMERIC(5,1), publishes) AS Publishes
INTO total
FROM rates

SELECT *
FROM total

SELECT User_id, publishes/starts AS Publish_rate, cancels/starts AS Cancel_rate
FROM total

SELECT User_id, 
	   CAST(ROUND(publishes/starts, 1) AS NUMERIC(36,1)) AS Publish_rate,
	   CAST(ROUND(cancels/starts, 1) AS NUMERIC(36,1)) AS Cancel_rate
FROM total

---------------------------------------------------------------------------------------

			--- METHOD 4 --- WITH USING 'CAST' & 'AS DECIMAL' ---

SELECT  User_id,
		CAST(publishes AS decimal (2,1))/CAST(starts AS decimal (2,1)) AS Publish_rate,
		CAST(cancels AS decimal (2,1))/CAST(starts AS decimal (2,1)) AS Cancel_rate 
FROM rates
ORDER BY User_id ASC
---------------------------------------------------------------------------------------

			--- METHOD 5 --- WITH MULTIPLYING BY 1.0 ---

SELECT User_id, 1.0*publishes/starts AS Publish_rate, 1.0*cancels/starts AS Cancel_rate
FROM rates

----------------------------------------------------------------------------------------

			--- METHOD 6 --- WITH USING 'FORMAT' ---

SELECT User_id, 
	   FORMAT(publishes/starts, '0.0') AS Publish_rate,
	   FORMAT(cancels/starts, '0.0') AS Cancel_rate
FROM total

---OR---

SELECT User_id, 
	   FORMAT(publishes/starts, 'N1') AS Publish_rate,
	   FORMAT(cancels/starts, 'N1') AS Cancel_rate
FROM total