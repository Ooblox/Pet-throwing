local UserInputService = game:GetService("UserInputService")

return function(self)
    self.OnClick = function()
        UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
            if gameProcessedEvent then return end

            game.ReplicatedStorage.RemoteSignals.UserInput:FireServer(input.UserInputState, input.UserInputType)
        end)
    end

    self.Initiate = function()
        self.OnClick()
    end
end
