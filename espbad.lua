-- ESP Script for Arsenal

-- Create a local function to get the player's team color
local function getTeamColor(player)
    local character = player.Character
    if character then
        return character.TeamColor
    end
    return nil
end

-- Create a local function to draw ESP boxes
local function drawESP(player)
    local teamColor = getTeamColor(player)
    if teamColor and teamColor ~= game.Players.LocalPlayer.Character.TeamColor then
        local character = player.Character
        if character then
            local head = character:FindFirstChild("Head")
            if head then
                local espBox = Instance.new("BoxHandleAdornment")
                espBox.Size = Vector3.new(1, 1, 1)
                espBox.Color3 = Color3.new(1, 0, 0) -- Red color for enemy players
                espBox.Parent = head
            end
        end
    end
end

-- Loop through all players and draw ESP boxes
for _, player in pairs(game.Players:GetPlayers()) do
    drawESP(player)
end

-- Update ESP boxes in real-time
game.Players.PlayerAdded:Connect(function(player)
    drawESP(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
    local character = player.Character
    if character then
        local head = character:FindFirstChild("Head")
        if head then
            for _, espBox in pairs(head:GetDescendants()) do
                if espBox:IsA("BoxHandleAdornment") then
                    espBox:Destroy()
                end
            end
        end
    end
end)
