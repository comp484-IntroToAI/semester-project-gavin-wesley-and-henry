local smartActions = {}

-- TODO - figure out whether requires within modules breaks stuff. does it make programs that require this run it too?
local calibration = require "calibration"

-- consider whether necessary. maybe to not break disk drives/stuff
local dig_disallowed = {}


-- if i do this in the module, it does run it for the files that use it!
-- TODO move this to a calibration function/module
settings.load()

--[[
    ABBREVIATIONS
]]

function smartActions.dig() return smartActions.smartDig() end
function smartActions.digUp() return smartActions.smartDigUp() end
function smartActions.digDown() return smartActions.smartDigDown() end

function smartActions.up() return smartActions.smartUp() end
function smartActions.down() return smartActions.smartDown() end

function smartActions.sy() return smartActions.setY() end
function smartActions.gy() return smartActions.getY() end



--[[
    ACTUAL FUNCTIONS
]]


    --[[        MINING FUNCTIONS        ]]--


--[[
    Digs forward, digging extra blocks if they exist. These are likely gravel/sand. Also avoids 
    blocks on a pre-determined disallowed mining list. These would probably be chests/disk drives/turtles.
    If we want to have circumstances where we mine without moving into the slot we're mining,
    we may need to adjust this to account for accidental cobblestone generators

    Return: a success value, a reason for any failure or extra action
]]
function smartActions.smartDig()
    -- TODO: check whether the block is on disallowed list, returning false and not mining if so

    local dug, reason = turtle.dig()

    if dug then
        -- if we broke a block, check if there's another block
        local is_block = turtle.detect()

        -- if there is, we'll clear it by just digging until no block remains
        if is_block then
            reason = "Had to clear extra blocks"
        end

        while is_block do
            turtle.dig()
            is_block = turtle.detect()
        end
    end

    return dug, reason
end

-- Version of smart dig to dig up
function smartActions.smartDigUp()
    -- TODO: check whether the block is on disallowed list, returning false and not mining if so

    local dug, reason = turtle.digUp()

    if dug then
        -- if we broke a block, check if there's another block
        local is_block = turtle.detectUp()

        -- if there is, we'll clear it by just digging until no block remains
        if is_block then
            reason = "Had to clear extra blocks"
        end

        while is_block do
            turtle.digUp()
            is_block = turtle.detectUp()
        end
    end

    return dug, reason
end

-- Version of smart dig to dig down
function smartActions.smartDigDown()
    -- TODO: check whether the block is on disallowed list, returning false and not mining if so

    local dug, reason = turtle.digDown()

    if dug then
        -- if we broke a block, check if there's another block
        local is_block = turtle.detectDown()

        -- if there is, we'll clear it by just digging until no block remains
        if is_block then
            reason = "Had to clear extra blocks"
        end

        while is_block do
            turtle.digDown()
            is_block = turtle.detectDown()
        end
    end

    return dug, reason
end

    --[[        MOVEMENT FUNCTIONS      ]]--


-- Version of turtle.up() that updates the y-value too
function smartActions.moveUp()
    -- TODO, when we have calibration and can check if settings are loaded or not, might adjust

    local success, reason = turtle.up()

    if success then
        smartActions.setY(smartActions.getY() + 1)
        return success, reason
    end

    return success, reason
end

-- Version of turtle.down() that updates the y-value too
function smartActions.moveDown()

    local success, reason = turtle.down()

    if success then
        smartActions.setY(smartActions.getY() - 1)
        return success, reason
    end
    return success, reason
end

-- Goes forward, breaking blocks in front of it if necessary
function smartActions.goForward()
    local moveSuccess, moveReason = turtle.forward()
    if moveSuccess then return true end
    
    local digSuccess, digReason = smartActions.dig()
    if not digSuccess then
        print(" SHIT IS REALLY BROKEN SHIT IS REALLY BROKEN")
        print(digReason)
        return false
    end

    moveSuccess, moveReason = smartActions.move()
    return moveSuccess
end

-- Goes up, smartly breaking blocks if necessary
function smartActions.goUp()
    local moveSuccess, moveReason = smartActions.moveUp()
    if moveSuccess then return true end
    
    local digSuccess, digReason = smartActions.digUp()
    if not digSuccess then
        print(" SHIT IS REALLY BROKEN SHIT IS REALLY BROKEN")
        print(digReason)
        return false
    end

    moveSuccess, moveReason = smartActions.moveUp()
    return moveSuccess
end

-- Goes down, smartly breaking blocks if necessary
function smartActions.goDown()
    local moveSuccess, moveReason = smartActions.moveDown()
    if moveSuccess then return true end
    
    local digSuccess, digReason = smartActions.digDown()
    if not digSuccess then
        print(" SHIT IS REALLY BROKEN SHIT IS REALLY BROKEN")
        print(digReason)
        return false
    end

    moveSuccess, moveReason = smartActions.moveDown()
    return moveSuccess
end


-- Goes to a y value, breaking blocks if necessary
function smartActions.goToY(desiredY)
    local CurrentY = smartActions.getY()

    if CurrentY == desiredY then return true end

    while CurrentY ~= desiredY do
        if CurrentY < desiredY then
            smartActions.goUp()
        else
            smartActions.goDown()
        end
    end
end

    --[[        INVENTORY FUNCTIONS        ]]--

--[[
    Checks whether an item is in the turtle's inventory. Parameter needs to be a string perfectly matching the item's
    Minecraft name. If the item is in the inventory, it returns a slot containing that item (if there are multiple, it only returns one of them)
    Returns bool, and slot (false & nil if no slot)
]]
function smartActions.checkInventoryForItem(itemName)
    local success = false
    local foundSlot = nil
    for i=1,16 do
        print(i)
        local itemDetails = turtle.getItemDetail(i)
        if itemDetails ~= nil then
            if itemDetails["name"] == itemName then
                success = true
                foundSlot = i
            end
        end
    end

    if not success then return success
    else return {success, foundSlot} end
end


        --[[    CALIBRATION FUNCTIONS       ]]--

-- sets the turtle's internal y value to a value. Expects settings to be loaded already
-- Should break if setting to nil, probably
function smartActions.setY(yValue)
    if yValue == nil then
        print("tried to set y-value to nil")
        print("so we did nothing")
    end
    settings.set("yLevel", yValue)
    settings.save()
end

-- returns the turtle's internal y level
-- currently, forces it to calibrate if the level isn't set yet. TODO figure out if that's the right behavior
function smartActions.getY()
    local y = settings.get("yLevel")

    if y == nil then 
        calibration.resetY()
        return -59 -- maybe could just returns settings.get again, because would have been set by calibration
    end

    return y
end



-- Return the module! --+
return smartActions   --+
------------------------+