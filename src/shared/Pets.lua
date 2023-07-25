
local CreateClass = require(script.Parent.CreateClass)

local PetDataBaseClass = CreateClass(function(self)
    self.Pets = {
        Pet = {
            Instance = nil
        }
    }

    self.GetPetData = function(PetName)
        return self.Pets[PetName]
    end
end)

local PetDataBase = PetDataBaseClass.new()
return PetDataBase