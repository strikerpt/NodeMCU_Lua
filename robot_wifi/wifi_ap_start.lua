-- Démarre un WIFI AP
print("\n wifi_ap_start.lua   zf180823.1039   \n")

wifi.setmode(wifi.SOFTAP)
wifi.ap.config({ ssid = "Hugo", pwd = "tototutu" })
