local Dss = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Ds = Dss:GetDataStore("Players")

local CreateClass = require(game.ReplicatedStorage.Shared.CreateClass)
local PetClass = CreateClass(require(script.Parent.Pet))

return function(self)
    self.USE_SAVED_DATA = false
    self.Instance = nil
    self.Character = nil
    self.Data = {
        OwnedPets = {"Cat"},
        Multiplier = 1,
        Cash = 0,
        Strength = 15,
    }
    self.ThrowDebounce = nil
    self.ThrowPowerMeter = 100
    self.HoldingLeftClick = nil

    self.SaveData = function()
        if self.USE_SAVED_DATA then
            Ds:SetAsync(self.Instance.UserId, self.Data)
        end
    end

    self.LoadData = function()
        local SavedData = Ds:GetAsync(self.Instance.UserId)

        if self.USE_SAVED_DATA then
            if SavedData then
                for i, v in pairs(SavedData) do
                    self.Data[i] = v
                end
            end
        end

        game.ServerScriptService.Signals.PlayerDataChange:Fire(self.Instance)
        game.ReplicatedStorage.RemoteSignals.PlayerDataChange:FireClient(self.Instance)
    end

    self.LoadPets = function()
        
    end

    self.OnJoin = function(PlrInstance)
        self.Instance = PlrInstance
        self.LoadData()

        coroutine.wrap(function()
            self.InputHandler()
        end)()

        self.OnCharacterAdded()
    end

    self.InputHandler = function()
        game.ReplicatedStorage.RemoteSignals.UserInput.OnServerEvent:Connect(function(Player, InputState, InputType)
            if Player == self.Instance then
                if InputState == "Began" then
                    if InputType == Enum.UserInputType.MouseButton1 then
                        self.HoldingLeftClick = true
                      
                        if not self.ThrowDebounce then
                            self.ThrowPet()
                        end
                    end
                else
                    if InputType == Enum.UserInputType.MouseButton1 then
                        self.HoldingLeftClick = nil
                    end
                end
            end
        end)
    end

    self.OnCharacterAdded = function()
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
        local TouchingPlatform

        local Region = Region3.new(
            game.Workspace.ThrowZone.Platform.Position - Vector3.new(game.Workspace.ThrowZone.Platform.Size.X/2, 0, game.Workspace.ThrowZone.Platform.Size.Z/2),
            game.Workspace.ThrowZone.Platform.Position + Vector3.new(game.Workspace.ThrowZone.Platform.Size.X/2, 3, game.Workspace.ThrowZone.Platform.Size.Z/2)
        )

        for i, v in pairs(game.Workspace:FindPartsInRegion3(Region)) do
            print(v)
            if v:IsDescendantOf(self.Character) then
                TouchingPlatform = true
            end
        end
        
        if TouchingPlatform then

            self.ThrowDebounce = true

            self.Character.HumanoidRootPart.Anchored = true
            self.Character.HumanoidRootPart.Orientation = game.Workspace.ThrowZone.Direction.Orientation

            local ThrowingPet = self.Character.Pets:GetChildren()[math.random(1, #self.Character.Pets:GetChildren())]
            ThrowingPet.PrimaryPart.Anchored = true
            ThrowingPet.PrimaryPart.CFrame = (self.Character:FindFirstChild("Right Arm") or self.Character:FindFirstChild("RightHand")).CFrame
    
            local MouseInfo = game.ReplicatedStorage.RemoteSignals.GetMouseInfo:InvokeClient(self.Instance)

            local PowerGaugeGui = game.ReplicatedStorage.Guis.PowerGauge:Clone()
            PowerGaugeGui.Parent = self.Instance.PlayerGui
            PowerGaugeGui.Position = UDim2.new(0, MouseInfo.X, 0, MouseInfo.Y)
           
            local Anim = self.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.Animations.ThrowPrepare)
            Anim:Play()

            for i = 1, 100 do
                self.ThrowPowerMeter = i
    
                if not self.HoldingLeftClick or i == 100 then
                    Anim:Stop()

                    local Anim = self.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.Animations.Throw)
                    Anim:Play()
                    
                    ThrowingPet.PrimaryPart.Anchored = false

                    local Destination = Instance.new("Part", workspace)
                    Destination.Anchored = true
                    Destination.CanCollide = false
                    Destination.Transparency = 1
                    Destination.Position = self.Character.HumanoidRootPart.Position + self.Character.HumanoidRootPart.CFrame.LookVector * self.Data.Strength

                    local A = Instance.new("Attachment", Destination)

                    ThrowingPet.PrimaryPart.AlignPosition.Attachment1 = A
                    ThrowingPet.PrimaryPart.AlignOrientation.Enabled = false

                    repeat wait() until (Destination.Position - ThrowingPet.PrimaryPart.Position).Magnitude < 2

                    ThrowingPet.PrimaryPart.CanCollide = true
                    ThrowingPet.PrimaryPart.AlignPosition.Enabled = false

                    self.Character.HumanoidRootPart.Anchored = false
                    break
                end
            end
        end
    end
end
