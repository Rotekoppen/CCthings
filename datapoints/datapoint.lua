local Class = require("classy")
local Datapoint = Class( "Datapoint" )

function Datapoint:__init(id)
    self.id = id
    self.spike = nil
end

function Datapoint:renderGuiLine()
    term.write(tostring(self:get()) .. "  ")
end

function Datapoint:set(value)
    self.spike:send({ ["type"] = "set" .. self.id, ["value"] = value })
end

function Datapoint:get()
    return self.spike.status[self.id]
end

function Datapoint:keyPressed()
end

return Datapoint