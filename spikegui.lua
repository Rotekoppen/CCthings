local M = {
    ["title"] = " > SpikeCTL",
    ["selected"] = 0,
    ["scroll"] = 0
}

function setColor(fg, bg)
    term.setBackgroundColor(bg)
    term.setTextColor(fg)
end
function invertColor()
    local fg = term.getBackgroundColor()
    local bg = term.getTextColor()
    setColor(fg, bg)
end

function M:render()
    setColor(colors.white, colors.black)
    term.clear()

    -- Draw titlebar
    term.setCursorPos(1, 1)
    invertColor()
    term.clearLine()
    term.write(M.title)
    invertColor()

    -- Draw Options
    for i,spike in ipairs(M.spikes) do
        
        
        setColor(colors.white, colors.black)
        
        -- Then Name
        term.setCursorPos(4+M.scroll, i+2)
        if not spike.connected then
            term.setTextColor(colors.red)
        end
        term.write(spike.name .. " ")
        term.setTextColor(colors.white)
        
        if not M.mobile then
            -- From right to left, first let the spike do its thing
            term.setCursorPos(12+M.scroll, i+2)
            term.write(" ")
            for k,datapoint in ipairs(spike.datapoints) do
                if M.selected == i then term.write(k .. ": ") end
                datapoint:renderGuiLine()
            end
        else
            term.setCursorPos(18, i+2)
            term.write(" ")
            spike.datapoints[spike.highlighted]:renderGuiLine()
        end

        -- Then the static stuff
        term.setCursorPos(1, i+2)
        if i == M.selected then
            term.write("-> ")
        else
            term.write (" " .. tostring(i) .. " ")
        end
    end

    if M.mobile and M.selected > 0 then
        for k,datapoint in ipairs(M.spikes[M.selected].datapoints) do
            term.setCursorPos(1, 10+k)
            term.write(k .. ": ")
            datapoint:renderGuiLine()
        end
    end
end

function M:inputThread()
    while true do
        local event, key, is_held = os.pullEvent("key")
        local char = keys.getName(key)

        if not M.mobile then
            if char == "left" then M.scroll = math.min(M.scroll + 1, 0) end
            if char == "right" then M.scroll = math.max(M.scroll - 1, -20) end
        end
        if char == "up" then M.selected = math.max(M.selected - 1, 0) end
        if char == "down" then M.selected = math.min(M.selected + 1, #M.spikes) end

        if M.selected > 0 then
            if (key - 1) < #M.spikes[M.selected].datapoints then
                M.spikes[M.selected].datapoints[key - 1]:keyPressed()
            end
        end
        
        M:render()
        
    end
end

return M