--- Complete Example: Daily Sales Export. Export yesterday's sales data to Cloud Storage as a compressed CSV file.
EXPORT DATA OPTIONS(
  uri='gs://my-bucket/incremental_csv/sales_' || FORMAT_TIMESTAMP('%Y%m%d_%H%M%S', CURRENT_TIMESTAMP()) || '_*.csv.gz',
  format='CSV',
  overwrite=false,
  header=true,
  field_delimiter=';', -- Using semicolon as an example delimiter
  -- Use GZIP compression for CSV files
  compression='GZIP'
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
FROM `myproject.ecommerce.sales`
WHERE DATE(order_timestamp) = CURRENT_DATE() - 1;
