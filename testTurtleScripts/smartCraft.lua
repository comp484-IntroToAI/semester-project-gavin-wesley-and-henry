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
    if ~moved then
        return false
    end

    local placed, re = turtle.placeDown()
    if ~placed then
        return false
    end

    local moved2, r = smac.moveUp()
    if ~moved then
        return false
    end

    while (turtle.getItemCount() < (initialSugarCaneCount + )) do
        local block_down, details = turtle.inspectDown()
        if block_down then
            if details["name"] == "minecraft:sugar_cane" then
                turtle.digDown() -- Not using SMAC here beacuse that gives us more info than we really need.
            end
    end

end

function smartCraft.findSugarCaneLocation()
    --TODO: create a function that either finds or creates a situation where sand is next to water
    -- HAVE IT LEAVE THE TURTLE ON THE SAND
end

-- Tries to craft a new turtle. Returns True if Sucessful, False if otherwise. 
function smartCraft.craftNewTurtle()
end



--- RETURN LIBRARY----
return smartCraft
----------------------