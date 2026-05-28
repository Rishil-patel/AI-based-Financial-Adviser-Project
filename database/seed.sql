-- =========================================
-- AI FINANCIAL ADVISOR
-- 6-MONTH ML DATASET
-- =========================================

-- =========================================

-- 1. USERS

-- =========================================

INSERT INTO users (business_name, owner_name, email, password_hash)
VALUES
('TechNova Solutions', 'Aarav Mehta', 'aarav@technova.com', 'hash1'),
('StyleHub Fashion', 'Meera Shah', 'meera@stylehub.com', 'hash2'),
('FreshBite Foods', 'Rohan Desai', 'rohan@freshbite.com', 'hash3'),
('UrbanMart Retail', 'Kunal Verma', 'kunal@urbanmart.com', 'hash4'),
('EduSphere Academy', 'Priya Nair', 'priya@edusphere.com', 'hash5'),
('AutoDrive Services', 'Vikram Joshi', 'vikram@autodrive.com', 'hash6');

-- =========================================

-- 2. DEPARTMENTS

-- =========================================

INSERT INTO departments (user_id, department_name, department_type_id)
VALUES
(1,'Development',3),(1,'Marketing',2),(1,'Support',4),
(2,'Retail Ops',3),(2,'Advertising',2),(2,'Finance',5),
(3,'Kitchen Ops',3),(3,'Delivery',1),(3,'Admin',4),
(4,'Sales',1),(4,'Marketing',2),(4,'Inventory',3),
(5,'Courses',3),(5,'Digital Marketing',2),(5,'Support',4),
(6,'Operations',3),(6,'Customer Growth',2),(6,'Finance',5);

-- =========================================

-- 3. EXPENSE CATEGORIES

-- =========================================

INSERT INTO expense_categories (category_name, category_type, keywords, priority_weight)
VALUES
('Cloud Hosting','operational','cloud,hosting,aws,server,database,infra',5),
('Ads Spend','variable','ads,marketing,campaign,google,meta',5),
('Instagram Ads','variable','instagram,social,meta,branding',4),
('Store Rent','fixed','rent,store,office,warehouse',5),
('Food Supply','operational','food,raw,stock,kitchen',5),
('Fuel','variable','fuel,transport,logistics',3),
('Inventory','operational','stock,inventory,goods',5),
('Servers','fixed','server,cloud,backend',4),
('Maintenance','operational','repair,fix,maintenance',3);

-- =========================================
-- 4. EXPENSES (CLEAN ML DATASET)
-- =========================================

INSERT INTO expenses (
user_id, department_id, category_id,
title, description, amount,
payment_method, transaction_type,
expense_date, is_recurring, recurring_frequency
)
VALUES

-- ================= TECHNOVA (14) =================
(1,1,8,'AWS Cloud','Hosting',15000,'credit_card','essential','2026-01-01',true,'monthly'),
(1,1,8,'DB Servers','Infra',12000,'credit_card','essential','2026-01-10',true,'monthly'),
(1,2,2,'Google Ads','Marketing',8000,'upi','non_essential','2026-01-15',false,NULL),
(1,2,3,'Instagram Ads','Social marketing',9000,'upi','non_essential','2026-02-01',false,NULL),
(1,3,9,'System Fix','Maintenance',6000,'debit_card','essential','2026-02-10',false,NULL),
(1,1,8,'Cloud Scaling','Upgrade',18000,'credit_card','essential','2026-03-01',true,'monthly'),
(1,3,9,'Firewall','Security',7000,'debit_card','essential','2026-03-10',true,'monthly'),
(1,1,8,'API Services','Integration',5000,'credit_card','essential','2026-04-01',true,'monthly'),
(1,2,2,'LinkedIn Ads','Hiring',6000,'upi','non_essential','2026-04-10',false,NULL),
(1,1,8,'Backup Storage','Data',4500,'credit_card','essential','2026-05-01',true,'monthly'),
(1,3,9,'Bug Fixes','Maintenance',3000,'debit_card','essential','2026-05-10',false,NULL),
(1,2,2,'Meta Ads','Campaign',7500,'upi','non_essential','2026-05-15',false,NULL),
(1,1,8,'Server Upgrade','Infra',20000,'credit_card','essential','2026-06-01',true,'monthly'),
(1,3,9,'Monitoring Tool','Health check',3500,'debit_card','essential','2026-06-10',true,'monthly'),

-- ================= STYLEHUB (14) =================
(2,4,4,'Mall Rent','Store rent',50000,'bank_transfer','essential','2026-01-01',true,'monthly'),
(2,4,4,'Warehouse Rent','Storage',42000,'bank_transfer','essential','2026-01-10',true,'monthly'),
(2,5,3,'Instagram Ads','Marketing',12000,'upi','non_essential','2026-01-15',false,NULL),
(2,5,2,'Google Ads','Campaign',14000,'upi','non_essential','2026-02-01',false,NULL),
(2,4,7,'Inventory Stock','Goods',55000,'bank_transfer','essential','2026-02-10',false,NULL),
(2,5,3,'Influencer Ads','Branding',15000,'upi','non_essential','2026-03-01',false,NULL),
(2,4,4,'Staff Salary','Payroll',45000,'bank_transfer','essential','2026-03-10',true,'monthly'),
(2,5,3,'Season Ads','Promo',16000,'upi','non_essential','2026-04-01',false,NULL),
(2,4,9,'Store Repair','Maintenance',8000,'cash','essential','2026-04-10',false,NULL),
(2,5,2,'Festival Ads','Campaign',18000,'upi','non_essential','2026-05-01',false,NULL),
(2,4,7,'Inventory Restock','Goods',50000,'bank_transfer','essential','2026-05-10',false,NULL),
(2,5,3,'Online Branding','Social',13000,'upi','non_essential','2026-05-15',false,NULL),
(2,4,4,'Logistics','Transport',10000,'cash','essential','2026-06-01',false,NULL),
(2,5,2,'Digital Ads','Growth',17000,'upi','non_essential','2026-06-10',false,NULL),

-- ================= FRESHBITE (14) =================
(3,7,5,'Vegetables','Supply',20000,'cash','essential','2026-01-01',true,'daily'),
(3,7,5,'Spices','Stock',7000,'cash','essential','2026-01-05',true,'monthly'),
(3,7,5,'Bulk Veg','Supply',25000,'cash','essential','2026-01-10',true,'weekly'),
(3,8,6,'Fuel','Delivery',6000,'cash','essential','2026-02-01',false,NULL),
(3,7,5,'Raw Material','Kitchen',12000,'cash','essential','2026-02-10',false,NULL),
(3,8,9,'Vehicle Repair','Maintenance',8000,'cash','non_essential','2026-03-01',false,NULL),
(3,7,5,'Cold Storage','Electricity',9000,'cash','essential','2026-03-10',true,'monthly'),
(3,7,5,'Meat Supply','Stock',15000,'cash','essential','2026-04-01',false,NULL),
(3,8,6,'Delivery Fee','Logistics',3000,'cash','non_essential','2026-04-10',false,NULL),
(3,7,5,'Oil Supply','Cooking',8000,'cash','essential','2026-05-01',false,NULL),
(3,7,5,'Packaging','Materials',5000,'cash','essential','2026-05-10',false,NULL),
(3,8,6,'Fuel Refill','Transport',4000,'cash','essential','2026-05-15',false,NULL),
(3,7,5,'Kitchen Tools','Equipment',6000,'cash','essential','2026-06-01',false,NULL),
(3,8,9,'Cleaning','Maintenance',3000,'cash','essential','2026-06-10',false,NULL),

-- ================= URBANMART (14) =================
(4,10,4,'Store Rent','Rent',60000,'bank_transfer','essential','2026-01-01',true,'monthly'),
(4,10,7,'Inventory','Stock',90000,'upi','essential','2026-01-10',false,NULL),
(4,11,2,'Facebook Ads','Marketing',15000,'upi','non_essential','2026-01-15',true,'monthly'),
(4,12,9,'Repair','Maintenance',9000,'cash','essential','2026-02-01',false,NULL),
(4,10,4,'Staff Salary','Payroll',50000,'bank_transfer','essential','2026-02-10',true,'monthly'),
(4,11,3,'Influencer Ads','Branding',22000,'upi','non_essential','2026-03-01',false,NULL),
(4,12,6,'Logistics','Transport',14000,'cash','essential','2026-03-10',false,NULL),
(4,10,4,'Utilities','Electricity',11000,'cash','essential','2026-04-01',false,NULL),
(4,11,2,'Online Ads','Digital',17000,'upi','non_essential','2026-04-10',false,NULL),
(4,12,7,'Packaging','Ops',8000,'cash','essential','2026-05-01',false,NULL),
(4,10,4,'Warehouse Rent','Storage',40000,'bank_transfer','essential','2026-05-10',true,'monthly'),
(4,11,3,'Social Ads','Branding',12000,'upi','non_essential','2026-05-15',false,NULL),
(4,12,9,'Maintenance','Fix',7000,'cash','essential','2026-06-01',false,NULL),
(4,10,4,'Electricity','Utilities',10000,'cash','essential','2026-06-10',false,NULL),

-- ================= EDUSPHERE (14) =================
(5,13,8,'Hosting','Platform',20000,'credit_card','essential','2026-01-01',true,'monthly'),
(5,14,2,'Ads','Marketing',25000,'upi','non_essential','2026-01-10',true,'monthly'),
(5,15,9,'Staff Salary','Payroll',40000,'bank_transfer','essential','2026-01-15',true,'monthly'),
(5,13,8,'Server Upgrade','Infra',22000,'credit_card','essential','2026-02-01',true,'monthly'),
(5,14,3,'YouTube Ads','Campaign',18000,'upi','non_essential','2026-02-10',false,NULL),
(5,15,9,'Content Team','Support',30000,'bank_transfer','essential','2026-03-01',false,NULL),
(5,13,8,'Zoom License','Tools',8000,'credit_card','essential','2026-03-10',true,'monthly'),
(5,14,2,'SEO Tools','Growth',11000,'upi','non_essential','2026-04-01',false,NULL),
(5,15,9,'Freelancers','Support',18000,'bank_transfer','essential','2026-04-10',false,NULL),
(5,13,8,'Security','Infra',14000,'credit_card','essential','2026-05-01',true,'monthly'),
(5,14,3,'Brand Ads','Social',16000,'upi','non_essential','2026-05-10',false,NULL),
(5,15,9,'Course Content','Production',15000,'bank_transfer','essential','2026-05-15',false,NULL),
(5,13,8,'Backup','Data',9000,'credit_card','essential','2026-06-01',true,'monthly'),
(5,14,2,'Marketing Push','Growth',20000,'upi','non_essential','2026-06-10',false,NULL),

-- ================= AUTODRIVE (14) =================
(6,16,4,'Garage Rent','Facility',30000,'bank_transfer','essential','2026-01-01',true,'monthly'),
(6,17,2,'Ads','Marketing',12000,'upi','non_essential','2026-01-10',true,'monthly'),
(6,18,9,'Repair','Maintenance',25000,'cash','essential','2026-01-15',false,NULL),
(6,16,7,'Spare Parts','Inventory',15000,'cash','essential','2026-02-01',false,NULL),
(6,17,3,'Google Ads','Lead',10000,'upi','non_essential','2026-02-10',true,'monthly'),
(6,18,9,'Mechanic Salary','Payroll',30000,'bank_transfer','essential','2026-03-01',true,'monthly'),
(6,16,6,'Fuel','Operations',9000,'cash','essential','2026-03-10',false,NULL),
(6,17,2,'Instagram Ads','Growth',14000,'upi','non_essential','2026-04-01',false,NULL),
(6,18,9,'Workshop Upgrade','Infra',18000,'cash','essential','2026-04-10',false,NULL),
(6,16,6,'Vehicle Parts','Stock',22000,'cash','essential','2026-05-01',false,NULL),
(6,17,3,'Local Ads','Promo',8000,'upi','non_essential','2026-05-10',false,NULL),
(6,18,9,'Cleaning','Maintenance',5000,'cash','essential','2026-05-15',false,NULL),
(6,16,7,'Tools','Equipment',12000,'cash','essential','2026-06-01',false,NULL),
(6,17,2,'Digital Ads','Marketing',16000,'upi','non_essential','2026-06-10',false,NULL);

-- =========================================
-- 5. REVENUE (6 MONTH TREND)
-- =========================================

INSERT INTO revenue (user_id, department_id, source, description, amount, revenue_date)
VALUES
(1,1,'Services','Revenue',120000,'2026-01-10'),
(1,1,'Services','Revenue',125000,'2026-02-10'),
(1,1,'Services','Revenue',132000,'2026-03-10'),
(1,1,'Services','Revenue',140000,'2026-04-10'),
(1,1,'Services','Revenue',148000,'2026-05-10'),
(1,1,'Services','Revenue',155000,'2026-06-10'),

(2,4,'Retail','Revenue',90000,'2026-01-10'),
(2,4,'Retail','Revenue',85000,'2026-02-10'),
(2,4,'Retail','Revenue',110000,'2026-03-10'),
(2,4,'Retail','Revenue',140000,'2026-04-10'),
(2,4,'Retail','Revenue',160000,'2026-05-10'),
(2,4,'Retail','Revenue',150000,'2026-06-10'),

(3,7,'Food','Revenue',80000,'2026-01-10'),
(3,7,'Food','Revenue',82000,'2026-02-10'),
(3,7,'Food','Revenue',85000,'2026-03-10'),
(3,7,'Food','Revenue',87000,'2026-04-10'),
(3,7,'Food','Revenue',90000,'2026-05-10'),
(3,7,'Food','Revenue',92000,'2026-06-10'),

(4,10,'Retail','Revenue',100000,'2026-01-10'),
(4,10,'Retail','Revenue',105000,'2026-02-10'),
(4,10,'Retail','Revenue',110000,'2026-03-10'),
(4,10,'Retail','Revenue',120000,'2026-04-10'),
(4,10,'Retail','Revenue',130000,'2026-05-10'),
(4,10,'Retail','Revenue',145000,'2026-06-10'),

(5,13,'Education','Revenue',110000,'2026-01-10'),
(5,13,'Education','Revenue',120000,'2026-02-10'),
(5,13,'Education','Revenue',130000,'2026-03-10'),
(5,13,'Education','Revenue',145000,'2026-04-10'),
(5,13,'Education','Revenue',160000,'2026-05-10'),
(5,13,'Education','Revenue',175000,'2026-06-10'),

(6,16,'Services','Revenue',95000,'2026-01-10'),
(6,16,'Services','Revenue',98000,'2026-02-10'),
(6,16,'Services','Revenue',100000,'2026-03-10'),
(6,16,'Services','Revenue',102000,'2026-04-10'),
(6,16,'Services','Revenue',105000,'2026-05-10'),
(6,16,'Services','Revenue',108000,'2026-06-10');

-- =========================================
-- 6. BUDGETS (6 MONTH PLANNING)
-- =========================================

INSERT INTO budgets (user_id, department_id, budget_month, budget_year, amount)
VALUES
(1,1,1,2026,200000),(1,1,2,2026,205000),(1,1,3,2026,210000),
(1,1,4,2026,215000),(1,1,5,2026,220000),(1,1,6,2026,230000),

(2,4,1,2026,150000),(2,4,2,2026,155000),(2,4,3,2026,160000),
(2,4,4,2026,180000),(2,4,5,2026,200000),(2,4,6,2026,210000),

(3,7,1,2026,100000),(3,7,2,2026,102000),(3,7,3,2026,105000),
(3,7,4,2026,108000),(3,7,5,2026,110000),(3,7,6,2026,115000),

(4,10,1,2026,180000),(4,10,2,2026,185000),(4,10,3,2026,190000),
(4,10,4,2026,200000),(4,10,5,2026,210000),(4,10,6,2026,220000),

(5,13,1,2026,160000),(5,13,2,2026,165000),(5,13,3,2026,170000),
(5,13,4,2026,180000),(5,13,5,2026,190000),(5,13,6,2026,200000),

(6,16,1,2026,140000),(6,16,2,2026,142000),(6,16,3,2026,145000),
(6,16,4,2026,148000),(6,16,5,2026,150000),(6,16,6,2026,155000);