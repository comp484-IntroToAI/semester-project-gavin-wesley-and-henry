
--[[
    Our installer module! Just run 'wget "https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/testTurtleScripts/installer.lua
    to get this file
]]
function install()

    -- Main stuff:

    -- STARTUP
    shell.run("wget", "https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/testTurtleScripts/startup.lua", "startup")
    
    -- SMART ACTIONS (smac)
    shell.run("wget", "https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/testTurtleScripts/smartActions.lua", "smartActions")
    
    -- CALIBRATION (calibration)
    shell.run("wget","https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/testTurtleScripts/calibration.lua", "calibration")

    -- Test stuff:

    -- Smart mine
    shell.run("wget","https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/testTurtleScripts/smartMine.lua", "smartmine")
end

install()

print("You now have all of your libraries installed! \n",
"The only executable file right now is 'smartMine' \n",
"If you run that, your turtle will calibrate its Y, and then go digging for diamonds")