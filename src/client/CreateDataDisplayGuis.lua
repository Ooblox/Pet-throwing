
local CreateClass = require(game.ReplicatedStorage.Shared.CreateClass)
local DataDisplayGuiClass = CreateClass(script.Parent.DataDisplayGui)

local Player = game.Players.LocalPlayer

return(function(self)
    self.TextLabels = {
        Player.PlayerGui.Menu.Top.Cash = "Cash",
        Player.PlayerGui.Menu.Top.Multiplier = "Multiplier",
        Player.PlayerGui.Menu.Top.ThrowingPower = "Strength",

    }

    self.LoadDataDisplayers = function()
        for i, v in pairs(self.TextLabels) do
            local DataDisplayer = DataDisplayGuiClass.new()
            DataDisplayer.TextLabel = i
            DataDisplayer.DataType = v
            DataDisplayer.Initiate()
        end
    end
end)