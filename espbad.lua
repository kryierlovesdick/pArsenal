local lplr = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local worldToViewportPoint = camera.worldToViewportPoint

local HeadOff = Vector3.new(0, 0.5, 0)
local LegOff = Vector3.new(0, 3, 0)

local function createBox(player)
    local BoxOutline = Drawing.new("Square")
    BoxOutline.Visible = false
    BoxOutline.Color = Color3.new(0, 0, 0)
    BoxOutline.Thickness = 3
    BoxOutline.Transparency = 1
    BoxOutline.Filled = false

    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Color3.new(1, 1, 1)
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false

    local function updateBox()
        if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("HumanoidRootPart") and player ~= lplr and player.Character.Humanoid.Health > 0 then
            local Vector, onScreen = camera:worldToViewportPoint(player.Character.HumanoidRootPart.Position)

            local RootPart = player.Character.HumanoidRootPart
            local Head = player.Character.Head
            local RootPosition, RootVis = camera:worldToViewportPoint(RootPart.Position)
            local HeadPosition = camera:worldToViewportPoint(Head.Position + HeadOff)
            local LegPosition = camera:worldToViewportPoint(RootPart.Position - LegOff)

            if onScreen then
                BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
                BoxOutline.Visible = true

                Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
                Box.Visible = true

                if player.TeamColor == lplr.TeamColor then
                    BoxOutline.Visible = false
                    Box.Visible = false
                else
                    BoxOutline.Visible = true
                    Box.Visible = true
                end
            else
                BoxOutline.Visible = false
                Box.Visible = false
            end
        else
            BoxOutline.Visible = false
            Box.Visible = false
        end
    end

    game:GetService("RunService").RenderStepped:Connect(updateBox)
end

for _, player in pairs(game.Players:GetPlayers()) do
    createBox(player)
end

game.Players.PlayerAdded:Connect(createBox)
