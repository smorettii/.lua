local moretti = game:GetObjects("rbxassetid://14281518045")[1]
for i,v in pairs(game.CoreGui:GetChildren()) do 
    if v.Name == "AlesitoHub" then 
        v:Destroy()
    end
end

moretti.Main.Activates.Template.Visible = false 
moretti.Main.Tabs.Tab.ButtonTemplate.Visible = false 
moretti.Main.Tabs.Tab.ToggleExample.Visible = false
moretti.Main.Tabs.Tab.Visible = false 

moretti.Parent = game.CoreGui

moretti.Main.Active = true 
moretti.Main.Draggable = true 

moretti.Main.Close.MouseButton1Click:Connect(function()
    moretti:Destroy()
end)

local lib = {}

local underlines = {}
function lib:CreateTab(text)
    local TabActive = moretti.Main.Activates.Template:Clone()
    local MyTab = moretti.Main.Tabs.Tab:Clone()


    TabActive.Parent = moretti.Main.Activates
    TabActive.Visible = true 
    TabActive.Name = "TabActivate"
    TabActive.Text = text
    TabActive.Underline.BackgroundTransparency = 1
    underlines[#underlines + 1] = TabActive.Underline

    MyTab.Parent = moretti.Main.Tabs
    MyTab.Name = 'newtab'
    
    TabActive.MouseButton1Click:Connect(function()
        for i,v in pairs(moretti.Main.Tabs:GetChildren()) do 
            if v:IsA("ScrollingFrame") then 
                v.Visible = false 
            end
        end
        MyTab.Visible = true 
        for i,v in pairs(underlines) do 
            game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        end
        game:GetService("TweenService"):Create(TabActive.Underline, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    end)

    local container = {}

    function container:CreateButton(text, callback)
        local MyButton = MyTab.ButtonTemplate:Clone()
        MyButton.Parent = MyTab 
        MyButton.Visible = true 
        MyButton.Title.Text = text
        MyButton.MouseButton1Click:Connect(function()
            local sucess, erro = pcall(callback)
            if not sucess then 
                print("AlesitoHub Error: "..erro)
            end
        end) 
    end

    function container:CreateToggle(text, callback)
        local toggled = false 
        local MyToggle = MyTab.ToggleExample:Clone()
        MyToggle.Parent = MyTab
        MyToggle.Title.Text = text 
        MyToggle.Visible = true 
        MyToggle.MouseButton1Click:Connect(function()
            toggled = not toggled
            game:GetService("TweenService"):Create(MyToggle.Toggle, TweenInfo.new(0.3), {BackgroundTransparency = toggled and 0 or 1}):Play()
            local sucess, erro = pcall(callback, toggled)
            if not sucess then 
                print("AlesitoHub Error: "..erro)
            end
        end)
    end

    return container
end

return lib
