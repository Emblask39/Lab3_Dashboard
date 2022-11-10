DROP DATABASE IF EXISTS lab3;
CREATE DATABASE IF NOT EXISTS lab3;
USE lab3;

DROP TABLE IF EXISTS `crashes`;
CREATE TABLE IF NOT EXISTS `crashes`(
	`date_crash`			DATE DEFAULT NULL,
    `time_crash`			VARCHAR(50) DEFAULT NULL,
    `location`				VARCHAR(100) DEFAULT NULL,
    `Operator`				VARCHAR(100) DEFAULT NULL,
    `flight_no`				VARCHAR(50) DEFAULT NULL,
    `route`					VARCHAR(100) DEFAULT NULL,
    `ac_type`				VARCHAR(50) DEFAULT NULL,
	`registration`			VARCHAR(50) DEFAULT NULL,
	`cn_ln`					VARCHAR(50) DEFAULT NULL,
	`all_aboard`			INT DEFAULT NULL,
	`passengers`			INT DEFAULT NULL,
    `crew`					INT DEFAULT NULL,
    `fatalities`			INT DEFAULT NULL,
    `passenger_fatalities`	INT DEFAULT NULL,
    `crew_fatalities`		INT DEFAULT NULL,
    `ground_fatalities`		INT DEFAULT NULL,
    `summary`				VARCHAR(3000) DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

LOAD DATA INFILE 'D:\\Henry\\Repos\\Labs PI\\PI03-Analytics-main\\PI03-Analytics-main\\TransformedCSV\\crashes.csv'
INTO TABLE `crashes` 
FIELDS TERMINATED BY ',' ENCLOSED BY'"' ESCAPED BY '' 
LINES TERMINATED BY '\r\n' IGNORE 1 LINES
(@vdate_crash, @vtime_crash, @vlocation, @vOperator, @vflight_no, @vroute, @vac_type, @vregistration, @vcn_ln, @vall_aboard, @vpassengers, @vcrew, @vfatalities, @vpassenger_fatalities, @Vcrew_fatalities, @vground_fatalities, @vsummary)
	SET date_crash = 			NULLIF(@vdate_crash,""),
		Passengers = 			NULLIF(@vpassengers,""),
        crew = 		 			NULLIF(@vcrew, ""),
        passenger_fatalities = 	NULLIF(@vpassenger_fatalities, ""),
        crew_fatalities = 		NULLIF(@vcrew_fatalities, ""),
		all_aboard = 			NULLIF(@vall_aboard, ""),
        fatalities = 			NULLIF(@vfatalities, ""),
		time_crash = 			NULLIF(@vtime_crash, ""),
        location = 				NULLIF(@vlocation, ""),
        Operator = 				NULLIF(@vOperator, ""),
        flight_no = 			NULLIF(@vflight_no, ""),
        route = 				NULLIF(@vroute, ""),
        ac_type = 				NULLIF(@vac_type,""),
        registration = 			NULLIF(@vregistration, ""),
        cn_ln = 				NULLIF(@vcn_ln, ""),
        ground_fatalities = 	NULLIF(@vground_fatalities, ""),
        summary = 				NULLIF(@vsummary, "");

select * from crashes;

DROP TABLE IF EXISTS `airlines`; 
CREATE TABLE IF NOT EXISTS `airlines`(
	`airline_name`					VARCHAR(50) DEFAULT NULL,
    `IATA`					VARCHAR(50) DEFAULT NULL,
    `ICAO`					VARCHAR(50) DEFAULT NULL,
    `callsign`				VARCHAR(50) DEFAULT NULL,
    `country`				VARCHAR(50) DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
    
LOAD DATA INFILE 'D:\\Henry\\Repos\\Labs PI\\PI03-Analytics-main\\PI03-Analytics-main\\TransformedCSV\\airlines.csv'
INTO TABLE `airlines` 
FIELDS TERMINATED BY ',' ENCLOSED BY'"' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES
(@vairline_name, @vIATA, @vICAO, @vcallsign, @vcountry)
	SET airline_name = 			NULLIF(@vairline_name, ""),
		IATA =					NULLIF(@vIATA, ""),
        ICAO = 					NULLIF(@vICAO, ""),
        callsign = 				NULLIF(@vcallsign, ""),
        country = 				NULLIF(@vcountry, "\r");

        
DROP TABLE IF EXISTS `aircrafts`;
CREATE TABLE IF NOT EXISTS `aircrafts`(
	`ac_type`				VARCHAR(100) DEFAULT NULL,
    `registration`			VARCHAR(50) DEFAULT NULL,
    `IATA`					VARCHAR(50) DEFAULT NULL,
    `capacity`				VARCHAR(50) DEFAULT NULL,
    `country`				VARCHAR(50) DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
    
LOAD DATA INFILE 'D:\\Henry\\Repos\\Labs PI\\PI03-Analytics-main\\PI03-Analytics-main\\TransformedCSV\\aircrafts.csv'
INTO TABLE `aircrafts` 
FIELDS TERMINATED BY ',' ENCLOSED BY'"' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES
(@vac_type, @vregistration, @vIATA, @vcapacity, @vcountry)
	SET ac_type = 			NULLIF(@vac_type, ""),
		registration = 		NULLIF(@vregistration, ""),
		IATA =				NULLIF(@vIATA, ""),
        capacity = 			NULLIF(@vcapacity, ""),
        country = 			NULLIF(@vcountry, "\r");

SELECT * FROM airlines 
  INNER JOIN aircrafts
  ON airlines.country = aircrafts.country;




