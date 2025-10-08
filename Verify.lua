local FH = {}; -- Verification UI Library [1.0.0] [FreakyHub]
local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
FH["1"] = Instance.new("ScreenGui")
FH["1"]["Name"] = "DiscordVerification"
FH["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
FH["2"] = Instance.new("Frame", FH["1"]);
FH["2"]["BorderSizePixel"] = 0;
FH["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
FH["2"]["Size"] = UDim2.new(0, 421, 0, 245);
FH["2"]["Position"] = UDim2.new(0.37201, 0, 0.34555, 0);
FH["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
FH["2"]["Name"] = [[MainFrame]];

local dragging = false
local dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	FH["2"].Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

FH["2"].InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = FH["2"].Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

FH["2"].InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		update(input)
	end
end)

FH["2"].InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

FH["3"] = Instance.new("UICorner", FH["2"]);
FH["4"] = Instance.new("UIGradient", FH["2"]);
FH["4"]["Rotation"] = 50;
FH["4"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(76, 61, 105)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(44, 35, 59))};
FH["5"] = Instance.new("UIStroke", FH["2"]);
FH["5"]["Transparency"] = 0.5;
FH["5"]["Thickness"] = 3;
FH["5"]["Color"] = Color3.fromRGB(30, 13, 51);
FH["6"] = Instance.new("TextBox", FH["2"]);
FH["6"]["CursorPosition"] = -1;
FH["6"]["Name"] = [[KeyInput]];
FH["6"]["PlaceholderColor3"] = Color3.fromRGB(201, 201, 201);
FH["6"]["BorderSizePixel"] = 0;
FH["6"]["TextSize"] = 25;
FH["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
FH["6"]["BackgroundColor3"] = Color3.fromRGB(76, 61, 101);
FH["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic);
FH["6"]["PlaceholderText"] = [[Key here . . .]];
FH["6"]["Size"] = UDim2.new(0, 284, 0, 50);
FH["6"]["Position"] = UDim2.new(0.09501, 0, 0.4, 0);
FH["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
FH["6"]["Text"] = [[]];
FH["6"]["BackgroundTransparency"] = 0.3;
FH["7"] = Instance.new("UIStroke", FH["6"]);
FH["7"]["Transparency"] = 0.4;
FH["7"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
FH["7"]["Thickness"] = 2;
FH["7"]["Color"] = Color3.fromRGB(61, 53, 77);
FH["8"] = Instance.new("UICorner", FH["6"]);
FH["9"] = Instance.new("TextLabel", FH["2"]);
FH["9"]["TextWrapped"] = true;
FH["9"]["BorderSizePixel"] = 0;
FH["9"]["TextSize"] = 14;
FH["9"]["TextScaled"] = true;
FH["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
FH["9"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
FH["9"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
FH["9"]["BackgroundTransparency"] = 1;
FH["9"]["Size"] = UDim2.new(0, 199, 0, 68);
FH["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
FH["9"]["Text"] = [[Verification]];
FH["9"]["Name"] = [[Title]];
FH["9"]["Position"] = UDim2.new(0.26366, 0, 0.03265, 0);
FH["a"] = Instance.new("TextLabel", FH["2"]);
FH["a"]["TextWrapped"] = true;
FH["a"]["BorderSizePixel"] = 0;
FH["a"]["TextSize"] = 14;
FH["a"]["TextScaled"] = true;
FH["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
FH["a"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
FH["a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
FH["a"]["BackgroundTransparency"] = 1;
FH["a"]["Size"] = UDim2.new(0, 89, 0, 25);
FH["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
FH["a"]["Text"] = [[Freaky Hub ]];
FH["a"]["Name"] = [[Name]];
FH["a"]["Position"] = UDim2.new(0.033, 0, 0.868, 0);
FH["b"] = Instance.new("TextLabel", FH["2"]);
FH["b"]["TextWrapped"] = true;
FH["b"]["BorderSizePixel"] = 0;
FH["b"]["TextSize"] = 14;
FH["b"]["TextScaled"] = true;
FH["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
FH["b"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
FH["b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
FH["b"]["BackgroundTransparency"] = 1;
FH["b"]["Size"] = UDim2.new(0, 66, 0, 18);
FH["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
FH["b"]["Text"] = [[v1.0.0]];
FH["b"]["Name"] = [[Version]];
FH["b"]["Position"] = UDim2.new(0.83848, 0, 0.89388, 0);
FH["c"] = Instance.new("ImageLabel", FH["2"]);
FH["c"]["BorderSizePixel"] = 0;
FH["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
FH["c"]["Image"] = [[rbxassetid://84962939688991]];
FH["c"]["Size"] = UDim2.new(0, 44, 0, 44);
FH["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
FH["c"]["Name"] = [[icon]];
FH["c"]["Position"] = UDim2.new(0.019, 0, 0.03265, 0);
FH["d"] = Instance.new("UICorner", FH["c"]);
FH["d"]["CornerRadius"] = UDim.new(1, 0);
FH["e"] = Instance.new("TextButton", FH["2"]);
FH["e"]["BorderSizePixel"] = 0;
FH["e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
FH["e"]["TextSize"] = 20;
FH["e"]["BackgroundColor3"] = Color3.fromRGB(76, 61, 101);
FH["e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
FH["e"]["Size"] = UDim2.new(0, 113, 0, 25);
FH["e"]["Name"] = [[CopyInvite]];
FH["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
FH["e"]["Text"] = [[Copy invite]];
FH["e"]["Position"] = UDim2.new(0.26366, 0, 0.86531, 0);
FH["f"] = Instance.new("UICorner", FH["e"]);
FH["f"]["CornerRadius"] = UDim.new(0.2, 0);
FH["10"] = Instance.new("UIStroke", FH["e"]);
FH["10"]["Transparency"] = 0.4;
FH["10"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
FH["10"]["Thickness"] = 2;
FH["10"]["Color"] = Color3.fromRGB(61, 53, 77);
FH["11"] = Instance.new("TextButton", FH["2"]);
FH["11"]["TextWrapped"] = true;
FH["11"]["BorderSizePixel"] = 0;
FH["11"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
FH["11"]["TextSize"] = 40;
FH["11"]["BackgroundColor3"] = Color3.fromRGB(76, 61, 101);
FH["11"]["RichText"] = true;
FH["11"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
FH["11"]["Size"] = UDim2.new(0, 50, 0, 50);
FH["11"]["BackgroundTransparency"] = 0.3;
FH["11"]["Name"] = [[Confirm]];
FH["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
FH["11"]["Text"] = [[X]];
FH["11"]["Position"] = UDim2.new(0.7886, 0, 0.4, 0);
FH["12"] = Instance.new("UICorner", FH["11"]);
FH["13"] = Instance.new("UIStroke", FH["11"]);
FH["13"]["Transparency"] = 0.4;
FH["13"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
FH["13"]["Thickness"] = 2;
FH["13"]["Color"] = Color3.fromRGB(61, 53, 77);
FH["1"].Enabled = true
FH["1"].Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
