-- [[ SETUP & SERVICES ]]
local CoreGui = gethui and gethui() or game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

-- Clean up old versions if you re-execute
if CoreGui:FindFirstChild("AdvancedWordSpoofer") then
	CoreGui.AdvancedWordSpoofer:Destroy()
end

-- [[ GUI CREATION ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdvancedWordSpoofer"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 380) 
MainFrame.Position = UDim2.new(0.5, -170, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(65, 65, 75)
UIStroke.Thickness = 1
UIStroke.Parent = MainFrame

-- [[ TOPBAR (Draggable) ]]
local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 35)
Topbar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Topbar.BorderSizePixel = 0
Topbar.Parent = MainFrame

local TopbarCorner = Instance.new("UICorner")
TopbarCorner.CornerRadius = UDim.new(0, 10)
TopbarCorner.Parent = Topbar

local TopbarHideBottom = Instance.new("Frame")
TopbarHideBottom.Size = UDim2.new(1, 0, 0, 10)
TopbarHideBottom.Position = UDim2.new(0, 0, 1, -10)
TopbarHideBottom.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TopbarHideBottom.BorderSizePixel = 0
TopbarHideBottom.Parent = Topbar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Auto-Word Generator & Spoofer"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Topbar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 100, 100)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = Topbar

-- [[ WORD GENERATOR INPUTS ]]
local StartInput = Instance.new("TextBox")
StartInput.Size = UDim2.new(0.45, 0, 0, 35)
StartInput.Position = UDim2.new(0, 10, 0, 45)
StartInput.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
StartInput.TextColor3 = Color3.fromRGB(255, 255, 255)
StartInput.PlaceholderText = "Starts: (e.g. s)"
StartInput.Font = Enum.Font.Gotham
StartInput.TextSize = 13
StartInput.Text = ""
StartInput.Parent = MainFrame
Instance.new("UICorner", StartInput).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", StartInput).Color = Color3.fromRGB(80, 80, 95)

local EndInput = Instance.new("TextBox")
EndInput.Size = UDim2.new(0.45, 0, 0, 35)
EndInput.Position = UDim2.new(0.55, -10, 0, 45)
EndInput.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
EndInput.TextColor3 = Color3.fromRGB(255, 255, 255)
EndInput.PlaceholderText = "Ends: (e.g. s)"
EndInput.Font = Enum.Font.Gotham
EndInput.TextSize = 13
EndInput.Text = ""
EndInput.Parent = MainFrame
Instance.new("UICorner", EndInput).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", EndInput).Color = Color3.fromRGB(80, 80, 95)

-- Generate Button
local GenerateBtn = Instance.new("TextButton")
GenerateBtn.Size = UDim2.new(0.65, -10, 0, 35)
GenerateBtn.Position = UDim2.new(0, 10, 0, 90)
GenerateBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
GenerateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GenerateBtn.Text = "Loading 3 Lists..."
GenerateBtn.Font = Enum.Font.GothamBold
GenerateBtn.TextSize = 13
GenerateBtn.Parent = MainFrame
Instance.new("UICorner", GenerateBtn).CornerRadius = UDim.new(0, 6)

-- Reset History Button
local ResetBtn = Instance.new("TextButton")
ResetBtn.Size = UDim2.new(0.35, -10, 0, 35)
ResetBtn.Position = UDim2.new(0.65, 10, 0, 90)
ResetBtn.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
ResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetBtn.Text = "Reset Used"
ResetBtn.Font = Enum.Font.GothamBold
ResetBtn.TextSize = 13
ResetBtn.Parent = MainFrame
Instance.new("UICorner", ResetBtn).CornerRadius = UDim.new(0, 6)

-- [[ SCROLLING FRAME ]]
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 0, 140)
ScrollFrame.Position = UDim2.new(0, 10, 0, 135)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.Parent = MainFrame
Instance.new("UICorner", ScrollFrame).CornerRadius = UDim.new(0, 6)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- [[ MANUAL INPUT SEPARATOR ]]
local CustomInput = Instance.new("TextBox")
CustomInput.Size = UDim2.new(1, -20, 0, 35)
CustomInput.Position = UDim2.new(0, 10, 0, 285)
CustomInput.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
CustomInput.TextColor3 = Color3.fromRGB(255, 255, 255)
CustomInput.PlaceholderText = "Or type custom word here..."
CustomInput.Font = Enum.Font.Gotham
CustomInput.TextSize = 13
CustomInput.Text = ""
CustomInput.Parent = MainFrame
Instance.new("UICorner", CustomInput).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", CustomInput).Color = Color3.fromRGB(80, 80, 95)

local SendCustomBtn = Instance.new("TextButton")
SendCustomBtn.Size = UDim2.new(1, -20, 0, 35)
SendCustomBtn.Position = UDim2.new(0, 10, 0, 330)
SendCustomBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
SendCustomBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SendCustomBtn.Text = "Send Custom Word"
SendCustomBtn.Font = Enum.Font.GothamBold
SendCustomBtn.TextSize = 14
SendCustomBtn.Parent = MainFrame
Instance.new("UICorner", SendCustomBtn).CornerRadius = UDim.new(0, 6)

-- [[ DRAGGING LOGIC ]]
local dragging, dragInput, dragStart, startPos
Topbar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
Topbar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- [[ NETWORK/BRIDGENET LOGIC ]]
local bridgeNet = ReplicatedStorage:WaitForChild("ffrostflame_bridgenet2@1.0.0", 5)
local dataRemoteEvent = bridgeNet and bridgeNet:WaitForChild("dataRemoteEvent", 5)
local TYPING_DELAY = 0.02 

local function simulateTypingSequence(fullWord)
	if not dataRemoteEvent then return false end
	
	dataRemoteEvent:FireServer({"", "\004"})
	if TYPING_DELAY > 0 then task.wait(TYPING_DELAY) end
	
	for i = 1, #fullWord do
		local currentSubstring = string.sub(fullWord, 1, i)
		dataRemoteEvent:FireServer({currentSubstring, "\004"})
		if TYPING_DELAY > 0 then task.wait(TYPING_DELAY) end
	end
	
	dataRemoteEvent:FireServer({fullWord, "\005"})
	return true
end

-- [[ GITHUB FETCH & DICTIONARY LOGIC ]]
local dictionary = {}
local usedWords = {}
local wordsReady = false

task.spawn(function()
	-- 1. Fetch all three links
	local s_Main, r_Main = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/first20hours/google-10000-english/refs/heads/master/20k.txt") end)
	local s_StartX, r_StartX = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/Nagai0426/Axura/refs/heads/main/words_starting_with_x_common.txt") end)
	local s_EndX, r_EndX = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/Nagai0426/Axura/refs/heads/main/common_words_ending_with_x_500plus.txt") end)
	
	if s_Main and r_Main then
		for _, word in ipairs(string.split(string.lower(r_Main), "\n")) do
			word = string.gsub(word, "%s+", "")
			-- Ignore words from this list if they start with 'x'
			if word ~= "" and string.sub(word, 1, 1) ~= "x" then
				table.insert(dictionary, word)
			end
		end
	end
	
	if s_StartX and r_StartX then
		for _, word in ipairs(string.split(string.lower(r_StartX), "\n")) do
			word = string.gsub(word, "%s+", "")
			if word ~= "" then table.insert(dictionary, word) end
		end
	end
	
	if s_EndX and r_EndX then
		for _, word in ipairs(string.split(string.lower(r_EndX), "\n")) do
			word = string.gsub(word, "%s+", "")
			if word ~= "" then table.insert(dictionary, word) end
		end
	end

	wordsReady = true
	GenerateBtn.Text = "Generate Words"
end)

local function createWordButton(wordText)
	local wordBtn = Instance.new("TextButton")
	wordBtn.Size = UDim2.new(1, -10, 0, 30)
	wordBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
	wordBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
	wordBtn.Text = wordText
	wordBtn.Font = Enum.Font.Gotham
	wordBtn.TextSize = 14
	wordBtn.Parent = ScrollFrame
	Instance.new("UICorner", wordBtn).CornerRadius = UDim.new(0, 4)
	
	wordBtn.MouseButton1Click:Connect(function()
		-- Mark as used immediately so it won't show up again
		usedWords[wordText] = true
		
		local originalColor = wordBtn.BackgroundColor3
		wordBtn.Text = "Sending..."
		wordBtn.BackgroundColor3 = Color3.fromRGB(67, 181, 129)
		
		simulateTypingSequence(wordText)
		
		-- Destroy the button so it disappears from the current list
		wordBtn:Destroy()
	end)
end

-- [[ BUTTON LOGIC ]]
GenerateBtn.MouseButton1Click:Connect(function()
	if not wordsReady then return end
	
	-- Clear old words from the frame
	for _, child in pairs(ScrollFrame:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	
	local startFilter = string.lower(StartInput.Text)
	local endFilter = string.lower(EndInput.Text)
	
	local count = 0
	for _, word in ipairs(dictionary) do
		-- Only process if the word hasn't been used yet
		if not usedWords[word] then
			local matchesStart = startFilter == "" or string.sub(word, 1, #startFilter) == startFilter
			local matchesEnd = endFilter == "" or string.sub(word, -#endFilter) == endFilter
			
			if matchesStart and matchesEnd then
				createWordButton(word)
				count = count + 1
				if count >= 100 then break end -- Limit to 100 words per search to prevent lag
			end
		end
	end
	
	if count == 0 then
		createWordButton("No new words found.")
	end
end)

-- Reset History Button
ResetBtn.MouseButton1Click:Connect(function()
	usedWords = {} -- Clears the history table
	
	-- Visual feedback
	local origColor = ResetBtn.BackgroundColor3
	ResetBtn.BackgroundColor3 = Color3.fromRGB(67, 181, 129)
	ResetBtn.Text = "Cleared!"
	task.wait(1)
	ResetBtn.BackgroundColor3 = origColor
	ResetBtn.Text = "Reset Used"
end)

-- Custom Word Manual Send
local function executeManualSend()
	local textToProcess = CustomInput.Text
	if textToProcess ~= "" then
		usedWords[string.lower(textToProcess)] = true -- Also mark custom words as used
		
		local originalColor = SendCustomBtn.BackgroundColor3
		SendCustomBtn.Text = "Sending..."
		SendCustomBtn.BackgroundColor3 = Color3.fromRGB(67, 181, 129)
		
		simulateTypingSequence(textToProcess)
		
		CustomInput.Text = ""
		task.wait(0.5)
		SendCustomBtn.Text = "Send Custom Word"
		SendCustomBtn.BackgroundColor3 = originalColor
	end
end

SendCustomBtn.MouseButton1Click:Connect(executeManualSend)
CustomInput.FocusLost:Connect(function(enter)
	if enter then executeManualSend() end
end)

CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)
