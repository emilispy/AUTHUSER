local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/unabletoIoad/vortexlib/main/library.lua'))()

local Window = Rayfield:CreateWindow({
    Name = "Vortex Hub",
    LoadingTitle = "Initializing",
    LoadingSubtitle = "Please wait...",
    Theme = "Amethyst",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "VortexFolder",
        FileName = "VortexHub"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = false
    },
    KeySystem = false,
    KeySettings = {
        Title = "Vortex Authentication",
        Subtitle = "Key: VortexTest",
        Note = "1.0.0",
        FileName = "SavedKey",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {"VortexTest"}
    },
})

local Home = Window:CreateTab("Home", 97039034122303)
Home:CreateSection("Home")
Home:CreateParagraph({
    Title = "⭐ | Update Log",
    Content = "⬇️ Current Version: 1.0.0 Beta ⬇️\n\n- Nothing"
})
Home:CreateParagraph({Title = "NOTICE", Content = "This exploit will only include useful features for THIS update, not permanent features."})

local CompetitionTab = Window:CreateTab("Competition", 97514831239615)
CompetitionTab:CreateSection("Side Features")

CompetitionTab:CreateToggle({
    Name = "Auto Blow",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoBubble = Value
        while _G.AutoBubble do
            game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer("BlowBubble")
            task.wait(0.01)
        end
    end
})

CompetitionTab:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoSell = Value
        task.spawn(function()
            while _G.AutoSell do
                local args = {
                    [1] = "SellBubble"
                }
                game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.RemoteEvent:FireServer(unpack(args))
                task.wait(1)
            end
        end)
    end
})

CompetitionTab:CreateToggle({
    Name = "Fast Hatch",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoPressR = Value
        task.spawn(function()
            while _G.AutoPressR do
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.R, false, game)
                task.wait(0.01)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.R, false, game)
                task.wait(0.01)
            end
        end)
    end
})

CompetitionTab:CreateSection("Main Features")
CompetitionTab:CreateToggle({
    Name = "Auto Reroll Quest",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoRerollQuest = Value
    end
})

local questOptions = {"None", "Hatch Mythics", "Blow Bubbles"}
local selectedQuest = "None"
CompetitionTab:CreateDropdown({
    Name = "Quest Selection",
    Options = questOptions,
    CurrentOption = "None",
    Callback = function(Value)
        selectedQuest = Value
    end
})

local Event = Window:CreateTab("Event", 119054513692205)
Event:CreateSection("Event / Minigames")

local rs = game:GetService("ReplicatedStorage")
local selectedDifficulty = "Insane"
local selectedMinigame = "Corn Maze"

Event:CreateDropdown({
    Name = "Minigame",
    Options = {"Corn Maze", "Pet Match", "Cart Escape", "Robot Claw"},
    CurrentOption = "Corn Maze",
    Callback = function(Value)
        if type(Value) == "table" then
            selectedMinigame = Value[1]
        else
            selectedMinigame = Value
        end
    end
})

Event:CreateDropdown({
    Name = "Difficulty",
    Options = {"Easy", "Medium", "Hard", "Insane"},
    CurrentOption = "Insane",
    Callback = function(Value)
        if type(Value) == "table" then
            selectedDifficulty = Value[1]
        else
            selectedDifficulty = Value
        end
    end
})

Event:CreateToggle({
    Name = "Auto Complete Minigame",
    CurrentValue = false,
    Callback = function(Value)
        _G.RunningMinigame = Value
        task.spawn(function()
            while _G.RunningMinigame do
                local remote = rs:WaitForChild("Shared", 9e9)
                    :WaitForChild("Framework", 9e9)
                    :WaitForChild("Network", 9e9)
                    :WaitForChild("Remote", 9e9)
                    :WaitForChild("RemoteEvent", 9e9)

                local args = {"SkipMinigameCooldown", selectedMinigame}
                remote:FireServer(unpack(args))
                task.wait(0.5)

                args = {"StartMinigame", selectedMinigame, selectedDifficulty}
                remote:FireServer(unpack(args))
                task.wait(0.5)

                args = {"FinishMinigame"}
                remote:FireServer(unpack(args))
                task.wait(0.5)
            end
        end)
    end
})


Event:CreateSection("Pickup")

Event:CreateToggle({
    Name = "Auto Pickup",
    CurrentValue = false,
    Callback = function(Value)
        _G.RunningPickup = Value
        task.spawn(function()
            while _G.RunningPickup do
                for _, v in next, game:GetService("Workspace").Rendered:GetChildren() do
                    if v.Name == "Chunker" then
                        for _, v2 in next, v:GetChildren() do
                            local part = v2:FindFirstChild("Part")
                            local hasMeshPart = v2:FindFirstChildWhichIsA("MeshPart")
                            local hasStars = part and part:FindFirstChild("Stars")
                            local hasPartMesh = part and part:FindFirstChild("Mesh")
                            if hasMeshPart or hasStars or hasPartMesh then
                                rs:WaitForChild("Remotes"):WaitForChild("Pickups"):WaitForChild("CollectPickup"):FireServer(v2.Name)
                                v2:Destroy()
                            end
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end
})


local PingTab = Window:CreateTab("Ping", 83207958900307)
PingTab:CreateSection("Check Game Activity")
PingTab:CreateParagraph({Title = "Help ❓", Content = "This feature will send a message to your specified Discord webhook URL at a set interval to let you know that you are still in the game."})
local enabled = false
local delayTime = 300
local webhookURL = ""

local function safeGet(desc, path)
    local success, result = pcall(function()
        local current = desc
        for _, part in ipairs(path) do
            current = current:FindFirstChild(part)
            if not current then return nil end
        end
        return current
    end)
    return success and result or nil
end

local function cleanText(text)
    if typeof(text) ~= "string" then return tostring(text or "") end
    text = string.gsub(text, "<[^>]->", "")
    text = string.gsub(text, "%s+", " ")
    text = string.gsub(text, "^%s*(.-)%s*$", "%1")
    return text
end

local function formatNumber(n)
    if typeof(n) == "number" then
        n = tostring(n)
    end
    if typeof(n) ~= "string" then return tostring(n or "N/A") end
    local formatted = n
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
        if k == 0 then break end
    end
    return formatted
end

PingTab:CreateToggle({
    Name = "Enable",
    CurrentValue = false,
    Callback = function(Value)
        enabled = Value
        if enabled then
            task.spawn(function()
                while enabled do
                    local player = game.Players.LocalPlayer
                    local stats = player:FindFirstChild("leaderstats")
                    local bubbles, hatches = "N/A", "N/A"
                    local extraFields = {}

                    if stats then
                        if stats:FindFirstChild("🟣 Bubbles") then
                            bubbles = formatNumber(stats["🟣 Bubbles"].Value)
                        end
                        if stats:FindFirstChild("🥚 Hatches") then
                            hatches = formatNumber(stats["🥚 Hatches"].Value)
                        end
                    end

                    local rerollPath = safeGet(game, {"Players", "LocalPlayer", "PlayerGui", "ScreenGui", "Inventory", "Frame", "Inner", "Items", "Main", "ScrollingFrame", "Powerups", "Items", "Reroll Orb", "Inner", "Button", "Inner", "Amount"})
                    if rerollPath then
                        table.insert(extraFields, {["name"] = "Reroll Orbs", ["value"] = cleanText(rerollPath.Text), ["inline"] = true})
                    else
                        warn("[Ping System] Missing Reroll Orb path.")
                    end

                    local currencyRoot = safeGet(game, {"Players", "PCTrades", "PlayerGui", "ScreenGui", "Inventory", "Frame", "Inner", "Items", "Main", "ScrollingFrame", "Currency", "Items"})
                    if currencyRoot then
                        for _, itemFrame in ipairs(currencyRoot:GetChildren()) do
                            local icon = safeGet(itemFrame, {"Button", "Inner", "Icon", "Label"})
                            if icon and icon:IsA("ImageLabel") and icon.Image == "rbxassetid://121401017387099" then
                                local bottomLabel = safeGet(itemFrame, {"Button", "Inner", "Bottom"})
                                if bottomLabel and bottomLabel:IsA("TextLabel") then
                                    table.insert(extraFields, {["name"] = "💰 Coins", ["value"] = cleanText(bottomLabel.Text), ["inline"] = true})
                                end
                            end
                        end
                    else
                        warn("[Ping System] Missing Coins path.")
                    end

                    local buffs = {
                        {"Speed", "⚡ Speed Potion"},
                        {"Secret Elixir", "🧪 Secret Elixir"},
                        {"Egg Elixir", "🥚 Egg Elixir"},
                        {"ShrineBlessing", "🙏 Shrine Blessing"},
                        {"Mythic", "💎 Mythic Potion"},
                        {"Lucky", "🍀 Lucky Potion"},
                        {"Infinity Elixir", "♾️ Infinity Elixir"}
                    }

                    for _, buff in ipairs(buffs) do
                        local buffPath = safeGet(game, {"Players", "PCTrades", "PlayerGui", "ScreenGui", "Buffs", buff[1], "Button", "Label"})
                        if buffPath then
                            table.insert(extraFields, {["name"] = buff[2], ["value"] = cleanText(buffPath.Text), ["inline"] = true})
                        else
                            warn("[Ping System] Missing buff: " .. buff[1])
                        end
                    end

                    local fields = {
                        {["name"] = "🟣 Bubbles", ["value"] = tostring(bubbles), ["inline"] = true},
                        {["name"] = "🥚 Hatches", ["value"] = tostring(hatches), ["inline"] = true}
                    }

                    for _, field in ipairs(extraFields) do
                        table.insert(fields, field)
                    end

                    local avatarURL = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"

                    local data = {
                        ["embeds"] = {{
                            ["title"] = "Ping! 🚨",
                            ["description"] = player.Name .. " is still in game.",
                            ["color"] = 16711680,
                            ["fields"] = fields,
                            ["thumbnail"] = {["url"] = avatarURL},
                            ["footer"] = {["text"] = "Vortex Hub - Status Ping"}
                        }}
                    }

                    local headers = {["Content-Type"] = "application/json"}
                    local encoded = game:GetService("HttpService"):JSONEncode(data)

                    if webhookURL ~= "" then
                        request = request or http_request or syn.request or http.request
                        if request then
                            request({
                                Url = webhookURL,
                                Method = "POST",
                                Headers = headers,
                                Body = encoded
                            })
                        end
                    end

                    task.wait(delayTime)
                end
            end)
        end
    end
})

PingTab:CreateDropdown({
    Name = "Delay",
    Options = {"5 minutes", "30 minutes", "1 hour"},
    CurrentOption = "5 minutes",
    Callback = function(Option)
        if Option == "5 minutes" then
            delayTime = 300
        elseif Option == "30 minutes" then
            delayTime = 1800
        elseif Option == "1 hour" then
            delayTime = 3600
        end
    end
})

PingTab:CreateInput({
    Name = "Discord URL",
    PlaceholderText = "https://discord.com/api/webhooks/...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        webhookURL = Text
    end
})

local Player = Window:CreateTab("Player", 101018108274597)
Player:CreateSection("Local Player")
local antiAFKConnection
Player:CreateToggle({
    Name = "Anti AFK", 
    CurrentValue = false, 
    Callback = function(Value)
        if Value then
            antiAFKConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                task.wait(1)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
            end)
        elseif antiAFKConnection then
            antiAFKConnection:Disconnect()
        end
    end
})

local noclipLoop
Player:CreateToggle({
    Name = "Noclip", 
    CurrentValue = false, 
    Callback = function(Value)
        local character = game:GetService("Players").LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not Value
                end
            end
        end
        if Value then
            noclipLoop = game:GetService("RunService").Stepped:Connect(function()
                if game:GetService("Players").LocalPlayer.Character then
                    for _, part in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        elseif noclipLoop then
            noclipLoop:Disconnect()
        end
    end
})

local infiniteJumpEnabled
Player:CreateToggle({
    Name = "Infinite Jump", 
    CurrentValue = false, 
    Callback = function(Value)
        infiniteJumpEnabled = Value
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if infiniteJumpEnabled then
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    end
})

Player:CreateSection("Performance")
local fpsCap = 60
Player:CreateSlider({
    Name = "FPS Editor",
    Range = {2, 240},
    Increment = 1,
    CurrentValue = 60,
    Callback = function(Value)
        fpsCap = Value
        setfpscap(Value)
    end
})

game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function()
        local currentFPS = math.floor(1/game:GetService("RunService").Heartbeat:Wait())
        if currentFPS ~= fpsCap then
        end
    end)
end)

Player:CreateSection("Server")
local jobIdValue = ""
Player:CreateInput({
    Name = "JobId Input",
    PlaceholderText = "Enter JobId",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        jobIdValue = Text
    end
})

Player:CreateButton({
    Name = "Copy JobId",
    Callback = function()
        setclipboard(game.JobId)
    end
})

Player:CreateButton({
    Name = "Join JobId",
    Callback = function()
        if jobIdValue ~= "" then
            game:GetService("TeleportService"):TeleFportToPlaceInstance(game.PlaceId, jobIdValue, game.Players.LocalPlayer)
        end
    end
})
