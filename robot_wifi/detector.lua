print("\n detector.lua  hv180824.1601  \n")

-- timers personnelles
detectortimer1=tmr.create() 
detectortimer2=tmr.create()

--Parametres pour le module ultra son 
ztrig=5
zecho=6
ztstart=0
ztstop=0
gpio.mode(ztrig, gpio.OUTPUT)
gpio.write(ztrig, gpio.LOW)
gpio.mode(zecho, gpio.INT, gpio.PULLUP)

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
            zlength=360*(ztstop-ztstart)/2/1000000
            if zlength>50 then zlength=0 end
            print(zlength)
            if zlength<0.20 then
                    right()
                    tmr.alarm(detectortimer1, 1000, tmr.ALARM_SINGLE, forward)
            end
           
    end
end
--t=math.random(1,2)
--if t==1 then 
-- left()
-- else 
                --right()
--  end
               
            --end   
    end
end
gpio.trig(zecho,"both",zmesure)
tmr.alarm(detectortimer2, 500, tmr.ALARM_AUTO, zmesure_pulse)
