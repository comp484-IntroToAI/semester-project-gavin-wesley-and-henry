
# Mine State (get resources)
    - check resource completion
        - if complete, switch to craft state
    - otherwise pick next resource
    - go to that "state"


# Mine State
    - go to bedrock
    - priority dict = {diamonds:3, redstone:4, lapis:1, iron:7, cobblestone:14} # this is ordered by my best guess of their depths
    - depth dict = {diamonds:y, redstone:y, lapis:y, iron:y, cobblestone:y} # I couldn't really tell exactly what depths they're found at
    - x = 0
    - while len(dict) > 0:
        - start at front of priority dict
        - go to depth dict[priority dict[x]:y]
        - while not priority dict[x] >= priority dict[1:n]:
            - mine around
            - periodically check if inventory is full
                - drop stuff if it's not in the dictionaries
        - while priority dict[x] >= priority dict[x:n]: # see if it randomly picked up the next resource along the way, if so, check the resource after that, and so on until it finds one it needs or it's done, in which case the overall while loop breaks
            - x += 1
        - delete priority dict[0 through x-1] # probably there will have to be a copy of this to regenerate from each reproduction cycle
    - once it's done with all the mining, it has to get the sand, sugarcane, logs and planks, there's probably a similar but slightly different process to get those but idk exactly how they're found/grown
    - fuel would make this more complicated

# Craft State
    

            
