
-- General Queries:
-- Orders placed by a specific customer
SELECT Order_id
FROM Orders O
JOIN 
Customer C ON (C.cid = O.cid)
WHERE Email = "traore.alphonse@example.com";

-- Customers who have placed more than 3 orders
SELECT Cid, COUNT(Order_id) AS OrderCount
FROM Orders
GROUP BY Cid
HAVING OrderCount > 3;

-- Customers with the most varied orders (based on different meals)
SELECT Customer.Cid, Customer.CName, COUNT(DISTINCT Meal.MName) AS UniqueMealsCount
FROM Customer
JOIN Orders ON Customer.Cid = Orders.Cid
JOIN Composed_By ON Orders.Order_id = Composed_by.Order_id
JOIN Contains ON Orders.Order_id = Contains.Order_id
JOIN Meal ON Contains.Mname = Meal.Mname
GROUP BY Customer.Cid, Customer.CName;


-- Count the number of deliveries that are yet to be delivered
SELECT COUNT(*)
FROM Delivery
WHERE Is_delivered = FALSE;


-- Delivery Personals from a specific city
SELECT PName
FROM Delivery_Personal
WHERE DPCity = 'Geel' ;




-- Customers with most varied orders
SELECT O.Cid, Cu.Email, COUNT(DISTINCT C.MName) AS DistinctMealCount
FROM Orders O
JOIN Contains C ON O.Order_id = C.Order_id
JOIN Customer Cu ON O.Cid = Cu.Cid
GROUP BY O.Cid, Cu.CName
ORDER BY DistinctMealCount DESC
LIMIT 5;



-- Percentage of cash Payment
SELECT (COUNT(Pc.PCid)/COUNT(P.Pyid))*100 AS PercentageCashPayment
FROM Payment P
JOIN Payment_cash Pc
ON PC.Pyid = P.Pyid;



--UNION QUERY:
-- Customers with a High Number of Orders
SELECT C.Cid, C.Email, COUNT(O.Order_id) AS OrderCount
FROM Customer C
JOIN Orders O ON C.Cid = O.Cid
GROUP BY C.Cid, C.Email
HAVING OrderCount > 3

UNION

-- Popular Restaurants
SELECT R.Rid AS ID, R.RName AS Restaurant_Name, COUNT(O.Order_id) AS OrderCount
FROM Restaurant R
JOIN Contains C ON R.Rid = C.Rid
JOIN Orders O ON C.Order_id = O.Order_id
GROUP BY R.Rid, R.RName
HAVING OrderCount > 3
ORDER BY OrderCount DESC;


-- UPDATE:
UPDATE Meal
SET Price = Price * 0.8
WHERE MName = "delectus";


UPDATE Customer
SET Address = "54 LOTISSEMENT CHEMS"
WHERE Email = "benjamin.dupuis@example.com";



-- DELETE:
DELETE FROM Vehicle
WHERE Vid = 3365
DELETE FROM Customer
WHERE Email = "frédérique62@example.com";



-- INSERT:
INSERT INTO Delivery_Personal (Pid, Vid, Is_fired, PName, DPCity, DP_Phone_number)
VALUES (7, 12, FALSE, 'Emma Johnson', 'Brussels' '+32 471 234 567');

INSERT INTO Restaurant (Rid, RName, RCity)
VALUES (12, 'Big Up', 'Geel');
