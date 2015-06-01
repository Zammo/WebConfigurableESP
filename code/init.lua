pin = 4

gpio.mode(pin,gpio.INT)
function Connect(level)
	dofile("GetNetwork.lua")
	print("INTER")
	if level == 1 then gpio.trig(1, "down") else gpio.trig(1, "up") end
end

gpio.trig(pin, "up",Connect)

print(tmr.now())
file.open("info.lua", "r")
if (file.open("info.lua", "r") == nil) then
print("No file")
dofile("GetNetwork.lua")
end
file.open("info.lua", "r")
status = file.read(1)
data = file.readline()

datasplit = {}

index = 0



if (status == "0") or (status=="") or (status==nil) then
	print("Wrong")
	dofile("GetNetwork.lua")
	print("INTER")
else

for i in string.gmatch(data, '([^,]+)') do
  datasplit[index] = i
  index = index + 1
end

file.close()

print("starting temp program")

wifi.setmode(wifi.STATION)
wifi.sta.config(datasplit[2],datasplit[4])
wifi.sta.connect()
tmr.alarm(1, 10, 1, function() 
if not (wifi.sta.getip() == nil) then 
tmr.stop(1)
--print("Config done, IP is "..wifi.sta.getip())

--Real Program


end 
end)
end 

