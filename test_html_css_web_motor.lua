print("\nDémarrage hv20180711.1606\n")
--[[hvtimer1=tmr.create()
hvtimer2=tmr.create()]]
hvtimer3=tmr.create()
hvtimer4=tmr.create()
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
pwm.setup(pin_a_speed,1000,duty) --PWM 1KHz, Duty 1023
pwm.start(pin_a_speed)
pwm.setduty(pin_a_speed,0)
gpio.mode(pin_a_dir,gpio.OUTPUT)
--initialise moteur B
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
function init_OLED(sda, scl) --Set up the u8glib lib
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(disp_sla)
     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
end

function forward()
   motor_a(FWD, 60) 
   motor_b(FWD, 60)
     function draw()
        disp:drawStr(40,32,"FORWARD")
    end
    init_OLED(pin_sda, pin_scl) --Run setting up
    disp:firstPage()
    repeat
        draw()
    until disp:nextPage() == false
    end  
end 
function stop()
   motor_a(FWD, 0)
   motor_b(FWD, 0) 
end
function right()
    motor_a(FWD, 60)
    motor_b(REV, 60)
end
function left()
    motor_a(REV, 60)
    motor_b(FWD, 60)
    function draw()
        disp:drawStr(55,32,"LEFT")
    end
    init_OLED(pin_sda, pin_scl) --Run setting up
    disp:firstPage()
    repeat
        draw()
    until disp:nextPage() == false
    end
end
function backward()
    motor_a(REV, 60)
    motor_b(REV, 60)
end

wifi.sta.connect()
tmr.alarm(hvtimer3, 1000, tmr.ALARM_AUTO , function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...")
   else
      print("Connected! IP: ",wifi.sta.getip())
      tmr.stop(hvtimer3)
   end
end)
srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
  conn:on("receive", function(client, request)
    local buf = ""
    local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
    if (method == nil) then
     _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
    end
    local _GET = {}
    if (vars ~= nil) then
      for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
        _GET[k] = v
        print(k..": "..v)
      end
    end
        local _left, _right, _forward, _backward, _stop = "", ""
    if (_GET.pin == "LEFT") then
      _left = " selected=true"
      left()
      tmr.alarm(hvtimer4, 1000, tmr.ALARM_SINGLE, forward)
      end
    elseif (_GET.pin == "BACKWARD") then
      _backward = " selected=\"true\""
      backward()
      tmr.alarm(hvtimer6, 1500, tmr.ALARM_SINGLE, right)
      tmr.stop(hvtimer6)
      forward()
    end
    buf = buf .. "<!DOCTYPE html><html><body><h1>Controler le robot : </h1></br> <a href=\"?pin=FORWARD\"><button id=\"buttonforward\">FORWARD</button></a></br>"
    buf = buf .. "<a href=\"?pin=LEFT\"><button id=\"buttonleft\">LEFT</button></a><a href=\"?pin=STOP\"><button id=\"buttonstop\">STOP</button></a><a href=\"?pin=RIGHT\"><button id=\"buttonright\">RIGHT</button></a></br>"
    buf = buf .. "<a href=\"?pin=BACKWARD\"><button id=\"buttonbackward\">BACKWARD</button></a>"
    buf = buf .. "<style> #buttonforward {position:relative; left:500px; height:100px; width:100px;} #buttonbackward {position:relative; left:500px; height:100px; width:100px;}</style>"
    buf = buf .. "<style> #buttonleft {position:relative; left:400px; height:100px; width:100px;} #buttonright {position:relative; left:400px; height:100px; width:100px;} #buttonstop {position:relative; left:400px; height:100px; width:100px;}</style> "   
    client:send(buf)
  end)
  conn:on("sent", function(c) c:close() end)
end)
