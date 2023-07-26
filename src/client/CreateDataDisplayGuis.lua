
local CreateClass = require(game.ReplicatedStorage.Shared.CreateClass)
local DataDisplayGuiClass = CreateClass(require(script.Parent.DataDisplayGui))

local Player = game.Players.LocalPlayer

return(function(self)
    self.TextLabels = {
        [Player.PlayerGui:WaitForChild("Menu").Top.Cash.TextLabel] = "Cash",
        [Player.PlayerGui.Menu.Top.Multiplier.TextLabel] = "Multiplier",
        [Player.PlayerGui.Menu.Top.ThrowingPower.TextLabel] = "Strength",

    }

    self.LoadDataDisplayers = function()
        for i, v in pairs(self.TextLabels) do
            local DataDisplayer = DataDisplayGuiClass.new()
            DataDisplayer.Initiate(i, v)
        end
    end
end)