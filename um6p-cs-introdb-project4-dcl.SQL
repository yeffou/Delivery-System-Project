USE DeliverySystem;

-- Restaurant USERS (The Manager We Can Say)
CREATE USER 'et'@'localhost' IDENTIFIED BY 'password1';
CREATE USER 'corrupti'@'localhost' IDENTIFIED BY 'password2';
CREATE USER 'sed'@'localhost' IDENTIFIED BY 'password3';
CREATE USER 'qui'@'localhost' IDENTIFIED BY 'password4';
CREATE USER 'itaque'@'localhost' IDENTIFIED BY 'password5';
CREATE USER 'ex'@'localhost' IDENTIFIED BY 'password6';
CREATE USER 'molestias'@'localhost' IDENTIFIED BY 'password7';
CREATE USER 'eos'@'localhost' IDENTIFIED BY 'password8';
CREATE USER 'quasi'@'localhost' IDENTIFIED BY 'password9';
CREATE USER 'velit'@'localhost' IDENTIFIED BY 'password10';

-- Customer USERS    
CREATE USER 'Renée'@'localhost' IDENTIFIED BY 'password11';
CREATE USER 'Antoinette'@'localhost' IDENTIFIED BY 'password12';
CREATE USER 'Édith'@'localhost' IDENTIFIED BY 'password13';
CREATE USER 'Emmanuelle'@'localhost' IDENTIFIED BY 'password14';
CREATE USER 'Louise'@'localhost' IDENTIFIED BY 'password15';

-- Delivery Personal USERS
CREATE USER 'Jarne'@'localhost' IDENTIFIED BY 'password16';
CREATE USER 'Jasper'@'localhost' IDENTIFIED BY 'password17';
CREATE USER 'Arthur'@'localhost' IDENTIFIED BY 'password18';
CREATE USER 'Simon'@'localhost' IDENTIFIED BY 'password19';
CREATE USER 'Samuel'@'localhost' IDENTIFIED BY 'password20';


-- Give The Delivery Personal The Privilege To Update The Delevery To Already Delivered And To Select Deliveries For Each Customer
CREATE VIEW restricted_Delivery1 AS
SELECT * FROM Delivery where Vid =' 52972';
GRANT SELECT,UPDATE ON DeliverySystem.restricted_Delivery1 TO 'Jarne'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_Delivery2 AS
SELECT * FROM Delivery where Vid ='81601';
GRANT SELECT,UPDATE ON DeliverySystem.restricted_Delivery2 TO 'Jasper'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_Delivery3 AS
SELECT * FROM Delivery where Vid ='83358';
GRANT SELECT,UPDATE ON DeliverySystem.restricted_Delivery3 TO 'Arthur'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_Delivery4 AS
SELECT * FROM Delivery where Vid ='22189';
GRANT SELECT,UPDATE ON DeliverySystem.restricted_Delivery4 TO 'Simon'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_Delivery AS
SELECT * FROM Delivery where Vid ='14317';
GRANT SELECT,UPDATE ON DeliverySystem.restricted_Delivery4 TO 'Samuel'@'localhost' ;
FLUSH PRIVILEGES;


-- Give Each Restaurant The Privilege To Make Changes In Their Meals To Boost Their Business 
CREATE VIEW restricted_meal1 AS
SELECT MName,Price FROM Meal where Rid ='59524';
GRANT ALL PRIVILEGES ON DeliverySystem.restricted_meal1 TO 'et'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_meal2 AS
SELECT MName,Price FROM Meal where Rid ='59524';
GRANT ALL PRIVILEGES ON DeliverySystem.restricted_meal2 TO 'corrupti'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_meal3 AS
SELECT MName,Price FROM Meal where Rid ='59362';
GRANT ALL PRIVILEGES ON DeliverySystem.restricted_meal3 TO 'sed'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_meal4 AS
SELECT MName,Price FROM Meal where Rid ='59365';
GRANT ALL PRIVILEGES ON DeliverySystem.restricted_meal4 TO 'qui'@'localhost';
FLUSH PRIVILEGES;

CREATE VIEW restricted_meal5 AS
SELECT MName,Price FROM Meal where Rid = '59414';
GRANT ALL PRIVILEGES ON DeliverySystem.restricted_meal5 TO 'itaque'@'localhost';
FLUSH PRIVILEGES;

CREATE VIEW restricted_meal6 AS
SELECT MName,Price FROM Meal where Rid = '59419';
GRANT ALL PRIVILEGES ON DeliverySystem.restricted_meal6 TO 'ex'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_meal7 AS
SELECT MName,Price FROM Meal where Rid ='59426';
GRANT ALL PRIVILEGES ON DeliverySystem.restricted_meal7 TO 'molestias'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_meal8 AS
SELECT MName,Price FROM Meal where Rid ='59447';
GRANT ALL PRIVILEGES ON DeliverySystem.restricted_meal8 TO 'eos'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_meal9 AS
SELECT MName,Price FROM Meal where Rid ='59466';
GRANT ALL PRIVILEGES ON DeliverySystem.restricted_meal9 TO 'quasi'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_meal10 AS
SELECT MName,Price FROM Meal where Rid ='59516';
GRANT ALL PRIVILEGES ON DeliverySystem.restricted_meal10 TO 'velit'@'localhost' ;
FLUSH PRIVILEGES;


-- Give Each Customer The Privilege To Track The History Of Their Orders
CREATE VIEW restricted_order1 AS
SELECT * FROM Orders where Cid ='147304';
GRANT SELECT ON DeliverySystem.restricted_order1 TO 'Renée'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_order2 AS
SELECT * FROM Orders where Cid ='424386';
GRANT SELECT ON DeliverySystem.restricted_order2 TO 'Antoinette'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_order3 AS
SELECT * FROM Orders where Cid ='1416764';
GRANT SELECT ON DeliverySystem.restricted_order3 TO 'Édith'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_order4 AS
SELECT * FROM Orders where Cid ='1867787';
GRANT SELECT ON DeliverySystem.restricted_order4 TO 'Emmanuelle'@'localhost' ;
FLUSH PRIVILEGES;

CREATE VIEW restricted_order5 AS
SELECT * FROM Orders where Cid ='2236374';
GRANT SELECT ON DeliverySystem.restricted_order5 TO 'Louise'@'localhost' ;
FLUSH PRIVILEGES;
