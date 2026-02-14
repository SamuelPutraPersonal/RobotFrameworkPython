# Step 1: Use an official Python runtime as the base image
FROM python:3.12-slim

# Step 2: Install system dependencies needed for Chrome and Selenium
# 'slim' images are small, so we must add basic tools like curl and unzip
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# Step 3: Set the working directory inside the container to /app
WORKDIR /app

# Step 4: Copy your requirements file into the container first
# This helps Docker cache your installed libraries
COPY requirements.txt .

# Step 5: Install the Robot Framework libraries
RUN pip install --no-cache-dir -r requirements.txt

# Step 6: Copy your entire project (Basic folder, etc.) into the container
# This ignores anything listed in your .dockerignore
COPY . .

# Step 7: Run the test when the container starts
# This saves results into the /results folder inside the container
CMD ["robot", "-d", "results", "Basic/TC3.robot"]