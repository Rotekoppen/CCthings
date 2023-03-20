local Class = require("classy")
local Datapoint = require("datapoints/datapoint")
local Toggle = Class( "DatapointToggle", Datapoint )

function Toggle:__init(id, display, onText, offText)
    Datapoint.__init(self, id)
    self.display = display
    self.onText = onText
    self.offText = offText
end

function Toggle:renderGuiLine(key)
    term.write(self.display)
    if self:get() then
        term.setBackgroundColor(colors.green)
        term.write("  ")
        term.setBackgroundColor(colors.black)
        term.write(" " .. self.onText .. " ")
    else
        term.setBackgroundColor(colors.red)
        term.write("  ")
        term.setBackgroundColor(colors.black)
        term.write(" " .. self.offText .. " ")
    end
end

function Toggle:keyPressed()
    self:set(not self:get())
end

return Toggle