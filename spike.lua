local Class = require( "classy" )
local Spike = Class( "Spike" )

function updateStatus(spike, id, payload)
    spike.status = payload["status"]
    spike.connected = true
end

function Spike:__init( name, id, datapoints, highlighted )
    self.name = name
    self.connected = false
    self.id = id
    self.status = {}
    self.highlighted = highlighted
    self.datapoints = datapoints
    for i,datapoint in ipairs(self.datapoints) do
        datapoint.spike = self
    end
    self.payloadTable = {
        ["updateStatus"] = updateStatus
    }
end

function Spike:send(payload)
    rednet.send(self.id, textutils.serialiseJSON(payload), "spikectl-remote")
end

function Spike:listenThread(callback)
    while true do
        repeat id, message = rednet.receive("spikectl-daemon")
        until id == self.id or (id == nil and message == nil)
        if id ~= nil then
            local payload = textutils.unserialiseJSON(message)
            if self.payloadTable[payload["type"]] ~= nil then
                self.payloadTable[payload["type"]](self, id, payload)
                callback()
            end
        end
    end
end

function Spike:listen(spike, callback)
    local function thread()
        spike:listenThread(callback)
    end
    return thread
end

function Spike:getStatus()
    self.connected = false
    self:send({["type"]="getStatus"})
end

return Spike