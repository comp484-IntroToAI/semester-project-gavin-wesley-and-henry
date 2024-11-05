local smartActions = {}

-- TODO - figure out whether requires within modules breaks stuff. does it make programs that require this run it too?
local calibration = require "calibration"





-- TODO move this to startup function/module
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

    moveSuccess, moveReason = turtle.forward()
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

--[[
    If an item is in the inventory, selects the last inventory slot with that item in it.
]]
function smartActions.selectItem(itemName)
    local checkResult = smartActions.checkInventoryForItem(itemName)
    if checkResult == false then
        return false
    end
    turtle.select(checkResult[2])
    return true
end


--[[
    Drops all items that are not whitelisted items. Keeps at most one full stack/slot of whitelisted items. The list of whitelisted items
    is defined at the top of this function.
    
    -- TODO: make this dump excess whitelisted
]]
function smartActions.dumpItems()
    -- TODO: figure out how to handle processed versions of this. for instance if we have floppy already, we never need lapis again
    -- TODO: add logs/planks to this system.
    -- TODO: figure out if we include buckets here. probably, but might affect stack checking logic
    local names = {"minecraft:diamond", "minecraft:redstone", "minecraft:raw_iron", "minecraft:lapis_lazuli", "minecraft:sugar_cane", "minecraft:cobblestone", "minecraft:sand", "minecraft:bucket","minecraft:water_bucket"}

    -- we create a set version of this table because we want to be able to check whether some item is in the list
    -- we can't just define them as keys in the initial construction because table keys can't contain colons
    -- this is what enables the [] indexing syntax
    local whitelisted = {}
    for index,name in ipairs(names) do
        whitelisted[name] = true
    end
    -- finished setting up whitelisted

    local startSlot = turtle.getSelectedSlot()

    for i=1,16 do
        local itemDetails = turtle.getItemDetail(i)
        -- if there's an item in the slot
        if itemDetails ~= nil then
            -- if the item's name is not in the list of whitelisted items (defined at top of smartActions file)
            if whitelisted[itemDetails["name"]] == nil then  
                turtle.select(i)
                turtle.drop()
            end
        end
    end

    turtle.select(startSlot)
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
-- currently, returns false if it isn't set yet.
function smartActions.getY()
    local y = settings.get("yLevel")

    if y == nil then 
        return false
    end

    return y
end



-- Return the module! --+
return smartActions   --+
------------------------+