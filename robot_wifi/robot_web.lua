-- petit script de serveur Wifi pour piloter le robot

print("\n robot_web.lua   hv180822.0912  \n")

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
    if (_GET.pin == "LEFT") then
        left()
    elseif (_GET.pin == "RIGHT") then
        right()
    elseif (_GET.pin == "FORWARD") then 
        forward()
    elseif (_GET.pin == "BACKWARD") then
        backward()
    elseif (_GET.pin == "STOP") then
        stop()
    end
    
--Partie HTML et CSS pour la page web
    buf = buf .. "<!DOCTYPE html><html><body><h1>Controler le robot : </h1></br> <a href=\"?pin=FORWARD\"><button id=\"buttonforward\">FORWARD</button></a></br>"
    buf = buf .. "<a href=\"?pin=LEFT\"><button id=\"buttonleft\">LEFT</button></a><a href=\"?pin=STOP\"><button id=\"buttonstop\">STOP</button></a><a href=\"?pin=RIGHT\"><button id=\"buttonright\">RIGHT</button></a></br>"
    buf = buf .. "<a href=\"?pin=BACKWARD\"><button id=\"buttonbackward\">BACKWARD</button></a>"
    buf = buf .. "<style> #buttonforward, #buttonbackward {position:relative; left:100px; height:100px; width:100px;} </style>"
    buf = buf .. "<style> #buttonleft, #buttonright, #buttonstop {position:relative; height:100px; width:100px;} </style> "   
    client:send(buf)
  end)
  conn:on("sent", function(c) c:close() end)
end)
