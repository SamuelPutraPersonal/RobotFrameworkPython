FROM python:3.12-slim

# Install Chromium and Driver
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    git \
    && rm -rf /var/lib/apt/lists/*

# Fix: Create a link so Selenium finds the driver easily
RUN ln -s /usr/bin/chromedriver /usr/local/bin/chromedriver

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Environment variables to help Selenium
ENV CHROME_BIN=/usr/bin/chromium
ENV CHROMEDRIVER_PATH=/usr/bin/chromedriver

# Optional: Add this to ensure the driver is executable
RUN chmod +x /usr/bin/chromedriver

CMD ["robot", "-d", "results", "Basic/TC3.robot"]