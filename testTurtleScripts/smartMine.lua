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