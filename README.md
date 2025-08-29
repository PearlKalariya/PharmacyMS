# PharmacyMS
Pharmacy Management System (PMS) is a MySQL-based project that manages medicines, suppliers, inventory, customers, doctors, prescriptions, pharmacists, and sales. It includes a normalized database schema, sample data (20 rows per table), and SQL queries for real-world pharmacy operations.

📦 Pharmacy Management System (PMS) – MySQL Database Project

The Pharmacy Management System (PMS) is a relational database solution designed to streamline and optimize pharmacy operations. Built in MySQL, it provides structured management of medicines, suppliers, inventory, customers, doctors, prescriptions, pharmacists, and sales transactions.

🔑 Features

Medicine Management – Track medicines with categories, prices, manufacturers, and expiry dates.
Supplier & Inventory Control – Maintain supplier records and manage medicine stock levels.
Customer & Doctor Records – Store patient and doctor details, with linked prescriptions.
Prescription Handling – Record prescriptions issued by doctors and fulfilled by pharmacists.
Sales Management – Capture sales transactions with detailed item-level breakdowns.
Relational Integrity – Enforced with primary keys, foreign keys, cascading deletes, and constraints.

📊 Example Queries

Identify expired or low-stock medicines
View total sales per customer or pharmacist
Determine top-selling medicines
Review prescription history of a customer
List medicines supplied by specific suppliers

🛠 Tech Stack

Database: MySQL
Schema Design: ER Model, 3NF Normalization
Scripts: CREATE TABLE, sample data inserts (20 rows per table), and query set

🚀 Getting Started

Import the pms_schema.sql file into MySQL Workbench (or any SQL client).
Load pms_sample_data.sql to populate the database with realistic test data.
Run queries from pms_queries.sql to validate functionality.
