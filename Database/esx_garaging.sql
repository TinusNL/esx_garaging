ALTER TABLE `owned_vehicles` ADD `stored` TINYINT(1) NOT NULL DEFAULT '0';
ALTER TABLE `owned_vehicles` ADD `garage` INT(11) NOT NULL DEFAULT '1';

CREATE TABLE IF NOT EXISTS `owned_garages` (
	`id` INT(11) NOT NULL,
	`owner` VARCHAR(50) DEFAULT NULL
)