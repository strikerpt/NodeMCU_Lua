print("\nrobot_oled.lua   hv180821.1702  \n")
--parametres pour l'oled
pin_sda = 12 
pin_scl = 11 
disp_sla = 0x3c
--parametres pour le module ultra son 
ztrig=5
zecho=6
ztstart=0
ztstop=0
gpio.mode(ztrig, gpio.OUTPUT)
gpio.write(ztrig, gpio.LOW)
gpio.mode(zecho, gpio.INT, gpio.PULLUP)
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



-- speed is 0 - 100


--fonctions pour donner une direction au robot





function forward()
--    print("forward")
    gpio.write(pin_a_dir,FWD)
    gpio.write(pin_b_dir,FWD)
    pwm.setduty(pin_a_speed,(70 * duty) / 100)
    pwm.setduty(pin_b_speed,(70 * duty) / 100)
end


function stop()
    pwm.setduty(pin_a_speed,0)
    pwm.setduty(pin_b_speed,0)
end



function right()
    gpio.write(pin_a_dir,FWD)
    gpio.write(pin_b_dir,REV)
    pwm.setduty(pin_a_speed,(70 * duty) / 100)
    pwm.setduty(pin_b_speed,(70 * duty) / 100)
end
function left()
    gpio.write(pin_a_dir,REV)
    gpio.write(pin_b_dir,FWD)
    pwm.setduty(pin_a_speed,(70 * duty) / 100)
    pwm.setduty(pin_b_speed,(70 * duty) / 100)
end






function backward()
    gpio.write(pin_a_dir,REV)
    gpio.write(pin_b_dir,REV)
    pwm.setduty(pin_a_speed,(70 * duty) / 100)
    pwm.setduty(pin_b_speed,(70 * duty) / 100)
end




--fonction pour faire fonctionner l'oled
function init_OLED(sda, scl)
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(disp_sla)
     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
end


function display()
   function draw()
        disp:drawStr(40,32,"FORWARD")
    end
    init_OLED(pin_sda, pin_scl)--Run setting up
    disp:firstPage()
    repeat
        draw()
    until disp:nextPage() == false 
end

--forward()
