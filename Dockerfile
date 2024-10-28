# Gunakan image dasar Python
FROM python:3.9-slim

# Instal dependencies untuk Selenium dan Chrome
RUN apt-get update && \
    apt-get install -y wget unzip xvfb && \
    wget -q -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y /tmp/chrome.deb && \
    rm /tmp/chrome.deb && \
    rm -rf /var/lib/apt/lists/*

# Instal Selenium dan SeleniumBase
RUN pip install selenium seleniumbase undetected-chromedriver

# Set variabel lingkungan untuk menggunakan Chrome secara headless
ENV DISPLAY=:99

# Salin script Python ke container
WORKDIR /usr/src/app
COPY script.py .

# Jalankan Xvfb dan script Python
CMD Xvfb :99 -screen 0 1920x1080x16 & python script.py