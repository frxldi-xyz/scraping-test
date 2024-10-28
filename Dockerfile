# Gunakan image dasar Python
FROM python:3.9-slim

# Instal dependencies untuk Selenium, Flask, dan Chrome
RUN apt-get update && \
    apt-get install -y wget unzip xvfb && \
    wget -q -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y /tmp/chrome.deb && \
    rm /tmp/chrome.deb && \
    rm -rf /var/lib/apt/lists/*

# Install pip dependencies
RUN pip install flask seleniumbase undetected-chromedriver

# Set variabel lingkungan untuk Flask
ENV FLASK_APP=app.py

# Set working directory
WORKDIR /usr/src/app

# Copy semua file ke container
COPY . .

# Jalankan Xvfb dan Flask
CMD ["xvfb-run", "-a", "flask", "run", "--host=0.0.0.0"]