-- Petit script pour connecter le NodeMCU sur un AP Wifi



print("\nWifi_client.lua   hv180821.1620  \n")

wifitimer1=tmr.create()
wifi.sta.connect()
tmr.alarm(wifitimer1, 1000, tmr.ALARM_AUTO , function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...")
   else
      print("Connected! IP: ",wifi.sta.getip())
--      tmr.stop(wifitimer1)
   end
end)
