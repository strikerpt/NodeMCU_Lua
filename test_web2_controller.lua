--Timers personnelles 
hvtimer3=tmr.create()
hvtimer4=tmr.create()
hvtimer5=tmr.create()
hvtimer6=tmr.create()
hvtimer7=tmr.create()

dofile("robot_oled.lua")
      backward()
      tmr.alarm(hvtimer6, 2000, tmr.ALARM_SINGLE, right)
      tmr.alarm(hvtimer7, 3000, tmr.ALARM_SINGLE, forward)
      tmr.alarm(hvtimer5, 1000, tmr.ALARM_SINGLE, stop)
 