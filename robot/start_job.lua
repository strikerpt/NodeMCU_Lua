print("\n start_job.lua hv180906.1648 \n")

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

function mesurewhenmanual()
    if zauto then 
        tmr.stop(jobtimer1)
    else 
        tmr.alarm(jobtimer1, 600, tmr.ALARM_AUTO, start_mesure)
    end
end

function return_mesure()
    print(zlength)
    print("RAM: "..node.heap())

 if zauto then 
        if zlength<0.20 then
          t=math.random(1,2)
          if t==1 then
            right()
          else
            left()
          end 
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

mesurewhenmanual()
forward()
--tmr.alarm(jobtimer1, 600, tmr.ALARM_AUTO, start_mesure)



