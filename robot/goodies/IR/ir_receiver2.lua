-- Petit script pour recevoir la LED IR
--[[
./luatool.py --ip 192.168.43.203 --src ~/Desktop/NodeMCU_Lua_robot/robot/goodies/IR/ir_receiver2.lua --dest ir_receiver2.lua
telnet -r 192.168.43.203
dofile("ir_receiver2.lua")
dofile("dir.lua")
dofile("cat.lua")
cat("ir_receiver2.lua")
node.restart()
tmr.stop(ir_receive_tmr1)
]]

print("\n ir_receive2.lua  zf180911.1813  \n")


pin_hp = 8
gpio.mode(pin_hp,gpio.OUTPUT)
gpio.write(pin_hp,gpio.LOW)

pin_ir_receive = 7
gpio.mode(pin_ir_receive, gpio.INT, gpio.PULLUP)

i=1  j=i

function pulse_detected()
--    gpio.write(pin_hp,gpio.HIGH)
    --tmr.delay(500)
    i=i+1
--    gpio.write(pin_hp,gpio.LOW)
end

gpio.trig(pin_ir_receive,"down",pulse_detected)

ir_receive_tmr1=tmr.create()
tmr.alarm(ir_receive_tmr1, 500, tmr.ALARM_AUTO, function()
    if i~=j then
      print(i)
      j=i
    end
end)
