
local CreateClass = require(script.Parent.CreateClass)

local PetDataBaseClass = CreateClass(function(self)
    self.Pets = {
        Cat = {
            Rarity = "Basic",
            Instance = game.ReplicatedStorage.Pets.Basic.Cat,
        },

    }

    self.GetPetData = function(PetName)
        return self.Pets[PetName]
    end
end)

local PetDataBase = PetDataBaseClass.new()
return PetDataBase