DROP DATABASE `shopDB`;

CREATE DATABASE `shopDB`;

USE `shopDB`;


DROP TABLE `Users`;

CREATE TABLE `Users` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`age` int(10) unsigned NOT NULL,
	`username` varchar(20) NOT NULL,
	`email` varchar(20) UNIQUE NOT NULL,
	`password` varchar(20) NOT NULL,
	`type` varchar(10) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;


DROP TABLE `Vendor_list`;

CREATE TABLE `Vendor_list` AS
SELECT u.`username`,u.`email` FROM Users u
WHERE u.`type`='vendor';

ALTER TABLE `Vendor_list`
ADD PRIMARY KEY (`email`);

ALTER TABLE `Vendor_list`
CONVERT TO CHARACTER SET utf8mb4;


DROP TABLE `Products`;

CREATE TABLE `Products` (
	`pid` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`quantity` int(10) unsigned NOT NULL,
	`productname` varchar(20) NOT NULL,
	`description` varchar(50) NOT NULL,
	`price` int(10) unsigned NOT NULL,
	`vendor` varchar(20) NOT NULL,
	`category` varchar(10) NOT NULL,
	PRIMARY KEY (`pid`),
	FOREIGN KEY (`vendor`) REFERENCES `Vendor_list`(`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

ALTER TABLE `Products` ADD UNIQUE `unique_products`(`productname`, `vendor`);

DROP TABLE `Cart`;

CREATE TABLE `Cart` (
	`cartid` int(10) unsigned NOT NULL,
	`productid` int(10) unsigned NOT NULL,
	`quantity` int(10) unsigned NOT NULL,
	FOREIGN KEY (`cartid`) REFERENCES `Users`(`id`),
	FOREIGN KEY (`productid`) REFERENCES `Products`(`pid`)
) ENGINE=InnoDB CHARSET=utf8mb4;


DROP TRIGGER `vendor_add`;
DELIMITER #

CREATE TRIGGER `vendor_add`
AFTER INSERT ON `Users`
FOR EACH ROW
BEGIN
	IF (NEW.type = 'vendor') THEN
		INSERT INTO `Vendor_list` (`email`, `username`)
		VALUES (NEW.`email`, NEW.`username`);
	END IF;
END#

DELIMITER ;


DROP TRIGGER `vendor_update`;
DELIMITER #

CREATE TRIGGER `vendor_update`
AFTER UPDATE ON `Users`
FOR EACH ROW
BEGIN
	IF (NEW.type = 'vendor') THEN
		IF (NEW.`email` <> OLD.`email`) THEN
			INSERT INTO `Vendor_list` (`email`, `username`)
			VALUES (NEW.`email`, NEW.`username`);
			
			UPDATE `Products` item
			SET item.`vendor` = NEW.`email`
			WHERE item.`vendor` = OLD.`email`;
			
			DELETE FROM `Vendor_list`
			WHERE `email`=OLD.email;
			
		ELSEIF (NEW.`username` <> OLD.`username`) THEN  
			UPDATE `Vendor_list` list
			SET list.`username` = NEW.`username`
			WHERE list.`username` = OLD.`username`;
		END IF;
	END IF;
END#

DELIMITER ;


DROP TRIGGER `vendor_delete`;
DELIMITER #

CREATE TRIGGER `vendor_delete`
BEFORE DELETE ON `Users`
FOR EACH ROW
BEGIN
	DELETE FROM `Cart`
	WHERE `cartid`=OLD.id;
		IF (OLD.type = 'vendor') THEN
			DELETE FROM `Products`
			WHERE `vendor`=OLD.email;
			
			DELETE FROM `Vendor_list`
			WHERE `email`=OLD.email;
		END IF;
END#

DELIMITER ;


DROP TRIGGER `product_delete`;
DELIMITER #

CREATE TRIGGER `product_delete`
BEFORE DELETE ON `Products`
FOR EACH ROW
BEGIN
	DELETE FROM `Cart`
	WHERE `productid`=OLD.pid;
END#

DELIMITER ;
;