print("\n start_job.lua hv180830.1430 \n")

jobtimer1=tmr.create()
jobtimer2=tmr.create()
jobtimer3=tmr.create()
jobtimer4=tmr.create()

dofile("disp_oled_old.lua")
oled_line1="RESET"
oled_line2=""
oled_line3=""
oled_line4=""
oled_line5=""
disp_oled()

oled_line1="DEMO"
oled_line2=""
oled_line3=""
oled_line4=""
oled_line5=""
disp_oled()

zpeed=50
zauto=true

function return_mesure()
    print(zlength)
    oled_line1=zlength.." m"
    oled_line2=""
    oled_line3=""
    oled_line4="NodeMCU: "..wifi.ap.getmac()
   
    if zauto then 
        if zlength<0.25 then
            right()
        end
    else
        disp_oled()
    end
end

    dofile("wifi_ap_start.lua")
    dofile("motor.lua")
    dofile("detector.lua")
    dofile("robot_web.lua")
    dofile("telnet_srv.lua")
    forward()
    tmr.alarm(jobtimer2, 500, tmr.ALARM_AUTO, start_mesure)



