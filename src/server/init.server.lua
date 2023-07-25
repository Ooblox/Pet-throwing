local Dss = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local Ds = Dss:GetDataStore("Players")

local CreateClass = require(game.ReplicatedStorage.Shared.CreateClass)
local PlayerClass = CreateClass(require(script.Player))

local PlayersManagerClass = CreateClass(function(self)
    self.CurrentPlayerObjects = {}

    self.PlayerRemovingManager = function()
        game.Players.PlayerRemoving:Connect(function(Player)
            for i, v in pairs(self.CurrentPlayerObjects) do
                if v.Instance == Player then
                    v.SaveData()
                    table.remove(self.CurrentPlayerObjects, table.find(self.CurrentPlayerObjects, v))
                end
            end
        end)
    end

    self.PlayerJoiningManager = function()
        game.Players.PlayerAdded:Connect(function(Player)
            local PlayerObj = PlayerClass.new()
            PlayerObj.Instance = Player
            PlayerObj.LoadData()

            table.insert(self.CurrentPlayerObjects, PlayerObj)    
        end)
    end
end)