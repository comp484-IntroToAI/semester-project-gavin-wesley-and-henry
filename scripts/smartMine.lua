---- DEFINE LIBRARY ----
local smartMine = {}
------------------------

local smac = require "smartActions"


--[[
    Digs in a straight line until it sees a block (in front, above, or below, but not left or right) 
    with either name1 or name2. These should be the regular ore and the deepslate version of the ore
]]
local function digUntilFind(name1, name2)
    local foundOre = false

    while not foundOre do
        local has_block, details = turtle.inspect()
        if has_block then
            if details["name"] == name1 or details["name"] == name2 then
                foundOre = true
                return true
            end
        end

        has_block, details = turtle.inspectUp()
        if has_block then
            if details["name"] == name1 or details["name"] == name2 then
                foundOre = true
                return true
            end
        end

        has_block, details = turtle.inspectDown()
        if has_block then
            if details["name"] == name1 or details["name"] == name2 then
                foundOre = true
                return true
            end
        end

        smac.goForward()
    end
end

--[[
    Goes to the y-level for an ore, and then mines in a straight line until it finds that resource.
]]
function smartMine.mineForBasicOre(ore)
    -- Y-levels to mine at are taken from https://minecraft.wiki/w/Ore#Distribution as of 11/4/24
    if ore == "diamond" or ore == "diamonds" then
        smac.goToY(-59)
        digUntilFind("minecraft:deepslate_diamond_ore", "minecraft:diamond_ore")
    end

    if ore == "redstone" then
        smac.goToY(-59)
        digUntilFind("minecraft:deepslate_redstone_ore", "minecraft:redstone_ore")
    end

    if ore == "lapis" or ore == "lapis lazuli" then
        smac.goToY(-2)
        digUntilFind("minecraft:deepslate_lapis_ore", "minecraft:lapis_ore")
    end

    if ore == "iron" then
        smac.goToY(14)
        digUntilFind("minecraft:deepslate_iron_ore", "minecraft:iron_ore")
    end

    if ore == "coal" or "fuel" then
        smac.goToY(45)
        digUntilFind("minecraft:deepslate_coal_ore", "minecraft:coal_ore")
    end

    -- this is a temp way to find sand w/o sticking to a surface
    -- based on the idea that we mostly want sand to grow sugarcane on, so it will be at water level
    -- 62 for the y should keep us at the top block of rivers / oceans, so we are walking through water
    if ore == "sand" then
        smac.goToY(62)
        digUntilFind("minecraft:sand", "NONE")
    end

end


function smartMine.mineVein()
    -- go to the back of the cube
    turtle.backward()
    -- mine a 5x5 square, then go back to the center and move forward and do it 4 more times
    -- the turtle should end up facing forward one block ahead of the cube
    -- the y-value shouldn't need to be updated unless it has to stop in the middle for some reason, probably fuel
    -- I don't have time to test it right now, also idk if it needs to be changed at all based on which block it's mining
    for i = 1, 5 do
       smac.goUp()
       smac.goUp()
       turtle.turnRight()
       smac.goForward()
       smac.goForward()
       smac.goDown()
       turtle.turnLeft()
       turtle.turnLeft()
       smac.goForward()
       smac.goDown()
       turtle.turnRight()
       turtle.turnRight()
       smac.goForward()
       smac.goDown()
       smac.goDown()
       turtle.turnLeft()
       turtle.turnLeft()
       smac.goForward()
       smac.goUp()
       smac.goForward()
       smac.goDown()
       smac.goForward()
       smac.goForward()
       smac.goUp()
       turtle.turnRight()
       turtle.turnRight()
       smac.goForward()
       smac.goUp()
       smac.goUp()
       smac.goUp()
       turtle.turnLeft()
       turtle.turnLeft()
       smac.goForward()
       smac.goDown()
       smac.goDown()
       turtle.turnRight()
       turtle.turnRight()
       smac.goForward()
       smac.goForward()
       turtle.turnLeft()
       smac.goForward()
    end
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