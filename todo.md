# Project Todo List

## Phase 1: Foundation & Data Acquisition

### Step 1: Project Setup & Initial Design (Weeks 1-2)
- [ ] Set up Git repository (GitHub/GitLab).
- [X] Establish development environments (Python, Node.js for frontend build tools, VS Code).
- [X] Create basic project structures for backend (FastAPI) and frontend (React/Vue).
- [X] Design initial database schema in PostgreSQL (for products, materials, impact factors, assessments).
- [ ] Create low-fidelity wireframes for the main user flows (product input, results display).

### Step 2: Core Backend API Shell (Weeks 2-4)
- [X] Develop basic FastAPI endpoints:
    - [X] POST /api/v1/assess: Placeholder to receive product info and return a dummy assessment.
    - [X] GET /api/v1/products/{product_id}: Placeholder to fetch product data.
- [X] Set up database connection and basic ORM (e.g., SQLAlchemy with Alembic for migrations, or SQLModel for FastAPI).

### Step 3: Data Source Identification & Prioritization (Weeks 3-6)
- [ ] Deep dive into identifying specific, reliable, and free/accessible data sources for your chosen initial product category.
- [ ] Document URLs, API endpoints (if any), data formats, and access methods.
- [ ] Assess the quality and coverage of these sources.

### Step 4: Initial Data Collection Scripts (Weeks 5-10)
- [ ] Develop Python scripts (Requests, BeautifulSoup, Scrapy if needed) to fetch data from 1-2 key sources.
- [ ] Focus on collecting raw product information (names, descriptions, materials mentioned, brand).
- [ ] Store this raw data (e.g., in JSON files or a staging table in PostgreSQL).

### Step 5: Data Preprocessing & Cleaning (Weeks 8-12)
- [ ] Develop Python scripts (using Pandas) to:
    - [ ] Clean the collected raw data (handle missing values, remove HTML, standardize text).
    - [ ] Normalize units (e.g., convert all weights to kilograms).
    - [ ] Structure the data for storage in your main product database.
- [ ] Populate your PostgreSQL database with this initial cleaned dataset.

## Phase 2: AI Model Development & Backend Logic (Months 3-6)

### Step 6: NLP for Information Extraction (Weeks 10-16)
- [ ] Goal: Extract structured information (materials, manufacturing locations, certifications) from unstructured product descriptions.
- [ ] Process:
    - [ ] Select a pre-trained NER model from Hugging Face or use spaCy's NER capabilities.
    - [ ] Develop Python functions to take product descriptions as input and output extracted entities.
    - [ ] Experiment and iterate.
    - [ ] Store these extracted, structured features in your database, linked to products.

### Step 7: Environmental Impact Scoring Logic - V1 (Rule-Based) (Weeks 14-20)
- [ ] Research: Gather data for impact factors.
- [ ] Develop a Python module:
    - [ ] Define rules and weights for each factor.
    - [ ] This module will take the NLP-extracted features and other product data as input.

### Step 8: Integrate NLP & Scoring into Backend API (Weeks 18-24)
- [ ] Update the /api/v1/assess endpoint.
- [ ] Implement caching.
- [ ] Develop administrative endpoints if needed.

## Phase 3: Frontend Development & User Experience (Months 5-8)

### Step 9: Build Core Frontend UI (Weeks 20-28)
- [ ] Using React/Vue and Tailwind CSS, develop components for:
    - [ ] Input: Search bar, manual input form.
    - [ ] Results Display: Eco-Score, breakdown, assumptions.
    - [ ] Product Comparison (Basic).
- [ ] Connect frontend to backend APIs.
- [ ] Ensure a responsive design.

### Step 10: User Feedback Mechanism (Weeks 26-30)
- [ ] Implement a simple way for users to provide feedback.
- [ ] Create a backend endpoint (POST /api/v1/feedback) to store this.

### Step 11: Basic User Accounts (Optional for V1, but plan) (Weeks 28-32)
- [ ] If desired, integrate a simple authentication system.
- [ ] Allows users to save past assessments or preferences.

## Phase 4: Testing, Deployment, and Iteration (Months 8-9+)

### Step 12: Comprehensive Testing (Weeks 30-36)
- [ ] Backend Unit Tests.
- [ ] Frontend Unit/Component Tests.
- [ ] Integration Tests.
- [ ] Usability Testing.
- [ ] Data Accuracy Testing.

### Step 13: Deployment Strategy & Setup (Weeks 35-38)
- [ ] Containerize: Dockerfile for backend and frontend.
- [ ] Choose Hosting.
- [ ] CI/CD: Set up GitHub Actions.

### Step 14: Monitoring, Logging & Soft Launch (Week 37+)
- [ ] Implement structured logging.
- [ ] Set up basic uptime monitoring.
- [ ] Consider a simple analytics tool.
- [ ] Soft launch to a limited audience.

### Step 15: Iterate and Improve (Ongoing)
- [ ] Collect and analyze user feedback.
- [ ] Continuously work on improving data source quality and coverage.
- [ ] Refine NLP models and the scoring algorithm.
- [ ] Expand to new product categories.
- [ ] Fix bugs and enhance performance.

