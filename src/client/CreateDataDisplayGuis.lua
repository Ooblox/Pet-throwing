
local CreateClass = require(game.ReplicatedStorage.Shared.CreateClass)
local DataDisplayGuiClass = CreateClass(require(script.Parent.DataDisplayGui))

local Player = game.Players.LocalPlayer

return(function(self)
    self.TextLabels = {
        [Player.PlayerGui:WaitForChild("MainGuis").Top.Cash.TextLabel] = "Cash",
        [Player.PlayerGui.MainGuis.Top.Multiplier.TextLabel] = "Multiplier",
        [Player.PlayerGui.MainGuis.Top.ThrowingPower.TextLabel] = "Strength",

    }

    self.LoadDataDisplayers = function()
        for i, v in pairs(self.TextLabels) do
            local DataDisplayer = DataDisplayGuiClass.new()
            DataDisplayer.Initiate(i, v)
        end
    end
end)