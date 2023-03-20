print("\nWhat to install: [spikectl, chopdaemon]")
term.write(" > ")
local input = read()

print()

if input == "spikectl" then
    print("\nInstalling spikectl\n")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/classy.lua")
    shell.run("mkdir datapoints")
    shell.run("cd datapoints")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/datapoints/datapoint.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/datapoints/toggle.lua")
    shell.run("cd ..")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/blob/main/spikectl.lua")
end

if input == "chopdaemon" then
    print("\nInstalling chopdaemon\n")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/main/spikedaemon.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/blob/main/chopdaemon.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/blob/main/configparser.lua")
    shell.run("wget https://raw.githubusercontent.com/Rotekoppen/CCthings/blob/main/defaultConfigs/chop.lua config.json")
end

print("\nDone\n")