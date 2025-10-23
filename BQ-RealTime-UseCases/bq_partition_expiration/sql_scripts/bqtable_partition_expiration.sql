-- ===================================================================================
-- Create a partitioned and clustered table for weather data with partition expiration.
--
-- This DDL script creates the `weather_data` table with the following features:
-- - Partitioned by the `weather_date` field on a daily basis for efficient querying.
-- - Clustered by `station_id`, `location`, and `weather_condition` to optimize queries filtering on these columns.
-- - Sets a 7-day partition expiration to automatically delete data older than a week, managing storage costs.
-- ===================================================================================
CREATE TABLE `poised-team-467209-a1.weather_dataset.weather_data`
(
  station_id STRING NOT NULL,
  weather_date DATETIME NOT NULL,
  temperature FLOAT64,
  humidity FLOAT64,
  pressure FLOAT64,
  wind_speed FLOAT64,
  precipitation FLOAT64,
  weather_condition STRING,
  location STRING,
  recorded_timestamp TIMESTAMP NOT NULL
)
PARTITION BY DATE(weather_date)
CLUSTER BY station_id, location, weather_condition
OPTIONS (
  description = "Weather data partitioned by weather_date with 7-day expiration",
  partition_expiration_days = 7
);

-- ===================================================================================
-- Insert Sample Data
--
-- This statement inserts a few sample records into the `weather_data` table
-- to demonstrate how partitioning and clustering work. Each record has a
-- different `weather_date` to create distinct partitions.
-- ===================================================================================
INSERT INTO `poised-team-467209-a1.weather_dataset.weather_data` 
(station_id, weather_date, temperature, humidity, pressure, wind_speed, precipitation, weather_condition, location, recorded_timestamp)
VALUES 
  ('STATION_001', DATETIME('2025-10-22 12:00:00'), 22.5, 65.0, 1013.25, 5.2, 0.0, 'Sunny', 'New York', CURRENT_TIMESTAMP()),
  ('STATION_002', DATETIME('2025-10-21 14:30:00'), 18.3, 72.0, 1015.8, 8.1, 2.5, 'Rainy', 'London', CURRENT_TIMESTAMP()),
  ('STATION_003', DATETIME('2025-10-20 09:15:00'), 15.7, 80.0, 1012.1, 12.3, 5.8, 'Cloudy', 'Paris', CURRENT_TIMESTAMP());

-- ===================================================================================
-- Verification Query: Check Table Metadata
--
-- This query retrieves metadata about the `weather_data` table from the
-- INFORMATION_SCHEMA. This is useful for verifying that the partitioning
-- and expiration settings have been applied correctly.
-- ===================================================================================
SELECT 
  *
FROM `poised-team-467209-a1.weather_dataset.INFORMATION_SCHEMA.TABLES`
WHERE table_name = 'weather_data';

-- ===================================================================================
-- Verification Query: List Table Partitions
--
-- This query lists all the current partitions in the `weather_data` table.
-- It helps confirm that data is being correctly partitioned by date.
-- You can monitor this over time to see old partitions being automatically deleted.
-- ===================================================================================
SELECT 
  *
FROM `poised-team-467209-a1.weather_dataset.INFORMATION_SCHEMA.PARTITIONS`
WHERE table_name = 'weather_data'
ORDER BY partition_id DESC;