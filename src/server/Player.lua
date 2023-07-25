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
        local SavedData = Ds:GetAsync(self.Instance.UserId)

        if SavedData then
            self.Data = SavedData
        else
            self.Data = self.BaseData
        end
    end

    self.LoadPets = function()
        
    end
end