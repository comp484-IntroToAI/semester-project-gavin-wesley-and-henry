local smac = require "smartActions"

CurrentY = settings.get("yLevel")

if CurrentY ~= -59 then
    print("We are not at the correct y-level to hunt for diamonds")
    return false
end

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