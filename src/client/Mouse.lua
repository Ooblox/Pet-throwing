local MouseInst = game.Players.LocalPlayer:GetMouse()

return function(self)
    self.ReturnMousePos = function()
        game.ReplicatedStorage.RemoteSignals.GetMouseInfo.OnClientInvoke = function()
            return {
                ScreenPos = {MouseInst.X, MouseInst.Y}, 
                HitPos = MouseInst.Hit.CFrame,
            }
        end
    end

    self.Initiate = function()
        self.ReturnMousePos()
    end
end