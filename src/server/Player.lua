local Dss = game:GetService("DataStoreService")
local Ds = Dss:GetDataStore("Players")

local CreateClass = require(game.ReplicatedStorage.Shared.CreateClass)
local PetClass = CreateClass(require(script.Parent.Pet))

return function(self)
    self.Instance = nil
    self.Character = nil
    self.Data = nil

    self.BaseData = {
        OwnedPets = {"Pet"}
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

    self.OnJoin = function(PlrInstance)
        self.Instance = PlrInstance
        self.LoadData()
        self.Character = self.Instance.Character or self.Instance.CharacterAdded:Wait()

        local PetFolder = Instance.new("Folder", self.Character)
        PetFolder.Name = "Pets"

        local PetPositions = Instance.new("Folder", self.Character)
        PetPositions.Name = "PetPositions"

        for i = 1, 4 do
            local PetPos = Instance.new("Attachment", self.Character.PetPositions)
            PetPos.Name = i
            Instance.new("BoolValue", PetPos).Name = "Occupied"

            if i == 1 then
                PetPos.Position = self.Character.HumanoidRootPart.CFrame.LookVector * -5 
            elseif i == 2 then
                PetPos.Position = self.Character.HumanoidRootPart.CFrame.RightVector * 5
            elseif i == 3 then
                PetPos.Position = self.Character.HumanoidRootPart.CFrame.RightVector * -5
            elseif i == 4 then
                PetPos.Position = self.Character.HumanoidRootPart.CFrame.LookVector * 5
            end
        end

        for i, v in pairs(self.Data.OwnedPets) do
            local NewPet = PetClass.new()
            NewPet.Spawn(v)
        end
    end

    self.OnLeave = function()
        self.SaveData()
    end
end