local Class = require( "classy" )
local Spike = require( "spike" )
local ToggleSpike = Class( "ToggleSpike", Spike )

function ToggleSpike:__init( name, id )
    Spike.__init( self, name, id )
end

function ToggleSpike:setEnabled(enabled)
    self:send({ ["type"] = "setEnabled", ["enabled"] = enabled })
end

function ToggleSpike:renderGuiLine()
    if self.status["enabled"] then
        term.setBackgroundColor(colors.green)
        term.write("  ")
        term.setBackgroundColor(colors.black)
        term.write(" on  ")
    else
        term.setBackgroundColor(colors.red)
        term.write("  ")
        term.setBackgroundColor(colors.black)
        term.write(" off ")
    end
end

return ToggleSpike