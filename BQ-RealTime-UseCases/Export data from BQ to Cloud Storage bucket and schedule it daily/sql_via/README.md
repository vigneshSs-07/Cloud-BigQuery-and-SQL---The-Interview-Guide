# BigQuery SQL Scripts for Daily Sales Data Export

This directory contains the SQL scripts necessary to set up a sample `ecommerce.sales` table in BigQuery and export its data to Google Cloud Storage (GCS). These scripts are designed to be used independently or as part of an automated workflow, such as the one defined in the `../workflows_via` directory.

## Files

### 1. `ecoomerce_sales_data.sql`

This script handles the initial setup of the database table.

*   **`CREATE OR REPLACE TABLE`**: Creates the `myorg-cloudai-gcp1722.ecommerce.sales` table.
    *   The table is partitioned by the `order_timestamp` field, which is a best practice for time-series data to improve query performance and manage costs.
*   **`INSERT INTO`**: Populates the newly created table with sample sales records from various past dates. This allows you to immediately test the export queries.

### 2. `BigQuery EXPORT DATA Statement.sql`

This script demonstrates how to export data from the `ecommerce.sales` table into a compressed CSV format.

*   **Purpose**: Exports sales data from the previous day (`WHERE DATE(order_timestamp) = CURRENT_DATE() - 1`).
*   **Format**: `CSV`
*   **Destination**: Google Cloud Storage (`gs://my-bucket/incremental_csv/...`)
*   **Features**:
    *   Exports data as a GZIP compressed file (`.csv.gz`).
    *   Includes a header row (`header=true`).
    *   Uses a semicolon (`;`) as the field delimiter.
    *   Generates a unique filename for each export using the current timestamp.

### 3. `BigQuery EXPORT DATA Statement parquet.sql`

This script demonstrates how to export the same data into the more efficient Parquet format.

*   **Purpose**: Exports sales data from the previous day (`WHERE DATE(order_timestamp) = CURRENT_DATE() - 1`).
*   **Format**: `PARQUET`
*   **Destination**: Google Cloud Storage (`gs://myorg-cloudai-gcp1722/incremental/...`)
*   **Features**:
    *   Uses `SNAPPY` compression for smaller file sizes.
    *   Generates a unique filename for each export using the current timestamp.

## Usage

1.  **Setup the Table**: Before running any export queries, execute the contents of `ecoomerce_sales_data.sql` in your BigQuery console to create and populate the `ecommerce.sales` table.
2.  **Configure Export Destination**: In `BigQuery EXPORT DATA Statement.sql` and `BigQuery EXPORT DATA Statement parquet.sql`, replace the placeholder bucket names (`my-bucket`, `myorg-cloudai-gcp1722`) with your actual GCS bucket name.
3.  **Run an Export**: Execute one of the `EXPORT DATA` scripts in your BigQuery console to export yesterday's data to the specified GCS bucket.

These export queries are ideal for scheduling. They can be incorporated into a daily scheduled query or a more robust orchestration tool like Cloud Workflows.