print("\n detector.lua  hv180830.0917  \n")

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
        if zlength>5 then zlength=0 end --print(zlength)  print("error length") end
        return_mesure()
     end
end

gpio.trig(zecho,"both",zmesure)

