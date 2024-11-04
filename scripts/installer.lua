
--[[
    Our installer module! Just run: 
        wget '"https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/scripts/installer.lua" installer'
    to get this file
]]
function install()

    -- Main stuff:

    -- STARTUP (we are just calling it main right now, so it doesn't automatically run)
    shell.run("wget", "https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/scripts/startup.lua", "main")
    
    -- SMART ACTIONS (smac)
    shell.run("wget", "https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/scripts/smartActions.lua", "smartActions")
    
    -- CALIBRATION (calibration)
    shell.run("wget","https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/scripts/calibration.lua", "calibration")

    -- MINING STATE FUNCTIONS (smartMine)
    shell.run("wget","https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/scripts/smartMine.lua", "smartMine")

    -- CRAFTING STATE FUNCTIONS (smartCraft)
    shell.run("wget","https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/scripts/smartCraft.lua", "smartCraft")

end

install()

print("\n \n You now have all of your libraries installed! \n",
"The executable file for the actual program is 'main'. \n \n")