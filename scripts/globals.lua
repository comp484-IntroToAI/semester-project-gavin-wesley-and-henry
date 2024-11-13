-- DEFINE MODULE --
local globals = {}
-------------------

--[[ ===================

This module contains lists of various things that other modules in the library may need.
Check if an item is in them by checking whether globals.NAME[thingToCheck] ~= nil.
Most are sets, where the key and value in the table are the same thing.
For some (like global.resourceCount), you can also get a count for the number by doing globals.NAME[thingToCheck]

we need to do the 'for' loops because the pure list versions aren't indexable (we can't check whether something is in them)
    - I wish we could just say arr = {name = true, name2 = true} etc., but the keys in the definition are only implicitly 
        treated like strings, and they can't have colons in them! which sucks :(
-- =================== ]]

globals.logs = {}
local logNames = {"minecraft:oak_log", "minecraft:spruce_log", "minecraft:birch_log", "minecraft:jungle_log", 
                "minecraft:acacia_log", "minecraft:dark_oak_log", "minecraft:mangrove_log", "minecraft:cherry_log"}
for index,name in ipairs(logNames) do
    globals.logs[name] = name
end

globals.planks = {}
local planksNames = {"minecraft:oak_planks", "minecraft:spruce_planks", "minecraft:birch_planks", "minecraft:jungle_planks", 
                "minecraft:acacia_planks", "minecraft:dark_oak_planks", "minecraft:mangrove_planks", "minecraft:cherry_planks"}
for index,name in ipairs(planksNames) do
    globals.planks[name] = name
end

globals.sugarcaneGrowable = {}
local sugarcaneGrowableNames = {"minecraft:grass", "minecraft:dirt", "minecraft:sand", "minecraft:mycelium"}
for index,name in ipairs(sugarcaneGrowableNames) do
    globals.sugarcaneGrowable[name] = name
end

globals.whitelisted = {}
local whitelistedNames = {"minecraft:diamond", "minecraft:redstone", "minecraft:raw_iron", "minecraft:lapis_lazuli", 
                    "minecraft:sugar_cane", "minecraft:cobblestone", "minecraft:sand", "minecraft:bucket", "minecraft:water_bucket",
                    "minecraft:dirt"}
for index,name in ipairs(whitelistedNames) do
    globals.whitelisted[name] = name
end

globals.ores = {}
local oreNames = {"minecraft:diamond_ore", "minecraft:deepslate_diamond_ore", "minecraft:iron_ore", "minecraft:deepslate_iron_ore", 
                "minecraft:lapis_ore", "minecraft:deepslate_lapis_ore", "minecraft:redstone_ore", "minecraft:deepslate_redstone_ore"}
for index,name in ipairs(oreNames) do
    globals.ores[name] = name
end


-- ============
-- DEFINE RESOURCES + RESOURCE COUNTS FOR MAIN RECIPE
-- ============

-- Currently handling logs by just giving them their own logic every time we interact with the recipe
-- TODO: implement a better strategy for this
    -- my thought is that resources and resourceCount just have a slot for "at least one of" items, which is a value
    -- that has its own table, with a table of potential items and the goal count.

globals.resources = {}
local resourceNames = {"minecraft:diamond", "minecraft:redstone", "minecraft:raw_iron", "minecraft:lapis_lazuli", 
                "minecraft:cobblestone", "minecraft:sand", "logs"}
for index,name in ipairs(resourceNames) do
    globals.resources[name] = name
end


globals.resourceCount = {}
    globals.resourceCount["minecraft:diamond"] = 3
    globals.resourceCount["minecraft:raw_iron"] = 7
    globals.resourceCount["minecraft:redstone"] = 4
    globals.resourceCount["minecraft:lapis_lazuli"] = 1
    globals.resourceCount["minecraft:cobblestone"] = 30
    globals.resourceCount["minecraft:sand"] = 6
    globals.resourceCount["logs"] = 6

-- RETURN MODULE --
return globals