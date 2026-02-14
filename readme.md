# Robot Framework Automation Project

This repository contains a portable Robot Framework automation suite using SeleniumLibrary. It is designed to work identically across any machine using Docker and VS Code.

## 🚀 Getting Started (Other Laptops)

### 1. Prerequisites
Ensure the following are installed on your machine:
* **Git**
* **Docker Desktop** (Running)
* **VS Code** (with the 'Dev Containers' extension)

---

## 💻 Option A: The "One-Click" Development (Recommended)
This method opens the project *inside* the Docker container. You don't need to install Python locally.

1. Clone the repo: `git clone <your-repo-url>`
2. Open the folder in VS Code.
3. When prompted "Reopen in Container", click **Yes**.
4. VS Code will build the environment and automatically enable auto-suggestions (RobotCode).

---

## 🛠 Option B: Manual Setup (Local Development)
If you prefer to run directly on your Mac/Windows without Docker:

1. Create a virtual environment:
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # Mac/Linux
   # or venv\Scripts\activate # Windows