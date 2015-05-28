pin = 4

gpio.mode(pin,gpio.INT)
function Connect(level)
	dofile("GetNetwork.lua")
	print("INTER")
	if level == 1 then gpio.trig(1, "down") else gpio.trig(1, "up") end
end

gpio.trig(pin, "up",Connect)

print(tmr.now())
-- ############################# Temp file
file.open("settings.lua", "r")
if (file.open("settings.lua", "r") == nil) then
	print("No file")
	dofile("GetNetwork.lua")
end
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

-- # real program

print(datasplit[2])
print(datasplit[4])
wifi.setmode(wifi.STATION)
wifi.sta.config(datasplit[2],datasplit[4])
print(wifi.sta.getip())



end
pin = 4

gpio.mode(pin,gpio.INT)
function Connect(level)
	dofile("GetNetwork.lua")
	print("INTER")
	if level == 1 then gpio.trig(1, "down") else gpio.trig(1, "up") end
end

gpio.trig(pin, "up",Connect)

print(tmr.now())
  
file.open("settings.lua", "r")
if (file.open("settings.lua", "r") == nil) then
	print("No file")
	dofile("GetNetwork.lua")
end
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

-- # real program

print(datasplit[2])
print(datasplit[4])
wifi.setmode(wifi.STATION)
wifi.sta.config(datasplit[2],datasplit[4])
print(wifi.sta.getip())

end
