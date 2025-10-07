--- Complete Example: Daily Sales Export. Export yesterday's sales data to Cloud Storage as a PARQUET file.
EXPORT DATA OPTIONS(
  uri='gs://myorg-cloudai-gcp1722/incremental/sales_' || FORMAT_TIMESTAMP('%Y%m%d_%H%M%S', CURRENT_TIMESTAMP()) || '_*.parquet',
  format='PARQUET',
  overwrite=false,
  -- Use compression for smaller files
  compression='SNAPPY'
) AS
SELECT 
  order_id,
  customer_id,
  product_id,
  quantity,
  unit_price,
  total_amount,
  order_date,
  region,
  CURRENT_TIMESTAMP() as export_timestamp
FROM `ecommerce.sales`
WHERE DATE(order_timestamp) = CURRENT_DATE() - 1;