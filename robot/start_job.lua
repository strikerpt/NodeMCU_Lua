print("\n start_job.lua hv180904.1758 \n")

jobtimer1=tmr.create()
jobtimer2=tmr.create()

oled_line1="Job Start..."
oled_line2=""
oled_line3=""
oled_line4=""
oled_line5=""
disp_oled()

oled_line1="AUTO..."
oled_line2=""
oled_line3=""
oled_line4=""
oled_line5=""
disp_oled()

zpeed=50
zauto=true

function return_mesure()
    print(zlength)
    if zauto then 
        if zlength<0.20 then
            right()
        end
    else
        oled_line1=zlength.." m"
        oled_line2=""
        oled_line3=""
        oled_line4="NodeMCU: "..wifi.ap.getmac()        
        disp_oled()
    end
end

--dofile("motor.lua")
dofile("detector.lua")

forward()
tmr.alarm(jobtimer1, 600, tmr.ALARM_AUTO, start_mesure)



