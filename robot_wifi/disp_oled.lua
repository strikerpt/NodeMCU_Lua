-- Petit script pour afficher des chose sur le display OLED ssd1306_128x64_i2c
print("\n disp_oled.lua   hv180822.1638  \n")

--parametres pour l'oled
pin_sda = 12 
pin_scl = 11 
disp_sla = 0x3c

function init_OLED(sda, scl) --Set up the u8glib lib     
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(disp_sla)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
end

function draw(hvx, hvy, htext)
    disp:setFont(u8g.font_6x10)
    disp:setFontPosTop()
    disp:drawStr(hvx, hvy, htext)
end

function disp_OLED(hvx, hvy, htext)
    print("coucou."..htext..".")
    disp:firstPage()
    repeat
        draw(hvx, hvy, htext)
    until disp:nextPage() == false
end


init_OLED(pin_sda, pin_scl) --Run setting up

oledtimer1=tmr.create()
oledtimer2=tmr.create()

tmr.alarm(oledtimer1, 1000, tmr.ALARM_SINGLE, function()
    disp_OLED(0,15, "toto")
end)

tmr.alarm(oledtimer2, 2000, tmr.ALARM_SINGLE, function()
disp_OLED(0,25, "tutu")
end)

