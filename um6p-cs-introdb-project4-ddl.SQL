DROP DATABASE IF EXISTS DeliverySystem;
CREATE DATABASE DeliverySystem;
USE DeliverySystem;

CREATE TABLE Vehicle(
    Vid INTEGER,
    Max_meals INTEGER CHECK (Max_meals > 0),
    Speed REAL CHECK (Speed >= 0),
    Is_working BOOLEAN,
    PRIMARY KEY (Vid)
);

CREATE TABLE Delivery_Personal(
    Pid INTEGER,
    Vid INTEGER,
    Is_fired BOOLEAN,
    PName VARCHAR(200),
    DPCity VARCHAR(200),
    DP_Phone_number VARCHAR(200) CHECK(DP_Phone_number REGEXP '^[0-9]{10}$'),
    PRIMARY KEY (Pid),
    FOREIGN KEY (Vid) REFERENCES Vehicle(Vid),
    UNIQUE (Vid)
);

CREATE TABLE Delivery(
    Did INTEGER,
    Vid INTEGER,
    DDate Date,
    DTIME TIME,
    Is_delivered BOOLEAN,
    PRIMARY KEY (Did),
    FOREIGN KEY (Vid) REFERENCES Vehicle(Vid)
);

CREATE TABLE Customer(
    Cid INTEGER,
    CName VARCHAR(200),
    Adress VARCHAR(200),
    Email VARCHAR(200),
    Pass_word VARCHAR(200),
    Phone_Number VARCHAR(200) CHECK(Phone_number REGEXP '^[0-9]{10}$'),
    PRIMARY KEY (Cid),
    UNIQUE(Email)
);

CREATE TABLE Orders(
    Order_id INTEGER,
    Cid INTEGER,
    Order_city VARCHAR(200),
    PRIMARY KEY (Order_id),
    FOREIGN KEY (Cid) REFERENCES Customer(Cid)
    ON DELETE CASCADE
);

CREATE TABLE Composed_by(
    Did INTEGER,
    Order_Id INTEGER,
    PRIMARY KEY (Did,Order_Id),
    FOREIGN KEY (Did) REFERENCES Delivery(Did),
    FOREIGN KEY (Order_Id) REFERENCES Orders(Order_Id)
);

CREATE TABLE Restaurant(
    Rid INTEGER,
    RName VARCHAR(200),
    RCity VARCHAR(200),
    PRIMARY KEY (Rid)
);

CREATE TABLE Meal(
    Rid INTEGER,
    MName VARCHAR(200),
    Price REAL CHECK (Price > 0),
    PRIMARY KEY (MName,Rid),
    FOREIGN KEY (Rid) REFERENCES Restaurant(Rid)
    ON DELETE CASCADE
);

CREATE TABLE Contains(
    Order_id INTEGER,
    Rid INTEGER,
    MName VARCHAR(200),
    PRIMARY KEY (Order_id,Rid,MName),
    FOREIGN KEY (Rid) REFERENCES Meal(Rid),
    FOREIGN KEY (MName) REFERENCES Meal(MName),
    FOREIGN KEY (Order_id) REFERENCES Orders(Order_id)
);

CREATE TABLE Payment(
    PYid INTEGER,
    PDate DATE,
    PRIMARY KEY (PYid)
);

CREATE TABLE Pays(
    Order_id INTEGER,
    Pyid INTEGER,
    PRIMARY KEY (Order_id , Pyid),
    FOREIGN KEY (Order_id) REFERENCES Orders(Order_id),
    FOREIGN KEY (Pyid) REFERENCES Payment(Pyid)
);

CREATE TABLE Payment_online(
    POid INTEGER,
    POPrice REAL,
    PYid INTEGER,
    PTime TIME,
    Credit_card INTEGER,
    PRIMARY KEY (POid),
    FOREIGN KEY (PYid) REFERENCES Payment(PYid),
    UNIQUE (Credit_card,PTime)
);

CREATE TABLE Payment_cash(
    PCid INTEGER,
    PCPrice REAL,
    PYid INTEGER,
    Budget REAL,
    Pid INTEGER,
    PRIMARY KEY (PCid),
    FOREIGN KEY (PYid) REFERENCES Payment(PYid)
);

-- Useful for login operations or searching for a customer by email
CREATE INDEX idx_Email ON Customer(Email);
-- Facilitates quick retrieval of delivery personnel details based on the vehicle they use
CREATE INDEX idx_Vid ON Delivery_Personal(Vid);
-- Useful for operations like retrieving orders for a specific customer (And for Joins)
CREATE INDEX idx_Combine_CID_OID ON Orders(Order_id,Cid);
-- Enables efficient retrieval of restaurant details when searching by name (Most of the real Case)
CREATE INDEX idx_Restaurant_Name ON Restaurant(RName);
-- Useful for operations such as fetching meals offered by a specific restaurant (Joins in Queries)
CREATE INDEX idx_Combine_Rid_MName ON Meal(Rid, MName);



-- Create a trigger to update the Vid column in Delivery_Personal after an update
-- This trigger ensures that if a delivery person is fired and has an associated vehicle, 
-- the vehicle is assigned to another delivery person if available
DELIMITER //
CREATE TRIGGER update_delivery_personal
AFTER UPDATE ON Delivery_Personal
FOR EACH ROW
BEGIN
    IF NEW.Is_fired = TRUE AND NEW.Vid IS NOT NULL THEN
        UPDATE Delivery_Personal
        SET Vid = (
            SELECT Vid
            FROM Delivery_Personal
            WHERE Is_fired = TRUE AND Vid IS NOT NULL
            LIMIT 1
        )
        WHERE Is_fired = FALSE AND Vid IS NULL;

        UPDATE Delivery_Personal
        SET Vid = NULL
        WHERE Is_fired = TRUE AND Vid IS NOT NULL;
    END IF;
END;
//


-- Create a trigger to check the delivery date before insertion
-- This trigger ensures that the delivery date is not in the future
DELIMITER //
CREATE TRIGGER Check_Delivery_date_trigger
BEFORE INSERT ON Delivery
FOR EACH ROW
BEGIN
    IF NEW.DDate > CURRENT_DATE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'INVALID DATE';
    END IF;
END;
//


-- Create a trigger to check the payment date before insertion
-- This trigger ensures that the payment date is not in the future
DELIMITER //
CREATE TRIGGER Check_Payment_date_trigger
BEFORE INSERT ON Payment
FOR EACH ROW
BEGIN
    IF NEW.PDate > CURRENT_DATE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'INVALID DATE';
    END IF;
END;
//


-- Create a trigger to handle the business logic when a vehicle is shut down
-- This trigger reassigns deliveries from the shut down vehicle to another available vehicle if a driver is assigned
DELIMITER //
CREATE TRIGGER Vehicle_Shut_down
AFTER UPDATE ON Vehicle
FOR EACH ROW
BEGIN
DECLARE Driver INT;
    DECLARE Available_Vehicle INT;
    IF NEW.Is_working = FALSE and OLD.Is_working = TRUE THEN
        SELECT Pid into Driver FROM Delivery_Personal WHERE Vid = NEW.Vid;
        IF Driver IS NOT NULL THEN
            SELECT Vid into Available_Vehicle From Vehicle WHERE Is_working = TRUE LIMIT 1;
            IF Available_Vehicle IS NOT NULL THEN
                UPDATE Delivery
                SET Vid = Available_Vehicle
                WHERE Vid = NEW.Vid AND is_delivered = FALSE;
            END IF;
        END IF;
    END IF;
END;
//