

DELIMITER //
CREATE TRIGGER BeforeInsertIndentityNumber
AFTER INSERT
ON employee FOR EACH ROW
BEGIN
IF (new.identity_number  RLIKE'00$')
THEN SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'CHECK Error for insert';
END IF;
END//


DELIMITER ;