local list = {
	"Checkpoints",
	"checkpoint",
	"Stages",
	"stages",
	"stage",
	"StagePoints",
	"Stagepoints",
	"CheckPoints"
}
for i, v in ipairs(workspace:GetChildren()) do
	for k, a in ipairs(list) do
		if v.Name == a then
			local folder = v
			local counter = folder:GetChildren()
print("detected ".. #counter .. " checkpoints")
local c = 0
print("3")
wait(1)
print("2")
wait(1)
print("1")
wait(1)
repeat
task.wait(0.4)
    c = c + 1
    game.Players.LocalPlayer.Character:MoveTo(folder:FindFirstChild(c).Position)
	print("stage ".. c .. " completed.. checking next")
until c == #counter
print("finished ur obby is probably done!")
		end
	end
end
