print("\n disp_oled.lua   hv180822.1051  \n")

--parametres pour l'oled
pin_sda = 12 
pin_scl = 11 
disp_sla = 0x3c

--fonction pour parametriser l'oled
function init_OLED(sda, scl)
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(disp_sla)
     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
end

--fonctions pour écrire sur l'oled
function displayforward()
   function draw()
        disp:drawStr(20,10,wifi.sta.getip())
        disp:drawStr(40,32,"FORWARD")
    end
    init_OLED(pin_sda, pin_scl)--Run setting up
    disp:firstPage()
    repeat
        draw()
    until disp:nextPage() == false 
end

function displaybackward()
   function draw()
        disp:drawStr(20,10,wifi.sta.getip())
        disp:drawStr(40,32,"BACKWARD")
    end
    init_OLED(pin_sda, pin_scl)--Run setting up
    disp:firstPage()
    repeat
        draw()
    until disp:nextPage() == false 
end

function displayleft()
   function draw()
        disp:drawStr(20,10,wifi.sta.getip())
        disp:drawStr(50,32,"LEFT")
    end
    init_OLED(pin_sda, pin_scl)--Run setting up
    disp:firstPage()
    repeat
        draw()
    until disp:nextPage() == false 
end

function displayright()
   function draw()
        disp:drawStr(20,10,wifi.sta.getip())
        disp:drawStr(50,32,"RIGHT")
    end
    init_OLED(pin_sda, pin_scl)--Run setting up
    disp:firstPage()
    repeat
        draw()
    until disp:nextPage() == false 
end

function displaystop()
   function draw()
        disp:drawStr(20,10,wifi.sta.getip())
        disp:drawStr(50,32,"STOP")
    end
    init_OLED(pin_sda, pin_scl)--Run setting up
    disp:firstPage()
    repeat
        draw()
    until disp:nextPage() == false 
end