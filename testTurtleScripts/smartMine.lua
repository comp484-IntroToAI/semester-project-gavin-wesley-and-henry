local smac = require "smartActions"

local function searchForDiamonds()
    smac.goToY(-59)

    local foundDiamonds = false

    while not foundDiamonds do
        local has_block, details = turtle.inspect()
        if has_block then
            if details["name"] == "minecraft:deepslate_diamond_ore" or details["name"] == "minecraft:diamond_ore" then
                foundDiamonds = true
                return true
            end
            smac.dig()
        end
        turtle.forward()
    end
end

searchForDiamonds()



function growSugarCane()
    --TODO: make it work (Henry wants to)
end

-----
-- TODO

-- FIND SAND, WOOD, AND WATER.
-- GROW SUGARCANE

------