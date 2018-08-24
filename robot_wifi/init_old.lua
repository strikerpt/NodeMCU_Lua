print("\ninit.lua hv180822.1102   \n")

zswitch=3     --switch flash
gpio.mode(zswitch, gpio.INT, gpio.PULLUP)

inittimer1=tmr.create()
inittimer2=tmr.create()

--[[tmr.alarm(inittimer1, 5000, tmr.ALARM_SINGLE, function()
    dofile("disp_oled.lua")
    tmr.alarm(inittimer1, 1000, tmr.ALARM_SINGLE, displaystop)
    gpio.trig(zswitch, "both", bouton)
end)]]

function bouton()
    print("\nStart\n")
    dofile("start_job.lua")
end


