print("\n start_job.lua hv180822.1039\n")


dofile("wifi_client.lua")
dofile("motor.lua")
dofile("detector.lua")
dofile("robot_web.lua")
tmr.alarm(0, 10000, tmr.ALARM_SINGLE,  function ()
    dofile("disp_oled.lua")
end)
--dofile("telnet_srv.lua")




