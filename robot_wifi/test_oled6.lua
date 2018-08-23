-- Affiche simplement un Hello Wolrd sur le mini display OLED
-- Source: https://wiki.wemos.cc/products:d1_mini_shields:oled_shield
-- font_10x20,font_6x10,font_7x13,font_8x13,font_9x15,font_chikita
print("\noled_first_minid1.lua   zf20180722.1422   \n")


--  Utilisation :
--              pin_sda = 5 
--              pin_scl = 6 
--              disp_sla = 0x3c
--              _dofile("i2c_display")
--              disp_add_data(texte)
--          avec texte un json du type
--          texte = '{ "id": "id_du_texte",
--                     "column": [0-20],    (si omis : 0)
--                     "row": [0-5],        (si omis : 0)
--                     "text": "abcdef",      (si omis : "")
--                     "angle": [0,90,180,270] }'     (si omis 0°)
--
--          disp_add_data('{"id":"id_du_texte"}') efface le texte
-------------------------------------------------
-- Modules nécessaires dans le firmware :
--    i2c, u8g(avec font ssd1306_128x64_i2c), cjson
-------------------------------------------------

pin_sda = 12 
pin_scl = 11 
disp_sla = 0x3c


function init_OLED(sda, scl) --Set up the u8glib lib     
     i2c.setup(0, sda, scl, i2c.SLOW)
      disp = u8g.ssd1306_128x64_i2c(disp_sla)
-- https://github.com/olikraus/u8glib/wiki/fontsize
     disp:setFont(u8g.font_7x14)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
end

function draw()
-- font_10x20,font_6x10,font_7x13,font_8x13,font_9x15,font_chikita
--    disp:setFont(u8g.font_6x10)
--    disp:drawStr(0,0,"Hello zuzu !")
    disp:drawStr(0,0,oledline1)
    disp:drawStr(0,14,oledline2)
    disp:drawStr(0,28,oledline3)
    disp:drawStr(0,42,oledline4)     --..string.char(233)..":")
--    disp:drawStr(0,70,oledline5)

--    disp:setFont(u8g.font_9x15)
--    disp:drawStr(0,0,"1'200W")



--    disp:drawStr(0,11,"et zuzu !")
end

function dispOLED()
    disp:firstPage()
    repeat
        draw()
    until disp:nextPage() == false
end

init_OLED(pin_sda, pin_scl) --Run setting up

oledline1="   192.168.4.1"
oledline2=""
oledline3="      RESET"
oledline4="1133"

dispOLED()

