--Timers personnelles 
hvtimer3=tmr.create()
hvtimer4=tmr.create()
hvtimer5=tmr.create()
hvtimer6=tmr.create()
hvtimer7=tmr.create()


--Connexion du nodemcu au réseau
wifi.sta.connect()
tmr.alarm(hvtimer3, 1000, tmr.ALARM_AUTO , function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...")
   else
      print("Connected! IP: ",wifi.sta.getip())
      tmr.stop(hvtimer3)
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
    if (vars ~= nil) then
      for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
        _GET[k] = v
        print(k..": "..v)
      end
    end
    
--Réaction des boutons 
--[[    local _left, _right, _forward, _backward, _stop = "", ""
    if (_GET.pin == "LEFT") then
      _left = " selected=true"
      left()
      tmr.alarm(hvtimer4, 1000, tmr.ALARM_SINGLE, forward)
    elseif (_GET.pin == "RIGHT") then
      _right = " selected=\"true\""
      right()
      tmr.alarm(hvtimer5, 1000, tmr.ALARM_SINGLE, forward)
    elseif (_GET.pin == "FORWARD") then
      _forward = " selected=\"true\""
      forward()
    elseif (_GET.pin == "BACKWARD") then
      _backward = " selected=\"true\""
      backward()
      tmr.alarm(hvtimer6, 2000, tmr.ALARM_SINGLE, right)
      tmr.alarm(hvtimer7, 1000, tmr.ALARM_SINGLE, forward)
      elseif (_GET.pin == "STOP") then
      _stop = " selected=\"true\""
      stop()
    end]]
    
--Partie HTML et CSS pour la page web
    buf = buf .. "<!DOCTYPE html><html><body><h1>Controler le robot : </h1></br> <a href=\"?pin=FORWARD\"><button id=\"buttonforward\">FORWARD</button></a></br>"
    buf = buf .. "<a href=\"?pin=LEFT\"><button id=\"buttonleft\">LEFT</button></a><a href=\"?pin=STOP\"><button id=\"buttonstop\">STOP</button></a><a href=\"?pin=RIGHT\"><button id=\"buttonright\">RIGHT</button></a></br>"
    buf = buf .. "<a href=\"?pin=BACKWARD\"><button id=\"buttonbackward\">BACKWARD</button></a>"
    buf = buf .. "<style> #buttonforward, #buttonbackward {position:relative; left:500px; height:100px; width:100px;} </style>"
    buf = buf .. "<style> #buttonleft, #buttonright, #buttonstop {position:relative; left:400px; height:100px; width:100px;} </style> "   
    client:send(buf)
  end)
  conn:on("sent", function(c) c:close() end)
end)

    

