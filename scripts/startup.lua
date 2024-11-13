
--[[
    This will run everytime we turn the computer on. That includes:
    when we log into the world, when we turn on the computer, when 
    the computer gets reloaded from an unloaded chunk.
]]

local smartMine = require("smartMine")
local smartCraft = require("smartCraft")
local calibration = require("calibration")
local smartActions = require("smartActions")
-- this will be used more extensively eventually, but it's just a placeholder for now


-- ALL THE CALIBRATION TO START WITH
calibration.setY()

-- BELOW ARE TEST RUNS RIGHT NOW

-- TODO find a better logic for this: rn if you mine the diamond vein but don't get enough, you don't get back to
-- diamonds until after running everything else

-- TODO add recursive-depth check to mineVein or find a different way to mine sand
while true do
    if not smartActions.isResourceSatisfied("minecraft:diamond") then
        smartMine.mineForBasicOre("diamonds")

    elseif not smartActions.isResourceSatisfied("minecraft:redstone") then
        smartMine.mineForBasicOre("redstone")
    
    elseif not smartActions.isResourceSatisfied("minecraft:lapis_lazuli") then
        smartMine.mineForBasicOre("lapis")
    
    elseif not smartActions.isResourceSatisfied("minecraft:raw_iron") then
        smartMine.mineForBasicOre("iron")
    
    elseif not smartActions.isResourceSatisfied("minecraft:sand") then
        smartMine.mineForBasicOre("sand")
    
    else
        break
    end
end

smac.goToY(100)


-- Add a calibrater, and run this here:
    -- loads settings, reselects item slot, checks fuel, checks inventory
    -- if y not set, might immediately go try to set y
    -- if not have the items it always expects to have, maybe complains
        -- maybe needs to check around for disk drive and stuff beforehand