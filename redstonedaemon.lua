local daemon = require("spikedaemon")

function setEnabled(id, payload)
    local enabled = payload["value"]
    daemon.status["Enabled"] = enabled
    if daemon.config["iverted"] then enabled = not enabled end
    redstone.setOutput(daemon.config["side"], enabled)
    daemon.sendStatus(id)
end

daemon.payloadTable["setEnabled"] = setEnabled

daemon.listen()