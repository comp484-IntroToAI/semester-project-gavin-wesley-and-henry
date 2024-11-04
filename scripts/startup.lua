
--[[
    This will run everytime we turn the computer on. That includes:
    when we log into the world, when we turn on the computer, when 
    the computer gets reloaded from an unloaded chunk.
]]

local smartMine = require("smartMine")
local smartCraft = require("smartCraft")
local calibration = require("calibration")
-- this will be used more extensively eventually, but it's just a placeholder for now


-- ALL THE CALIBRATION TO START WITH
calibration.setY()

-- BELOW ARE TEST RUNS RIGHT NOW
smartMine.mineForBasicOre("diamonds")




-- Add a calibrater, and run this here:
    -- loads settings, reselects item slot, checks fuel, checks inventory
    -- if y not set, might immediately go try to set y
    -- if not have the items it always expects to have, maybe complains
        -- maybe needs to check around for disk drive and stuff beforehand