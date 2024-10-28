from flask import Flask, jsonify
from seleniumbase import Driver
import json

app = Flask(__name__)

@app.route('/get-json', methods=['GET'])
def get_json():
    # Inisialisasi Selenium driver
    driver = Driver(uc=True, incognito=True)
    
    try:
        # URL halaman yang mengembalikan JSON
        url = "https://www.idx.co.id/primary/ListedCompany/GetAnnouncement?kodeEmiten=&emitenType=*&indexFrom=1&pageSize=10&dateFrom=19010101&dateTo=20241029&lang=id&keyword="  # Ganti dengan URL Anda
        driver.get(url)

        # Eksekusi JavaScript untuk mendapatkan JSON dari body
        json_data = driver.execute_script("return document.body.innerText;")
        data = json.loads(json_data)  # Konversi string JSON ke dictionary Python

        return jsonify(data)  # Kembalikan sebagai JSON response Flask

    except Exception as e:
        # Jika ada error, kirim pesan error sebagai JSON
        return jsonify({"error": str(e)}), 500

    finally:
        # Tutup driver
        driver.quit()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
