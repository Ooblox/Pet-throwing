local CameraInst = game.Workspace.CurrentCamera

return function(self)
    self.AssignCameraToPet = function()
        game.ReplicatedStorage.RemoteSignals.Camera.OnClientEvent:Connect(function(PetInst, Type)
            print(Type)
            if Type == "Begin" then
                CameraInst.CameraSubject = PetInst
            else
                CameraInst.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
            end 
        end)
    end

    self.Initiate = function()
        self.AssignCameraToPet()
    end
end