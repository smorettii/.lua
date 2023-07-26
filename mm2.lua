if not game:IsLoaded() then 
	game.Loaded:wait()
end

local lib = loadstring(game:HttpGet("https://pastebin.com/raw/7Wr0Fnk6"))()
local q = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
game.Players.LocalPlayer.OnTeleport:Connect(function(State) if State == Enum.TeleportState.Started then if q then q("loadstring(game:HttpGet('https://raw.githubusercontent.com/smorettii/.lua/main/mm2.lua'))()") end end end)
lib:freature("Facas", function()    
    x.MessagePosted:fire(".")
end)

lib:freature("Pets", function()    
    x.MessagePosted:fire("..")
end)

lib:freature("Accept Trade", function()    
    x.MessagePosted:fire("...")
end)

lib:freature("Matar", function()    
    x.MessagePosted:fire("....")
end)

lib:freature("Crasha", function()    
    x.MessagePosted:fire(".....")
end)
