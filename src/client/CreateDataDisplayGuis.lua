
local CreateClass = require(game.ReplicatedStorage.Shared.CreateClass)
local DataDisplayGuiClass = CreateClass(require(script.Parent.DataDisplayGui))

local Player = game.Players.LocalPlayer

return(function(self)
    self.TextLabels = {
        [Player.PlayerGui:WaitForChild("MainFrames").Top.Cash.TextLabel] = "Cash",
        [Player.PlayerGui.MainFrames.Top.Multiplier.TextLabel] = "Multiplier",
        [Player.PlayerGui.MainFrames.Top.ThrowingPower.TextLabel] = "Strength",

    }

    self.LoadDataDisplayers = function()
        for i, v in pairs(self.TextLabels) do
            local DataDisplayer = DataDisplayGuiClass.new()
            DataDisplayer.Initiate(i, v)
        end
    end
end)