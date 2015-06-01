print("EX GetNetwork.lua")
wifi.setmode(wifi.SOFTAP);
wifi.ap.config({ssid="test",pwd="12345678"});
srv=net.createServer(net.TCP,1) 

file.remove("settings.lua")
print("removeee")
file.open("settings.lua", "w+")
file.close()



srv:listen(80,function(conn) 
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then 
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP"); 
        end
        local _GET = {}

                
        if (vars ~= nil)then 
            for k, v in string.gmatch(vars, "(%w+)=([%w+-@%%]+)&*") do 
                _GET[k] = v

            
            end 
        end
		
        file.open("settings.lua", "a+")
        file.write(status)
        file.write(",")
        for b,c in pairs(_GET) do
            file.write(c)
            file.write(",")
            print(c)
        end

        file.close()
        print("Done")

        buf = buf..'<h1> Hello, Please enter the following information.</h1>';
        buf = buf..'<form src=\"/\"><hr>';
        buf = buf..'SSID of the network:<br><input type="text" name="ssid"><br>Password:<br>';
        buf = buf..'<input type="password" name="pass"><hr>';
        buf = buf..'<br><br><input type="submit" value="Submit"></form>';
        
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
