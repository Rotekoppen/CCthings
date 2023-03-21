term.clear()
print("\nThis will remove existing files, type [y] to continue")
term.write(" > ")
local input = read()
if not input == "y" then return end

for i,v in ipairs({
    -- Spikectl
    "classy.lua",
    "datapoints",
    "toggle.lua",
    "spikectl.lua",
    "spikegui.lua",
    "spike.lua",

    -- Chopdaemon
    "spikedaemon.lua",
    "chopdaemon.lua",
    "configparser.lua"
}) do
    shell.run("rm " .. v)
end

term.clear()
print("\nWhat to install: [spikectl, chopdaemon, redstonedaemon]")
term.write(" > ")
input = read()

print()

if input == "spikectl" then
    print("\nInstalling spikectl\n")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/classy.lua")
    shell.run("mkdir datapoints")
    shell.run("cd datapoints")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/datapoints/datapoint.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/datapoints/toggle.lua")
    shell.run("cd ..")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/configparser.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/spike.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/spikegui.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/spikectl.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/defaultConfigs/ctl.json config.json")
end

if input == "chopdaemon" then
    print("\nInstalling chopdaemon\n")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/spikedaemon.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/chopdaemon.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/configparser.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/defaultConfigs/chop.json config.json")
end

if input == "redstonedaemon" then
    print("\nInstalling redstonedaemon\n")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/spikedaemon.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/redstonedaemon.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/configparser.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/defaultConfigs/redstone.json config.json")
end

term.clear()
print("\nDone\n")