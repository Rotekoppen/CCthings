--[[

/#2#\
1   3
#   #
|#7#|
6   4
#   #
\#5#/

]]

local M = {

}

local characters = {
    ["0"] = {true,  true,  true,  true,  true,  true,  false},
    ["1"] = {true,  false, false, false, false, true,  false},
    ["2"] = {false, true,  true,  false, true,  true,  true },
    ["3"] = {false, true,  true,  true,  true,  false, true },
    ["4"] = {true,  false, true,  true,  false, false, true },
    ["5"] = {true,  true,  false, true,  true,  false, true },
    ["6"] = {true,  false, false, true,  true,  true,  true },
    ["7"] = {false, true,  true,  true,  false, false, false},
    ["8"] = {true,  true,  true,  true,  true,  true,  true },
    ["9"] = {true,  true,  true,  true,  false, false, true }
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

function M:printSevSeg(l1, l2, l3, l4, l5, l6, l7)
    invertColor()
    local x, y = term.getCursorPos()
    if l1 then
        term.setCursorPos(x, y)
        term.write(" ")
        term.setCursorPos(x, y+1)
        term.write(" ")
        term.setCursorPos(x, y+2)
        term.write(" ")
    end
    if l2 then
        term.setCursorPos(x, y)
        term.write("    ")
    end
    if l3 then
        term.setCursorPos(x+3, y)
        term.write(" ")
        term.setCursorPos(x+3, y+1)
        term.write(" ")
        term.setCursorPos(x+3, y+2)
        term.write(" ")
    end
    if l4 then
        term.setCursorPos(x+3, y+2)
        term.write(" ")
        term.setCursorPos(x+3, y+3)
        term.write(" ")
        term.setCursorPos(x+3, y+4)
        term.write(" ")
    end
    if l5 then
        term.setCursorPos(x, y+4)
        term.write("    ")
    end
    if l6 then
        term.setCursorPos(x, y+2)
        term.write(" ")
        term.setCursorPos(x, y+3)
        term.write(" ")
        term.setCursorPos(x, y+4)
        term.write(" ")
    end
    if l7 then
        term.setCursorPos(x, y+2)
        term.write("    ")
    end
    invertColor()
    term.setCursorPos(x+5, y)
end

function M:printDots()
    invertColor()
    local x, y = term.getCursorPos()
    term.setCursorPos(x+1, y+1)
    term.write(" ")
    term.setCursorPos(x+1, y+3)
    term.write(" ")
    term.setCursorPos(x+4, y)
    invertColor()
end

function M:printDigit(digit)
    M:printSevSeg(table.unpack(characters[tostring(digit)]))
end


function M:printClock()
    local time = textutils.formatTime( os.time(), true )
    
    if #time < 5 then
        time = " " .. time
    end

    for i = 1, #time do
        local c = time:sub(i,i)
        if c == " " then
            term.write("     ")
        elseif c == ":" then
            M:printDots()
        else
            M:printDigit(c)
        end
    end
end

--[[
    local sx, sy = term.getSize()
    
    while true do
        term.clear()
        term.setCursorPos(sx / 2 - 10, sy / 2 - 1)
        clock()
        sleep(1)
    end
]]