-- DEFINE LIBRARY----
local smartCraft = {}
---------------------

local smac = require "smartActions"

-----------
-- CHEST --
-----------

function smartCraft.dumpAllExcept()
    -- Assumes the turtle is facing a chest
    -- Takes a list of items 'materials' and dumps all items besides those from the inventory into that chest
    -- Returns true if successful, false otherwise
    local has_block, details = turtle.inspect()
    if (not has_block) then
        return false
    end
    if (details["name"] ~= "minecraft:chest") then
        return false
    end

end

function smartCraft.dumpCurrentSlot()
    -- Assumes the turtle is facing a chest
    -- Dumps the item it is currently selecting into that chest

    local has_block, details = turtle.inspect()
    if (not has_block) then
        return false
    end
    if (details["name"] ~= "minecraft:chest") then
        return false
    end

end

function smartCraft.collectAll()
    -- Assumes the turtle is facing a chest
    -- Collects every item from that chest

    local has_block, details = turtle.inspect()
    if (not has_block) then
        return false
    end
    if (details["name"] ~= "minecraft:chest") then
        return false
    end

end

-------------
-- FURNACE --
-------------

function smartCraft.addFuel(nLogs)
    -- Assumes the turtle is facing a furnace
    -- Adds nLogs logs to the furnace in front of it

    local has_block, details = turtle.inspect()
    if (not has_block) then
        return false
    end
    if (details["name"] ~= "minecraft:furnace") then
        return false
    end

end

function smartCraft.smeltCurrentItem(toSmelt)
    -- Assumes the turtle is facing a furnace with fuel in it
    -- Smelts toSmelt items in the current slot
    -- I think it should wait for those to smelt, and then be able to return stuff based on how successful it was?? idk

    local has_block, details = turtle.inspect()
    if (not has_block) then
        return false
    end
    if (details["name"] ~= "minecraft:furnace") then
        return false
    end

end

----------------
-- SUGAR CANE --
----------------

-- Function assumes we are STANDING on a piece of dirt that is water-adjacent!!
function smartCraft.growSugarCane(scToGrow)

    local foundSuitableLocation = smartCraft.findSugarCaneLocation()
    if not foundSuitableLocation then
        return false
    end

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
    for i=1,4 do
        turtle.turnLeft()
    end
    smac.moveDown()
    return true
end

-- Function that finds grass/dirt/sand that is next to water.
function smartCraft.findSugarCaneLocation()

    -- Find water
    smartCraft.locateWater()

    -- Clear the area
    smac.goDown()
    smac.dig()
    smac.goUp()
    smac.dig()
    smac.goForward()
    smac.goUp()
    smac.goUp()
    smac.goUp()
    smac.goDown()
    smac.goDown()
    smac.goDown()
    
    -- We might want to check if we really have dirt-- but also dirt is so prevelant im not worried
    local haveDirt = smac.selectItem("minecraft:dirt")
    if (not haveDirt) then
        return false
    end
    turtle.placeDown()

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

-----------------------------
-- Literal Actual Crafting --
-----------------------------

function smartCraft.craftRecipie(slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
    -- Still not sure how exactly this will work
end

-- Tries to craft a new turtle. Returns True if Sucessful, False if otherwise. 
function smartCraft.craftNewTurtle()

end

--- RETURN LIBRARY----
return smartCraft
----------------------