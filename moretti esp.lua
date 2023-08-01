getgenv().espConfig = {
    lines = false,
    boxes = false,
    filled = false,
    names = false,
    size = 20,
    distance = false,
    healthbar = false,
    teamcheck = false,
    thickness = 1,
    extra_function = nil, -- caso queira uma funcao extra de verificar o jogador voce adiciona a funcao com o parametro player
    esp_color = 'team_color', -- deixe em 'team_color' para ser a cor do time do jogador, ou use o seu Color3.fromRGB(0, 0, 0)
    refresh_time = 0 -- Tempo em ms --
}

local worldToViewportPoint = workspace.CurrentCamera.worldToViewportPoint
local HeadOff = Vector3.new(0, 0.5, 0)
local LegOff = Vector3.new(0, -5, 0)

function vida(health, maxhealth)
    local HealthColor = Color3.fromRGB(255, 0, 0)
    task.spawn(function()
        local Health = health

        if Health == 0 then
            HealthColor = Color3.fromRGB(255, 0, 0)
        elseif Health < 10 then
            HealthColor = Color3.fromRGB(255, 72, 0)
        elseif Health < 20 then
            HealthColor = Color3.fromRGB(255, 132, 0)
        elseif Health < 30 then
            HealthColor = Color3.fromRGB(255, 166, 0)
        elseif Health < 40 then
            HealthColor = Color3.fromRGB(255, 213, 0)
        elseif Health < 50 then
            HealthColor = Color3.fromRGB(238, 255, 0)
        elseif Health < 60 then
            HealthColor = Color3.fromRGB(200, 255, 0)
        elseif Health < 70 then
            HealthColor = Color3.fromRGB(166, 255, 0)
        elseif Health < 80 then
            HealthColor = Color3.fromRGB(85, 255, 0)
        elseif Health < 90 then
            HealthColor = Color3.fromRGB(43, 255, 0)
        elseif Health < 100 then
            HealthColor = Color3.fromRGB(38, 255, 0)
        elseif Health == maxhealth then
            HealthColor = Color3.fromRGB(0, 255, 0)
        end
    end)
    return HealthColor
end
function add_esp(player)
    local Line = Drawing.new("Line")
    local BoxOutline = Drawing.new("Square")
    local Box = Drawing.new("Square")
    local HealthOutline = Drawing.new("Square")
    local Health = Drawing.new("Square")
    local NameEsp = Drawing.new("Text")

    Line.Visible = false 
    Line.Thickness = getgenv().espConfig.thickness
    Line.Color = Color3.fromRGB(0, 255, 0)

    BoxOutline.Visible = false 
    BoxOutline.Thickness = getgenv().espConfig.thickness + 2
    BoxOutline.Color = Color3.fromRGB(0,0,0)
    BoxOutline.Filled = false

    Box.Visible = false 
    Box.Thickness = getgenv().espConfig.thickness
    Box.Color = Color3.fromRGB(255, 255, 255)
    Box.Filled = false

    Health.Visible = false 
    Health.Thickness = getgenv().espConfig.thickness
    Health.Color = Color3.fromRGB(0, 0, 0)
    Health.Filled = true

    HealthOutline.Visible = false 
    HealthOutline.Thickness = getgenv().espConfig.thickness 
    HealthOutline.Color = Color3.fromRGB(0, 0, 0)
    HealthOutline.Filled = false

    NameEsp.Visible = false 
    NameEsp.Outline = true 
    NameEsp.OutlineColor = Color3.fromRGB(0, 0, 0)
   
    spawn(function()
        while true do 
            if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Humanoid").Health > 0 and player.Character:FindFirstChild("HumanoidRootPart") and (espConfig.teamcheck == true and player.TeamColor ~= game.Players.LocalPlayer.TeamColor or espConfig.teamcheck == false) and (espConfig.extra_function ~= nil and espConfig.extra_function(player) == true or espConfig.extra_function == nil) then 
                local Vector, OnScreen = workspace.CurrentCamera:worldToViewportPoint(player.Character.HumanoidRootPart.Position)
                local HeadPos = workspace.CurrentCamera:worldToViewportPoint(player.Character.HumanoidRootPart.Position + HeadOff)
                local LegPos = workspace.CurrentCamera:worldToViewportPoint(player.Character.HumanoidRootPart.Position + LegOff)
                local RootPos = workspace.CurrentCamera:worldToViewportPoint(player.Character.HumanoidRootPart.Position)
                if OnScreen then 
                    Line.Visible = espConfig.lines
                    Line.Color = (getgenv().espConfig.esp_color == 'team_color' and player.TeamColor.Color) or getgenv().espConfig.esp_color
                    Line.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
                    Line.To = Vector2.new(Vector.X, Box.Position.Y)

                    Box.Visible = espConfig.boxes
                    Box.Size = Vector2.new(1600 / RootPos.Z, HeadPos.Y - LegPos.Y)
                    Box.Position = Vector2.new(RootPos.X - Box.Size.X / 2, RootPos.Y - Box.Size.Y / 2)
                    Box.Color = (getgenv().espConfig.esp_color == 'team_color' and player.TeamColor.Color) or getgenv().espConfig.esp_color

                    BoxOutline.Visible = espConfig.boxes
                    BoxOutline.Size = Vector2.new(1600 / RootPos.Z, HeadPos.Y - LegPos.Y)
                    BoxOutline.Position = Vector2.new(RootPos.X - Box.Size.X / 2, RootPos.Y - Box.Size.Y / 2)

                    Health.Visible = espConfig.healthbar 
                    Health.Size = Vector2.new(1, Box.Size.Y)
                    Health.Position = Box.Position + Vector2.new(-6, 0)
                    Health.Color = vida(player.Character.Humanoid.Health, player.Character.Humanoid.MaxHealth)

                    HealthOutline.Visible = espConfig.healthbar 
                    HealthOutline.Size = Vector2.new(1, Box.Size.Y)
                    HealthOutline.Position = Box.Position + Vector2.new(-6, 0)
                    HealthOutline.Thickness = 2

                    NameEsp.Visible = espConfig.names 
                    NameEsp.OutlineColor = (getgenv().espConfig.esp_color == 'team_color' and player.TeamColor.Color) or getgenv().espConfig.esp_color
                    NameEsp.Text = player.Name .. " / " .. player.DisplayName
                    NameEsp.Position = Vector2.new(Vector.X, Vector.Y + Box.Size.Y + 5)
                    NameEsp.Size = espConfig.size
                    NameEsp.Center = true
                    if espConfig.distance then 
                        pcall(function() NameEsp.Text = NameEsp.Text .. string.format(" [%sm]", math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)) end)
                    end
                    if espConfig.filled then 
                        Box.Filled = true 
                        Box.Transparency = 0.4
                    else
                        Box.Filled = false 
                        Box.Transparency = 1
                    end
                else
                    Line.Visible = false 
                    Box.Visible = false
                    BoxOutline.Visible = false
                    Health.Visible = false 
                    HealthOutline.Visible = false
                    NameEsp.Visible = false
                end
            else
                Line.Visible = false 
                Box.Visible = false
                BoxOutline.Visible = false
                Health.Visible = false 
                HealthOutline.Visible = false
                NameEsp.Visible = false
            end
            if not player then 
            	Line:Remove()
                Box:Remove()
                BoxOutline:Remove()
                Health:Remove()
                HealthOutline:Remove()
                NameEsp:Remove()
            	break
            end
            task.wait(espConfig.refresh_time / 1000)
        end
    end)
end


for i,v in pairs(game.Players:GetChildren()) do
	if v ~= game.Players.LocalPlayer then
		spawn(function()
            add_esp(v)
        end)
	end
end

game.Players.ChildAdded:Connect(function(v)
    spawn(function()
        add_esp(v)
    end)
end)
