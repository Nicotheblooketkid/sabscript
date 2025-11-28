-- Client-Side Permanent Lag Simulator with GUI
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- Lag variables
local isLagging = false
local lagConnections = {}
local createdObjects = {}

-- Keybind settings
local ACTIVATE_KEY = Enum.KeyCode.Z

-- Create main UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LagSimulatorUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main container
local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 220, 0, 140)
MainContainer.Position = UDim2.new(0, 10, 0, 10)
MainContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainContainer.BorderSizePixel = 0
MainContainer.Active = true
MainContainer.Draggable = true
MainContainer.Selectable = true
MainContainer.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainContainer

-- Header (drag area)
local Header = Instance.new("TextButton")
Header.Size = UDim2.new(1, 0, 0, 30)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
Header.BorderSizePixel = 0
Header.Text = ""
Header.AutoButtonColor = false
Header.Parent = MainContainer

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "PERMANENT LAG SIM"
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.Parent = Header

-- Content area
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, 0, 1, -30)
Content.Position = UDim2.new(0, 0, 0, 30)
Content.BackgroundTransparency = 1
Content.Parent = MainContainer

-- Toggle container
local ToggleContainer = Instance.new("Frame")
ToggleContainer.Size = UDim2.new(1, -20, 0, 40)
ToggleContainer.Position = UDim2.new(0, 10, 0, 10)
ToggleContainer.BackgroundTransparency = 1
ToggleContainer.Parent = Content

-- Toggle label
local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Size = UDim2.new(0.6, 0, 1, 0)
ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
ToggleLabel.Text = "Permanent Lag"
ToggleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Font = Enum.Font.Gotham
ToggleLabel.TextSize = 12
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
ToggleLabel.Parent = ToggleContainer

-- Modern toggle switch
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 40, 0, 20)
ToggleButton.Position = UDim2.new(1, -40, 0.5, -10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = ""
ToggleButton.AutoButtonColor = false
ToggleButton.Parent = ToggleContainer

local ToggleButtonCorner = Instance.new("UICorner")
ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
ToggleButtonCorner.Parent = ToggleButton

-- Toggle knob
local ToggleKnob = Instance.new("Frame")
ToggleKnob.Size = UDim2.new(0, 16, 0, 16)
ToggleKnob.Position = UDim2.new(0, 2, 0.5, -8)
ToggleKnob.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
ToggleKnob.BorderSizePixel = 0
ToggleKnob.Parent = ToggleButton

local ToggleKnobCorner = Instance.new("UICorner")
ToggleKnobCorner.CornerRadius = UDim.new(1, 0)
ToggleKnobCorner.Parent = ToggleKnob

-- Status text
local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -20, 0, 20)
StatusText.Position = UDim2.new(0, 10, 0, 55)
StatusText.Text = "Status: OFF"
StatusText.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusText.BackgroundTransparency = 1
StatusText.Font = Enum.Font.Gotham
StatusText.TextSize = 11
StatusText.Parent = Content

-- Keybind text
local KeybindText = Instance.new("TextLabel")
KeybindText.Size = UDim2.new(1, -20, 0, 20)
KeybindText.Position = UDim2.new(0, 10, 0, 80)
KeybindText.Text = "Press Z to activate"
KeybindText.TextColor3 = Color3.fromRGB(120, 120, 120)
KeybindText.BackgroundTransparency = 1
KeybindText.Font = Enum.Font.Gotham
KeybindText.TextSize = 10
KeybindText.Parent = Content

-- Warning text
local WarningText = Instance.new("TextLabel")
WarningText.Size = UDim2.new(1, -20, 0, 20)
WarningText.Position = UDim2.new(0, 10, 0, 100)
WarningText.Text = "⚠️ Reset to stop"
WarningText.TextColor3 = Color3.fromRGB(255, 200, 80)
WarningText.BackgroundTransparency = 1
WarningText.Font = Enum.Font.GothamBold
WarningText.TextSize = 9
WarningText.Parent = Content

-- Intensive math calculations to cause lag
local function intensiveCalculation()
    local result = 0
    for i = 1, 100000 do
        result = result + math.sin(i) * math.cos(i) / math.tan(i + 1)
        result = result * math.sqrt(math.abs(result))
    end
    return result
end

-- Create massive amounts of particles
local function createParticleStorm()
    local character = LocalPlayer.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    for i = 1, 50 do
        local particle = Instance.new("Part")
        particle.Name = "LagParticle"
        particle.Size = Vector3.new(0.1, 0.1, 0.1)
        particle.Material = Enum.Material.Neon
        particle.BrickColor = BrickColor.random()
        particle.Anchored = true
        particle.CanCollide = false
        particle.Position = rootPart.Position + Vector3.new(
            math.random(-50, 50),
            math.random(-10, 50),
            math.random(-50, 50)
        )
        particle.Parent = workspace
        
        table.insert(createdObjects, particle)
        
        -- Add particle emitter for extra lag
        local emitter = Instance.new("ParticleEmitter")
        emitter.Rate = 1000
        emitter.Speed = NumberRange.new(10, 50)
        emitter.SpreadAngle = Vector2.new(45, 45)
        emitter.Lifetime = NumberRange.new(1, 3)
        emitter.Parent = particle
        
        table.insert(createdObjects, emitter)
    end
end

-- Create recursive function calls
local function recursiveLag(depth)
    if depth <= 0 or not isLagging then return end
    
    -- Intensive operations
    for i = 1, 100 do
        intensiveCalculation()
    end
    
    -- Recursive call
    spawn(function()
        recursiveLag(depth - 1)
    end)
end

-- Memory intensive operations
local function fillMemory()
    local massiveTable = {}
    for i = 1, 10000 do
        massiveTable[i] = {
            data = string.rep("LAG", 1000),
            numbers = {math.random(1, 1000000), math.random(1, 1000000), math.random(1, 1000000)},
            nested = {
                moreData = string.rep("MEMORY", 500),
                evenMore = string.rep("USAGE", 500)
            }
        }
    end
    return massiveTable
end

-- Update UI when lag starts
local function updateUI(active)
    if active then
        StatusText.Text = "Status: ACTIVE"
        StatusText.TextColor3 = Color3.fromRGB(255, 80, 80)
        
        -- Animate toggle switch
        TweenService:Create(ToggleKnob, TweenInfo.new(0.2), {
            Position = UDim2.new(1, -18, 0.5, -8),
            BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        }):Play()
        
        TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(80, 30, 30)
        }):Play()
    else
        StatusText.Text = "Status: OFF"
        StatusText.TextColor3 = Color3.fromRGB(150, 150, 150)
        
        -- Animate toggle switch
        TweenService:Create(ToggleKnob, TweenInfo.new(0.2), {
            Position = UDim2.new(0, 2, 0.5, -8),
            BackgroundColor3 = Color3.fromRGB(220, 220, 220)
        }):Play()
        
        TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        }):Play()
    end
end

-- Start permanent lag effects
local function startPermanentLag()
    if isLagging then 
        print("⚠️  LAG SIMULATOR: Already active!")
        return 
    end
    
    isLagging = true
    updateUI(true)
    
    print("🔄 LAG SIMULATOR: Starting PERMANENT client-side lag...")
    print("⚠️  WARNING: This will NOT stop until you reset/rejoin!")
    
    -- Method 1: Intensive calculation loop
    local calcConnection = RunService.Heartbeat:Connect(function()
        intensiveCalculation()
    end)
    table.insert(lagConnections, calcConnection)
    
    -- Method 2: Rapid fire events
    local eventConnection = RunService.RenderStepped:Connect(function()
        for i = 1, 10 do
            intensiveCalculation()
        end
    end)
    table.insert(lagConnections, eventConnection)
    
    -- Method 3: Particle storm
    createParticleStorm()
    
    -- Method 4: Recursive lag
    spawn(function()
        while isLagging do
            recursiveLag(5)
            wait(0.1)
        end
    end)
    
    -- Method 5: Memory filling
    local memoryData = {}
    local memoryConnection = RunService.Heartbeat:Connect(function()
        table.insert(memoryData, fillMemory())
        
        -- Prevent complete crash by clearing occasionally
        if #memoryData > 10 then
            table.remove(memoryData, 1)
        end
    end)
    table.insert(lagConnections, memoryConnection)
    
    -- Method 6: Rapid instance creation
    local instanceConnection = RunService.Heartbeat:Connect(function()
        for i = 1, 5 do
            local light = Instance.new("PointLight")
            light.Brightness = 10
            light.Range = 20
            light.Parent = workspace
            
            local part = Instance.new("Part")
            part.Size = Vector3.new(1, 1, 1)
            part.Material = Enum.Material.Neon
            part.BrickColor = BrickColor.random()
            part.Position = Vector3.new(
                math.random(-100, 100),
                math.random(0, 50),
                math.random(-100, 100)
            )
            part.Parent = workspace
            
            table.insert(createdObjects, light)
            table.insert(createdObjects, part)
        end
    end)
    table.insert(lagConnections, instanceConnection)
    
    print("❌ LAG SIMULATOR: PERMANENTLY ACTIVE")
    print("🔄 Reset character or rejoin to stop lag")
end

-- Toggle button click (does the same as Z key)
ToggleButton.MouseButton1Click:Connect(function()
    startPermanentLag()
end)

-- Make the entire toggle container clickable
local ToggleClickArea = Instance.new("TextButton")
ToggleClickArea.Size = UDim2.new(1, 0, 1, 0)
ToggleClickArea.Position = UDim2.new(0, 0, 0, 0)
ToggleClickArea.BackgroundTransparency = 1
ToggleClickArea.Text = ""
ToggleClickArea.AutoButtonColor = false
ToggleClickArea.Parent = ToggleContainer
ToggleClickArea.MouseButton1Click:Connect(function()
    startPermanentLag()
end)

-- Keybind handler (Z key)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == ACTIVATE_KEY then
        startPermanentLag()
    end
end)

-- Auto cleanup only on character respawn
LocalPlayer.CharacterAdded:Connect(function()
    if isLagging then
        isLagging = false
        updateUI(false)
        
        for _, connection in pairs(lagConnections) do
            connection:Disconnect()
        end
        lagConnections = {}
        
        for _, obj in pairs(createdObjects) do
            if obj and obj.Parent then
                obj:Destroy()
            end
        end
        createdObjects = {}
        
        print("🔄 LAG SIMULATOR: Cleared on respawn")
    end
end)

-- Simple drag functionality
local dragging = false
local dragStart, startPos

Header.MouseButton1Down:Connect(function()
    dragging = true
    dragStart = UserInputService:GetMouseLocation()
    startPos = MainContainer.Position
end)

Header.MouseButton1Up:Connect(function()
    dragging = false
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local delta = mousePos - dragStart
        MainContainer.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- Initial print
print("🎮 Permanent Client Lag Simulator Loaded!")
print("🔑 Press Z or click toggle to activate PERMANENT lag")
print("⚠️  This will make your game EXTREMELY laggy")
print("🔄 Only way to stop: Reset or Rejoin")
print("🛡️  Only affects your client - others are safe")
