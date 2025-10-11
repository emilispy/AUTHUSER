local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AntiLagUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 120)
mainFrame.Position = UDim2.new(0, 50, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.BorderSizePixel = 0
title.Text = "Anti Lag"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Parent = mainFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.8, 0, 0, 30)
toggleButton.Position = UDim2.new(0.1, 0, 0.4, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "Remove Gift Lag: OFF"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 12
toggleButton.Parent = mainFrame

local currentValue = false
_G.DeleteParts = false

toggleButton.MouseButton1Click:Connect(function()
    currentValue = not currentValue
    _G.DeleteParts = currentValue
    
    if currentValue then
        toggleButton.Text = "Remove Gift Lag: ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
        
        local connection
        connection = game:GetService("Workspace").DescendantAdded:Connect(function(descendant)
            if not _G.DeleteParts then
                connection:Disconnect()
                return
            end
            
            if descendant:IsA("BasePart") and descendant.Parent and descendant.Parent.Parent then
                local parent = descendant.Parent
                local grandparent = parent.Parent
                if grandparent.Name == "Rendered" and parent.Name == "Generic" and #descendant.Name > 25 then
                    descendant:Destroy()
                end
            end
        end)
        
        local genericFolder = game:GetService("Workspace"):FindFirstChild("Rendered")
        if genericFolder then
            genericFolder = genericFolder:FindFirstChild("Generic")
            if genericFolder then
                for _, part in ipairs(genericFolder:GetDescendants()) do
                    if part:IsA("BasePart") and #part.Name > 25 then
                        part:Destroy()
                    end
                end
            end
        end
    else
        toggleButton.Text = "Remove Gift Lag: OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end
end)
