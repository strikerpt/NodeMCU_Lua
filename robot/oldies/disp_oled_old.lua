-- Source: https://wiki.wemos.cc/products:d1_mini_shields:oled_shield
-- font_10x20,font_6x10,font_7x13,font_8x13,font_9x15,font_chikita
print("\n display_oled.lua   hv180729.1133  \n")

pin_sda = 12 
pin_scl = 11 
disp_sla = 0x3c


function init_OLED(sda, scl)    
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(disp_sla)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
end

function draw()
    disp:setFont(u8g.font_10x20)
    disp:setFontPosTop()
    disp:drawStr(0,0,oled_line1)
    disp:setFont(u8g.font_6x10)
    disp:setFontPosTop()
    disp:drawStr(0,14,oled_line2)
    disp:drawStr(0,28,oled_line3)
    disp:drawStr(0,42,oled_line4)
    disp:drawStr(0,70,oled_line5)
end


function disp_oled()
    disp:firstPage()
    repeat
        draw()
    until disp:nextPage() == false
end



init_OLED(pin_sda, pin_scl) --Run setting up
