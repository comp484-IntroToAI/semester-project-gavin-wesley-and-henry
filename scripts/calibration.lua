local calibration = {}

-- if calibration requires smac, and smac requires calibration, everything breaks
-- which means we can't use samc helper functions here

-- meaning smac probably ends up being a "higher-level" helper library

local function goToBedrock() 
    local foundBedrock = false

    while not foundBedrock do 
        -- check if the block below us is bedrock, if it is, break and return
        local has_block, block_data = turtle.inspectDown()
        if has_block then 
            if block_data["name"] == "minecraft:bedrock" then
                foundBedrock = true
                return true
            end

            -- if the block isn't bedrock, mine it to clear our path
            turtle.digDown()
            -- this used to be smac. think if we need more edge-case handling that smac provides
            -- if we do, we'll need to change it up a bit

        end
        
        -- move down one block
        turtle.down()
    end
end


-- checks whether the given block is next to the turtle
-- returns a boolean value, as well as a table with the particular positions the block was in
local function checkBlock(blockName)
    -- TODO this is probably a smac function. will need to adjust for smart movement
    local wasBlock = false
    local blockData = {}
    for i=1, 4 do
        blockData[i] = false
      end
    local has_block, details

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


local function checkStillInBedrock()
    --[[
    This checks that we're good by going forward a block, then checking for bedrock again. 
    There's a possibility this fails too, but it's very slim ]]

    local notInBedrock = true
    -- for each cardinal direction,
    for i=1,4 do
        turtle.turnLeft()

        -- try to dig forward one block, if we succeed, go forward and check for bedrock and then repeat
        local success, reason = turtle.dig()
        -- TODO - this dig used to be smac. think if there's ever a world where we need
        -- edge case handling here. we're in bedrock, so probs not, but worth checking

        -- if we successfully dig, or there's nothing there, then move and check
        if success or reason == "Nothing to dig here" then
            turtle.forward()
            if checkBlock("minecraft:bedrock") then
                notInBedrock = false
            end

            -- turn around, go back to original spot, then turn to be in same orientation as before
            turtle.turnLeft()
            turtle.turnLeft()
            turtle.forward()
            turtle.turnLeft()
            turtle.turnLeft()
        
        else -- if we fail to dig because it's bedrock then we're uncalibrated
            notInBedrock = false
        end
    end

    return notInBedrock
end


local function goToTopOfBedrock()
    --[[
    When we hit bedrock, there's only a 1 in 5 chance we're at the lowest comfortable y-level
    This function calibrates us to be at the top of bedrock. It basically checks if there's bedrock
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

        if not checkStillInBedrock() then
            -- if our realityCheck failed, we were in a weird edge case. just move up one and recalibrate
            print("reality failed, so moving up and recalibrating")
            turtle.up()
            goToTopOfBedrock()
        end
    end

end


-- Places the turtle one layer above bedrock, and sets its internal y to -59. Main function to use
-- if the y-value in settings isn't set yet, or if we run into some other problem that happens because
-- of uncalibrated y-values
function calibration.setY()
    goToBedrock()
    goToTopOfBedrock()

    -- this used to be smac.setY, but that breaks, so doing it ourselves
    -- need to think about whether settings is already loaded, etc.

    settings.load()
    settings.set("yLevel", -59)
    settings.save()

    return true
end



-- did set y alr :)

-- TODO:

-- CHECK INVENTORY / UPDATE REQUIRED MATERIALS type beat
-- CHECK FUEL / INITIAL REFUEL

-- Return the module
-------------------+
return calibration
-------------------+