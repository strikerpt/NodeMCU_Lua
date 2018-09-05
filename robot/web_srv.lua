-- petit script de serveur WEB Wifi

print("\n web_srv.lua   hv180905.1510   \n")

dofile("web_get.lua")
dofile("web_html.lua")

srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
  conn:on("receive", function(client, request)
     buf = ""
     _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
    if (method == nil) then
     _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
    end
   _GET = {}
    if (vars ~= nil) then
      for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
        _GET[k] = v
        print(k..": "..v)
      end
    end
    print("toto")
  web_get()
    print("tutu")
  web_html()
    print("titi")
    client:send(buf)
  end)
  conn:on("sent", function(c) c:close() end)
end)
