-- petit script pour la gestion du GET du serveur web

print("\n web_get.lua   hv180907.0928   \n")

webtimer1=tmr.create()
webtimer2=tmr.create()


--Réaction des boutons 
function web_get()
    if (_GET.pin == "L") then
        left()
    elseif (_GET.pin == "R") then
        right()
    elseif (_GET.pin == "F") then 
        forward()        
    elseif (_GET.pin == "B") then
        backward()       
    elseif (_GET.pin == "S") then
        zauto=false
        stop()        
    elseif (_GET.pin == "LT") then
        zpeed=50
        set_speed()
    elseif (_GET.pin == "M") then
        zpeed=70
        set_speed()
    elseif (_GET.pin == "V") then
       zpeed=100
       set_speed()
    elseif (_GET.pin == "A") then
        tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, function()
            stop()
            oled_line1="Auto..."   oled_line2=""   oled_line3=""   oled_line4=""   oled_line5=""
            disp_oled()
            zauto=true
        end)
    elseif (_GET.pin == "ML") then
        tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, function()
            stop()
            oled_line1="Manuel..."   oled_line2=""   oled_line3=""   oled_line4=""   oled_line5=""
            disp_oled()
            zauto=false 
        end)
    elseif (_GET.pin == "WIFI") then
        tmr.alarm(webtimer1, 2000, tmr.ALARM_SINGLE, function()
            dofile("wifi_cnf_start.lua")
        end)
    elseif (_GET.pin == "T1") then
        tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, function()
            dofile("start_job.lua")
        end)
    elseif (_GET.pin == "T2") then
        oled_line1="Restart..."   oled_line2=""   oled_line3=""   oled_line4=""   oled_line5=""
        disp_oled()
        zauto=false
        tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, node.restart)
     elseif (_GET.pin == "T3") then
        tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, function()
            zauto=false
            zmeter=true
            stop()
            oled_line1="Meter..."   oled_line2=""   oled_line3=""   oled_line4=""   oled_line5=""
            disp_oled()
            tmr.alarm(webtimer2, 600, tmr.ALARM_AUTO, start_mesure)
        end)
    end
end

