-- Petit script pour afficher des chose sur le display OLED ssd1306_128x64_i2c
print("\n disp_oled.lua   hv180822.1602  \n")

--parametres pour l'oled
pin_sda = 12 
pin_scl = 11 
disp_sla = 0x3c

--fonction pour parametriser l'oled
function init_OLED(sda, scl)
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(disp_sla)
     disp:begin()
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosCenter()
end


function disp_page()
    disp:firstPage()
    repeat 
        ip()
        displayreset()
        displayleft()
    until disp:nextPage() == false
end

function displayclear()
    disp:firstPage()

--[[
disp:setFont(u8g.font_6x10)
    disp:getFontAscent()
    disp:setFontPosCenter()
    disp:drawStr(50,32,"")
    disp:drawStr(20,32,"")
]]
end




function ip()
   disp:setFont(u8g.font_10x20)
   disp:getFontAscent()
   disp:setFontPosCenter()
   disp:drawStr(20,20,wifi.sta.getip())
end






function displayOLED(hvx, hvy, hvtext, hvfont)
    disp:setFont(u8g.hvfont)
    disp:getFontAscent()
    disp:setFontPosCenter()
    disp:drawStr(hvx,hvy,hvtext) 
end





function displayreset()
    disp:setFont(u8g.font_6x10)
    disp:getFontAscent()
    disp:setFontPosCenter()
    disp:drawStr(50,32,"toto") 
end


    
function displayleft()
    disp:setFont(u8g.font_10x20)
    disp:getFontAscent()
    disp:setFontPosCenter()
    disp:drawStr(50,32,"LEFT")
end 

function displayright()
    disp:setFont(u8g.font_6x10)
    disp:getFontAscent()
    disp:setFontPosCenter()
    disp:drawStr(50,32,"RIGHT")
end 

function displayforward()
    disp:setFont(u8g.font_6x10)
    disp:getFontAscent()
    disp:setFontPosCenter()
    disp:drawStr(40,32,"FORWARD")
end

function displaybackward()
    disp:setFont(u8g.font_6x10)
    disp:getFontAscent()
    disp:setFontPosCenter()
    disp:drawStr(40,32,"BACKWARD")
end

init_OLED(pin_sda, pin_scl)


