--Petit serveur WEB pour allumer/éteindre une LED en mode client WIFI
print("\nDémarrage hv20180711.1606\n")

hvtime=tmr.create()
wifi.sta.connect()
tmr.alarm(hvtime, 1000, tmr.ALARM_AUTO , function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...")
   else
      print("Connected! IP: ",wifi.sta.getip())
      tmr.stop(hvtime)
   end
end)
srv = net.createServer(net.TCP)

srv:listen(80, function(conn)
  conn:on("receive", function(client, request)
    local buf = ""
    local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
    if (method == nil) then
     _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
    end
    local _GET = {}
    print("Nouvelle entrée !")
    if (vars ~= nil) then
      for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
        _GET[k] = v
        print(k..": "..v)
      end
    end

    buf = buf .. "<!DOCTYPE html><html><body><h1>web_oled</h1></br><form name=\"hform\">"

        if hinput==1 then   
            print(htext)
        end
   
    buf = buf .. "<textarea name=htext>hello zuzu</textarea> </br> <input name=\"hinput\" type=\"submit\"></input></form></body></html>"
    client:send(buf)
  end)
  conn:on("sent", function(c) c:close() end)
end)

