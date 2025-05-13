-- Database schema for Environmental Impact Analyzer

-- Products Table: Stores information about the products being assessed.
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(255),
    description TEXT,
    category VARCHAR(100), -- e.g., Apparel, Beverages, Electronics
    manufacturing_country VARCHAR(100),
    weight_kg NUMERIC(10, 3), -- Weight in kilograms
    packaging_type VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Materials Table: Stores information about different materials and their known impact.
CREATE TABLE materials (
    material_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL, -- e.g., Cotton, Recycled Aluminum, PET Plastic
    sustainability_score INTEGER, -- A score representing its sustainability (e.g., 1-10)
    co2_per_kg NUMERIC(10, 4), -- CO2e emissions per kg of material
    water_usage_per_kg NUMERIC(10, 2), -- Water usage in liters per kg of material
    recyclability BOOLEAN,
    biodegradability BOOLEAN,
    source_info TEXT -- Information about common sources or certifications
);

-- Product_Materials Junction Table: Links products to their constituent materials and quantities.
CREATE TABLE product_materials (
    product_id INTEGER REFERENCES products(product_id) ON DELETE CASCADE,
    material_id INTEGER REFERENCES materials(material_id) ON DELETE RESTRICT,
    percentage NUMERIC(5, 2), -- Percentage of this material in the product
    PRIMARY KEY (product_id, material_id)
);

-- Impact Factors Table: Defines the environmental impact factors being considered.
CREATE TABLE impact_factors (
    factor_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL, -- e.g., Carbon Footprint, Water Usage, Material Sustainability
    description TEXT,
    unit VARCHAR(50), -- e.g., CO2e, Liters, Score
    weight NUMERIC(5, 2) -- Weight of this factor in the overall Eco-Score calculation
);

-- Assessments Table: Stores the results of environmental impact assessments for products.
CREATE TABLE assessments (
    assessment_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(product_id) ON DELETE CASCADE,
    assessment_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    eco_score NUMERIC(5, 2), -- Overall Eco-Score (e.g., 1-100 or A-E mapping)
    carbon_footprint_co2e NUMERIC(10, 4),
    water_usage_liters NUMERIC(10, 2),
    material_sustainability_score NUMERIC(5, 2),
    chemical_usage_score NUMERIC(5, 2),
    waste_generation_score NUMERIC(5, 2),
    assumptions_notes TEXT, -- Notes on assumptions made during the assessment
    data_sources TEXT -- Sources used for this specific assessment
);

-- Certifications Table: Stores information about various environmental certifications.
CREATE TABLE certifications (
    certification_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL, -- e.g., Fair Trade, Organic, Cradle to Cradle
    description TEXT,
    issuing_organization VARCHAR(255)
);

-- Product_Certifications Junction Table: Links products to their certifications.
CREATE TABLE product_certifications (
    product_id INTEGER REFERENCES products(product_id) ON DELETE CASCADE,
    certification_id INTEGER REFERENCES certifications(certification_id) ON DELETE RESTRICT,
    PRIMARY KEY (product_id, certification_id)
);

-- User Feedback Table
CREATE TABLE user_feedback (
    feedback_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(product_id) ON DELETE SET NULL, -- Optional link to a product
    assessment_id INTEGER REFERENCES assessments(assessment_id) ON DELETE SET NULL, -- Optional link to an assessment
    user_email VARCHAR(255), -- Optional user email
    feedback_text TEXT NOT NULL,
    submission_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'new' -- e.g., new, reviewed, addressed
);

-- Function to update 'updated_at' timestamp
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for products table
CREATE TRIGGER set_timestamp_products
BEFORE UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

-- You might want to add indexes for frequently queried columns, for example:
-- CREATE INDEX idx_products_name ON products(name);
-- CREATE INDEX idx_materials_name ON materials(name);
-- CREATE INDEX idx_assessments_product_id ON assessments(product_id);

