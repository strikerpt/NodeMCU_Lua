--Programme qui démarre le robot en appuyant sur le bouton flash et le redémarre si le bouton flash est appuyer pendant 3 secondes

print("\n init.lua hv180829.1750\n")

zswitch=3     --switch flash
gpio.mode(zswitch, gpio.INT, gpio.PULLUP)
 
function hvbouton()
    gpio.trig(zswitch, "none")
    tmr.unregister(initalarme)
    dofile("start_job.lua")
end

gpio.trig(zswitch, "both", hvbouton)

initalarme=tmr.create()
--[[
tmr.alarm(initalarme, 300000,  tmr.ALARM_SINGLE, function()
    print("\nStart\n")
    dofile("start_job.lua")
end)
]]