--motordrive: motor.lua
pin_a_speed = 1
pin_a_dir = 3
pin_b_speed = 2
pin_b_dir = 4
FWD = gpio.HIGH
REV = gpio.LOW
duty = 1023
--initiate motor A
gpio.mode(pin_a_speed,gpio.OUTPUT)
gpio.write(pin_a_speed,gpio.LOW)
pwm.setup(pin_a_speed,1000,duty) --PWM 1KHz, Duty 1023
pwm.start(pin_a_speed)
pwm.setduty(pin_a_speed,0)
gpio.mode(pin_a_dir,gpio.OUTPUT)
--initiate motor B
gpio.mode(pin_b_speed,gpio.OUTPUT)
gpio.write(pin_b_speed,gpio.LOW)
pwm.setup(pin_b_speed,1000,duty) --PWM 1KHz, Duty 1023
pwm.start(pin_b_speed)
pwm.setduty(pin_b_speed,0)
gpio.mode(pin_b_dir,gpio.OUTPUT)
-- speed is 0 - 100
function motor(pin_speed, pin_dir, dir, speed)
    gpio.write(pin_dir,dir)
    pwm.setduty(pin_speed, (speed * duty) / 100)
end
function motor_a(dir, speed)
    motor(pin_a_speed, pin_a_dir, dir, speed)
end
    
function motor_b(dir, speed)
    motor(pin_b_speed, pin_b_dir, dir, speed)
end
    
-------------------------------------------------
--start motors 100% speed forward
print("\navance\n")
motor_a(FWD, 50)
motor_b(FWD, 50)
--reverse motors after 4s
tmr.register(0, 4000, tmr.ALARM_SINGLE, function() 
    print("\nrecule\n")
    motor_a(REV, 60)
    motor_b(FWD, 80)
end)
tmr.start(0)
--turn motors off after 8s
tmr.register(1, 8000, tmr.ALARM_SINGLE, function() 
    print("\stop\n")
    motor_a(FWD, 0)
    motor_b(FWD, 0)
end)
tmr.start(1)
print("\n\init test motors, 180712.2126\n")
