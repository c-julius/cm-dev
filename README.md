# CM Demo Development Environment

This repository contains a full-stack demo application for company and employee management, featuring:
- **Backend:** Laravel API with JWT authentication
- **Frontend:** Vue.js SPA
- **E2E Testing:** Cypress (Dockerized)

## Directory Structure
- `backend/` — Laravel API (auth, company, employee, seeding)
- `frontend/` — Vue.js SPA (JWT auth, CRUD UI)
- `cypress-tests/` — Cypress E2E tests (Docker-ready)

## How It Works
- The **frontend** communicates with the **backend** via RESTful API endpoints under `/api`.
- JWT tokens are used for authentication; the frontend stores the token and attaches it to API requests.
- The **Cypress** tests run against the full stack, using Docker for isolation and repeatability.

## Setup Instructions

### 1. Clone the Repository
```bash
git clone --recurse-submodules git@github.com:c-julius/cm-dev.git
cd cm-dev
```

### 2. Docker setup
- Copy the example environment file:
  ```bash
  cp .env.example .env
  ```
- Set the database password in `secrets/db_password`
  - e.g. `echo "cm_password" > secrets/db_password`
- Start Docker Compose:
  ```bash
  docker-compose up
  ```
  - This will start the nginx, app, and Cypress containers. The app container will set up the backend and frontend automatically.
  - The app container will also run migrations and seed the database with demo data.

### 3. Backend Setup
- No manual steps needed if using Docker Compose.
- For local dev (optional):
  ```bash
  cd backend
  composer install
  cp .env.example .env
  php artisan key:generate
  php artisan jwt:secret
  php artisan migrate --seed
  ```

### 4. Frontend Setup
- The frontend is served via Docker Compose and proxies API requests to the backend.
- No manual steps needed if using Docker Compose.
- For local dev (optional):
  ```bash
  cd frontend
  npm install
  npm run serve
  ```

### 5. Cypress E2E Tests
- Cypress is set up to run in Docker for both headless and interactive (GUI) modes.
- For interactive GUI (vai X11 forwarding):
  ```bash
  docker-compose exec cypress cypress open -P /e2e
  ```
  This assumes the host has an X server running and is set up for GUI applications.
    - I.e. a Linux host with X11 forwarding enabled, or Windows with WSL2.
- For headless mode:
  ```bash
  docker-compose exec cypress cypress run -P /e2e
  ```

## App usage
- Access the frontend at `http://localhost:8000`.
- The backend API is available at `http://localhost:8000/api`.
- Use the provided demo credentials to log in:
  - **Email:** `admin@example.com`
  - **Password:** `password`
- The frontend allows you to manage companies and employees, with JWT authentication handled automatically.

## Notes
- All API endpoints are under `/api`.
- Use the provided seeders for demo data.
- For troubleshooting, check logs in the respective containers.
