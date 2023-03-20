local config = require("configparser")
local Spike = require("spike")
local Datapoint = require("datapoints/datapoint");
local Toggle = require("datapoints/toggle");

local spikes = {}

for i,_spike in ipairs(config["spikes"]) do
    local datapoints = {}
    
    for j,v in ipairs(_spike["datapoints"]) do
        if v["type"] == "Datapoint" then table.insert(datapoints, Datapoint(v["name"])) end
        if v["type"] == "Toggle" then table.insert(datapoints, Toggle(v["name"], v["display"], v["onText"], v["offText"])) end
    end

    spikes[i] = Spike(_spike["name"], _spike["id"], datapoints, _spike["highlighted"])
end

local gui = require("spikegui")

gui.spikes = spikes

print("Starting spikectl")

peripheral.find("modem", rednet.open)

function listen()
    local threads = {}
    for i,spike in ipairs(spikes) do
        table.insert(threads, spike:listen(spike, gui.render))
    end
    parallel.waitForAny(table.unpack(threads))
end

local f = 0
function statusUpdates()
    while true do
        for i,spike in ipairs(spikes) do
            spike:getStatus()
        end
        sleep(1)
    end
end

gui.mobile = config["mobile"]
gui:render()

parallel.waitForAny(listen, statusUpdates, gui.inputThread)
