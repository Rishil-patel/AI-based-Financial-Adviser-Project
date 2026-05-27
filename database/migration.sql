-- =========================================
-- MIGRATION: Department Types System
-- AI Financial Advisor
-- =========================================



-- =========================================
-- 1. CREATE DEPARTMENT TYPES TABLE
-- =========================================

CREATE TABLE department_types (
    id SERIAL PRIMARY KEY,

    type_name VARCHAR(50) UNIQUE NOT NULL,

    description TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- =========================================
-- 2. SEED DEPARTMENT TYPES (FINAL 5)
-- =========================================

INSERT INTO department_types (type_name, description)
VALUES
('revenue_generating', 'Activities that bring direct income to the business'),
('growth_marketing', 'Activities focused on customer acquisition and branding'),
('operations', 'Core execution and service delivery functions'),
('support', 'Internal support and administrative functions'),
('finance_control', 'Financial tracking, budgeting, and control activities');



-- =========================================
-- 3. MODIFY DEPARTMENTS TABLE
-- =========================================

-- Add department_type_id column
ALTER TABLE departments
ADD COLUMN department_type_id INT;



-- =========================================
-- 4. LINK FOREIGN KEY
-- =========================================

ALTER TABLE departments
ADD CONSTRAINT fk_department_type
FOREIGN KEY (department_type_id)
REFERENCES department_types(id)
ON DELETE SET NULL;



-- =========================================
-- 5. OPTIONAL CLEANUP (if needed later)
-- =========================================

-- You can later remove old classification fields if they existed:
-- ALTER TABLE departments DROP COLUMN is_universal;
-- ALTER TABLE departments DROP COLUMN department_category;



-- =========================================
-- 6. INDEX FOR PERFORMANCE
-- =========================================

CREATE INDEX idx_departments_type
ON departments(department_type_id);