local config = require("config")
local spikes = config["spikes"]
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

gui:render()

parallel.waitForAny(listen, statusUpdates, gui.inputThread)
