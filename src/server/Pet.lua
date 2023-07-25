
return function(self)
    self.Instance = nil
    self.Data = nil
    self.PlayerOwnerObj = nil

    self.FollowPlayer = function()
        
    end

    self.Spawn = function(PetName)
        self.Data = require(game.ReplicatedStorage.Shared.Pets).GetPetData(PetName)
        self.Instance = 
    end
end