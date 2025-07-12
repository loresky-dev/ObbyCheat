local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "CheckpointUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0.3, 0, 0.25, 0)
frame.Position = UDim2.new(0.35, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Text = "Checkpoint Teleport"

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, -10, 0.3, 0)
status.Position = UDim2.new(0, 5, 0.3, 0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.new(0.8, 0.8, 0.8)
status.TextScaled = true
status.Text = "Status: Idle"

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.8, 0, 0.3, 0)
button.Position = UDim2.new(0.1, 0, 0.7, 0)
button.BackgroundColor3 = Color3.fromRGB(50, 120, 50)
button.TextColor3 = Color3.new(1, 1, 1)
button.TextScaled = true
button.Text = "Start"

local running = false
local folderName = nil
local folder = nil
local checkpointCount = 0

local function detectFolder()
    folder = workspace:FindFirstChild("Stages") or workspace:FindFirstChild("Checkpoints")
    if folder then
        folderName = folder.Name
        checkpointCount = #folder:GetChildren()
        return true
    end
    return false
end

local function teleportThroughCheckpoints()
    if not folder then return end
    local c = 0
    while running do
        task.wait(0.4)
        c += 1
        local part = folder:FindFirstChild(tostring(c))
        if not part then
            status.Text = "✅ All checkpoints completed."
            button.Text = "Start"
            running = false
            break
        end
        if player.Character then
            player.Character:MoveTo(part.Position)
        end
        status.Text = "Checkpoint " .. c .. " / " .. checkpointCount
    end
end

button.MouseButton1Click:Connect(function()
    if running then
        running = false
        button.Text = "Start"
        status.Text = "Status: Stopped"
        return
    end
    if detectFolder() then
        running = true
        button.Text = "Stop"
        status.Text = "Detected Folder: " .. folderName .. " (" .. checkpointCount .. " parts)"
        task.spawn(teleportThroughCheckpoints)
    else
        status.Text = "❌ No folder found."
    end
end)
