--Petit serveur WEB pour allumer/éteindre une LED en mode client WIFI
print("\nDémarrage hv20180711.1606\n")
hvtimer1=tmr.create()
hvtimer2=tmr.create()
hvtimer3=tmr.create()
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
function forward()
   motor_a(FWD, 60) 
   motor_b(FWD, 60)  
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
end
function backward()
    motor_a(REV, 60)
    motor_b(REV, 60)
end
--[[function zmesure_pulse()
    gpio.write(ztrig, gpio.HIGH)
    tmr.delay(10)
    gpio.write(ztrig, gpio.LOW)
end
--mesure la distance et il s'arrete si < 20cm
function zmesure()
    if gpio.read(zecho)==1 then 
        ztstart=tmr.now()
    else
        ztstop=tmr.now() 
        zlength=360*(ztstop-ztstart)/2/10000
        if zlength>200 then zlength=0 end  
        if zlength<20 then 
            if t==1 then 
               left()
            else 
               right()
            end
            tmr.alarm(hvtimer1, 1000, tmr.ALARM_SINGLE, forward)
        end
    end
end
gpio.trig(zecho, "both", zmesure)
tmr.alarm(hvtimer2, 1000, tmr.ALARM_AUTO, zmesure_pulse)
wifi.sta.connect()
tmr.alarm(hvtimer3, 1000, tmr.ALARM_AUTO , function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...")
   else
      print("Connected! IP: ",wifi.sta.getip())
      tmr.stop(0)
   end
end)
zLED=0]]
--gpio.mode(zLED, gpio.OUTPUT)
--gpio.write(zLED, gpio.HIGH)
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
    buf = buf .. "<!DOCTYPE html><html><body><h1>Controler le robot : </h1></br> <a href=\"?pin=FORWARD\"><button style=\"height:100px; width:100px;\">FORWARD</button></a></br>"
    local _left, _right, _forward, _backward, _stop = "", ""
    if (_GET.pin == "LEFT") then
      _left = " selected=true"
      left()
    elseif (_GET.pin == "RIGHT") then
      _right = " selected=\"true\""
      right()
    elseif (_GET.pin == "FORWARD") then
      _forward = " selected=\"true\""
      forward()
    elseif (_GET.pin == "BACKWARD") then
      _backward = " selected=\"true\""
      backward()
      elseif (_GET.pin == "STOP") then
      _stop = " selected=\"true\""
      stop()
    end
    buf = buf .. "<a href=\"?pin=LEFT\"><button>LEFT</button></a><a href=\"?pin=STOP\"><button >STOP</button></a><a href=\"?pin=RIGHT\"><button>RIGHT</button></a></br><a href=\"?pin=BACKWARD\"><button>BACKWARD</button></a>"
    client:send(buf)
  end)
  conn:on("sent", function(c) c:close() end)
end)
