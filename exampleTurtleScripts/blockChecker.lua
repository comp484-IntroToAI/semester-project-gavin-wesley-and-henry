local personalCoords = {x = 0, y = 0, z = 0}
local treeLocations = {}



local function checkBlock() 
    local has_block, details = turtle.inspect()
    if has_block then
        return details
    end
    return false
end


while true do
    io.write("ready for next read?")
    local answer = io.read("*l")
    local blockResult = checkBlock()
    if not blockResult == false then
        -- textutils.pagedPrint(textutils.serialise(blockResult))
        textutils.pagedPrint(blockResult["name"])
    end
end

-- needs to know where trees are
-- needs to know whats going on in its inventory
-- needs to store inventory somewhere
