# Availability Tracker – CI/CD Project

This project is a CI/CD-enabled version of a real-world web app used to track team availability. It automates code quality checks, formatting validation, and Dockerized deployment through a custom Bash script-based CI/CD pipeline. This setup mimics real DevOps practices and is compatible with manual scripts or integration tools like GitHub Actions or Jenkins. The application is a simple Node.js + Express server that serves static files and provides an endpoint to save history data.

---

## Project Structure

- ci.sh                	  	# CI automation script
- Dockerfile              		# Docker build instructions
- docker-compose.yml      # Service configuration
- server.cjs              		# Main Express server
- package.json            	# Project metadata & scripts

---

## Tech Stack

|       Area       |                        Tools Used                        |
| :--------------: | :-------------------------------------------------------: |
| Version Control |                            Git                            |
|    Scripting    |                           Bash                           |
|  CI/CD Pipeline  | Bash, GitHub Actions (optional), <br />Jenkins (optional) |
|   Code Quality   |                     ESLint, Prettier                     |
|     Testing     |                           Jest                           |
| Containerization |                  Docker, Docker Compose                  |

<!-- | Infrastructure as Code | Terraform (optional)                                | -->

---

## Features

- Serve static frontend (HTML, CSS, JS)
- ESLint for code linting
- Prettier for consistent formatting
- Dockerized using multi-stage builds
- Docker Compose for service orchestration
- Bash script (`ci.sh`) to automate the CI steps

---

## CI Script: `ci.sh`

#### Automates the following steps:

1. Run ESLint and Prettier checks
2. Run tests (placeholder)
3. Build Docker image
4. Run the app using Docker Compose

---

## Prerequisites & Requirements

#### List the technologies or tools required to run the project:

* Node.js v18+
* Docker & Docker Compose (v2)
* Bash (for ``ci.sh``)
* NPM packages: ``express``, ``body-parser``, etc.
* (Optional) Prettier & ESLint

---

## Issues Faced & Solutions:

### 1. `__dirname` is not defined

- Cause: When using ES modules (`type: "module"` in `package.json`) or `import`, `__dirname` is not available.
- Fix: Removed the unnecessary line:

  ```bash
  const __dirname = __dirname;
  ```

  In CommonJS, `__dirname` is available by default.

### 2. ESLint / Prettier Warnings

- Cause: Linting and formatting errors on first run.
- Fix: Updated files manually and used:

  ```bash
  npx prettier --write .
  ```

### 3. `docker-compose` not recognized

- Cause: Legacy Docker Compose was missing or outdated.
- Fix: Installed the Docker Compose plugin correctly:

  ```bash
  sudo apt remove docker-compose   
  sudo apt update   
  sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin   
  ```

### 4. Error: no test specified

- Cause: The npm test command runs by default but no tests were defined.
- Fix (temporary): Ignored error using || true. You can later add actual tests in test/ or with a framework like Mocha or Jest.

### 5. `Parsing error: 'import' and 'export' may appear only with 'sourceType: module'`

- Cause: ESLint complained about import/export statements in a file being interpreted as CommonJS (.cjs), which doesn’t support ES module syntax by default.
- Fix:

  - Avoided mixing require(...) and import ... from in .cjs files.
  - Used only require() in server.cjs, which is compatible with CommonJS.
  - Removed:

    ```bash
    import { dirname } from 'path';
    import { fileURLToPath } from 'url';
    ```

    and just used `__dirname` (already available in ``.cjs``).

### 6. ``console`` and ``__dirname`` reported as ``not defined`` in ESLint

- Cause: ESLint rules no-undef were triggered for globals like console and __dirname.
- Fix:

  - Added the following config to .eslintrc.json:

    ```json
    {
      "env": {
          "node": true
      }
    }
    ```

    This tells ESLint to recognize Node.js global variables.

### 7. CRLF (Windows line endings) issues in ``ci.sh``

- Cause: CI shell script showed invisible syntax or permission issues due to Windows line endings (CRLF).
- Fix:

  - Converted the script to Unix format using:

    ```bash
    sudo apt install dos2unix
    dos2unix ci.sh
    ```
  - Re-ran with:

    ```bash
    chmod +x ci.sh
    ./ci.sh
    ```

### 8. Docker Compose CLI not found (``docker: 'compose' is not a docker command``)

- Cause: The system was using Docker without the new Compose CLI plugin.
- Fix:

  - Uninstalled the legacy docker-compose:

    ```bash
    sudo apt remove docker-compose
    ```
  - Reinstalled Compose via Docker's plugin-based method:

    ```bash
    sudo apt update
    sudo apt install docker-compose-plugin
    ```
  - Verified with:

    ```bash
    docker compose version
    ```

### 9. Docker Compose ``version`` warning

- Cause: Docker Compose v2 no longer needs a ``version`` field in ``docker-compose.yml``.
- Fix:

  - Removed the ``version: "3"`` (or similar) line from ``docker-compose.yml`` to avoid warnings.

---

## How to Run the Pipeline Locally

#### 1. Clone the repository:

```bash
git clone https://github.com/O37mousa/TeamavailTest-konecta.git
cd TeamavailTest-konecta
```

#### 2. Make sure Docker is installed and running.

#### 3. Give execute permission to the CI script (if needed):

```bash
chmod +x ci.sh   
./ci.sh   
```

This script will:

* Run ESLint
* Run Prettier check
* Run unit tests with Jest
* Build a Docker image
* Launch the app with Docker Compose

---

## Docker & Compose

#### Build and Run manually:

```bash
docker-compose up --build
```

This builds and launches the app on [http://localhost:3000](http://localhost:3000).

---

## ``.gitignore``

#### To avoid committing unnecessary files, the following are ignored:

```
node_modules/
output/
input/
.env
package-lock.json
.DS_Store
*.log
```
