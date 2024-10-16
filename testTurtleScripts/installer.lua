
--[[
    Our installer module! Just run 'wget "https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/testTurtleScripts/installer.lua'
    to get this file
]]
function install()
    shell.run("wget", "https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/testTurtleScripts/startup.lua", "startup")
    
    shell.run("wget", "https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/testTurtleScripts/smartActions.lua", "smartActions")
    
    shell.run("wget","https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/testTurtleScripts/findBedrock.lua", "findBedrock")
end

install()

print("You now have all of your libraries installed! \n",
"The only executable file right now is 'findBedrock' \n",
"If you run that, your turtle will dig down until bedrock \n",
 "and then set its internal y-level to be the correct y-level")