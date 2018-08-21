-- timers personnelles
hvtimer1=tmr.create() 
hvtimer2=tmr.create()
t=math.random(1,2)
--Function pour faire envoyer le pulse
function zmesure_pulse()
    gpio.write(ztrig, gpio.HIGH)
    tmr.delay(10)
    gpio.write(ztrig, gpio.LOW)
end

--Fonction pour mesurer la pulse et action si la pulsion est moins de 20cm
function zmesure()
    if gpio.read(zecho)==1 then 
        ztstart=tmr.now()
    else
        ztstop=tmr.now() 
        zlength=360*(ztstop-ztstart)/2/10000
        if zlength>200 then zlength=0 end  
        if zlength<20 then 
            if t==1 then 
               left()
            else 
               right()
            end
            tmr.alarm(hvtimer1, 1000, tmr.ALARM_SINGLE, forward)
        end
    end
end
gpio.trig(zecho, "both", zmesure)
tmr.alarm(hvtimer2, 1000, tmr.ALARM_AUTO, zmesure_pulse)
