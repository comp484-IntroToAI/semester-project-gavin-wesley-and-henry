
--[[
    Our installer module! When we make changes to any of these files, 
    we'll need to reupload to pastebin and replace the code, and then
    reupload the installer file too.
]]
function install()
    shell.run("pastebin","get", "6HmrGBe8", "startup")
    shell.run("pastebin", "get", "XzAPXqsM", "smartActions")
    shell.run("pastebin", "get", "0j5Mjyuj", "findBedrock")
end



install()

print("You now have all of your libraries installed! \n",
"The only executable file right now is 'findBedrock' \n",
"If you run that, your turtle will dig down until bedrock \n",
 "and then set its internal y-level to be the correct y-level")