-- Justification: Ensuring consistent and accurate data when placing an order is crucial in a restaurant delivery system.
-- Using REPEATABLE READ to prevent non-repeatable reads and maintain data integrity during the transaction.
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

DELIMITER //

CREATE PROCEDURE AddOrderAtRestaurant(
    IN orderID INT,
    IN customerID INT,
    IN restaurantID INT,
    IN totalAmount DECIMAL(10,2),
    IN orderStatus BOOLEAN,
    IN mealID VARCHAR(20) 
)
BEGIN
    DECLARE customerExists INT;
    DECLARE restaurantExists INT;
    DECLARE mealValid INT;

    -- Check if the customer exists
    SELECT COUNT(*) INTO customerExists
    FROM Customer
    WHERE Cid = customerID;

    -- Check if the restaurant exists
    SELECT COUNT(*) INTO restaurantExists
    FROM Restaurant
    WHERE Rid = restaurantID;

    -- Check if the mealID provided is valid for the restaurant
    SELECT COUNT(*) INTO mealValid
    FROM Meal
    WHERE Rid = restaurantID AND MName = mealID;

    START TRANSACTION;

    IF customerExists = 1 AND restaurantExists = 1 AND mealValid = 1 THEN
        -- Insert the order details
        INSERT INTO Orders (Order_id, Cid, Total_amount, Order_status, Order_city)
        VALUES (orderID, customerID, totalAmount, orderStatus, (SELECT RCity FROM Restaurant WHERE Rid = restaurantID));

        -- Associate the meal with the order in the Contains table
        INSERT INTO Contains (Order_id, Rid, MName)
        VALUES (orderID, restaurantID, mealID);

    ELSE
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid customer, restaurant, or meal ID';
    END IF;

    COMMIT;
    
END //

DELIMITER ;
