local configFile = io.input("config.json")
local config = textutils.unserialiseJSON( configFile:read("a") )
configFile:close()

function config:save()
    local configFile = io.output("config.json")
    configFile:write(textutils.serialiseJSON( config ))
    configFile:close()
end

return config