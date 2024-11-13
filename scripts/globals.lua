-- DEFINE MODULE --
local globals = {}
-------------------

--[[ ===================

This module contains lists of various things that other modules in the library may need.

we need to do the 'for' loops because the pure list versions aren't indexable (we can't check whether something is in them)

-- =================== ]]

globals.logs = {}
local logNames = {"minecraft:oak_log", "minecraft:spruce_log", "minecraft:birch_log", "minecraft:jungle_log", 
                "minecraft:acacia_log", "minecraft:dark_oak_log", "minecraft:mangrove_log", "minecraft:cherry_log"}
for index,name in ipairs(logNames) do
    globals.logs[name] = false
end

globals.planks = {}
local planksNames = {"minecraft:oak_planks", "minecraft:spruce_planks", "minecraft:birch_planks", "minecraft:jungle_planks", 
                "minecraft:acacia_planks", "minecraft:dark_oak_planks", "minecraft:mangrove_planks", "minecraft:cherry_planks"}
for index,name in ipairs(planksNames) do
    globals.planks[name] = false
end

globals.sugarcaneGrowable = {}
local sugarcaneGrowableNames = {"minecraft:grass", "minecraft:dirt", "minecraft:sand", "minecraft:mycelium"}
for index,name in ipairs(sugarcaneGrowableNames) do
    globals.sugarcaneGrowable[name] = false
end

globals.whitelisted = {}
local whitelistedNames = {"minecraft:diamond", "minecraft:redstone", "minecraft:raw_iron", "minecraft:lapis_lazuli", 
                    "minecraft:sugar_cane", "minecraft:cobblestone", "minecraft:sand", "minecraft:bucket", "minecraft:water_bucket",
                    "minecraft:dirt"}
for index,name in ipairs(whitelistedNames) do
    globals.whitelisted[name] = false
end

globals.ores = {}
local oreNames = {"minecraft:diamond_ore", "minecraft:deepslate_diamond_ore", "minecraft:iron_ore", "minecraft:deepslate_iron_ore", 
                "minecraft:lapis_ore", "minecraft:deepslate_lapis_ore", "minecraft:redstone_ore", "minecraft:deepslate_redstone_ore"}
for index,name in ipairs(oreNames) do
    globals.ores[name] = false
end


-- RETURN MODULE --
return globals