local CreateClass = require(game.ReplicatedStorage.Shared.CreateClass)
local PlayerClass = CreateClass(require(script.Parent.Player))

return function(self)
    self.CurrentPlayerObjects = {}

    self.PlayerRemovingManager = function()
        game.Players.PlayerRemoving:Connect(function(Player)
            for i, v in pairs(self.CurrentPlayerObjects) do
                if v.Instance == Player then
                    v.OnLeave()
                    table.remove(self.CurrentPlayerObjects, table.find(self.CurrentPlayerObjects, v))
                end
            end
        end)
    end

    self.PlayerJoiningManager = function()
        game.Players.PlayerAdded:Connect(function(Player)
            local PlayerObj = PlayerClass.new()
            PlayerObj.OnJoin(Player)

            table.insert(self.CurrentPlayerObjects, PlayerObj)    
        end)
    end
    
    self.Initiate = function()
        self.PlayerJoiningManager()
        self.PlayerRemovingManager()
    end
end