-- =========================================
-- MIGRATION SYSTEM
-- AI-BASED BUSINESS FINANCIAL ADVISOR
-- =========================================



-- =========================================
-- MIGRATION 1: DEPARTMENT TYPES SYSTEM
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
-- 5. INDEX FOR PERFORMANCE
-- =========================================

CREATE INDEX idx_departments_type
ON departments(department_type_id);



-- =========================================
-- MIGRATION 2: AI INTELLIGENCE LAYER
-- =========================================



-- =========================================
-- 6. EXPENSE AI CLASSIFICATION SUPPORT
-- =========================================

ALTER TABLE expenses
ADD COLUMN predicted_category VARCHAR(100),
ADD COLUMN predicted_department_type_id INT,
ADD COLUMN classification_confidence DECIMAL(5,2);



-- =========================================
-- FK: EXPENSES → DEPARTMENT TYPES (PREDICTION)
-- =========================================

ALTER TABLE expenses
ADD CONSTRAINT fk_expenses_predicted_department_type
FOREIGN KEY (predicted_department_type_id)
REFERENCES department_types(id)
ON DELETE SET NULL;



-- =========================================
-- 7. CLASSIFICATION LOGS (ML MEMORY)
-- =========================================

CREATE TABLE classification_logs (
    id SERIAL PRIMARY KEY,

    expense_id INT REFERENCES expenses(id) ON DELETE CASCADE,

    predicted_category VARCHAR(100),

    predicted_department_type_id INT,

    confidence DECIMAL(5,2),

    model_version VARCHAR(50),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- =========================================
-- FK: CLASSIFICATION LOGS → DEPARTMENT TYPES
-- =========================================

ALTER TABLE classification_logs
ADD CONSTRAINT fk_classification_department_type
FOREIGN KEY (predicted_department_type_id)
REFERENCES department_types(id)
ON DELETE SET NULL;



-- =========================================
-- 8. FINANCIAL INSIGHTS TABLE
-- =========================================

CREATE TABLE financial_insights (
    id SERIAL PRIMARY KEY,

    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,

    insight_type VARCHAR(50) CHECK (
        insight_type IN (
            'spending_trend',
            'cashflow_anomaly',
            'growth_opportunity',
            'risk_detection',
            'budget_alert'
        )
    ),

    title VARCHAR(255),
    message TEXT,

    severity VARCHAR(20) CHECK (
        severity IN ('low', 'medium', 'high')
    ),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- =========================================
-- 9. PREDICTION HISTORY (MODEL EVOLUTION)
-- =========================================

CREATE TABLE prediction_history (
    id SERIAL PRIMARY KEY,

    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,

    prediction_type VARCHAR(50),

    predicted_value DECIMAL(12,2),
    actual_value DECIMAL(12,2),

    accuracy_score DECIMAL(5,2),

    prediction_month INT,
    prediction_year INT,

    model_version VARCHAR(50),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- =========================================
-- 10. SYSTEM EVENT LOGS (DEBUGGING + OBSERVABILITY)
-- =========================================

CREATE TABLE system_event_logs (
    id SERIAL PRIMARY KEY,

    event_type VARCHAR(50),

    entity_type VARCHAR(50),

    entity_id INT,

    message TEXT,

    metadata JSONB,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- =========================================
-- INDEXES (AI PERFORMANCE OPTIMIZATION)
-- =========================================

CREATE INDEX idx_classification_logs_expense
ON classification_logs(expense_id);

CREATE INDEX idx_classification_logs_model
ON classification_logs(model_version);

CREATE INDEX idx_insights_user
ON financial_insights(user_id);

CREATE INDEX idx_prediction_history_user
ON prediction_history(user_id);

CREATE INDEX idx_system_logs_type
ON system_event_logs(event_type);

-- =========================================
-- MIGRATION 3: ADD KEYWORD-BASED AI MAPPING TO EXPENSE CATEGORIES
-- =========================================


-- =========================================
-- 1. ADD AI KEYWORDS SUPPORT TO CATEGORIES
-- =========================================

ALTER TABLE expense_categories
ADD COLUMN keywords TEXT;



-- =========================================
-- 2. OPTIONAL: PRIORITY FOR AI DECISION MAKING
-- =========================================

ALTER TABLE expense_categories
ADD COLUMN priority_weight INT DEFAULT 1;



-- =========================================
-- 3. POPULATE KEYWORDS (INITIAL INTELLIGENCE LAYER)
-- =========================================

UPDATE expense_categories
SET keywords = 'ads,advertising,campaign,marketing,meta,google,instagram'
WHERE category_name = 'Ads Spend';

UPDATE expense_categories
SET keywords = 'cloud,hosting,aws,server,database,backend,infra'
WHERE category_name = 'Cloud Hosting';

UPDATE expense_categories
SET keywords = 'supply,raw material,food,inventory,stock,procurement'
WHERE category_name = 'Food Supply';

UPDATE expense_categories
SET keywords = 'fuel,petrol,diesel,transport,logistics'
WHERE category_name = 'Fuel';

UPDATE expense_categories
SET keywords = 'repair,maintenance,service,upkeep,fix'
WHERE category_name = 'Maintenance';

UPDATE expense_categories
SET keywords = 'salary,payroll,wages,employee,staff'
WHERE category_name = 'Salary';

UPDATE expense_categories
SET keywords = 'rent,lease,office,warehouse,store'
WHERE category_name = 'Rent';

UPDATE expense_categories
SET keywords = 'inventory,stock,goods,purchase,procurement'
WHERE category_name = 'Inventory';

UPDATE expense_categories
SET keywords = 'software,saas,license,subscription,tools'
WHERE category_name = 'Software Tools';



-- =========================================
-- 4. INDEX FOR FAST AI MATCHING
-- =========================================

CREATE INDEX IF NOT EXISTS idx_expense_categories_keywords
ON expense_categories USING GIN (to_tsvector('english', COALESCE(keywords, '')));