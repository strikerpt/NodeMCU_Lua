-- petit script pour le HTML du serveur web

print("\n web_html.lua   hv180906.1028   \n")

--Partie HTML et CSS pour la page web
function web_html()  
    buf = "<!DOCTYPE html><html><body><meta charset='utf-8' name='viewport' content='width=device-width, initial-scale=1.0'>\n" 
    buf = buf .. "<h1>Contrôler le robot : </h1></br><a href='?pin=F'><button id='bf'>F</button></a></br>\n"
    buf = buf .. "<a href='?pin=L'><button id='bl'>L</button></a><a href='?pin=S'><button id='bs'>S</button></a><a href='?pin=R'><button id='br'>R</button></a></br>\n"
    buf = buf .. "<a href='?pin=B'><button id='bb'>B</button></a></br>\n"
    buf = buf .. "<h1> Vitesse : </h1></br>\n" 
    buf = buf .. "<a href='?pin=LT'><button id='blt'>L</button></a><a href='?pin=M'><button id='bm'>M</button></a><a href='?pin=V'><button id='bv'>V</button></a></br>\n" 
    buf = buf .. "<h1> Robot : </h1></br>\n" 
    buf = buf .. "<a href='?pin=A'><button id='ba'>A</button></a><a href='?pin=ML'><button id='bml'>ML</button></a></br>\n"
    buf = buf .. "<h1> Tests : </h1></br>\n" 
    buf = buf .. "<a href='?pin=T1'><button id='bt1'>Start auto</button></a><a href='?pin=T2'><button id='bt2'>Reboot</button></a>\n"
    buf = buf .. "<a href='?pin=T3'><button id='bt3'>T3</button></a><a href='?pin=T4'><button id='bt4'>T4</button></a>\n"
    buf = buf .. "<h1> Wifi : </h1></br>\n" 
    buf = buf .. "<a href='?pin=WIFI'><button id='bwifi'>WIFI</button></a>\n"
    buf = buf .. "<style>\n"
    buf = buf .. "#bf, #bb, #bl, #br, #bs, #bv, #bm, #blt, #ba, #bml, #bt1, #bt2, #bt3, #bt4, #bwifi{font-size:10px; position:relative; height:70px; width:70px;}\n"
    buf = buf .. "#bf, #bb {left:70px;}\n"   
    buf = buf .. "</style>\n"   
end
