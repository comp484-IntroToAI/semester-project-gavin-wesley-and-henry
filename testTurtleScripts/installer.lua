
--[[
    Our installer module! When we make changes to any of these files, 
    we'll need to reupload to pastebin and replace the code, and then
    reupload the installer file too.
]]
function install()
    shell.run("wget", "https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/testTurtleScripts/startup.lua?token=GHSAT0AAAAAACW7P2EVGIADHP3H6VSG6N4QZYPDSTQ", "startup")
    shell.run("wget", "https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/testTurtleScripts/smartActions.lua?token=GHSAT0AAAAAACW7P2EVNJZA4THV3UESYGPWZYPDSMA", "smartActions")
    shell.run("wget","https://raw.githubusercontent.com/comp484-IntroToAI/semester-project-gavin-wesley-and-henry/refs/heads/main/testTurtleScripts/findBedrock.lua?token=GHSAT0AAAAAACW7P2EVJA32BJCTQG2FYYMCZYPDO7A", "findBedrock")
end

install()

print("You now have all of your libraries installed! \n",
"The only executable file right now is 'findBedrock' \n",
"If you run that, your turtle will dig down until bedrock \n",
 "and then set its internal y-level to be the correct y-level")