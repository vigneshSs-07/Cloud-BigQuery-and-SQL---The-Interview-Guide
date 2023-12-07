>>> **PROFESSIONAL DATA ENGINEER** - *Google Cloud Platform*
--------------------------------------------------------------------------------------------------------------------------------------------

> TITLE: "BigQuery SQL - Coding Interview Questions"
> 
> Author:
  >- Name: "Vignesh Sekar"
  >- Designation: "Multi Cloud Architect"
  >- Tags: [Google Cloud, DataEngineer, Python, PySpark, SQL, BigData]

-----------------------------------------------------------------------------------------------------------------------------------------------

## 1.Write an SQL query to find customers who have made more than one order in a single day.

```sql
### DDL Statement to drop table
DROP TABLE IF EXISTS `lucky-leaf-396003.kf_demo_dataset_010.customer`
```

### DDL statement to create table
```sql
CREATE TABLE IF NOT EXISTS
  `lucky-leaf-396003.kf_demo_dataset_010.customer` (customer_id int64,
    order_date date)
```

### DDL statement to insert records into table
```sql
INSERT INTO
  `lucky-leaf-396003.kf_demo_dataset_010.customer` (customer_id,
    order_date)
VALUES
  (1111, '2023-09-01'),
  (1111,'2023-09-01'),
  (1222,'2023-09-02')
```

### query to find customers who have made more than one order in a single day.
```sql
SELECT
  *
FROM
  `lucky-leaf-396003.kf_demo_dataset_010.customer`;
```

### Query   
```sql
SELECT
  customer_id,
  order_date,
  COUNT(*) AS order_count
FROM
  `lucky-leaf-396003.kf_demo_dataset_010.customer`
GROUP BY
  customer_id,
  order_date
HAVING
  COUNT(*) > 1
```

## 2. Write a sql query to find the number of times each student attended each exam.Return the result table ordered by student_id and subject_name.
### DDL for dropping table
```sql
1. drop table If  Exists `lucky-leaf-396003.kf_demo_dataset_010.Students` (student_id int, student_name string)
2. drop table If  Exists `lucky-leaf-396003.kf_demo_dataset_010.Subjects` (subject_name string)
3. drop table If  Exists `lucky-leaf-396003.kf_demo_dataset_010.Examinations` (student_id int, subject_name string)
```

### DDL for creating table
```sql
1. Create table If Not Exists `lucky-leaf-396003.kf_demo_dataset_010.Students` (student_id int, student_name string)
2. Create table If Not Exists `lucky-leaf-396003.kf_demo_dataset_010.Subjects` (subject_name string)
3. Create table If Not Exists `lucky-leaf-396003.kf_demo_dataset_010.Examinations` (student_id int, subject_name string)
```

### Table1 : Students
```sql
insert into `lucky-leaf-396003.kf_demo_dataset_010.Students` (student_id, student_name) values (1, 'Alice'),
(2, 'Bob'),
(13, 'John'),
(6, 'Alex')
```

### Table2 : Subjects
```sql
insert into `lucky-leaf-396003.kf_demo_dataset_010.Subjects` (subject_name) values ('Math'),
('Physics'),
('Programming')
```

### Table3 : Examinations
```sql
insert into `lucky-leaf-396003.kf_demo_dataset_010.Examinations` (student_id, subject_name) values (1, 'Math'),
(1, 'Physics'),
(1, 'Programming'),
(2, 'Programming'),
(1, 'Physics'),
(1, 'Math'),
(13, 'Math'),
(13, 'Programming'),
(13, 'Physics'),
(2, 'Math'),
(1, 'Math')
```

### Displaying Students table
```sql
select * from `lucky-leaf-396003.kf_demo_dataset_010.Students`
```

### Displaying Examinations table
```sql
select * from `lucky-leaf-396003.kf_demo_dataset_010.Examinations`
```

### Displaying Subjects table
```sql
select * from  `lucky-leaf-396003.kf_demo_dataset_010.Subjects`
```

### SQL query
```sql
select t1.student_id,t1.student_name,t2.subject_name,count(t3.subject_name) as attended_exams
from `lucky-leaf-396003.kf_demo_dataset_010.Students` t1
left outer join `lucky-leaf-396003.kf_demo_dataset_010.Examinations` t3
on t1.student_id = t3.student_id 
join `lucky-leaf-396003.kf_demo_dataset_010.Subjects` t2
on t2.subject_name = t3.subject_name
group by t1.student_id,t1.student_name,t2.subject_name
order by t1.student_id,t2.subject_name
```

## 3. NEXT USECASE #############
### DDL for dropping table
```sql
1. DROP TABLE IF EXISTS `lucky-leaf-396003.kf_demo_dataset_010.customers`
2. DROP TABLE IF EXISTS `lucky-leaf-396003.kf_demo_dataset_010.orders`
```

### DDL for creating table
```sql
CREATE TABLE `lucky-leaf-396003.kf_demo_dataset_010.customers` (
customer_id INT,
first_shop DATE,
age INT,
rewards string,
can_email string
);
```

### DDL for inserting records into source table
```sql
INSERT INTO `lucky-leaf-396003.kf_demo_dataset_010.customers` (customer_id, first_shop, age, rewards, can_email)
VALUES (1, '2022-03-20', 23, 'yes', 'no'),
(2, '2022-03-25', 26, 'no', 'no'),
(3, '2022-04-06', 32, 'no', 'no'),
(4, '2022-04-13', 25, 'yes', 'yes'),
(5, '2022-04-22', 49, 'yes', 'yes'),
(6, '2022-06-18', 28, 'yes', 'no'),
(7, '2022-06-30', 36, 'no', 'no'),
(8, '2022-07-04', 37, 'yes', 'yes');
```

### DDL for creating table
```sql
CREATE TABLE `lucky-leaf-396003.kf_demo_dataset_010.orders` (
order_id INT,
customer_id INT,
date_shop DATE,
sales_channel string,
country_id INT
);
```

### DDL for recording records into source table
```sql
INSERT INTO `lucky-leaf-396003.kf_demo_dataset_010.orders` (order_id, customer_id, date_shop, sales_channel, country_id)
VALUES (1, 1, '2023-01-16', 'retail', 1),
(2, 4, '2023-01-20', 'retail', 1),
(3, 2, '2023-01-25', 'retail', 2),
(4, 3, '2023-01-25', 'online', 1),
(5, 1, '2023-01-28', 'retail', 3),
(6, 5, '2023-02-02', 'online', 1),
(7, 6, '2023-02-05', 'retail', 1),
(8, 3, '2023-02-11', 'online', 3);
```

## 4. How many orders were made by customers aged 30 or older?
```sql
select count(distinct o.order_id) as total_orders
from `lucky-leaf-396003.kf_demo_dataset_010.customers` c
inner join `lucky-leaf-396003.kf_demo_dataset_010.orders` o on c.customer_id = o.customer_id
where c.age >= 30;
```

## 5. What is the date of the latest order made by a customer who can receive marketing emails?
```sql
select max(o.date_shop) as latest_order_date
from `lucky-leaf-396003.kf_demo_dataset_010.customers` c
inner join `lucky-leaf-396003.kf_demo_dataset_010.orders` o on c.customer_id = o.customer_id
where can_email = 'yes'
```

## 6. Get table information using INFORMATION_SCHEMA
```sql
SELECT
  table_catalog,
  table_schema,
  table_name,
  table_type,
  is_insertable_into,
  creation_time,
  ddl
FROM
  kf_demo_dataset_010.INFORMATION_SCHEMA.TABLES;
```

## 7. Drop schema. To delete a dataset and all of its contents, use the CASCADE keyword
```sql
drop schema if exists  `lucky-leaf-396003.kf_demo_dataset_010` CASCADE;
```

-----------------------------------------------------------------------------------------------------------------------

  <div class="footer">
              copyright © 2022—2023 Cloud & AI Analytics. 
                                      All rights reserved
          </div>
