local Dss = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local Ds = Dss:GetDataStore("Players")

local CreateClass = require(game.ReplicatedStorage.Shared.CreateClass)
local PetClass = CreateClass(require(script.Parent.Pet))

return function(self)
    self.USE_SAVED_DATA = false
    self.Instance = nil
    self.Character = nil
    self.Data = nil

    self.BaseData = {
        OwnedPets = {"Pet"},
        PetMultiplier = 1,
        Coins = 0,
        Strength = 5,
    }

    self.SaveData = function()
        if self.USE_SAVED_DATA then
            Ds:SetAsync(self.Instance.UserId, self.Data)
        end
    end

    self.LoadData = function()
        print(self.Instance)
        local SavedData = Ds:GetAsync(self.Instance.UserId)

        if self.USE_SAVED_DATA then
            if SavedData then
                self.Data = SavedData
            else
                self.Data = self.BaseData
            end
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

        for i = 1, 4 do
            local PetPos = Instance.new("Attachment", self.Character:WaitForChild("HumanoidRootPart"))
            PetPos.Name = i
            Instance.new("BoolValue", PetPos).Name = "Occupied"

            if i == 1 then
                PetPos.Position = self.Character.HumanoidRootPart.CFrame.LookVector * -5 - Vector3.new(0, 2, 0)
                PetPos.Orientation += Vector3.new(0, 180, 0)
            elseif i == 2 then
                PetPos.Position = self.Character.HumanoidRootPart.CFrame.RightVector * 5 - Vector3.new(0, 2, 0)
                PetPos.Orientation += Vector3.new(0, 90, 0)
            elseif i == 3 then
                PetPos.Position = self.Character.HumanoidRootPart.CFrame.RightVector * -5 - Vector3.new(0, 2, 0)
                PetPos.Orientation += Vector3.new(0, -90, 0)
            elseif i == 4 then
                PetPos.Position = self.Character.HumanoidRootPart.CFrame.LookVector * 5 - Vector3.new(0, 2, 0)
            end
        end

        for i, v in pairs(self.Data.OwnedPets) do
            local NewPet = PetClass.new()
            NewPet.Spawn(v, self)
        end
    end

    self.OnLeave = function()
        self.SaveData()
    end

    self.ThrowPet = function()
        
    end
end