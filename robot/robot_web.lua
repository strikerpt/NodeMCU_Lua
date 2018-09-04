-- petit script de serveur Wifi pour piloter le robot

print("\n robot_web.lua   hv180904.1513   \n")

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
        zauto=false
        stop()        
    elseif (_GET.pin == "LENT") then
        zpeed=50
        set_speed()
    elseif (_GET.pin == "MOYEN") then
        zpeed=70
        set_speed()
    elseif (_GET.pin == "VITE") then
       zpeed=100
       set_speed()
    elseif (_GET.pin == "AUTO") then
        oled_line1="Auto..."
        oled_line2=""
        oled_line3=""
        oled_line4=""
        oled_line5=""
        disp_oled()
        zauto=true       
    elseif (_GET.pin == "MANUEL") then
        oled_line1="Manuel..."
        oled_line2=""
        oled_line3=""
        oled_line4=""
        oled_line5=""
        disp_oled()
        zauto=false
    elseif (_GET.pin == "WIFI") then
        dofile("wifi_cnf_start.lua")
    elseif (_GET.pin == "TEST1") then
        dofile("start_job.lua")
    end
    
--Partie HTML et CSS pour la page web
    buf = buf .. "<!DOCTYPE html><html><body><meta charset='utf-8' name='viewport' content='width=device-width, initial-scale=1.0'>\n" 
    buf = buf .. "<h1>Contrôler le robot : </h1></br> <a href='?pin=FORWARD'><button id='buttonforward'>FORWARD</button></a></br>\n"
    buf = buf .. "<a href='?pin=LEFT'><button id='buttonleft'>LEFT</button></a><a href='?pin=STOP'><button id='buttonstop'>STOP</button></a><a href='?pin=RIGHT'><button id='buttonright'>RIGHT</button></a></br>\n"
    buf = buf .. "<a href='?pin=BACKWARD'><button id='buttonbackward'>BACKWARD</button></a></br>\n"
    buf = buf .. "<h1> Vitesse : </h1> </br>\n" 
    buf = buf .. "<a href='?pin=LENT'><button id='buttonlent'> L </button></a><a href='?pin=MOYEN'><button id='buttonmoyen'> M </button></a><a href='?pin=VITE'><button id='buttonvite'> V </button></a></br>\n" 
    buf = buf .. "<h1> Robot : </h1> </br>\n" 
    buf = buf .. "<a href='?pin=AUTO'><button id='buttonauto'> AUTO </button></a><a href='?pin=MANUEL'><button id='buttonmanuel'> MANUEL </button></a></br>\n"
    buf = buf .. "<h1> Tests : </h1> </br>\n" 
    buf = buf .. "<a href='?pin=TEST1'><button id='buttontest1'> TEST1 </button></a>\n"
    buf = buf .. "<a href='?pin=TEST2'><button id='buttontest2'> TEST2 </button></a>\n"
    buf = buf .. "<a href='?pin=TEST3'><button id='buttontest3'> TEST3 </button></a>\n"
    buf = buf .. "<h1> Wifi : </h1> </br>\n" 
    buf = buf .. "<a href='?pin=WIFI'><button id='buttonwifi'> WIFI </button></a>\n"
    buf = buf .. "<style>\n"
    buf = buf .. "#buttonforward, #buttonbackward {font-size:10px; position:relative; left:70px; height:70px; width:70px;}\n"
    buf = buf .. "#buttonleft, #buttonright, #buttonstop {font-size:10px; position:relative; height:70px; width:70px;}\n"   
    buf = buf .. "#buttonvite, #buttonmoyen, #buttonlent {font-size:10px; position:relative; height:70px; width:70px;}\n"
    buf = buf .. "#buttonauto, #buttonmanuel {font-size:10px; position:relative; height:70px; width:70px;}\n"
    buf = buf .. "#buttonwifi {font-size:10px; position:relative; height:70px; width:70px;}\n"
    buf = buf .. "#buttontest1, #buttontest2, #buttontest3 {font-size:10px; position:relative; height:70px; width:70px;}\n"
    buf = buf .. "</style>\n"
    client:send(buf)
  end)
  conn:on("sent", function(c) c:close() end)
end)
