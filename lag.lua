-- Client-Side Permanent Lag Simulator (Auto-Start)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

-- Lag variables
local lagConnections = {}
local createdObjects = {}

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
    if depth <= 0 then return end
    
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
    print("🔄 PERMANENT LAG SIMULATOR: Starting infinite client-side lag...")
    
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
    
    -- Method 4: Infinite recursive lag
    spawn(function()
        while true do
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
    
    print("❌ PERMANENT LAG SIMULATOR: ACTIVE")
    print("⚠️  Game will remain laggy until you close/rejoin")
    print("🛡️  Only affects your client - others are safe")
end

-- Auto-start lag on script execution
startPermanentLag()

-- Restart lag if character respawns
LocalPlayer.CharacterAdded:Connect(function()
    wait(1) -- Wait for character to fully load
    createParticleStorm()
end)

-- Initial print
print("🎮 Permanent Client Lag Simulator Loaded!")
print("🔥 LAG STARTED AUTOMATICALLY")
print("⚠️  NO TOGGLE - This will lag forever!")
print("💡 Only way to stop: Close game or rejoin server")
