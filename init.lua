-- Programme qui fait quelque chose quand on appuie sur le btn flash
-- hv180713.1543

zswitch=3     --switch flash
gpio.mode(zswitch, gpio.INT, gpio.PULLUP)

function bouton()
    print("Start robot_1.lua...")
    dofile("robot_1.lua")
end

gpio.trig(zswitch, "both", bouton)

print("\nhvinit 180713.1544\n")

