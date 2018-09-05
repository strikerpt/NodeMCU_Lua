-- Petit script pour connecter le NodeMCU sur un AP Wifi

print("\n wifi_client.lua   hv180824.1345  \n")

wifi.sta.disconnect()
wifi.setmode(wifi.STATION)
wifi.sta.config{ssid="Hugo", pwd="tototutu"}

wifitimer1=tmr.create()
wifi.sta.connect()
tmr.alarm(wifitimer1, 1000, tmr.ALARM_AUTO , function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...")
   else
      print("Connected! IP: ",wifi.sta.getip())
      tmr.stop(wifitimer1)
      oledline1=wifi.sta.getip()
   end
end)
