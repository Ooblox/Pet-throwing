
local DataChangeRemote = game.ReplicatedStorage.RemoteSignals.PlayerDataChange
local GetData = game.ReplicatedStorage.RemoteSignals.GetPlayerData

return(function(self)
    self.TextLabel = nil
    self.DataType = nil

    self.SetText = function()
        self.TextLabel.Text = GetData:InvokeServer()[self.DataType]
    end

    self.DetectDataChange = function()
        DataChangeRemote.OnClientEvent:Connect(function()
            self.SetText()
        end)
    end

    self.Initiate = function()
        self.SetText()
        self.DetectDataChange()
    end
end)