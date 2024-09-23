this = {curDirection = 1, curCoords = {x = 0, y = 0, z = 0}}
map = {block = "block", {x = 0, y = 0, z = 0}}
function this.turnRight ()
    if      this.curDirection == 1 then
        this.curDirection = 2
    elseif  this.curDirection == 2 then
        this.curDirection = -1
    elseif  this.curDirection == -1 then
        this.curDirection = -2
    elseif  this.curDirection == -2 then
        this.curDirection = 1
    end
    turtle.turnRight()
end

function this.turnLeft ()
    if      this.curDirection == 1 then
        this.curDirection = -2
    elseif  this.curDirection == -2 then
        this.curDirection = -1
    elseif  this.curDirection == -1 then
        this.curDirection = 2
    elseif  this.curDirection == 2 then
        this.curDirection = 1
    end
    turtle.turnLeft()
end

function this.turnUntil(dir)
    while this.curDirection ~= dir do
        this.turnRight()
    end
end

function this.moveForward()
    -- Note that this assumes the forward succeeds
    -- TODO refactor to allow assert test of forward
    if this.curDirection == 1 then
        this.curCoords["x"] = this.curCoords["x"] + 1
    
    elseif this.curDirection == -1 then
        this.curCoords["x"] = this.curCoords["x"] - 1

    elseif this.curDirection == 2 then
        this.curCoords["y"] = this.curCoords["y"] + 1

    elseif this.curDirection == -2 then
        this.curCoords["y"] = this.curCoords["y"] - 1
    end
    turtle.forward()
end

function this.moveUp()
    if not turtle.detectUp() then
        this.curCoords["z"] = this.curCoords["z"] + 1
        turtle.up()
        return true
    else return false
    end
end

function this.moveDown()
    if not turtle.detectDown() then
        this.curCoords["z"] = this.curCoords["z"] - 1
        turtle.down()
        return true
    else return false
    end
end

function this.getDirection()
    return this.curDirection
end


function this.checkPheromone()
    local isBlock, blockUnder = turtle.inspectDown();
    if isBlock then
        print(blockUnder)
    end
end


for i = 1, 10, 1 do
    turtle.dig()
    this.moveForward()
end

-- MAP
--   plusX, minusX, plusY, minusY, plusZ,w minusZ