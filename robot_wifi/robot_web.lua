-- petit script de serveur Wifi pour piloter le robot

print("\n robot_web.lua   hv180824.1655   \n")

srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
  conn:on("receive", function(client, request)
    local buf = ""
    local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
    if (method == nil) then
     _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
    end
    local GET = {}
    if (vars ~= nil) then
      for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
        GET[k] = v
        print(k..": "..v)
      end
    end

--Réaction des boutons 
    if (GET.pin == "LEFT") then
        left()
    elseif (GET.pin == "RIGHT") then
        right()
    elseif (GET.pin == "FORWARD") then 
        forward()
    elseif (GET.pin == "BACKWARD") then
        backward()
    elseif (GET.pin == "STOP") then
        stop()
    elseif (GET.pin == "LENT") then
        zpeed=50
    elseif (GET.pin == "MOYEN") then
        zpeed=70
    elseif (GET.pin == "VITE") then
       zpeed=100
    elseif (GET.pin == "AUTO") then
        zauto=true
    elseif (GET.pin == "MANUEL") then
       zauto=false
    elseif (GET.pin == "WIFI") then
   
    end
    
--Partie HTML et CSS pour la page web
    buf = buf .. "<!DOCTYPE html><html><body><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">" 
    buf = buf .. "<h1>Controler le robot : </h1></br> <a href=\"?pin=FORWARD\"><button id=\"buttonforward\">FORWARD</button></a></br>"
    buf = buf .. "<a href=\"?pin=LEFT\"><button id=\"buttonleft\">LEFT</button></a><a href=\"?pin=STOP\"><button id=\"buttonstop\">STOP</button></a><a href=\"?pin=RIGHT\"><button id=\"buttonright\">RIGHT</button></a></br>"
    buf = buf .. "<a href=\"?pin=BACKWARD\"><button id=\"buttonbackward\">BACKWARD</button></a></br>"
    buf = buf .. "<h1> Vitesse : </h1> </br>" 
    buf = buf .. "<a href=\"?pin=LENT\"><button id=\"buttonlent\"> L </button></a><a href=\"?pin=MOYEN\"><button id=\"buttonmoyen\"> M </button></a><a href=\"?pin=VITE\"><button id=\"buttonvite\"> V </button></a></br>" 
    buf = buf .. "<h1> Robot : </h1> </br>" 
    buf = buf .. "<a href=\"?pin=AUTO\"><button id=\"buttonauto\"> AUTO </button></a><a href=\"?pin=MANUEL\"><button id=\"buttonmanuel\"> MANUEL </button></a></br>"
    buf = buf .. "<h1> Wifi : </h1> </br>" 
    buf = buf .. "<a href=\"?pin=WIFI\"><button id=\"buttonwifi\"> WIFI </button></a>"
    buf = buf .. "<style> #buttonforward, #buttonbackward {font-size:10px; position:relative; left:70px; height:70px; width:70px;} </style>"
    buf = buf .. "<style> #buttonleft, #buttonright, #buttonstop {font-size:10px; position:relative; height:70px; width:70px;} </style> "   
    buf = buf .. "<style> #buttonvite, #buttonmoyen, #buttonlent {font-size:10px; position:relative; height:70px; width:70px;} </style> "
    buf = buf .. "<style> #buttonauto, #buttonmanuel {font-size:10px; position:relative; height:70px; width:70px;} </style> "
    buf = buf .. "<style> #buttonwifi {font-size:10px; position:relative; height:70px; width:70px;} </style> "
    client:send(buf)
  end)
  conn:on("sent", function(c) c:close() end)
end)
