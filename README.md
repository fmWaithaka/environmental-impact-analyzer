# Environmental Impact Analyzer - How to Run

This document provides instructions on how to set up and run the Environmental Impact Analyzer project, including the backend API, frontend application, and PostgreSQL database.

## Project Structure

```
/home/ubuntu/environmental_impact_analyzer/
├── backend/
│   ├── venv/                # Python virtual environment
│   └── main.py              # FastAPI application
├── frontend/
│   ├── node_modules/        # Node.js dependencies
│   ├── public/
│   ├── src/
│   ├── index.html
│   ├── package.json
│   ├── tailwind.config.js
│   ├── postcss.config.js
│   └── vite.config.js       # Vite configuration (updated for allowedHosts)
├── database_schema.sql      # PostgreSQL database schema
├── project_description.txt  # Extracted project description
└── todo.md                  # Project task checklist
```

## Prerequisites

Ensure the following are installed on your system:

*   **Python 3.11+**
*   **Node.js & npm** (Node.js v22.13.0 and npm v10.9.2 were used in development)
*   **PostgreSQL** (Version 14 was used in development)

## Setup and Running Instructions

### 1. PostgreSQL Database Setup

   a.  **Start PostgreSQL Service:**
       Ensure your PostgreSQL service is running. If not, start it using:
       ```bash
       sudo systemctl start postgresql
       sudo systemctl enable postgresql # To start on boot
       ```

   b.  **Create Database and Apply Schema:**
       You need to create a database and then apply the schema. The following commands assume you have `psql` access as the `postgres` user.

       First, copy the schema file to a location accessible by the `postgres` user (e.g., `/tmp/`) and set appropriate permissions:
       ```bash
       sudo cp /home/ubuntu/environmental_impact_analyzer/database_schema.sql /tmp/database_schema.sql
       sudo chmod 644 /tmp/database_schema.sql
       ```

       Then, create the database and apply the schema:
       ```bash
       sudo -u postgres psql -c "DROP DATABASE IF EXISTS environmental_impact_db;"
       sudo -u postgres psql -c "CREATE DATABASE environmental_impact_db;"
       sudo -u postgres psql -d environmental_impact_db -f /tmp/database_schema.sql
       ```
       This will create a database named `environmental_impact_db` and set up the necessary tables.

### 2. Backend (FastAPI) Setup and Run

   a.  **Navigate to Backend Directory:**
       ```bash
       cd /home/ubuntu/environmental_impact_analyzer/backend
       ```

   b.  **Activate Virtual Environment:**
       If you haven't already, create and activate the Python virtual environment:
       ```bash
       python3.11 -m venv venv
       source venv/bin/activate
       ```

   c.  **Install Dependencies:**
       Install the required Python packages:
       ```bash
       pip3 install fastapi uvicorn[standard]
       ```

   d.  **Run the Backend Server:**
       Start the FastAPI application using Uvicorn:
       ```bash
       uvicorn main:app --host 0.0.0.0 --port 8000
       ```
       The backend API will be running at `http://0.0.0.0:8000` (or `http://localhost:8000`).
       During development, it was temporarily accessible at: `https://8000-imxal5ns2bjfhya6c4top-b162364b.manus.computer` (this URL is temporary and may not be active).

### 3. Frontend (React + Vite) Setup and Run

   a.  **Navigate to Frontend Directory:**
       ```bash
       cd /home/ubuntu/environmental_impact_analyzer/frontend
       ```

   b.  **Install Dependencies:**
       Install the Node.js dependencies:
       ```bash
       npm install
       ```
       Ensure Tailwind CSS and its peer dependencies are correctly installed (versions compatible with Tailwind CSS v3 were used):
       ```bash
       npm install -D tailwindcss@^3.0 postcss@^8.0 autoprefixer@^10.0
       ```
       Initialize Tailwind CSS configuration (if not already present or if you need to regenerate):
       ```bash
       npx tailwindcss init -p
       ```

   c.  **Configure Vite for Public Access (if needed for development proxies):
       The `vite.config.js` file was updated during development to allow access from the public proxy URL. The relevant section looks like this:
       ```javascript
       // vite.config.js
       import { defineConfig } from 'vite'
       import react from '@vitejs/plugin-react'

       export default defineConfig({
         plugins: [react()],
         server: {
           host: '0.0.0.0',
           port: 5173,
           allowedHosts: ['YOUR_PUBLIC_PROXY_DOMAIN_HERE'] // e.g., '5173-imxal5ns2bjfhya6c4top-b162364b.manus.computer'
         }
       })
       ```
       If you are running behind a different proxy or need to access it from a specific hostname, update `allowedHosts` accordingly.

   d.  **Run the Frontend Development Server:**
       Start the React application using Vite:
       ```bash
       npm run dev -- --host 0.0.0.0 --port 5173
       ```
       The frontend application will be running at `http://0.0.0.0:5173` (or `http://localhost:5173`).
       During development, it was temporarily accessible at: `https://5173-imxal5ns2bjfhya6c4top-b162364b.manus.computer` (this URL is temporary and may not be active).

## Accessing the Application

*   **Backend API:** `http://localhost:8000`
*   **Frontend Application:** `http://localhost:5173`

Open the frontend URL in your browser to interact with the Environmental Impact Analyzer.

## Notes

*   The provided public URLs for backend and frontend were temporary and for development/validation purposes only. You will need to run the servers locally as described above or deploy them to your own hosting environment for persistent access.
*   This project is a scaffold. Further development is needed to implement the full functionality described in the project PDF, including data collection, NLP processing, scoring logic, and UI/UX enhancements.
*   Remember to deactivate the Python virtual environment when you are done working on the backend:
    ```bash
    deactivate
    ```

