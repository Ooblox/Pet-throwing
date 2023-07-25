local Dss = game:GetService("DataStoreService")
local Ds = Dss:GetDataStore("Players")

local CreateClass = require(game.ReplicatedStorage.Shared.CreateClass)

return function(self)
    self.Instance = nil
    self.Data = nil

    self.BaseData = {
        OwnedPets = {}
    }

    self.SaveData = function()
        Ds:SetAsync(self.Instance.UserId, self.Data)
    end

    self.LoadData = function()
        print(self.Instance)
        local SavedData = Ds:GetAsync(self.Instance.UserId)

        if SavedData then
            self.Data = SavedData
        else
            self.Data = self.BaseData
        end
    end

    self.LoadPets = function()
        
    end

    self.OnJoin = function(Instance)
        self.Instance = Instance
        print(self.Instance)
        self.LoadData()
    end

    self.OnLeave = function()
        self.SaveData()
    end
end