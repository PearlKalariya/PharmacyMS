-- ======================================
-- Create Database
-- ======================================
CREATE DATABASE PharmacyMS;
USE PharmacyMS;

-- ======================================
-- Table Definitions
-- ======================================

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE Medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    manufacturer VARCHAR(100),
    price DECIMAL(10,2) NOT NULL CHECK(price >= 0),
    expiry_date DATE NOT NULL,
    CONSTRAINT fk_medicine_category FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);

CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT
);

CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_id INT NOT NULL,
    supplier_id INT NOT NULL,
    quantity INT NOT NULL CHECK(quantity >= 0),
    last_updated DATE NOT NULL DEFAULT (CURDATE()),
    CONSTRAINT fk_inventory_medicine FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id) ON DELETE CASCADE,
    CONSTRAINT fk_inventory_supplier FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE CASCADE
);

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT
);

CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    contact_number VARCHAR(15) UNIQUE
);

CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    doctor_id INT NOT NULL,
    date_issued DATE NOT NULL DEFAULT (CURDATE()),
    notes TEXT,
    CONSTRAINT fk_prescription_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_prescription_doctor FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

CREATE TABLE Pharmacists (
    pharmacist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    pharmacist_id INT NOT NULL,
    prescription_id INT,
    sale_date DATE NOT NULL DEFAULT (CURDATE()),
    total_amount DECIMAL(10,2) NOT NULL CHECK(total_amount >= 0),
    CONSTRAINT fk_sales_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_sales_pharmacist FOREIGN KEY (pharmacist_id) REFERENCES Pharmacists(pharmacist_id) ON DELETE CASCADE,
    CONSTRAINT fk_sales_prescription FOREIGN KEY (prescription_id) REFERENCES Prescriptions(prescription_id) ON DELETE SET NULL
);

CREATE TABLE Sales_Details (
    sale_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT NOT NULL,
    medicine_id INT NOT NULL,
    quantity INT NOT NULL CHECK(quantity > 0),
    price DECIMAL(10,2) NOT NULL CHECK(price >= 0),
    CONSTRAINT fk_salesdetails_sale FOREIGN KEY (sale_id) REFERENCES Sales(sale_id) ON DELETE CASCADE,
    CONSTRAINT fk_salesdetails_medicine FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id) ON DELETE CASCADE
);

-- ======================================
-- Sample Data Inserts (20 rows each)
-- ======================================

-- Categories (20 rows)
INSERT INTO Categories (category_name, description) VALUES
('Analgesics', 'Pain relief medicines'),
('Antibiotics', 'Bacterial infection treatment'),
('Antiseptics', 'Prevents infection'),
('Antipyretics', 'Fever reducers'),
('Vitamins', 'Dietary supplements'),
('Antacids', 'Stomach acid neutralizers'),
('Antifungals', 'Fungal infection treatment'),
('Cough & Cold', 'Respiratory symptom relief'),
('Cardiac', 'Heart medicines'),
('Diabetes', 'Blood sugar control'),
('Dermatology', 'Skin care medicines'),
('Neurology', 'Brain and nerves treatment'),
('Oncology', 'Cancer medicines'),
('Ophthalmology', 'Eye care medicines'),
('Psychiatry', 'Mental health medicines'),
('Respiratory', 'Asthma and lung care'),
('Gastroenterology', 'Digestive care'),
('Orthopedics', 'Bone and joint care'),
('ENT', 'Ear, Nose, Throat medicines'),
('General', 'General OTC medicines');

-- Medicines (20 rows, linked to categories)
INSERT INTO Medicines (name, category_id, manufacturer, price, expiry_date) VALUES
('Paracetamol 500mg', 1, 'Cipla', 25.50, '2026-12-01'),
('Amoxicillin 250mg', 2, 'Sun Pharma', 120.00, '2027-01-15'),
('Dettol Solution', 3, 'Reckitt Benckiser', 60.00, '2026-05-20'),
('Ibuprofen 400mg', 1, 'Dr. Reddys', 45.00, '2026-07-10'),
('Vitamin C 1000mg', 5, 'Himalaya', 200.00, '2028-08-25'),
('Ranitidine 150mg', 6, 'Zydus Cadila', 80.00, '2026-11-30'),
('Fluconazole 150mg', 7, 'Torrent Pharma', 150.00, '2027-04-10'),
('Cough Syrup 100ml', 8, 'Alkem', 65.00, '2026-03-05'),
('Aspirin 75mg', 9, 'GSK', 35.00, '2027-02-15'),
('Metformin 500mg', 10, 'Sun Pharma', 110.00, '2026-09-12'),
('Calamine Lotion', 11, 'Cipla', 70.00, '2026-10-01'),
('Carbamazepine 200mg', 12, 'Abbott', 95.00, '2027-06-18'),
('Cisplatin Injection', 13, 'Biocon', 2500.00, '2026-12-30'),
('Eye Drops Refresh', 14, 'Alcon', 90.00, '2026-05-22'),
('Sertraline 50mg', 15, 'Lupin', 180.00, '2027-09-09'),
('Salbutamol Inhaler', 16, 'Cipla', 350.00, '2026-04-11'),
('Omeprazole 20mg', 17, 'Sun Pharma', 130.00, '2026-02-14'),
('Calcium Tablet', 18, 'Himalaya', 85.00, '2028-01-20'),
('Cetirizine 10mg', 19, 'Cipla', 25.00, '2026-08-08'),
('ORS Powder', 20, 'Dabur', 20.00, '2027-05-10');

-- Suppliers (20 rows)
INSERT INTO Suppliers (supplier_name, contact_number, email, address) VALUES
('MediSupply Pvt Ltd', '9876543210', 'medisupply@gmail.com', 'Ahmedabad'),
('HealthFirst Ltd', '9123456780', 'healthfirst@yahoo.com', 'Surat'),
('Care Distributors', '9786541230', 'care_dist@gmail.com', 'Vadodara'),
('Wellness Traders', '9900112233', 'wellness@outlook.com', 'Rajkot'),
('Sunrise Pharma', '9090909090', 'sunrise@gmail.com', 'Bhavnagar'),
('Cure Distributors', '8123456789', 'cure@gmail.com', 'Junagadh'),
('MediLink Ltd', '9765432109', 'medilink@yahoo.com', 'Gandhinagar'),
('Lifeline Pharma', '8456781234', 'lifeline@gmail.com', 'Anand'),
('PharmaDirect', '9543218765', 'pharmadirect@gmail.com', 'Nadiad'),
('VitalMed', '7896543210', 'vitalmed@gmail.com', 'Bharuch'),
('TrustCare Pharma', '9212345678', 'trustcare@gmail.com', 'Valsad'),
('GlobalMeds', '9801234567', 'globalmeds@gmail.com', 'Navsari'),
('EverHealth', '9098765432', 'everhealth@gmail.com', 'Porbandar'),
('Goodwill Pharma', '9345678901', 'goodwill@gmail.com', 'Jamnagar'),
('MediPlus', '8888999900', 'mediplus@gmail.com', 'Patan'),
('LifeCare Suppliers', '8008008000', 'lifecare@gmail.com', 'Bhuj'),
('Cipla Suppliers', '8701234567', 'cipla_sup@gmail.com', 'Mehsana'),
('Torrent Distributors', '8899776655', 'torrent@gmail.com', 'Surendranagar'),
('Sun Pharma Distributors', '8111222333', 'sunpharma@gmail.com', 'Amreli'),
('Zydus Distributors', '8222333444', 'zydus@gmail.com', 'Morbi');

-- ======================================
-- Customers (20 rows)
-- ======================================
INSERT INTO Customers (name, contact_number, email, address) VALUES
('Ravi Patel', '9000000001', 'ravi.patel@gmail.com', 'Ahmedabad'),
('Sneha Shah', '9000000002', 'sneha.shah@gmail.com', 'Surat'),
('Amit Mehta', '9000000003', 'amit.mehta@gmail.com', 'Vadodara'),
('Priya Joshi', '9000000004', 'priya.joshi@gmail.com', 'Rajkot'),
('Karan Desai', '9000000005', 'karan.desai@gmail.com', 'Gandhinagar'),
('Nisha Raval', '9000000006', 'nisha.raval@gmail.com', 'Bhavnagar'),
('Manish Trivedi', '9000000007', 'manish.trivedi@gmail.com', 'Anand'),
('Neha Gohil', '9000000008', 'neha.gohil@gmail.com', 'Nadiad'),
('Deepak Parmar', '9000000009', 'deepak.parmar@gmail.com', 'Valsad'),
('Asha Pandya', '9000000010', 'asha.pandya@gmail.com', 'Jamnagar'),
('Mihir Chauhan', '9000000011', 'mihir.chauhan@gmail.com', 'Navsari'),
('Komal Shukla', '9000000012', 'komal.shukla@gmail.com', 'Morbi'),
('Rajiv Bhatt', '9000000013', 'rajiv.bhatt@gmail.com', 'Patan'),
('Pooja Dave', '9000000014', 'pooja.dave@gmail.com', 'Porbandar'),
('Ankit Solanki', '9000000015', 'ankit.solanki@gmail.com', 'Mehsana'),
('Disha Kapadia', '9000000016', 'disha.kapadia@gmail.com', 'Surendranagar'),
('Rohit Kothari', '9000000017', 'rohit.kothari@gmail.com', 'Junagadh'),
('Meera Vyas', '9000000018', 'meera.vyas@gmail.com', 'Bhuj'),
('Harsh Joshi', '9000000019', 'harsh.joshi@gmail.com', 'Amreli'),
('Janki Patel', '9000000020', 'janki.patel@gmail.com', 'Bharuch');

-- ======================================
-- Doctors (20 rows)
-- ======================================
INSERT INTO Doctors (name, specialization, contact_number) VALUES
('Dr. Arvind Shah', 'Cardiologist', '9100000001'),
('Dr. Meena Patel', 'Dermatologist', '9100000002'),
('Dr. Rakesh Joshi', 'General Physician', '9100000003'),
('Dr. Snehal Desai', 'Pediatrician', '9100000004'),
('Dr. Kiran Bhatt', 'Neurologist', '9100000005'),
('Dr. Pooja Mehta', 'Oncologist', '9100000006'),
('Dr. Jignesh Chauhan', 'Orthopedic', '9100000007'),
('Dr. Hiral Trivedi', 'Gynecologist', '9100000008'),
('Dr. Bharat Raval', 'Psychiatrist', '9100000009'),
('Dr. Sunita Shukla', 'ENT Specialist', '9100000010'),
('Dr. Manish Pandya', 'Diabetologist', '9100000011'),
('Dr. Deepa Solanki', 'Gastroenterologist', '9100000012'),
('Dr. Nirav Kapadia', 'Pulmonologist', '9100000013'),
('Dr. Bhavna Vyas', 'Ophthalmologist', '9100000014'),
('Dr. Rajesh Dave', 'Oncologist', '9100000015'),
('Dr. Seema Kothari', 'Dermatologist', '9100000016'),
('Dr. Kamlesh Parmar', 'General Physician', '9100000017'),
('Dr. Ritu Joshi', 'Cardiologist', '9100000018'),
('Dr. Hemant Chauhan', 'Orthopedic', '9100000019'),
('Dr. Anjali Pandya', 'Psychiatrist', '9100000020');

-- ======================================
-- Prescriptions (20 rows)
-- (Each links a customer with a doctor)
-- ======================================
INSERT INTO Prescriptions (customer_id, doctor_id, date_issued, notes) VALUES
(1, 1, '2025-01-10', 'Blood pressure check'),
(2, 3, '2025-01-12', 'Cough treatment'),
(3, 5, '2025-01-14', 'Headache issues'),
(4, 2, '2025-01-16', 'Skin rash treatment'),
(5, 4, '2025-01-17', 'Child fever'),
(6, 7, '2025-01-18', 'Joint pain treatment'),
(7, 6, '2025-01-19', 'Cancer diagnosis'),
(8, 8, '2025-01-20', 'Gynecology check'),
(9, 9, '2025-01-21', 'Mental health support'),
(10, 10, '2025-01-22', 'ENT infection'),
(11, 11, '2025-01-23', 'Diabetes medicine'),
(12, 12, '2025-01-24', 'Stomach pain'),
(13, 13, '2025-01-25', 'Asthma treatment'),
(14, 14, '2025-01-26', 'Eye irritation'),
(15, 15, '2025-01-27', 'Cancer therapy'),
(16, 16, '2025-01-28', 'Skin allergy'),
(17, 17, '2025-01-29', 'Routine checkup'),
(18, 18, '2025-01-30', 'Cardio check'),
(19, 19, '2025-02-01', 'Fracture follow-up'),
(20, 20, '2025-02-02', 'Depression treatment');

-- ======================================
-- Pharmacists (20 rows)
-- ======================================
INSERT INTO Pharmacists (name, contact_number, email) VALUES
('Arjun Patel', '9200000001', 'arjun.patel@pharma.com'),
('Neha Shah', '9200000002', 'neha.shah@pharma.com'),
('Vikas Mehta', '9200000003', 'vikas.mehta@pharma.com'),
('Pooja Joshi', '9200000004', 'pooja.joshi@pharma.com'),
('Raj Desai', '9200000005', 'raj.desai@pharma.com'),
('Kavita Raval', '9200000006', 'kavita.raval@pharma.com'),
('Manoj Trivedi', '9200000007', 'manoj.trivedi@pharma.com'),
('Smita Gohil', '9200000008', 'smita.gohil@pharma.com'),
('Nitin Parmar', '9200000009', 'nitin.parmar@pharma.com'),
('Anjali Pandya', '9200000010', 'anjali.pandya@pharma.com'),
('Suresh Chauhan', '9200000011', 'suresh.chauhan@pharma.com'),
('Rina Shukla', '9200000012', 'rina.shukla@pharma.com'),
('Jay Bhatt', '9200000013', 'jay.bhatt@pharma.com'),
('Preeti Dave', '9200000014', 'preeti.dave@pharma.com'),
('Hitesh Solanki', '9200000015', 'hitesh.solanki@pharma.com'),
('Megha Kapadia', '9200000016', 'megha.kapadia@pharma.com'),
('Chetan Vyas', '9200000017', 'chetan.vyas@pharma.com'),
('Divya Kothari', '9200000018', 'divya.kothari@pharma.com'),
('Rahul Parmar', '9200000019', 'rahul.parmar@pharma.com'),
('Kiran Joshi', '9200000020', 'kiran.joshi@pharma.com');

-- ======================================
-- Sales (20 rows)
-- Each sale links customer, pharmacist, and prescription
-- ======================================
INSERT INTO Sales (customer_id, pharmacist_id, prescription_id, sale_date, total_amount) VALUES
(1, 1, 1, '2025-02-05', 250.00),
(2, 2, 2, '2025-02-06', 120.00),
(3, 3, 3, '2025-02-06', 95.00),
(4, 4, 4, '2025-02-07', 70.00),
(5, 5, 5, '2025-02-07', 300.00),
(6, 6, 6, '2025-02-08', 1500.00),
(7, 7, 7, '2025-02-08', 2500.00),
(8, 8, 8, '2025-02-09', 220.00),
(9, 9, 9, '2025-02-09', 180.00),
(10, 10, 10, '2025-02-10', 60.00),
(11, 11, 11, '2025-02-11', 110.00),
(12, 12, 12, '2025-02-11', 85.00),
(13, 13, 13, '2025-02-12', 350.00),
(14, 14, 14, '2025-02-12', 90.00),
(15, 15, 15, '2025-02-13', 2000.00),
(16, 16, 16, '2025-02-13', 180.00),
(17, 17, 17, '2025-02-14', 250.00),
(18, 18, 18, '2025-02-14', 400.00),
(19, 19, 19, '2025-02-15', 130.00),
(20, 20, 20, '2025-02-15', 75.00);

-- ======================================
-- Sales_Details (20 rows)
-- Each sale contains medicines
-- ======================================
INSERT INTO Sales_Details (sale_id, medicine_id, quantity, price) VALUES
(1, 1, 2, 25.50),
(2, 2, 1, 120.00),
(3, 4, 2, 45.00),
(4, 11, 1, 70.00),
(5, 5, 2, 200.00),
(6, 13, 1, 1500.00),
(7, 13, 1, 2500.00),
(8, 8, 2, 65.00),
(9, 15, 1, 180.00),
(10, 3, 1, 60.00),
(11, 10, 1, 110.00),
(12, 18, 1, 85.00),
(13, 16, 1, 350.00),
(14, 14, 1, 90.00),
(15, 13, 1, 2000.00),
(16, 15, 1, 180.00),
(17, 1, 5, 25.50),
(18, 17, 2, 130.00),
(19, 19, 2, 25.00),
(20, 20, 3, 20.00);


-- 1. Medicines with Category Names
SELECT m.name AS medicine, c.category_name
FROM Medicines m
JOIN Categories c ON m.category_id = c.category_id;

-- 2. Total Sales per Customer
SELECT cu.name, SUM(s.total_amount) AS total_spent
FROM Sales s
JOIN Customers cu ON s.customer_id = cu.customer_id
GROUP BY s.customer_id;

-- 3. Expired Medicines
SELECT name, expiry_date
FROM Medicines
WHERE expiry_date < CURDATE();

-- 4. Low Stock Inventory (below 10)
SELECT m.name, i.quantity
FROM Inventory i
JOIN Medicines m ON i.medicine_id = m.medicine_id
WHERE i.quantity < 10;

-- 5. Doctors and Number of Prescriptions Issued
SELECT d.name, COUNT(p.prescription_id) AS prescriptions_issued
FROM Doctors d
JOIN Prescriptions p ON d.doctor_id = p.doctor_id
GROUP BY d.doctor_id;

-- 6. Top 5 Most Sold Medicines
SELECT m.name, SUM(sd.quantity) AS total_sold
FROM Sales_Details sd
JOIN Medicines m ON sd.medicine_id = m.medicine_id
GROUP BY sd.medicine_id
ORDER BY total_sold DESC
LIMIT 5;

-- 7. Detailed Sale View (example for sale_id = 1)
SELECT s.sale_id, s.sale_date, m.name, sd.quantity, sd.price
FROM Sales s
JOIN Sales_Details sd ON s.sale_id = sd.sale_id
JOIN Medicines m ON sd.medicine_id = m.medicine_id
WHERE s.sale_id = 1;

-- 8. Customer Prescription History (example for customer_id = 1)
SELECT p.prescription_id, p.date_issued, d.name AS doctor
FROM Prescriptions p
JOIN Doctors d ON p.doctor_id = d.doctor_id
WHERE p.customer_id = 1;

-- 9. Total Inventory by Medicine
SELECT m.name, SUM(i.quantity) AS total_stock
FROM Inventory i
JOIN Medicines m ON i.medicine_id = m.medicine_id
GROUP BY m.medicine_id;

-- 10. Sales by Pharmacist
SELECT ph.name, COUNT(s.sale_id) AS total_sales
FROM Pharmacists ph
JOIN Sales s ON ph.pharmacist_id = s.pharmacist_id
GROUP BY ph.pharmacist_id;

-- 11. Supplier-wise Medicines
SELECT sup.supplier_name, m.name AS medicine
FROM Inventory i
JOIN Suppliers sup ON i.supplier_id = sup.supplier_id
JOIN Medicines m ON i.medicine_id = m.medicine_id;

-- 12. High-Price Medicines (₹500+)
SELECT name, price
FROM Medicines
WHERE price > 500;

-- 13. Current Month’s Sales
SELECT * 
FROM Sales
WHERE MONTH(sale_date) = MONTH(CURDATE()) 
  AND YEAR(sale_date) = YEAR(CURDATE());

-- 14. Average Sale per Pharmacist
SELECT ph.name, AVG(s.total_amount) AS avg_sale
FROM Pharmacists ph
JOIN Sales s ON ph.pharmacist_id = s.pharmacist_id
GROUP BY ph.pharmacist_id;

-- 15. Customers Served by Pharmacist
SELECT ph.name, COUNT(DISTINCT s.customer_id) AS customers_served
FROM Pharmacists ph
JOIN Sales s ON ph.pharmacist_id = s.pharmacist_id
GROUP BY ph.pharmacist_id;
