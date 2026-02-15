Getting Started: Installation & Execution
1. Local Setup (Non-Docker)
If you want to run tests directly on your Mac/Windows machine:

Clone the Repo:

Bash
git clone <your-repo-url>
cd <project-folder>
Initialize Environment:

Bash
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
Run: robot -d results Basic/TC1.robot

🐳 2. Running in DevContainer (Recommended)
This is the easiest way to develop. It uses the pre-configured environment inside VS Code.

Open the project in VS Code.

When prompted (bottom right), click "Reopen in Container".

Select Interpreter: Press Cmd+Shift+P -> Python: Select Interpreter -> /usr/local/bin/python.

Run with Play Button: Open any .robot file and click the "Play" icon.

📦 3. Running via Docker Command Line
To run your tests inside a standalone container (identical to the CI pipeline):

Build: docker build -t robot-app .

Execute:

Bash
docker run --rm -v $(pwd)/results:/app/results robot-app \
robot --variable RUN_IN_DOCKER_MODE:True -d results Basic/
Pro-Tip for your README:
Make sure to keep your requirements.txt up to date so that the "Install" steps always work for new users!