from seleniumbase import Driver
import json

driver = Driver(uc=True, xvfb=True, incognito=True)
url = "https://www.idx.co.id/primary/ListedCompany/GetAnnouncement?kodeEmiten=&emitenType=*&indexFrom=1&pageSize=10&dateFrom=19010101&dateTo=20241029&lang=id&keyword="
driver.uc_open_with_reconnect(url, 4)
driver.uc_gui_click_captcha()
json_data = driver.execute_script("return document.body.innerText;")
data = json.loads(json_data)
print(json.dumps(data, indent=4))
driver.quit()