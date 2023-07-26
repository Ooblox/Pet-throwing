
return function(self)
    self.Instance = nil
    self.Data = nil
    self.PlayerOwnerObj = nil

    self.FollowPlayer = function()
        
    end

    self.Spawn = function(PetName)
        self.Data = require(game.ReplicatedStorage.Shared.Pets).GetPetData(PetName)
        self.Instance = self.Data.Instance:Clone()
        self.Instance.Parent = self.PlayerOwnerObj.Character:WaitForChild("Pets")

        local Att = Instance.new("Attachment", self.Instance)
        local Bp = Instance.new("AlignPosition", self.Instance)
        Bp.Attachment0 = Att

        for i = 1, 4 do
            if not self.PlayerOwnerObj.Character.PetPositions[i].Occupied then
                Bp.Attachment1 = self.PlayerOwnerObj.Character.PetPositions[i]
                self.PlayerOwnerObj.Character.PetPositions[i].Occupied.Value = true
                break 
            end
        end
    end
end