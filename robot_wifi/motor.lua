print("\n motor.lua   hv180824.1320\n")

--timers personnels
hvtimer1=tmr.create()
hvtimer2=tmr.create()
hvtimer3=tmr.create()
hvtimer4=tmr.create()

--parametres pour les moteurs
pin_a_speed = 1
pin_a_dir = 3
pin_b_speed = 2
pin_b_dir = 4
FWD = gpio.LOW
REV = gpio.HIGH
duty = 1023

--initialise moteur A
gpio.mode(pin_a_speed,gpio.OUTPUT)
gpio.write(pin_a_speed,gpio.LOW)
pwm.setup(pin_a_speed,50,duty) --PWM 1KHz, Duty 1023
pwm.start(pin_a_speed)
pwm.setduty(pin_a_speed,0)

gpio.mode(pin_a_dir,gpio.OUTPUT)
gpio.write(pin_a_dir,FWD)

--initialise moteur B
gpio.mode(pin_b_speed,gpio.OUTPUT)
gpio.write(pin_b_speed,gpio.LOW)
pwm.setup(pin_b_speed,50,duty) --PWM 1KHz, Duty 1023
pwm.start(pin_b_speed)
pwm.setduty(pin_b_speed,0)

gpio.mode(pin_b_dir,gpio.OUTPUT)
gpio.write(pin_b_dir,FWD)

function forward()
    gpio.write(pin_a_dir,FWD)
    gpio.write(pin_b_dir,FWD)
    pwm.setduty(pin_a_speed,(70 * duty) / 100)
    pwm.setduty(pin_b_speed,(70 * duty) / 100)
    --draw()
end

function stop()
    pwm.setduty(pin_a_speed,0)
    pwm.setduty(pin_b_speed,0)
    --displaystop()
end

function right()
    gpio.write(pin_a_dir,FWD)
    gpio.write(pin_b_dir,REV)
    pwm.setduty(pin_a_speed,(70 * duty) / 100)
    pwm.setduty(pin_b_speed,(70 * duty) / 100)
    tmr.alarm(hvtimer1, 1000, tmr.ALARM_SINGLE, forward)
    --draw()
end

function left()
    gpio.write(pin_a_dir,REV)
    gpio.write(pin_b_dir,FWD)
    pwm.setduty(pin_a_speed,(70 * duty) / 100)
    pwm.setduty(pin_b_speed,(70 * duty) / 100)
    tmr.alarm(hvtimer2, 1000, tmr.ALARM_SINGLE, forward)
    --displayleft()
end

function backward()
    gpio.write(pin_a_dir,REV)
    gpio.write(pin_b_dir,REV)
    pwm.setduty(pin_a_speed,(70 * duty) / 100)
    pwm.setduty(pin_b_speed,(70 * duty) / 100)
    tmr.alarm(hvtimer3, 1000, tmr.ALARM_SINGLE, right)
    tmr.alarm(hvtimer4, 2000, tmr.ALARM_SINGLE, forward)
    --displaybackward()
end

function lent()
    gpio.write(pin_a_dir,FWD)
    gpio.write(pin_b_dir,FWD)
    pwm.setduty(pin_a_speed,(50 * duty) / 100)
    pwm.setduty(pin_b_speed,(50 * duty) / 100)
end

function moyen()
    gpio.write(pin_a_dir,FWD)
    gpio.write(pin_b_dir,FWD)
    pwm.setduty(pin_a_speed,(70 * duty) / 100)
    pwm.setduty(pin_b_speed,(70 * duty) / 100)
end

function vite()
    gpio.write(pin_a_dir,FWD)
    gpio.write(pin_b_dir,FWD)
    pwm.setduty(pin_a_speed,(100 * duty) / 100)
    pwm.setduty(pin_b_speed,(100 * duty) / 100)
end
