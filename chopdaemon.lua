local daemon = require("spikedaemon")

function setEnabled(id, payload)
    daemon.status["Enabled"] = payload["value"]
    daemon.sendStatus(id)
end

daemon.payloadTable["setEnabled"] = setEnabled

function setFertilize(id, payload)
    daemon.status["Fertilize"] = payload["value"]
    daemon.sendStatus(id)
end

daemon.payloadTable["setFertilize"] = setFertilize

function setStatus(status)
    daemon.status["Status"] = status
end

function main()
    while true do
        setStatus("Idle")
        sleep(10)

        -- If enabled
        if daemon.status["Enabled"] then
            -- Check tree
            if turtle.inspect() then
                -- Chop tree
                setStatus("Running")
                turtle.down()
                turtle.select(1)
                while turtle.inspect() do 
                    turtle.dig()
                    turtle.digUp()
                    turtle.up()
                end
                while not turtle.inspectDown() do 
                    turtle.down()
                end

                -- Refuel
                setStatus("Running")
                turtle.select(1)
                while turtle.getItemCount() ~= 0 and turtle.getFuelLevel() / turtle.getFuelLimit() > 0.2 do
                    if not turtle.refuel() then break end
                end

                -- Load Fertilizer and Saplings
                setStatus("Reloading")
                turtle.turnLeft()
                turtle.turnLeft()
                turtle.forward()
                turtle.forward()
                turtle.select(16)
                turtle.suck(64 - turtle.getItemCount())
                turtle.down()
                turtle.select(15)
                turtle.suck(64 - turtle.getItemCount())
                turtle.up()

                -- Unload
                setStatus("Unloading")
                turtle.up()
                for i=1,8,1 do
                    turtle.select(i)
                    turtle.drop()
                end

                -- Return to tree
                turtle.down()
                turtle.turnRight()
                turtle.turnRight()
                turtle.forward()
                turtle.forward()
                
                -- Plant sapling
                turtle.select(16)
                turtle.place()

                -- Fertilize
                if daemon.status["Fertilize"] then
                    turtle.select(15)
                    turtle.place()
                end

                -- Return to starting position
                turtle.up()
            end
            
        end
    end
end

parallel.waitForAny(main, daemon.listen)

