pin_sda = 12 
pin_scl = 11 
disp_sla = 0x3c

test="1"
test2="hugo"
function init_OLED(sda, scl) --Set up the u8glib lib
     
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(disp_sla)
     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
end

function draw()
    disp:drawStr(64,32,test)
    disp:drawStr(0,10,test2)
end

init_OLED(pin_sda, pin_scl) --Run setting up

disp:firstPage()
repeat
    draw()
until disp:nextPage() == false
