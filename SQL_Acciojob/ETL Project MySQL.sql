DROP DATABASE IF EXISTS olympics_project;
CREATE DATABASE olympics_project;
USE olympics_project;

CREATE TABLE stg_athlete_events (
  ID INT,
  Name VARCHAR(255),
  Sex CHAR(1),
  Age VARCHAR(10),
  Height_cm VARCHAR(10),
  Weight_kg VARCHAR(10),
  Team VARCHAR(255),
  NOC VARCHAR(3),
  Games VARCHAR(255),
  Year INT,
  Season VARCHAR(100),
  City VARCHAR(255),
  Sport VARCHAR(255),
  Event VARCHAR(255),
  Medal VARCHAR(100)
);

SELECT COUNT(*) FROM stg_athlete_events;
SELECT * FROM stg_athlete_events LIMIT 20;


