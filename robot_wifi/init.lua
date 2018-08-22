print("\ninit.lua hv180822.1018   \n")

zswitch=3     --switch flash
gpio.mode(zswitch, gpio.INT, gpio.PULLUP)

function bouton()
    print("\nStart\n")
    dofile("start_job.lua")
end

gpio.trig(zswitch, "both", bouton)

