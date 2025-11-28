-- Client-Side Permanent Lag Simulator
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- Lag variables
local isLagging = false
local lagConnections = {}
local createdObjects = {}

-- Keybind settings
local ACTIVATE_KEY = Enum.KeyCode.F

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

-- Start permanent lag effects
local function startPermanentLag()
    if isLagging then 
        print("⚠️  LAG SIMULATOR: Already active!")
        return 
    end
    
    isLagging = true
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

-- Keybind handler
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

-- Initial print
print("🎮 Permanent Client Lag Simulator Loaded!")
print("🔑 Press F to activate PERMANENT lag")
print("⚠️  This will make your game EXTREMELY laggy")
print("🔄 Only way to stop: Reset or Rejoin")
print("🛡️  Only affects your client - others are safe")
