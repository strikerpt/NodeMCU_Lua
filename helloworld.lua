-- blink the blue led builting
-- zf180709.2200

zpin=0  --led blue builting
gpio.mode(zpin, gpio.OUTPUT)

for i=1,10 do
    print("Hello World "..i)
    gpio.write(zpin, gpio.LOW)
    tmr.delay(50000)
    gpio.write(zpin, gpio.HIGH)
    tmr.delay(300000)
end