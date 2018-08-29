zswitch=3     --switch flash
gpio.mode(zswitch, gpio.INT, gpio.PULLUP)


gpio.trig(zswitch, "both", bouton)
