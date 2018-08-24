--Programme qui démarre le robot en appuyant sur le bouton flash et le redémarre si le bouton flash est appuyer pendant 3 secondes

print("\n init.lua hv180824.0946\n")

zswitch=3     --switch flash
gpio.mode(zswitch, gpio.INT, gpio.PULLUP)
 
function bouton()
    print("\nStart\n")
    dofile("start_job.lua")
end

gpio.trig(zswitch, "both", bouton)