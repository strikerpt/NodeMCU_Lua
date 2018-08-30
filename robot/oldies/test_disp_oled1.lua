-- Petit script pour tester le script disp_oled.lua
print("\ntest_disp_oled11.lua   hv180822.1602   \n")

dofile("disp_oled.lua")

--disp_page()
displayclear()
--displayreset()


--[[
function displayOLED(hvx, hvy, hvtext, hvfont)
    disp:setFont(u8g.hvfont)
    disp:getFontAscent()
    disp:setFontPosCenter()
    disp:drawStr(hvx,hvy,hvtext) 
end
]]


