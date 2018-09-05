-- petit script pour la gestion du GET du serveur web

print("\n web_get.lua   hv180905.1427   \n")

webtimer1=tmr.create()

--Réaction des boutons 
function web_get()
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
        tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, function()
        stop()
        oled_line1="Auto..."
        oled_line2=""
        oled_line3=""
        oled_line4=""
        oled_line5=""
        disp_oled()
        zauto=true
        end)
    elseif (_GET.pin == "MANUEL") then
        tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, function()
        stop()
        oled_line1="Manuel..."
        oled_line2=""
        oled_line3=""
        oled_line4=""
        oled_line5=""
        disp_oled()
        zauto=false
        end)
    elseif (_GET.pin == "WIFI") then
        dofile("wifi_cnf_start.lua")
    elseif (_GET.pin == "TEST1") then
        tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, function() dofile("start_job.lua") end)
    elseif (_GET.pin == "TEST2") then
        print("toto")
        oled_line1="Restart..."
        oled_line2=""
        oled_line3=""
        oled_line4=""
        oled_line5=""
        disp_oled()
        zauto=false
        tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, node.restart)
    end
end