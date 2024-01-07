-- Update the Is_delivered column to TRUE for the specified delivery_id
-- This stored procedure is intended to be called by the delivery person
-- after successfully delivering an order, indicating that the delivery is completed.

USE Deliverysystem;

DELIMITER //

CREATE PROCEDURE Update_Delivery_Status(IN delivery_id INT)
BEGIN

    UPDATE Delivery
    SET Is_delivered = TRUE
    WHERE Did = delivery_id;
END;

//
DELIMITER ;
