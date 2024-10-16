local smartActions = {}

local dig_disallowed = {}

-- if i do this in the module, it does run it for the files that use it!
settings.load()

--[[
    ABBREVIATIONS
]]

function smartActions.dig() return smartActions.smartDig() end
function smartActions.sy() return smartActions.setY() end
function smartActions.gy() return smartActions.getY() end



--[[
    ACTUAL FUNCTIONS
]]

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

-- 

--[[
    Functions to interact with our internal y-level representation

    these are still proof-of-concepts. Basically settings is our persistent storage, and we can maybe
    just store our state in there. Need to look into how slow settings.save is and whether the state
    can be fucked by leaving at an inopportune time
    ]]
function smartActions.setY(yValue)
    settings.set("yLevel", yValue)
    settings.save()
end

function smartActions.getY()
    return settings.get("yLevel")
end


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


-- Return the module! --+
return smartActions   --+
------------------------+