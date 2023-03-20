local configFile = io.open("config.json", "r")
local config = textutils.unserialiseJSON( configFile.read() )
configFile.close()

function config:save()
    local configFile = io.open("config.json", "w")
    configFile.write(textutils.serialiseJSON( config ))
    configFile.close()
end

return config