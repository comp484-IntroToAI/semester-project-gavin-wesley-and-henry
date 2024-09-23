while(true) do
    local tried, reason = turtle.back();

    if(tried == false) then
        for i=1,5 do
            turtle.up()
        end
        turtle.select(16)
        turtle.placeUp()
        redstone.setOutput("top", true)
        break;
    end

    turtle.place();

    local turn = math.random(3)
    if(turn == 2) then
        turtle.turnLeft();
    end
    if(turn == 3) then
        turtle.turnRight();
    end
end