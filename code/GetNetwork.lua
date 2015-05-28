print("EX GetNetwork.lua")
wifi.setmode(wifi.SOFTAP);
wifi.ap.config({ssid="test",pwd="12345678"});
srv=net.createServer(net.TCP,1) 

file.remove("settings.lua")
print("removeee")
file.open("settings.lua", "w+")
file.close()

password = "abcd"
status = 0


srv:listen(80,function(conn) 
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then 
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP"); 
        end
        local _GET = {}

        if (status == 1) then
            status = 0
		else
		file.remove("settings.lua")
        end
                
        if (vars ~= nil)then 
            for k, v in string.gmatch(vars, "(%w+)=([%w+-@%%]+)&*") do 
            
            if(k=="device") then
                if(v==password) then
                    status = 1
                else
					print("Wrong password")
					file.remove("settings.lua")
                end
            end
            
            if (status == 1 and k ~= "device") then
                _GET[k] = v
            end
            
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

        if (status==1)then
			node.restart();
			print("Restart")
        end
                
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
