print("\ninit.lua hv180820.1445   \n")

zswitch=3     --switch flash
gpio.mode(zswitch, gpio.INT, gpio.PULLUP)

function bouton()
    print("\nStart\n")
    dofile("u_start_job.lua")
end

gpio.trig(zswitch, "both", bouton)

