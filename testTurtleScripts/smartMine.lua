---- DEFINE LIBRARY ----
local smartMine = {}
------------------------

local smac = require "smartActions"


function smartMine.searchForDiamonds()
    smac.goToY(-59)

    local foundDiamonds = false

    while not foundDiamonds do
        local has_block, details = turtle.inspect()
        -- TODO: Make this check above and below too. triples our odds
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


function smartMine.mineVein()
    -- TODO by Wesley
    -- You are face to face with the block that you would like to mine.
    -- Mine a 5x5 cube around it
    -- Don't worry about inventory management, and just worry about making it work on Diamonds for now
    -- make sure to use functions from smartActions (smac)
end


function smartMine.stickToSurface()
    -- TODO: make a function that, when called, has the turtle go down until it is resting on a surface block (check for leaves?)
end

-----
-- TODO

-- FIND SAND, WOOD, AND WATER.
-- GROW SUGARCANE

------ RETURN LIBRARY -------
return smartMine
-----------------------------