print("\n detector.lua  hv180906.0906  \n")

--Parametres pour le module ultra son 
ztrig=5
zecho=6
ztstart=0
ztstop=0
gpio.mode(ztrig, gpio.OUTPUT)
gpio.write(ztrig, gpio.LOW)
gpio.mode(zecho, gpio.INT, gpio.PULLUP)

--Function pour démarrer la mesure
function start_mesure()
    gpio.write(ztrig, gpio.HIGH)
    tmr.delay(10)
    gpio.write(ztrig, gpio.LOW)
end

--Fonction pour mesurer
function zmesure()
    if gpio.read(zecho)==1 then 
        ztstart=tmr.now()
    else
        ztstop=tmr.now() 
        zlength=math.floor(360*(ztstop-ztstart)/2/10000)/100
        if zlength>5 then zlength=0 end
        return_mesure()
     end
end

gpio.trig(zecho,"both",zmesure)
