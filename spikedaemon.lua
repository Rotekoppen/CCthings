local config = require("configparser")
local alive = false
local status = {}
peripheral.find("modem", rednet.open)

function sendJson(id, payload)
    rednet.send(id, textutils.serialiseJSON(payload), "spikectl-daemon")
end

function getStatus(id, payload)
    sendStatus(id)
end

function sendStatus(id)
    sendJson(id, {
        ["type"] = "updateStatus",
        ["status"] = status
    })
end

local payloadTable = {
    ["getStatus"] = getStatus,
}

function listen()
    alive = true
    while alive do
        local id, message = rednet.receive("spikectl-remote")
        if not alive then break end
        if id ~= nil then
            if not config["permittedRemotes"][tostring(id)] then
                print(id, ": rejected id")
            else
                local payload = textutils.unserialiseJSON(message)
                if payloadTable[payload["type"]] ~= nil then
                    payloadTable[payload["type"]](id, payload)
                end
            end
        end
    end
end

function stopListen()
    alive = false
end

return {
    ["status"] = status,
    ["payloadTable"] = payloadTable,
    ["listen"] = listen,
    ["stopListen"] = stopListen,
    ["config"] = config,
    ["sendStatus"] = sendStatus
}
