-- DEFINE LIBRARY----
local smartCraft = {}
---------------------

local smac = require "smartActions"
local smartMine = require "smartMine"

-----------------------
-- CHEST HELPERS
-- stole these from a forum post by fatboychummy: 
-- https://github.com/cc-tweaked/CC-Tweaked/discussions/1552#discussioncomment-6664168
-----------------------

--- Find an item in a chest, given the chest's position and item name.
---@param item_list itemList The list of items in the chest.
---@param item_name string The name of the item to find.
---@return integer? The slot number of the item, or nil if not found.
local function find_item(item_list, item_name)
    for slot, item in pairs(item_list) do
      if item.name == item_name then
        return slot
      end
    end
    return nil
end
  
--- Find the first empty slot in a chest.
---@param item_list itemList The list of items in the chest.
---@param size integer The size of the chest.
---@return integer? slot The slot number of the first empty slot, or nil if none are empty.
local function find_empty_slot(item_list, size)
    for slot = 1, size do
        if not item_list[slot] then
        return slot
        end
    end
    return nil
end
  
--- Move an item from one slot to another in a given inventory.
---@param inventory_name string The name of the inventory to move items in.
---@param from_slot integer The slot to move from.
---@param to_slot integer The slot to move to.
local function move_item_stack(inventory_name, from_slot, to_slot)
    return peripheral.call(inventory_name, "pushItems", inventory_name, from_slot, nil, to_slot)
end
  
--- Move a specific item to slot one, moving other items out of the way if needed.
---@param chest_name string The name of the chest to search.
---@param item_name string The name of the item to find.
---@return boolean success Whether or not the item was successfully moved to slot one (or already existed there)
function smartCraft.move_item_to_slot_one(chest_name, item_name)
    local list = peripheral.call(chest_name, "list")
    local size = peripheral.call(chest_name, "size")
    local slot = find_item(list, item_name)

    -- If the item didn't exist, or is already in the first slot, we're done.
    if not slot then
        print("Item not found")
        return false
    end
    if slot == 1 then
        print("Item already in slot 1")
        return true
    end
    
    -- If an item is blocking the first slot (we already know it's not the one we want), we need to move it.
    if list[1] then
        print("Slot 1 is occupied, moving to first empty slot")
        local empty_slot = find_empty_slot(list, size)

        -- If there are no empty slots, we can't move the item.
        if not empty_slot then
        print("No empty slots")
        return false
        end

        -- Move the item to the first empty slot.
        if not move_item_stack(chest_name, 1, empty_slot) then
        print("Failed to move item to slot " .. empty_slot)
        return false
        end

        print("Moved item to slot " .. empty_slot)
    end

    -- Move the item to slot 1.
    if move_item_stack(chest_name, slot, 1) == 0 then
        print("Failed to move item to slot 1")
        return false
    end

    print("Moved item to slot 1")
    return true
end

-----------------------
-- CHEST INTERACTION --
-----------------------

function smartCraft.getItemFromChest(item_name, count) 
    -- Assumes the turtle is facing a chest
    -- gets <count> items of the type <item_name> from the chest
    -- fails if turtle's inventory is full, or if the chest doesn't have the item
    if item_name == "None" or item_name == "none" or item_name == nil then
        return true
    end
    if smartCraft.move_item_to_slot_one("front", item_name) then
        return turtle.suck(count)
    else
        return false, "the chest doesn't have that item"
    end
end

function smartCraft.dumpAllExcept(materials)
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

    local startSlot = turtle.getSelectedSlot()
    for i=1,16 do
        local item_details = turtle.getItemDetail(i)
        if item_details ~= nil then
            if materials[item_details["name"]] == nil then
                turtle.select(i)
                turtle.drop()
            end
        end
    end
    turtle.select(startSlot)

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
    turtle.drop()
    return true
end

function smartCraft.dumpAllItems()
    -- Assumes the turtle is facing a chest
    -- Dumps all of its items into that chest
    local has_block, details = turtle.inspect()
    if (not has_block) then
        return false
    end
    if (details["name"] ~= "minecraft:chest") then
        return false
    end
    local startSlot = turtle.getSelectedSlot()
    for i=1,16 do
        turtle.select(i)
        turtle.drop()
    end
    turtle.select(startSlot)
    return true
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

-- slot 1: thing to smelt, slot 2: fuel slot, slot 3: result
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
------------------------------------
-- Craft-Level Resource Gathering --
------------------------------------

-- Returns {success?, reason} :)
function smartCraft.growPlants()
    
    sugarCaneSuccess = smartCraft.growSugarCane(4)

    if (not sugarCaneSuccess) then
        return {false, "sugar cane growth failed"}
    end

    local logs = smac.countItem("minecraft:birch_log")
    local saps = smac.countItem("minecraft:birch_sapling")
    while ((logs < 13) or (saps < 2)) do
        smac.smartDump()
        logSuccess, reason = smartCraft.growSapling()
        if (not logSuccess) then
            return {logSuccess, reason}
        end
        logs = smac.countItem("minecraft:birch_log")
        saps = smac.countItem("minecraft:birch_sapling")
    end

    return {true, "plants grown successfully"} 
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

----------------
-- GROW LOGS  --
----------------


-- Function goes to y=300, places dirt, and grows the sapling that it has
-- Fails and returns false, reason if any step along the way fails
function smartCraft.growSapling()

    -- Go wayyy up in the sky
    smac.goToY(300)

    -- Select dirt
    if smac.selectItem("minecraft:dirt") == false then
        return false, "no dirt in inventory"
    end

    -- Place the dirt
    local placed, re = turtle.placeDown()
    if not placed then
        return false, re
    end

    smac.goUp()

    -- Select sapling
    if smac.selectItem("minecraft:birch_sapling") == false then
        return false, "no sapling in inventory"
    end

    -- Place the sapling
    local place, rea = turtle.placeDown()
    if not place then
        return false, rea
    end

    smac.goBackward()
    smac.goDown()

    -- Wait for the tree to grow
    while true do
        local has_block, details = turtle.inspect()
        if has_block then
            if details["name"] == "minecraft:birch_log" then
                break
            end
        end
    end

    -- Mine the tree! :)
    smac.goBackward()
    turtle.turnLeft()
    smac.goForward()
    smac.goForward()
    turtle.turnRight()

    for i=1,6 do
        smac.goUp()
    end

    smac.minePrism(5,8,"top")

    return {true, "suceeded in growing a tree!"}
end


-----------------------------
-- Literal Actual Crafting --
-----------------------------

--[[
    Craft the recipe in the given list. The list must be an array 9 long, with the first three indices being the top row, etc.
    Assumes the turtle is facing a chest which contains all the ingredients necessary to the recipe.
    Pass "None" or "none" for any slots without items in them.
    The crafted item(s) are placed into the chest, leaving the turtle's inventory empty after the operation.
]]
function smartCraft.craftRecipe(recipeList)
    smartCraft.dumpAllItems()

    for i=1,3 do
        turtle.select(i)
        smartCraft.getItemFromChest(recipeList[i], 1)
    end

    for i=4,6 do
        turtle.select(i+1)
        smartCraft.getItemFromChest(recipeList[i], 1)
    end

    for i=7,9 do
        turtle.select(i+2)
        smartCraft.getItemFromChest(recipeList[i], 1)
    end

    turtle.craft()
    smartCraft.dumpAllItems()
end


function smartCraft.craftTurtle()
    --[[
        Assuming it is facing a chest with all of the necessary materials (post-smelting), crafts a new miney-crafting turtle
    ]]

    -- craft all the planks we'll need for these (30 for everything, leaving 2 left over)
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:birch_planks"])
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:birch_planks"])
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:birch_planks"])
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:birch_planks"])
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:birch_planks"])
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:birch_planks"])


    -- craft what we'll need to pass on our files
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:blue_dye"])
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:paper"])
    smartCraft.craftRecipe(globals.craftingRecipes["computercraft:disk"])
    smartCraft.craftRecipe(globals.craftingRecipes["computercraft:disk_drive"])

    -- craft what we'll need to equip our next turtle
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:stick"])
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:diamond_pickaxe"])
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:crafting_table"])
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:chest"])

        -- TODO: figure out if add chest / water buckets to this

    -- craft all of our mechanical bits, ending with the fully equipped turtle
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:glass_pane"])
    smartCraft.craftRecipe(globals.craftingRecipes["computercraft:computer"])
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:chest"])
    smartCraft.craftRecipe(globals.craftingRecipes["computercraft:turtle"])
    smartCraft.craftRecipe(globals.craftingRecipes["computercraft:crafty_turtle"])
    smartCraft.craftRecipe(globals.craftingRecipes["computercraft:miney_crafty_turtle"])
end


function smartCraft.craftPreparation()
    --[[
        Craft all of the things we'll need in order to prepare for crafting: furnace, fuel, chest, etc.
    ]]

    -- TODO: figure out exactly how 
    -- each plank smelts 1.5 items, so we need:
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:birch_planks"])   -- 10 planks * 1.5 for 14 stone (2 planks left-over)
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:birch_planks"])
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:birch_planks"])

    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:birch_planks"])   -- 4 planks * 1.5 for 6 glass (no planks left-over)

    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:birch_planks"])   -- 5 planks * 1.5 for 7 iron (use the 2 planks left over from stone to supplement)

    -- and we need the furnace
    smartCraft.craftRecipe(globals.craftingRecipes["minecraft:furnace"])
end

--- RETURN LIBRARY----
return smartCraft
----------------------