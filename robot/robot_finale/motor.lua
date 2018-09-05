print("\n motor.lua   hv180904.1805 \n")

--timers personnels
hvtimer1=tmr.create()
hvtimer2=tmr.create()
hvtimer3=tmr.create()

--parametres pour les moteurs
pin_a_speed = 1
pin_a_dir = 3
pin_b_speed = 2
pin_b_dir = 4
FWD = gpio.LOW
REV = gpio.HIGH
duty = 1023
turn_on = 250

--initialise moteur A
gpio.mode(pin_a_speed,gpio.OUTPUT)
gpio.write(pin_a_speed,gpio.LOW)
pwm.setup(pin_a_speed,50,duty) --PWM 50Hz, Duty 1023
pwm.start(pin_a_speed)
pwm.setduty(pin_a_speed,0)

gpio.mode(pin_a_dir,gpio.OUTPUT)
gpio.write(pin_a_dir,FWD)

--initialise moteur B
gpio.mode(pin_b_speed,gpio.OUTPUT)
gpio.write(pin_b_speed,gpio.LOW)
pwm.setup(pin_b_speed,50,duty) --PWM 50Hz, Duty 1023
pwm.start(pin_b_speed)
pwm.setduty(pin_b_speed,0)

gpio.mode(pin_b_dir,gpio.OUTPUT)
gpio.write(pin_b_dir,FWD)

function set_speed()
    pwm.setduty(pin_a_speed,(zpeed * duty) / 100)
    pwm.setduty(pin_b_speed,(zpeed * duty) / 100)
end

function forward()
    gpio.write(pin_a_dir,FWD)
    gpio.write(pin_b_dir,FWD)
    pwm.setduty(pin_a_speed,(zpeed * duty) / 100)
    pwm.setduty(pin_b_speed,(zpeed * duty) / 100)
end

function stop()
    pwm.setduty(pin_a_speed,0)
    pwm.setduty(pin_b_speed,0)
end

function right()
print("right")
    tmr.unregister(hvtimer1)
    gpio.write(pin_a_dir,FWD)
    gpio.write(pin_b_dir,REV)
    pwm.setduty(pin_a_speed,(zpeed * duty) / 100)
    pwm.setduty(pin_b_speed,(zpeed * duty) / 100)
    if zauto then 
        tmr.alarm(hvtimer1, turn_on, tmr.ALARM_SINGLE, forward)
    else
        tmr.alarm(hvtimer1, turn_on, tmr.ALARM_SINGLE, stop)
    end
end

function left()
    gpio.write(pin_a_dir,REV)
    gpio.write(pin_b_dir,FWD)
    pwm.setduty(pin_a_speed,(zpeed * duty) / 100)
    pwm.setduty(pin_b_speed,(zpeed * duty) / 100)
    if zauto then 
        tmr.alarm(hvtimer1, turn_on, tmr.ALARM_SINGLE, forward)
    else
        tmr.alarm(hvtimer1, turn_on, tmr.ALARM_SINGLE, stop)
    end
end

function backward()
    gpio.write(pin_a_dir,REV)
    gpio.write(pin_b_dir,REV)
    pwm.setduty(pin_a_speed,(zpeed * duty) / 100)
    pwm.setduty(pin_b_speed,(zpeed * duty) / 100)
    tmr.alarm(hvtimer3, 1000, tmr.ALARM_SINGLE, right)
end
