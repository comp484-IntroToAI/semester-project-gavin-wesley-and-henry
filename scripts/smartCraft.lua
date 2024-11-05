-- DEFINE LIBRARY----
local smartCraft = {}
---------------------

local smac = require "smartActions"

-- Function assumes we are STANDING on a piece of sand that is water-adjacent!!
function smartCraft.growSugarCane(scToGrow)
    -- Select the sugar cane, or return false if unsuccessful

    if smac.selectItem("minecraft:sugar_cane") == false then
        return false
    end

    local initialSugarCaneCount = turtle.getItemCount()

    local moved, r = smac.moveUp()
    if not moved then
        return false
    end

    local placed, re = turtle.placeDown()
    if not placed then
        return false
    end

    local moved2, rea = smac.moveUp()
    if not moved then
        return false
    end

    while (turtle.getItemCount() < ((initialSugarCaneCount-1) + scToGrow)) do
        local block_down, details = turtle.inspectDown()
        if block_down then
            if details["name"] == "minecraft:sugar_cane" then
                turtle.digDown() -- Not using SMAC here beacuse that gives us more info than we really need.
            end
        end
    end

    smac.moveDown()
    smac.digDown()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.turnLeft()
    smac.moveDown()
    return true
end

-- Function that positions the turtle such that it is standing above water.
-- Does so by wandering around at water level.
function smartCraft.locateWater()
    -- Go to water level:
    smac.goToY(63)

    -- Go until we find water
    while true do
        local has_block, details = turtle.inspectDown()
        if has_block then
            if details["name"] == "minecraft:water" then

                break
            end
        end
        smac.goForward()
    end
end

-- Function that finds sand that is next to water.
-- Could be adapted if we decide to find sand and place it next to water, but that seems trickier
-- to me, because sand can fall? I dunno.
function smartCraft.findSugarCaneLocation()
    -- TODO make this!
end

-- Tries to craft a new turtle. Returns True if Sucessful, False if otherwise. 
function smartCraft.craftNewTurtle()

end



--- RETURN LIBRARY----
return smartCraft
----------------------