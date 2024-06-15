_G.SilentAimEnabled = true
_G.WallbangEnabled = true

local lplr = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = lplr:GetMouse()
local worldToViewportPoint = camera.worldToViewportPoint

local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge

    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= lplr and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local Vector, onScreen = camera:worldToViewportPoint(player.Character.HumanoidRootPart.Position)

            if onScreen then
                local distance = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(Vector.X, Vector.Y)).magnitude

                if distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end

    return closestPlayer
end

local function silentAim()
    if _G.SilentAimEnabled then
        local target = getClosestPlayer()

        if target then
            local character = target.Character
            local humanoid = character.Humanoid
            local rootPart = character.HumanoidRootPart
            local head = character.Head

            local rootPosition = rootPart.Position
            local headPosition = head.Position

            local direction = (headPosition - rootPosition).unit
            local ray = Ray.new(rootPosition, direction * 1000)

            local hit, position = workspace:FindPartOnRay(ray)

            if hit and _G.WallbangEnabled then
                local distance = (rootPosition - position).magnitude

                if distance < 1000 then
                    lplr.Character.HumanoidRootPart.CFrame = CFrame.new(position)
                end
            else
                lplr.Character.HumanoidRootPart.CFrame = CFrame.new(headPosition)
            end
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(silentAim)
