print("\n start_job.lua hv180907.0928 \n")

jobtimer1=tmr.create()

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
    print("RAM: "..node.heap())
    
    if zauto then 
        if zlength < 0.20 then
            if math.random(1,2) == 1 then
                right()
            else
                left()
            end 
        end
        tmr.alarm(jobtimer1, 200, tmr.ALARM_SINGLE, start_mesure)
    else
        if zmeter then
            oled_line1=zlength.." m"
            oled_line2=""
            oled_line3=""
            oled_line4="NodeMCU: "..wifi.ap.getmac()        
            disp_oled()
        end
    end
end

dofile("detector.lua")
tmr.alarm(jobtimer1, 200, tmr.ALARM_SINGLE, start_mesure)
forward()




