-- Fishing Rod Script

local fishingRod = script.Parent -- Fishing rod part
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local fishingRange = 10 -- Distance within which a fish can be caught

-- Event to start the fishing process when clicked
fishingRod.Touched:Connect(function(hit)
    if hit and hit.Parent:FindFirstChild("Humanoid") then
        -- When the fishing rod touches a player, it starts the fishing process
        castFishingLine()
    end
end)

-- Function to cast the fishing line
function castFishingLine()
    local targetPosition = mouse.Hit.p -- Get the point where the player clicked
    local fishingLine = Instance.new("Part")
    fishingLine.Size = Vector3.new(1, 1, (targetPosition - fishingRod.Position).Magnitude)
    fishingLine.CFrame = CFrame.new(fishingRod.Position, targetPosition)
    fishingLine.Anchored = true
    fishingLine.Parent = workspace

    -- Check if a fish is within range of the line
    local fish = game.Workspace:FindFirstChild("Fish")
    if fish and (fish.Position - targetPosition).Magnitude <= fishingRange then
        catchFish(fish)
    end
end

-- Function to catch the fish
function catchFish(fish)
    print("Fish caught!")
    fish:Destroy() -- Removes the fish from the workspace

    -- Give player rewards or handle the caught fish
    local fishReward = Instance.new("StringValue")
    fishReward.Name = "CaughtFish"
    fishReward.Value = "Fish" -- Can store data like fish type, etc.
    fishReward.Parent = player
end
