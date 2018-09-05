-- petit script pour le HTML du serveur web

print("\n web_html.lua   hv180905.1203   \n")

--Partie HTML et CSS pour la page web
function web_html()  
    buf = "<!DOCTYPE html><html><body><meta charset='utf-8' name='viewport' content='width=device-width, initial-scale=1.0'>\n" 
    buf = buf .. "<h1>Contrôler le robot : </h1></br> <a href='?pin=FORWARD'><button id='buttonforward'>FORWARD</button></a></br>\n"
    buf = buf .. "<a href='?pin=LEFT'><button id='buttonleft'>LEFT</button></a><a href='?pin=STOP'><button id='buttonstop'>STOP</button></a><a href='?pin=RIGHT'><button id='buttonright'>RIGHT</button></a></br>\n"
    buf = buf .. "<a href='?pin=BACKWARD'><button id='buttonbackward'>BACKWARD</button></a></br>\n"
    buf = buf .. "<h1> Vitesse : </h1> </br>\n" 
    buf = buf .. "<a href='?pin=LENT'><button id='buttonlent'> L </button></a><a href='?pin=MOYEN'><button id='buttonmoyen'> M </button></a><a href='?pin=VITE'><button id='buttonvite'> V </button></a></br>\n" 
    buf = buf .. "<h1> Robot : </h1> </br>\n" 
    buf = buf .. "<a href='?pin=AUTO'><button id='buttonauto'> AUTO </button></a><a href='?pin=MANUEL'><button id='buttonmanuel'> MANUEL </button></a></br>\n"
    buf = buf .. "<h1> Tests : </h1> </br>\n" 
    buf = buf .. "<a href='?pin=TEST1'><button id='buttontest1'> TEST1 </button></a>\n"
    buf = buf .. "<a href='?pin=TEST2'><button id='buttontest2'> TEST2 </button></a>\n"
    buf = buf .. "<a href='?pin=TEST3'><button id='buttontest3'> TEST3 </button></a>\n"
    buf = buf .. "<h1> Wifi : </h1> </br>\n" 
    buf = buf .. "<a href='?pin=WIFI'><button id='buttonwifi'> WIFI </button></a>\n"
    buf = buf .. "<style>\n"
    buf = buf .. "#buttonforward, #buttonbackward {font-size:10px; position:relative; left:70px; height:70px; width:70px;}\n"
    buf = buf .. "#buttonleft, #buttonright, #buttonstop {font-size:10px; position:relative; height:70px; width:70px;}\n"   
    buf = buf .. "#buttonvite, #buttonmoyen, #buttonlent {font-size:10px; position:relative; height:70px; width:70px;}\n"
    buf = buf .. "#buttonauto, #buttonmanuel {font-size:10px; position:relative; height:70px; width:70px;}\n"
    buf = buf .. "#buttonwifi {font-size:10px; position:relative; height:70px; width:70px;}\n"
    buf = buf .. "#buttontest1, #buttontest2, #buttontest3 {font-size:10px; position:relative; height:70px; width:70px;}\n"
    buf = buf .. "</style>\n"
end
