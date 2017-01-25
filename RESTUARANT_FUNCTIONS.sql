/*TO CHECK GIVEN ITEM IS AVAILABLE BASED ON CURREN*/
DELIMITER //
CREATE FUNCTION FN_IS_ITEM_AVAILABLE(ITEM VARCHAR(70))
RETURNS BOOLEAN 
BEGIN
DECLARE TEMP INT;
SELECT ID INTO TEMP  FROM FOOD_SCHEDULE WHERE CURTIME() BETWEEN FROM_TIME AND TO_TIME; 
IF EXISTS(SELECT ITEM_NAME FROM ITEM_SCHEDULES WHERE FOOD_TYPE_ID=TEMP AND ITEM_NAME=ITEM)  THEN 
RETURN 1;
ELSE 
RETURN 0;
END IF;
END //
DELIMITER; 
-- TO CHECK SEAT IS AVAILABLE OR NOT		
DELIMITER //
CREATE FUNCTION FN_IS_SEAT_AVAILABLE(SEATNUM VARCHAR(50))
RETURNS BOOLEAN 
BEGIN
IF EXISTS(SELECT SEATNO FROM SEED_SEAT WHERE SEATNO=SEATNUM AND STATUS='AVAILABLE' ) THEN
RETURN 1;
ELSE
RETURN 0;
END IF;
END//
DELIMITER; 
		
-- TO GET SESSION ID FROM FOOD SCHEDULE
DELIMITER $$
CREATE  FUNCTION FN_GET_SESSIONID()
 RETURNS INT
BEGIN
DECLARE TEMP INT ;
SELECT ID INTO TEMP  FROM FOOD_SCHEDULE WHERE CURTIME() BETWEEN FROM_TIME AND TO_TIME;
RETURN TEMP;

END $$
DELIMITER ;


-- TO CHECK MAXIMUM AMOUNT OF ORDER IS REACHED		
DELIMITER//
CREATE FUNCTION FN_CHECK_ORDERCOUNT(SEATNUM VARCHAR(80))
RETURNS INT
BEGIN
IF (SELECT COUNT(DISTINCT(ITEM)) FROM ORDER_RECORDS WHERE SEATNO=SEATNUM AND STATUS='ORDERED'OR'BILL PAID')<(SELECT MAX_ORDER FROM MAX_LIMIT WHERE ID=1) THEN
RETURN 1;
ELSE 
RETURN 0;
END IF;

END//
DELIMITER ;
		
