-- Retrieves information about customers, their orders, delivery details,
-- vehicles used for delivery, and the time of online payments, sorted by payment time in descending order.

SELECT
    Customer.Cid AS CustomerID,         
    Customer.CName AS CustomerName,     
    Orders.Order_id AS OrderID,          
    Orders.Order_city AS OrderCity,      
    Vehicle.Vid AS VehicleID,            
    Payment_online.PTime AS PaymentTime  
FROM
    Customer
JOIN
    Orders ON Customer.Cid = Orders.Cid              
JOIN
    Delivery ON Orders.Order_id = Delivery.Did         
    Vehicle ON Delivery.Vid = Vehicle.Vid             
JOIN
    Pays ON Orders.Order_id = Pays.Order_id            
JOIN
    Payment_online ON Pays.PYid = Payment_online.PYid 
ORDER BY
    Payment_online.PTime DESC;                        




-- Selects specific columns from the Orders, Contains, and Restaurant tables,
-- providing information about orders, the meals they contain, and the corresponding restaurant.

SELECT
    Orders.Order_id,       
    Contains.MName,       
    Contains.Rid,           
    Restaurant.RName          
FROM
    Orders
LEFT JOIN
    Contains ON Orders.Order_id = Contains.Order_id  
LEFT JOIN
    Restaurant ON Contains.Rid = Restaurant.Rid      
WHERE
    Orders.Cid = ?;         


-- This query inserts a new record into the Payment_online table with the given Payment ID
-- and the current date (of the order placement)

INSERT INTO 
    Payment_online (PYid, PDate) 
VALUES 
    ($paymentId, CURDATE());
