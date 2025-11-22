repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

repeat task.wait() until LocalPlayer:FindFirstChild("PlayerGui")

task.wait(0.5)

-- Remove existing GUI if present
local existing = LocalPlayer.PlayerGui:FindFirstChild("Orion lagger")
if existing then
	existing:Destroy()
	task.wait(0.1)
end

-- Create GUI
local screen_gui = Instance.new("ScreenGui")
screen_gui.Name = "Orion lagger"
screen_gui.ResetOnSpawn = false
screen_gui.IgnoreGuiInset = false
screen_gui.DisplayOrder = 999
screen_gui.Enabled = true

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 220, 0, 140)
frame.Position = UDim2.new(0, 50, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Visible = true
frame.Parent = screen_gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1
stroke.Transparency = 0
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = frame

local title_bar = Instance.new("Frame")
title_bar.Name = "TitleBar"
title_bar.Size = UDim2.new(1, 0, 0, 35)
title_bar.Position = UDim2.new(0, 0, 0, 0)
title_bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title_bar.BorderSizePixel = 0
title_bar.Parent = frame

local title_corner = Instance.new("UICorner")
title_corner.CornerRadius = UDim.new(0, 8)
title_corner.Parent = title_bar

local title_fix = Instance.new("Frame")
title_fix.Size = UDim2.new(1, 0, 0, 8)
title_fix.Position = UDim2.new(0, 0, 1, -8)
title_fix.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title_fix.BorderSizePixel = 0
title_fix.Parent = title_bar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Orion lagger (Bee Gun Edition)"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = title_bar

-- Main Button
local button = Instance.new("TextButton")
button.Name = "RocketLagButton"
button.Size = UDim2.new(1, -20, 0, 35)
button.Position = UDim2.new(0, 10, 0, 45)
button.Text = "Bee Lagger"
button.TextColor3 = Color3.fromRGB(0, 0, 0)
button.Font = Enum.Font.GothamBold
button.TextSize = 14
button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
button.AutoButtonColor = false
button.Parent = frame

local button_corner = Instance.new("UICorner")
button_corner.CornerRadius = UDim.new(0, 4)
button_corner.Parent = button

-- Discord Link (clickable)
local discord_button = Instance.new("TextButton")
discord_button.Name = "DiscordButton"
discord_button.Size = UDim2.new(1, -20, 0, 28)
discord_button.Position = UDim2.new(0, 10, 0, 90)
discord_button.Text = "https://discord.gg/SXymyHHBGC"
discord_button.TextColor3 = Color3.fromRGB(255, 255, 255)
discord_button.Font = Enum.Font.GothamBold
discord_button.TextSize = 12
discord_button.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
discord_button.AutoButtonColor = false
discord_button.Parent = frame

local discord_corner = Instance.new("UICorner")
discord_corner.CornerRadius = UDim.new(0, 4)
discord_corner.Parent = discord_button

-- Parent GUI
screen_gui.Parent = LocalPlayer.PlayerGui

button.MouseButton1Click:Connect(function()
	button.Text = "Activated!"
	button.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
	task.wait(1)
	button.Text = "Bee Gun"
	button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
end)

button.MouseEnter:Connect(function()
	button.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
end)

button.MouseLeave:Connect(function()
	button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
end)

-- Discord button functionality
discord_button.MouseButton1Click:Connect(function()
	discord_button.BackgroundColor3 = Color3.fromRGB(70, 80, 200)
	setclipboard("https://discord.gg/39P3gwAGgq")
	discord_button.Text = "Copied!"
	task.wait(2)
	discord_button.Text = "discord.gg/39P3gwAGgq"
	discord_button.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
end)

discord_button.MouseEnter:Connect(function()
	discord_button.BackgroundColor3 = Color3.fromRGB(100, 115, 255)
end)

discord_button.MouseLeave:Connect(function()
	discord_button.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
end)

-- Draggable functionality
local dragging = false
local drag_input, drag_start, start_pos

local function update(input)
	local delta = input.Position - drag_start
	frame.Position = UDim2.new(
		start_pos.X.Scale, start_pos.X.Offset + delta.X,
		start_pos.Y.Scale, start_pos.Y.Offset + delta.Y
	)
end

title_bar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		drag_start = input.Position
		start_pos = frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

title_bar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		drag_input = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input == drag_input then
		update(input)
	end
end)
