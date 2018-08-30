--Programme qui démarre le robot en appuyant sur le bouton flash et le redémarre si le bouton flash est appuyer pendant 3 secondes

print("\n init.lua hv180830.1428\n")

zswitch=3     --switch flash
gpio.mode(zswitch, gpio.INT, gpio.PULLUP)
 
function hvbouton()
    gpio.trig(zswitch, "none")
    tmr.unregister(initalarme)
    dofile("start_job.lua")
end

gpio.trig(zswitch, "both", hvbouton)

initalarme=tmr.create()

