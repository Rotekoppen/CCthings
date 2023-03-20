local configFile = open("config.json", "rw")
local config = textutils.unserialiseJSON( configFile.read() )

function config:save()
    configFile.write(textutils.serialiseJSON( config ))
end

return config