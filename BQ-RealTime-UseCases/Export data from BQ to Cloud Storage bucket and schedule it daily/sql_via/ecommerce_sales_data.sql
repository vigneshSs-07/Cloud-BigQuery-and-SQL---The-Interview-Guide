-- File: /home/cloudaianalytics/Cloud BigQuery/BQ-RealTime-UseCases/Export data from BQ to Cloud Storage bucket and schedule it daily/sql_via/setup_sales_table.sql

-- 1. CREATE the sales table with partitioning
-- This schema is inferred from your EXPORT DATA query.
-- Partitioning by order_timestamp (as a DATE) is a best practice for performance and cost management.
CREATE OR REPLACE TABLE `myorg-cloudai-gcp1722.ecommerce.sales`
(
  order_id INT64,
  customer_id INT64,
  product_id INT64,
  quantity INT64,
  unit_price NUMERIC,
  total_amount NUMERIC,
  order_date DATE,
  region STRING,
  order_timestamp TIMESTAMP
)
PARTITION BY
  DATE(order_timestamp)
OPTIONS(
  description="Table to store daily sales data."
);

-- 2. INSERT some sample data for yesterday
-- This allows you to test your EXPORT DATA query immediately.
INSERT INTO `myorg-cloudai-gcp1722.ecommerce.sales` (
  order_id,
  customer_id,
  product_id,
  quantity,
  unit_price,
  total_amount,
  order_date,
  region,
  order_timestamp
)
VALUES
  (101, 1, 501, 2, 10.50, 21.00, CURRENT_DATE() - 3, 'North', TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 24 HOUR)),
  (102, 2, 502, 1, 150.00, 150.00, CURRENT_DATE() - 7, 'South', TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 36 HOUR)),
  (103, 1, 503, 5, 5.00, 25.00, CURRENT_DATE() - 9, 'North', TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 40 HOUR)),
  (104, 3, 501, 1, 10.50, 10.50, CURRENT_DATE() - 17, 'East', TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 76 HOUR));

