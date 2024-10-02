local smartActions = {}

local dig_disallowed = {}

-- if i do this in the module, it does run it for the files that use it!
settings.load()

--[[
    ABBREVIATIONS
]]

function smartActions.dig() return smartActions.smartDig() end



--[[
    ACTUAL FUNCTIONS
]]

--[[
    Digs forward, digging extra blocks if 

    Return: a success value, a reason for any failure or extra action
]]
function smartActions.smartDig()
-- smart mine needs to check for:
    -- gravel/sand
    -- cobblestone
        -- this might be solved by just moving forward immediately after digging...
        -- then the turtle is there and the lava doesn't move fast enough
        -- if it is solved like that, then we can just mine until there's no block there
    -- blocks we don't allow ourselves to break
    local smart_reason = ""

    -- TODO: check whether the block is on disallowed list, returning false if so

    local dug, reason = turtle.dig()

    if dug then 
        -- if we broke a block, check if there's another block
        local is_block = turtle.detect()

        -- if there is, we'll clear it by just digging until no block remains
        -- we can do this because in theory the only "infinite" block is cobblestone
        -- generators, which we will move into before they can generate again
        -- also, gravel/sand drop fast enough that detect measures them
        if is_block then
            reason = "Had to clear extra blocks"
        end

        while is_block do
            turtle.dig()
            is_block = turtle.detect()
        end

        -- if block_details["name"] == "minecraft:gravel" or block_details["name"] == "minecraft.sand" then
    end
    
    return dug, reason
end

function smartActions.setY(yValue)
    settings.set("yLevel", yValue)
    settings.save()
end

function smartActions.getY()
    return settings.get("yLevel")
end

return smartActions