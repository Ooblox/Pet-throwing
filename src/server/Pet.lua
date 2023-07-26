
return function(self)
    self.Instance = nil
    self.Data = nil
    self.PlayerOwnerObj = nil

    self.FollowPlayer = function()
        
    end

    self.Spawn = function(PetName, Owner)
        self.PlayerOwnerObj = Owner
        self.Data = require(game.ReplicatedStorage.Shared.Pets).GetPetData(PetName)

        self.Instance = self.Data.Instance:Clone()
        self.Instance.Parent = self.PlayerOwnerObj.Character:WaitForChild("Pets")

        local Att = Instance.new("Attachment", self.Instance.PrimaryPart)
        local Bp = Instance.new("AlignPosition", self.Instance.PrimaryPart)
        local Orient = Instance.new("AlignOrientation", self.Instance.PrimaryPart)
        Bp.Attachment0 = Att
        Orient.Attachment0 = Att

        for i = 1, 4 do
            if not self.PlayerOwnerObj.Character.HumanoidRootPart[i].Occupied.Value then
                self.Instance:MoveTo(self.PlayerOwnerObj.Character.HumanoidRootPart[i].WorldPosition)
                
                Bp.Attachment1 = self.PlayerOwnerObj.Character.HumanoidRootPart[i]
                Orient.Attachment1 = self.PlayerOwnerObj.Character.HumanoidRootPart[i]
                
                self.PlayerOwnerObj.Character.HumanoidRootPart[i].Occupied.Value = true
                break 
            end
        end
    end
end