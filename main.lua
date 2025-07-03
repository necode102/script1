local library = {}
local tweenService = game:GetService("TweenService")
local mouse = game.Players.LocalPlayer:GetMouse()

function play(id)
    for _, v in next, workspace:GetChildren() do
        if v.Name == "GUISound" then
            v:Destroy()
        end
    end
    local Sound = Instance.new("Sound", workspace)
    Sound.Name = "GUISound"
    Sound.Volume = 6
    Sound.SoundId = id
    Sound:Play()
end

function library:CreateWindow(name, theme)
    local theme1, theme2, theme3
    local toolight = false
    
    -- Удаляем старые окна
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == "By Shaddow" then
            v:Destroy()
        end
    end

    -- Выбор темы
    local themes = {
        Normal = {Color3.fromRGB(32,32,32), Color3.fromRGB(26,26,26), Color3.fromRGB(176, 148, 255)},
        Reverse = {Color3.fromRGB(26,26,26), Color3.fromRGB(32,32,32), Color3.fromRGB(176, 148, 255)},
        Blood = {Color3.fromRGB(32,32,32), Color3.fromRGB(26,26,26), Color3.fromRGB(138, 3, 3)},
        Gainsboro = {Color3.fromRGB(32,32,32), Color3.fromRGB(26,26,26), Color3.fromRGB(220, 220, 221), true},
        Canary = {Color3.fromRGB(32,32,32), Color3.fromRGB(26,26,26), Color3.fromRGB(255, 253, 130)},
        Emerald = {Color3.fromRGB(32,32,32), Color3.fromRGB(26,26,26), Color3.fromRGB(68, 207, 108)},
        Crimson = {Color3.fromRGB(32,32,32), Color3.fromRGB(26,26,26), Color3.fromRGB(214, 40, 57)},
        DeepSea = {Color3.fromRGB(32,32,32), Color3.fromRGB(26,26,26), Color3.fromRGB(40, 81, 214)}
    }
    
    theme1, theme2, theme3, toolight = unpack(themes[theme] or themes.Normal)

    -- Создание элементов интерфейса
    local Screen = Instance.new("ScreenGui")
    Screen.Name = "By Shaddow"
    Screen.Parent = game:WaitForChild("CoreGui")
    Screen.Enabled = true
    Screen.ResetOnSpawn = false

    local Top = Instance.new("Frame")
    Top.Name = "Top"
    Top.Parent = Screen
    Top.AnchorPoint = Vector2.new(0.5, 0.5)
    Top.BackgroundColor3 = theme1
    Top.BackgroundTransparency = 0
    Top.BorderSizePixel = 0
    Top.Active = true
    Top.Position = UDim2.new(0.5, 0, 0.2, 0)
    Top.Size = UDim2.new(0, 650, 0, 30)
    Top.ZIndex = 10
    
    -- Скругление углов
    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 6)
    TopCorner.Parent = Top

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = Top
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.035, 0, 0, 0)
    TextLabel.Size = UDim2.new(0, 600, 0, 30)
    TextLabel.Font = Enum.Font.GothamSemibold
    TextLabel.Text = name
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 16
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.ZIndex = 11

    local Toggle = Instance.new("ImageButton")
    Toggle.Name = "Toggle"
    Toggle.Parent = Top
    Toggle.BackgroundTransparency = 1
    Toggle.Position = UDim2.new(0.009, 0, 0.15, 0)
    Toggle.Rotation = 90
    Toggle.Size = UDim2.new(0, 20, 0, 20)
    Toggle.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Image = "rbxassetid://3926305904"
    Toggle.ImageRectOffset = Vector2.new(284, 4)
    Toggle.ImageRectSize = Vector2.new(24, 24)
    Toggle.ZIndex = 11

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = Top
    Main.AnchorPoint = Vector2.new(0.5, 0)
    Main.BackgroundColor3 = theme2
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 1, 5)
    Main.Size = UDim2.new(0, 650, 0, 0) -- Начальный размер 0, будет анимировано
    Main.ClipsDescendants = true
    Main.ZIndex = 9
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 6)
    MainCorner.Parent = Main

    local TabContainer = Instance.new("Folder")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Main

    local Tabs = Instance.new("ScrollingFrame")
    Tabs.Name = "Tabs"
    Tabs.Parent = TabContainer
    Tabs.BackgroundTransparency = 1
    Tabs.Position = UDim2.new(0.013, 0, 0.03, 0)
    Tabs.Size = UDim2.new(0, 150, 0, 420)
    Tabs.CanvasSize = UDim2.new(0, 0, 0, 0)
    Tabs.ScrollBarThickness = 5
    Tabs.ScrollBarImageColor3 = theme3
    Tabs.ZIndex = 10

    local UIGridLayout = Instance.new("UIListLayout")
    UIGridLayout.Parent = Tabs
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIGridLayout.Padding = UDim.new(0, 5)

    local Items = Instance.new("ScrollingFrame")
    Items.Name = "Items"
    Items.Parent = Main
    Items.BackgroundTransparency = 1
    Items.Position = UDim2.new(0.245, 0, 0.03, 0)
    Items.Size = UDim2.new(0, 480, 0, 420)
    Items.CanvasSize = UDim2.new(0, 0, 0, 0)
    Items.ScrollBarThickness = 5
    Items.ScrollBarImageColor3 = theme3
    Items.ZIndex = 10

    local ItemsLayout = Instance.new("UIListLayout")
    ItemsLayout.Parent = Items
    ItemsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ItemsLayout.Padding = UDim.new(0, 10)

    local Footer = Instance.new("Frame")
    Footer.Name = "Footer"
    Footer.Parent = Main
    Footer.BackgroundColor3 = theme1
    Footer.BorderSizePixel = 0
    Footer.Position = UDim2.new(0.013, 0, 0.93, 0)
    Footer.Size = UDim2.new(0, 624, 0, 25)
    Footer.ZIndex = 10
    
    local FooterCorner = Instance.new("UICorner")
    FooterCorner.CornerRadius = UDim.new(0, 6)
    FooterCorner.Parent = Footer
    
    local FooterText = Instance.new("TextLabel")
    FooterText.Parent = Footer
    FooterText.BackgroundTransparency = 1
    FooterText.Size = UDim2.new(1, 0, 1, 0)
    FooterText.Font = Enum.Font.GothamSemibold
    FooterText.Text = "Shaddow UI Library | v1.4 | "..os.date("%d/%m/%Y %H:%M")
    FooterText.TextColor3 = Color3.fromRGB(255, 255, 255)
    FooterText.TextSize = 14
    FooterText.ZIndex = 11

    -- Анимация открытия/закрытия
    local opened = false
    local animating = false
    
    local function toggleWindow()
        if animating then return end
        animating = true
        
        if opened then
            play("rbxassetid://1593371283") -- Звук закрытия
            local closeAnim = tweenService:Create(
                Main,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 650, 0, 0)}
            )
            closeAnim:Play()
            closeAnim.Completed:Connect(function()
                opened = false
                animating = false
                Top.Draggable = false
            end)
            
            local rotateAnim = tweenService:Create(
                Toggle,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Rotation = 0}
            )
            rotateAnim:Play()
        else
            play("rbxassetid://1593371300") -- Звук открытия
            local openAnim = tweenService:Create(
                Main,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 650, 0, 450)}
            )
            openAnim:Play()
            openAnim.Completed:Connect(function()
                opened = true
                animating = false
                Top.Draggable = true
            end)
            
            local rotateAnim = tweenService:Create(
                Toggle,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Rotation = 90}
            )
            rotateAnim:Play()
        end
    end

    Toggle.MouseButton1Click:Connect(toggleWindow)

    -- Улучшенный захват и перетаскивание
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function updateInput(input)
        local delta = input.Position - dragStart
        local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        Top.Position = newPos
    end

    Top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Top.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Top.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging and Top.Draggable then
            updateInput(input)
        end
    end)

    local InsideLibrary = {}

    function InsideLibrary:CreateTab(text)
        local TextButton = Instance.new("TextButton")
        TextButton.Name = text.." Button"
        TextButton.Parent = Tabs
        TextButton.BackgroundColor3 = theme1
        TextButton.BackgroundTransparency = 0
        TextButton.Size = UDim2.new(0, 150, 0, 30)
        TextButton.Font = Enum.Font.GothamSemibold
        TextButton.Text = text
        TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextButton.TextSize = 15
        TextButton.AutoButtonColor = false
        TextButton.ZIndex = 11
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 6)
        ButtonCorner.Parent = TextButton
        
        -- Обновляем размер CanvasSize для Tabs
        Tabs.CanvasSize = UDim2.new(0, 0, 0, UIGridLayout.AbsoluteContentSize.Y + 10)

        local Container = Instance.new("ScrollingFrame")
        Container.Name = text.." Container"
        Container.Parent = Items
        Container.BackgroundTransparency = 1
        Container.Size = UDim2.new(1, 0, 1, 0)
        Container.Visible = false
        Container.CanvasSize = UDim2.new(0, 0, 0, 0)
        Container.ScrollBarThickness = 5
        Container.ScrollBarImageColor3 = theme3
        Container.ZIndex = 10
        
        local ContainerLayout = Instance.new("UIListLayout")
        ContainerLayout.Parent = Container
        ContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContainerLayout.Padding = UDim.new(0, 10)
        
        ContainerLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y + 20)
        end)

        TextButton.MouseButton1Click:Connect(function()
            play("rbxassetid://1412830636")
            
            -- Анимация переключения вкладок
            for i, v in ipairs(Tabs:GetChildren()) do
                if v:IsA("TextButton") then
                    tweenService:Create(
                        v,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = theme1, TextColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                end
            end
            
            tweenService:Create(
                TextButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = theme3, TextColor3 = Color3.fromRGB(255, 255, 255)}
            ):Play()
            
            for i, v in ipairs(Items:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            
            Container.Visible = true
        end)

        local InsideTab = {}

        function InsideTab:CreateToggle(text, callback)
            callback = callback or function() end
            local enabled = false
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Container
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
            ToggleFrame.ZIndex = 11
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Name = "ToggleLabel"
            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Position = UDim2.new(0, 0, 0, 5)
            ToggleLabel.Size = UDim2.new(0, 300, 0, 30)
            ToggleLabel.Font = Enum.Font.GothamSemibold
            ToggleLabel.Text = text
            ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleLabel.TextSize = 15
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.ZIndex = 11
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundColor3 = theme2
            ToggleButton.Position = UDim2.new(1, -50, 0, 5)
            ToggleButton.Size = UDim2.new(0, 50, 0, 30)
            ToggleButton.AutoButtonColor = false
            ToggleButton.Text = ""
            ToggleButton.ZIndex = 11
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(1, 0)
            ToggleCorner.Parent = ToggleButton
            
            local ToggleDot = Instance.new("Frame")
            ToggleDot.Name = "ToggleDot"
            ToggleDot.Parent = ToggleButton
            ToggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleDot.Position = UDim2.new(0, 2, 0.5, -10)
            ToggleDot.Size = UDim2.new(0, 26, 0, 26)
            ToggleDot.ZIndex = 12
            
            local DotCorner = Instance.new("UICorner")
            DotCorner.CornerRadius = UDim.new(1, 0)
            DotCorner.Parent = ToggleDot
            
            local function updateToggle()
                play("rbxassetid://6309164078")
                if enabled then
                    tweenService:Create(
                        ToggleDot,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Position = UDim2.new(0, 22, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                    tweenService:Create(
                        ToggleButton,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = theme3}
                    ):Play()
                else
                    tweenService:Create(
                        ToggleDot,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                    tweenService:Create(
                        ToggleButton,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = theme2}
                    ):Play()
                end
                callback(enabled)
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                enabled = not enabled
                updateToggle()
            end)
            
            local toggleActions = {}
            
            function toggleActions:Set(value)
                enabled = value
                updateToggle()
            end
            
            function toggleActions:Toggle()
                enabled = not enabled
                updateToggle()
            end
            
            return toggleActions
        end

        function InsideTab:CreateSlider(text, minvalue, maxvalue, callback)
            minvalue = minvalue or 0
            maxvalue = maxvalue or 100
            callback = callback or function() end
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = "SliderFrame"
            SliderFrame.Parent = Container
            SliderFrame.BackgroundTransparency = 1
            SliderFrame.Size = UDim2.new(1, 0, 0, 60)
            SliderFrame.ZIndex = 11
            
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Name = "SliderLabel"
            SliderLabel.Parent = SliderFrame
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Position = UDim2.new(0, 0, 0, 5)
            SliderLabel.Size = UDim2.new(0, 300, 0, 20)
            SliderLabel.Font = Enum.Font.GothamSemibold
            SliderLabel.Text = text
            SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderLabel.TextSize = 15
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.ZIndex = 11
            
            local SliderValue = Instance.new("TextLabel")
            SliderValue.Name = "SliderValue"
            SliderValue.Parent = SliderFrame
            SliderValue.BackgroundTransparency = 1
            SliderValue.Position = UDim2.new(1, -100, 0, 5)
            SliderValue.Size = UDim2.new(0, 100, 0, 20)
            SliderValue.Font = Enum.Font.GothamSemibold
            SliderValue.Text = tostring(minvalue)
            SliderValue.TextColor3 = theme3
            SliderValue.TextSize = 15
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right
            SliderValue.ZIndex = 11
            
            local SliderTrack = Instance.new("Frame")
            SliderTrack.Name = "SliderTrack"
            SliderTrack.Parent = SliderFrame
            SliderTrack.BackgroundColor3 = theme2
            SliderTrack.Position = UDim2.new(0, 0, 0, 30)
            SliderTrack.Size = UDim2.new(1, 0, 0, 10)
            SliderTrack.ZIndex = 11
            
            local TrackCorner = Instance.new("UICorner")
            TrackCorner.CornerRadius = UDim.new(1, 0)
            TrackCorner.Parent = SliderTrack
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Name = "SliderFill"
            SliderFill.Parent = SliderTrack
            SliderFill.BackgroundColor3 = theme3
            SliderFill.Size = UDim2.new(0, 0, 1, 0)
            SliderFill.ZIndex = 12
            
            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(1, 0)
            FillCorner.Parent = SliderFill
            
            local SliderButton = Instance.new("TextButton")
            SliderButton.Name = "SliderButton"
            SliderButton.Parent = SliderTrack
            SliderButton.BackgroundTransparency = 1
            SliderButton.Size = UDim2.new(1, 0, 1, 0)
            SliderButton.Text = ""
            SliderButton.ZIndex = 13
            
            local dragging = false
            local currentValue = minvalue
            
            local function updateSlider(input)
                local pos = UDim2.new(
                    math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1),
                    0, 1, 0
                )
                
                SliderFill.Size = pos
                
                local value = math.floor(minvalue + (maxvalue - minvalue) * pos.X.Scale)
                if value ~= currentValue then
                    currentValue = value
                    SliderValue.Text = tostring(currentValue)
                    callback(currentValue)
                end
            end
            
            SliderButton.MouseButton1Down:Connect(function()
                dragging = true
                updateSlider(game:GetService("UserInputService"):GetMouseLocation())
            end)
            
            game:GetService("UserInputService").InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateSlider(input)
                end
            end)
            
            local sliderActions = {}
            
            function sliderActions:Set(value)
                currentValue = math.clamp(value, minvalue, maxvalue)
                SliderValue.Text = tostring(currentValue)
                SliderFill.Size = UDim2.new((currentValue - minvalue) / (maxvalue - minvalue), 0, 1, 0)
                callback(currentValue)
            end
            
            return sliderActions
        end

        function InsideTab:CreateButton(text, callback)
            callback = callback or function() end
            
            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Name = "ButtonFrame"
            ButtonFrame.Parent = Container
            ButtonFrame.BackgroundTransparency = 1
            ButtonFrame.Size = UDim2.new(1, 0, 0, 40)
            ButtonFrame.ZIndex = 11
            
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Parent = ButtonFrame
            Button.BackgroundColor3 = theme2
            Button.Position = UDim2.new(0, 0, 0, 5)
            Button.Size = UDim2.new(1, 0, 0, 30)
            Button.Font = Enum.Font.GothamSemibold
            Button.Text = text
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 15
            Button.AutoButtonColor = false
            Button.ZIndex = 11
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = Button
            
            Button.MouseEnter:Connect(function()
                tweenService:Create(
                    Button,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = theme3}
                ):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                tweenService:Create(
                    Button,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = theme2}
                ):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                play("rbxassetid://178104975")
                tweenService:Create(
                    Button,
                    TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextColor3 = theme1}
                ):Play()
                tweenService:Create(
                    Button,
                    TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1),
                    {BackgroundColor3 = theme3, TextColor3 = Color3.fromRGB(255, 255, 255)}
                ):Play()
                callback()
            end)
        end

        function InsideTab:CreateLabel(text)
            local LabelFrame = Instance.new("Frame")
            LabelFrame.Name = "LabelFrame"
            LabelFrame.Parent = Container
            LabelFrame.BackgroundTransparency = 1
            LabelFrame.Size = UDim2.new(1, 0, 0, 30)
            LabelFrame.ZIndex = 11
            
            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Parent = LabelFrame
            Label.BackgroundTransparency = 1
            Label.Size = UDim2.new(1, 0, 1, 0)
            Label.Font = Enum.Font.GothamSemibold
            Label.Text = text
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 15
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.ZIndex = 11
        end

        function InsideTab:Show()
            for i, v in ipairs(Items:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            Container.Visible = true
            
            for i, v in ipairs(Tabs:GetChildren()) do
                if v:IsA("TextButton") then
                    tweenService:Create(
                        v,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = theme1, TextColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                end
            end
            
            tweenService:Create(
                TextButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = theme3, TextColor3 = Color3.fromRGB(255, 255, 255)}
            ):Play()
        end

        return InsideTab
    end

    -- Автоматически открываем первое окно
    toggleWindow()
    
    return InsideLibrary
end

return library
