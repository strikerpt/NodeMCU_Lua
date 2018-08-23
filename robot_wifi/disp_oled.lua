-- Source: https://wiki.wemos.cc/products:d1_mini_shields:oled_shield
-- font_10x20,font_6x10,font_7x13,font_8x13,font_9x15,font_chikita
print("\n display_oled.lua   hv20180723.1332   \n")

pin_sda = 12 
pin_scl = 11 
disp_sla = 0x3c


function init_OLED(sda, scl)    
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(disp_sla)
     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
end

function draw()
    disp:drawStr(0,0,oledline1)
    disp:drawStr(0,14,oledline2)
    disp:drawStr(0,28,oledline3)
    disp:drawStr(0,42,oledline4)
    disp:drawStr(0,70,oledline5)
end

function dispOLED()
    disp:firstPage()
    repeat
        draw()
    until disp:nextPage() == false
end

init_OLED(pin_sda, pin_scl) --Run setting up

oledline1=     wifi.sta.getip()
oledline2=""
oledline3=""
oledline4="1133"
oledline5=""

dispOLED()

