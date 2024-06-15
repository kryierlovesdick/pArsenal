_G.ESPEnabled = true

local lplr = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local function createBox(player)
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Color3.new(1, 1, 1)
    box.Thickness = 1
    box.Transparency = 1
    box.Filled = false

    local function updateBox()
        if _G.ESPEnabled then
            if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("HumanoidRootPart") and player ~= lplr and player.Character.Humanoid.Health > 0 then
                local Vector, onScreen = camera:worldToViewportPoint(player.Character.HumanoidRootPart.Position)

                if onScreen then
                    box.Size = Vector2.new(1000 / Vector.Z, 1000 / Vector.Z)
                    box.Position = Vector2.new(Vector.X, Vector.Y)
                    box.Visible = true
                else
                    box.Visible = false
                end
            else
                box.Visible = false
            end
        else
            box.Visible = false
        end
    end

    game:GetService("RunService").RenderStepped:Connect(updateBox)
end

for _, player in pairs(game.Players:GetPlayers()) do
    createBox(player)
end

game.Players.PlayerAdded:Connect(createBox)

while true do
    if not _G.ESPEnabled then
        break
    end
    wait(1)
end
