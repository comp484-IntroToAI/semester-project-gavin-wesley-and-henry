local smac = require "smartActions"

CurrentY = settings.get("yLevel")

local function huntForBedrock() 
    local foundBedrock = false

    while not foundBedrock do 
        local has_block, block_data = turtle.inspectDown()
        if has_block then
            print("was a block")
            if block_data["name"] ~= "minecraft:bedrock" then
                turtle.digDown()
                turtle.down()
            else
                foundBedrock = true
            end
        else
            print("was not a block")
            turtle.down()
        end
    end
end


-- checks whether the given block is next to the turtle
-- returns a boolean value, as well as a table with the particular positions the block was in
local function checkBlock(blockName)
    local wasBlock = false
    local blockData = {}
    for i=1, 4 do
        blockData[i] = false
      end
    local has_block

    for i=1, 4 do
        has_block, details = turtle.inspect()
        if has_block then
            if details["name"] == blockName then
                wasBlock = true
                blockData[i] = true
            end
        end
        turtle.turnLeft()
    end
    
    return wasBlock, blockData
end

local function realityCheck()
    --[[
    This checks that we're good by going forward a block, then checking for bedrock again. 
    There's a possibility this fails too, but it's very slim ]]

    local inReality = true
    -- for each cardinal direction,
    for i=1,4 do
        turtle.turnLeft()

        -- try to dig forward one block, if we succeed, go forward and check for bedrock and then repeat
        local success, reason = smac.dig()

        -- if we successfully dig, or there's nothing there, then move and check
        if success or reason == "Nothing to dig here" then
            turtle.forward()
            if checkBlock("minecraft:bedrock") then
                inReality = false
            end

            -- turn around, go back to original spot, then turn to be in same orientation as before
            turtle.turnLeft()
            turtle.turnLeft()
            turtle.forward()
            turtle.turnLeft()
            turtle.turnLeft()
        
        else -- if we fail to dig because it's bedrock then we're uncalibrated
            inReality = false
        end
    end
    

    return inReality
end

local function calibrateY()
    --[[
    When we hit bedrock, there's only a 1 in 5 chance we're at the lowest comfortable y-level
    This function calibrates our Y to be at the top of bedrock. It basically checks if there's bedrock
    on its current level and moves up if there is. There are some circumstances where this will fail, so
    we then do a reality check to minimize breakages.
    ]]
    local calibrated = false
    local yIncrease = 0

    -- while we're still in the middle bedrock layers, check again and move up
    while not calibrated do
        -- if we've already moved up 4 layers, our only possibility is to be over bedrock
        if yIncrease == 4 then
            break
        end

        -- check if there's any bedrock on our y-level right next to us, if there is we must not be on the right level
        -- so we just move up and note our y-level increasing
        if checkBlock("minecraft:bedrock") then
            turtle.up()
            yIncrease = yIncrease + 1
        else 
            -- if there's not, then we're probably calibrated!
            -- this breaks us out of our calibration loop
            calibrated = true
        end
    end

    -- now we do a reality check. we don't need to if our yIncrease is 4, because we'd know we're right above the top layer of bedrock
    if yIncrease ~= 4 then
        print("running reality check")

        if not realityCheck() then
            -- if our realityCheck failed, we were in a weird edge case. just move up one and recalibrate
            print("reality failed, so moving up and recalibrating")
            turtle.up()
            calibrateY()
        end
    end

    smac.setY(-59)
end

huntForBedrock()
calibrateY()
