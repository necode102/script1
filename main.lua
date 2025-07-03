local library = {}
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Эффект размытия фона
local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 0
blurEffect.Parent = lighting

-- Звуковые эффекты
local sounds = {
    open = "rbxassetid://138080526",  -- Открытие
    close = "rbxassetid://138080539", -- Закрытие
    click = "rbxassetid://138080557", -- Клик
    hover = "rbxassetid://138080573", -- Наведение
    select = "rbxassetid://138080589" -- Выбор
}

local function playSound(id)
    local sound = Instance.new("Sound")
    sound.SoundId = id
    sound.Volume = 0.5
    sound.Parent = workspace
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 2)
end

-- Современные цветовые темы
local themes = {
    Cyberpunk = {
        primary = Color3.fromRGB(138, 43, 226), -- Фиолетовый
        secondary = Color3.fromRGB(25, 25, 35),
        accent = Color3.fromRGB(0, 255, 255),
        text = Color3.fromRGB(255, 255, 255)
    },
    Neon = {
        primary = Color3.fromRGB(0, 255, 170),
        secondary = Color3.fromRGB(15, 15, 25),
        accent = Color3.fromRGB(255, 0, 170),
        text = Color3.fromRGB(240, 240, 240)
    },
    Dark = {
        primary = Color3.fromRGB(220, 20, 60),
        secondary = Color3.fromRGB(20, 20, 30),
        accent = Color3.fromRGB(70, 130, 180),
        text = Color3.fromRGB(230, 230, 230)
    },
    Light = {
        primary = Color3.fromRGB(65, 105, 225),
        secondary = Color3.fromRGB(245, 245, 245),
        accent = Color3.fromRGB(255, 140, 0),
        text = Color3.fromRGB(40, 40, 40)
    }
}

function library:CreateWindow(title, themeName)
    local theme = themes[themeName] or themes.Cyberpunk
    
    -- Удаляем старые окна
    for _, v in ipairs(game.CoreGui:GetChildren()) do
        if v.Name == "ShadowUI" then
            v:Destroy()
        end
    end

    -- Создание главного контейнера
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ShadowUI"
    screenGui.Parent = game.CoreGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

    -- Фоновый эффект
    local background = Instance.new("Frame")
    background.Name = "Background"
    background.BackgroundColor3 = Color3.new(0, 0, 0)
    background.BackgroundTransparency = 0.8
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Visible = false
    background.Parent = screenGui

    -- Главное окно
    local mainWindow = Instance.new("Frame")
    mainWindow.Name = "MainWindow"
    mainWindow.BackgroundColor3 = theme.secondary
    mainWindow.AnchorPoint = Vector2.new(0.5, 0.5)
    mainWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainWindow.Size = UDim2.new(0, 500, 0, 0) -- Начнем с высоты 0
    mainWindow.ClipsDescendants = true
    mainWindow.Parent = screenGui

    -- Закругление углов
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainWindow

    -- Тень
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Image = "rbxassetid://5554236805"
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    shadow.ImageTransparency = 0.5
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.BackgroundTransparency = 1
    shadow.ZIndex = -1
    shadow.Parent = mainWindow

    -- Заголовок
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.BackgroundColor3 = theme.primary
    header.Size = UDim2.new(1, 0, 0, 40)
    header.Parent = mainWindow

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = header

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = theme.text
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header

    -- Кнопка закрытия
    local closeButton = Instance.new("ImageButton")
    closeButton.Name = "CloseButton"
    closeButton.Image = "rbxassetid://3926305904"
    closeButton.ImageRectOffset = Vector2.new(284, 4)
    closeButton.ImageRectSize = Vector2.new(24, 24)
    closeButton.ImageColor3 = theme.text
    closeButton.BackgroundTransparency = 1
    closeButton.Position = UDim2.new(0.9, 0, 0.2, 0)
    closeButton.Size = UDim2.new(0, 25, 0, 25)
    closeButton.Parent = header

    -- Контейнер вкладок
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.BackgroundTransparency = 1
    tabContainer.Size = UDim2.new(1, -30, 0, 40)
    tabContainer.Position = UDim2.new(0, 15, 0, 45)
    tabContainer.Parent = mainWindow

    -- Индикатор активной вкладки
    local tabIndicator = Instance.new("Frame")
    tabIndicator.Name = "TabIndicator"
    tabIndicator.BackgroundColor3 = theme.accent
    tabIndicator.Size = UDim2.new(0, 100, 0, 3)
    tabIndicator.Position = UDim2.new(0, 0, 1, -3)
    tabIndicator.BorderSizePixel = 0
    tabIndicator.ZIndex = 2
    tabIndicator.Parent = tabContainer

    -- Контейнер контента
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "Content"
    contentContainer.BackgroundTransparency = 1
    contentContainer.Size = UDim2.new(1, -30, 1, -90)
    contentContainer.Position = UDim2.new(0, 15, 0, 90)
    contentContainer.ClipsDescendants = true
    contentContainer.Parent = mainWindow

    -- Анимация открытия
    local openTween = tweenService:Create(
        mainWindow,
        TweenInfo.new(0.6, Enum.EasingStyle.Quint),
        {Size = UDim2.new(0, 500, 0, 400)}
    )
    
    local blurTween = tweenService:Create(
        blurEffect,
        TweenInfo.new(0.8),
        {Size = 12}
    )
    
    background.Visible = true
    openTween:Play()
    blurTween:Play()
    playSound(sounds.open)
    
    -- Анимация закрытия
    closeButton.MouseButton1Click:Connect(function()
        playSound(sounds.close)
        local closeTween = tweenService:Create(
            mainWindow,
            TweenInfo.new(0.5, Enum.EasingStyle.Quint),
            {Size = UDim2.new(0, 500, 0, 0)}
        )
        
        local unblurTween = tweenService:Create(
            blurEffect,
            TweenInfo.new(0.6),
            {Size = 0}
        )
        
        closeTween:Play()
        unblurTween:Play()
        
        closeTween.Completed:Wait()
        screenGui:Destroy()
    end)

    -- Эффект перетаскивания
    local dragging
    local dragInput
    local dragStart
    local startPos

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainWindow.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            mainWindow.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    local tabContents = {}
    local tabButtons = {}
    local tabIndex = 1

    local lib = {}

    function lib:CreateTab(name, icon)
        local tabId = #tabButtons + 1
        
        -- Создание кнопки вкладки
        local tabButton = Instance.new("TextButton")
        tabButton.Name = name.."Tab"
        tabButton.Text = name
        tabButton.Font = Enum.Font.GothamMedium
        tabButton.TextSize = 14
        tabButton.TextColor3 = theme.text
        tabButton.BackgroundTransparency = 1
        tabButton.Size = UDim2.new(0, 100, 1, 0)
        tabButton.Position = UDim2.new(0, (#tabButtons * 110), 0, 0)
        tabButton.AutoButtonColor = false
        tabButton.Parent = tabContainer
        
        -- Иконка вкладки
        if icon then
            local iconImage = Instance.new("ImageLabel")
            iconImage.Image = icon
            iconImage.Size = UDim2.new(0, 20, 0, 20)
            iconImage.Position = UDim2.new(0.5, -25, 0.5, -10)
            iconImage.BackgroundTransparency = 1
            iconImage.Parent = tabButton
            
            tabButton.TextXAlignment = Enum.TextXAlignment.Left
            tabButton.PaddingLeft = UDim.new(0, 25)
        end
        
        -- Эффекты при наведении
        tabButton.MouseEnter:Connect(function()
            if tabId ~= tabIndex then
                playSound(sounds.hover)
                tweenService:Create(
                    tabButton,
                    TweenInfo.new(0.2),
                    {TextColor3 = theme.accent}
                ):Play()
            end
        end)
        
        tabButton.MouseLeave:Connect(function()
            if tabId ~= tabIndex then
                tweenService:Create(
                    tabButton,
                    TweenInfo.new(0.2),
                    {TextColor3 = theme.text}
                ):Play()
            end
        end)
        
        -- Создание контента вкладки
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = name.."Content"
        tabContent.BackgroundTransparency = 1
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.Visible = false
        tabContent.ScrollBarImageColor3 = theme.accent
        tabContent.ScrollBarThickness = 4
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        tabContent.Parent = contentContainer
        
        local contentLayout = Instance.new("UIListLayout")
        contentLayout.Padding = UDim.new(0, 15)
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.Parent = tabContent
        
        -- Сохраняем ссылки
        tabContents[tabId] = tabContent
        tabButtons[tabId] = tabButton
        
        -- Обработчик клика
        tabButton.MouseButton1Click:Connect(function()
            playSound(sounds.select)
            tabIndex = tabId
            
            -- Анимация индикатора
            tweenService:Create(
                tabIndicator,
                TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                {Position = UDim2.new(0, tabButton.Position.X.Offset, 1, -3)}
            ):Play()
            
            -- Обновление цвета кнопок
            for i, btn in ipairs(tabButtons) do
                if i == tabId then
                    tweenService:Create(
                        btn,
                        TweenInfo.new(0.2),
                        {TextColor3 = theme.accent}
                    ):Play()
                else
                    tweenService:Create(
                        btn,
                        TweenInfo.new(0.2),
                        {TextColor3 = theme.text}
                    ):Play()
                end
            end
            
            -- Переключение контента
            for i, content in ipairs(tabContents) do
                content.Visible = (i == tabId)
            end
        end)
        
        -- Активируем первую вкладку
        if #tabButtons == 1 then
            tabButton.TextColor3 = theme.accent
            tabContent.Visible = true
        end

        local tabLib = {}
        
        -- Функция создания секции
        function tabLib:CreateSection(title)
            local section = Instance.new("Frame")
            section.Name = "Section"
            section.BackgroundTransparency = 1
            section.Size = UDim2.new(1, 0, 0, 40)
            section.LayoutOrder = #tabContent:GetChildren() + 1
            section.Parent = tabContent
            
            local sectionTitle = Instance.new("TextLabel")
            sectionTitle.Name = "Title"
            sectionTitle.Text = string.upper(title)
            sectionTitle.Font = Enum.Font.GothamBold
            sectionTitle.TextSize = 14
            sectionTitle.TextColor3 = theme.accent
            sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            sectionTitle.BackgroundTransparency = 1
            sectionTitle.Size = UDim2.new(1, 0, 1, 0)
            sectionTitle.Parent = section
            
            local divider = Instance.new("Frame")
            divider.Name = "Divider"
            divider.BackgroundColor3 = theme.primary
            divider.BorderSizePixel = 0
            divider.Size = UDim2.new(1, 0, 0, 1)
            divider.Position = UDim2.new(0, 0, 1, -5)
            divider.Parent = section
            
            return section
        end
        
        -- Функция создания кнопки
        function tabLib:CreateButton(text, callback)
            local button = Instance.new("TextButton")
            button.Name = "Button"
            button.Text = text
            button.Font = Enum.Font.GothamMedium
            button.TextSize = 14
            button.TextColor3 = theme.text
            button.BackgroundColor3 = theme.primary
            button.AutoButtonColor = false
            button.Size = UDim2.new(1, 0, 0, 35)
            button.LayoutOrder = #tabContent:GetChildren() + 1
            button.Parent = tabContent
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = button
            
            -- Анимации кнопки
            button.MouseEnter:Connect(function()
                playSound(sounds.hover)
                tweenService:Create(
                    button,
                    TweenInfo.new(0.2),
                    {BackgroundColor3 = theme.accent}
                ):Play()
            end)
            
            button.MouseLeave:Connect(function()
                tweenService:Create(
                    button,
                    TweenInfo.new(0.2),
                    {BackgroundColor3 = theme.primary}
                ):Play()
            end)
            
            button.MouseButton1Down:Connect(function()
                tweenService:Create(
                    button,
                    TweenInfo.new(0.1),
                    {Size = UDim2.new(0.98, 0, 0, 33)}
                ):Play()
            end)
            
            button.MouseButton1Up:Connect(function()
                tweenService:Create(
                    button,
                    TweenInfo.new(0.1),
                    {Size = UDim2.new(1, 0, 0, 35)}
                ):Play()
            end)
            
            button.MouseButton1Click:Connect(function()
                playSound(sounds.click)
                if callback then callback() end
                
                -- Эффект пульсации
                local ripple = Instance.new("Frame")
                ripple.BackgroundColor3 = Color3.new(1, 1, 1)
                ripple.BackgroundTransparency = 0.8
                ripple.Size = UDim2.new(0, 0, 0, 0)
                ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
                ripple.AnchorPoint = Vector2.new(0.5, 0.5)
                ripple.ZIndex = 2
                ripple.Parent = button
                
                local rippleCorner = Instance.new("UICorner")
                rippleCorner.CornerRadius = UDim.new(1, 0)
                rippleCorner.Parent = ripple
                
                tweenService:Create(
                    ripple,
                    TweenInfo.new(0.6),
                    {
                        Size = UDim2.new(2, 0, 5, 0),
                        BackgroundTransparency = 1
                    }
                ):Play()
                
                game:GetService("Debris"):AddItem(ripple, 0.6)
            end)
            
            return button
        end
        
        -- Функция создания переключателя
        function tabLib:CreateToggle(text, default, callback)
            local toggle = Instance.new("Frame")
            toggle.Name = "Toggle"
            toggle.BackgroundTransparency = 1
            toggle.Size = UDim2.new(1, 0, 0, 30)
            toggle.LayoutOrder = #tabContent:GetChildren() + 1
            toggle.Parent = tabContent
            
            local label = Instance.new("TextLabel")
            label.Name = "Label"
            label.Text = text
            label.Font = Enum.Font.GothamMedium
            label.TextSize = 14
            label.TextColor3 = theme.text
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(0.7, 0, 1, 0)
            label.Parent = toggle
            
            local toggleButton = Instance.new("Frame")
            toggleButton.Name = "ToggleButton"
            toggleButton.BackgroundColor3 = theme.primary
            toggleButton.Size = UDim2.new(0, 50, 0, 25)
            toggleButton.Position = UDim2.new(1, -50, 0.5, -12.5)
            toggleButton.AnchorPoint = Vector2.new(1, 0.5)
            toggleButton.Parent = toggle
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(1, 0)
            toggleCorner.Parent = toggleButton
            
            local toggleDot = Instance.new("Frame")
            toggleDot.Name = "Dot"
            toggleDot.BackgroundColor3 = theme.text
            toggleDot.Size = UDim2.new(0, 19, 0, 19)
            toggleDot.Position = UDim2.new(0, 3, 0.5, -9.5)
            toggleDot.AnchorPoint = Vector2.new(0, 0.5)
            toggleDot.Parent = toggleButton
            
            local dotCorner = Instance.new("UICorner")
            dotCorner.CornerRadius = UDim.new(1, 0)
            dotCorner.Parent = toggleDot
            
            local state = default or false
            
            local function updateToggle()
                if state then
                    tweenService:Create(
                        toggleDot,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                        {Position = UDim2.new(1, -22, 0.5, -9.5)}
                    ):Play()
                    tweenService:Create(
                        toggleButton,
                        TweenInfo.new(0.3),
                        {BackgroundColor3 = theme.accent}
                    ):Play()
                else
                    tweenService:Create(
                        toggleDot,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                        {Position = UDim2.new(0, 3, 0.5, -9.5)}
                    ):Play()
                    tweenService:Create(
                        toggleButton,
                        TweenInfo.new(0.3),
                        {BackgroundColor3 = theme.primary}
                    ):Play()
                end
                
                if callback then callback(state) end
            end
            
            updateToggle()
            
            toggleButton.MouseButton1Click:Connect(function()
                playSound(sounds.click)
                state = not state
                updateToggle()
            end)
            
            return {
                Set = function(_, value)
                    state = value
                    updateToggle()
                end
            }
        end
        
        -- Функция создания слайдера
        function tabLib:CreateSlider(text, min, max, default, callback)
            local slider = Instance.new("Frame")
            slider.Name = "Slider"
            slider.BackgroundTransparency = 1
            slider.Size = UDim2.new(1, 0, 0, 60)
            slider.LayoutOrder = #tabContent:GetChildren() + 1
            slider.Parent = tabContent
            
            local label = Instance.new("TextLabel")
            label.Name = "Label"
            label.Text = text
            label.Font = Enum.Font.GothamMedium
            label.TextSize = 14
            label.TextColor3 = theme.text
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1, 0, 0, 20)
            label.Parent = slider
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Name = "Value"
            valueLabel.Text = tostring(default or min)
            valueLabel.Font = Enum.Font.GothamMedium
            valueLabel.TextSize = 14
            valueLabel.TextColor3 = theme.accent
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right
            valueLabel.BackgroundTransparency = 1
            valueLabel.Size = UDim2.new(1, 0, 0, 20)
            valueLabel.Parent = slider
            
            local track = Instance.new("Frame")
            track.Name = "Track"
            track.BackgroundColor3 = theme.primary
            track.Size = UDim2.new(1, 0, 0, 6)
            track.Position = UDim2.new(0, 0, 0, 35)
            track.Parent = slider
            
            local trackCorner = Instance.new("UICorner")
            trackCorner.CornerRadius = UDim.new(1, 0)
            trackCorner.Parent = track
            
            local fill = Instance.new("Frame")
            fill.Name = "Fill"
            fill.BackgroundColor3 = theme.accent
            fill.Size = UDim2.new(0, 0, 1, 0)
            fill.Parent = track
            
            local fillCorner = Instance.new("UICorner")
            fillCorner.CornerRadius = UDim.new(1, 0)
            fillCorner.Parent = fill
            
            local dot = Instance.new("Frame")
            dot.Name = "Dot"
            dot.BackgroundColor3 = theme.text
            dot.Size = UDim2.new(0, 16, 0, 16)
            dot.Position = UDim2.new(0, -8, 0.5, -8)
            dot.AnchorPoint = Vector2.new(0, 0.5)
            dot.Parent = fill
            
            local dotCorner = Instance.new("UICorner")
            dotCorner.CornerRadius = UDim.new(1, 0)
            dotCorner.Parent = dot
            
            local currentValue = default or min
            local dragging = false
            
            local function updateSlider(value)
                currentValue = math.clamp(value, min, max)
                valueLabel.Text = string.format("%.1f", currentValue)
                local percent = (currentValue - min) / (max - min)
                fill.Size = UDim2.new(percent, 0, 1, 0)
                
                if callback then callback(currentValue) end
            end
            
            updateSlider(currentValue)
            
            local function updateFromMouse()
                local mousePos = game:GetService("UserInputService"):GetMouseLocation()
                local trackPos = track.AbsolutePosition
                local trackSize = track.AbsoluteSize.X
                
                local relativeX = math.clamp(mousePos.X - trackPos.X, 0, trackSize)
                local percent = relativeX / trackSize
                
                updateSlider(min + (max - min) * percent)
            end
            
            track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    updateFromMouse()
                end
            end)
            
            track.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateFromMouse()
                end
            end)
            
            return {
                Set = function(_, value)
                    updateSlider(value)
                end
            }
        end
        
        -- Функция создания выпадающего списка
        function tabLib:CreateDropdown(text, options, callback)
            local dropdown = Instance.new("Frame")
            dropdown.Name = "Dropdown"
            dropdown.BackgroundTransparency = 1
            dropdown.Size = UDim2.new(1, 0, 0, 40)
            dropdown.LayoutOrder = #tabContent:GetChildren() + 1
            dropdown.Parent = tabContent
            
            local label = Instance.new("TextLabel")
            label.Name = "Label"
            label.Text = text
            label.Font = Enum.Font.GothamMedium
            label.TextSize = 14
            label.TextColor3 = theme.text
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(0.5, 0, 1, 0)
            label.Parent = dropdown
            
            local button = Instance.new("TextButton")
            button.Name = "Button"
            button.Text = "Select..."
            button.Font = Enum.Font.GothamMedium
            button.TextSize = 14
            button.TextColor3 = theme.text
            button.BackgroundColor3 = theme.primary
            button.AutoButtonColor = false
            button.Size = UDim2.new(0.5, 0, 0, 35)
            button.Position = UDim2.new(0.5, 0, 0, 0)
            button.Parent = dropdown
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 8)
            buttonCorner.Parent = button
            
            local arrow = Instance.new("ImageLabel")
            arrow.Name = "Arrow"
            arrow.Image = "rbxassetid://3926305904"
            arrow.ImageRectOffset = Vector2.new(884, 4)
            arrow.ImageRectSize = Vector2.new(24, 24)
            arrow.ImageColor3 = theme.text
            arrow.Size = UDim2.new(0, 20, 0, 20)
            arrow.Position = UDim2.new(1, -25, 0.5, -10)
            arrow.AnchorPoint = Vector2.new(1, 0.5)
            arrow.BackgroundTransparency = 1
            arrow.Parent = button
            
            local dropdownContent = Instance.new("Frame")
            dropdownContent.Name = "DropdownContent"
            dropdownContent.BackgroundColor3 = theme.secondary
            dropdownContent.Size = UDim2.new(0.5, 0, 0, 0)
            dropdownContent.Position = UDim2.new(0.5, 0, 1, 5)
            dropdownContent.Visible = false
            dropdownContent.ClipsDescendants = true
            dropdownContent.Parent = dropdown
            
            local contentCorner = Instance.new("UICorner")
            contentCorner.CornerRadius = UDim.new(0, 8)
            contentCorner.Parent = dropdownContent
            
            local contentLayout = Instance.new("UIListLayout")
            contentLayout.Padding = UDim.new(0, 5)
            contentLayout.Parent = dropdownContent
            
            local contentPadding = Instance.new("UIPadding")
            contentPadding.PaddingTop = UDim.new(0, 5)
            contentPadding.PaddingBottom = UDim.new(0, 5)
            contentPadding.Parent = dropdownContent
            
            -- Создание элементов списка
            for i, option in ipairs(options) do
                local optionButton = Instance.new("TextButton")
                optionButton.Name = option
                optionButton.Text = option
                optionButton.Font = Enum.Font.GothamMedium
                optionButton.TextSize = 14
                optionButton.TextColor3 = theme.text
                optionButton.BackgroundTransparency = 1
                optionButton.Size = UDim2.new(1, -10, 0, 30)
                optionButton.Position = UDim2.new(0, 5, 0, 0)
                optionButton.AutoButtonColor = false
                optionButton.Parent = dropdownContent
                
                optionButton.MouseEnter:Connect(function()
                    tweenService:Create(
                        optionButton,
                        TweenInfo.new(0.2),
                        {BackgroundColor3 = theme.primary}
                    ):Play()
                end)
                
                optionButton.MouseLeave:Connect(function()
                    tweenService:Create(
                        optionButton,
                        TweenInfo.new(0.2),
                        {BackgroundColor3 = Color3.new()}
                    ):Play()
                end)
                
                optionButton.MouseButton1Click:Connect(function()
                    playSound(sounds.select)
                    button.Text = option
                    dropdownContent.Visible = false
                    if callback then callback(option) end
                end)
            end
            
            -- Обновление размера контента
            contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                dropdownContent.Size = UDim2.new(0.5, 0, 0, contentLayout.AbsoluteContentSize.Y + 10)
            end)
            
            -- Переключение видимости
            button.MouseButton1Click:Connect(function()
                playSound(sounds.click)
                dropdownContent.Visible = not dropdownContent.Visible
                
                if dropdownContent.Visible then
                    tweenService:Create(
                        arrow,
                        TweenInfo.new(0.3),
                        {Rotation = 180}
                    ):Play()
                else
                    tweenService:Create(
                        arrow,
                        TweenInfo.new(0.3),
                        {Rotation = 0}
                    ):Play()
                end
            end)
            
            return {
                Set = function(_, value)
                    button.Text = value
                    if callback then callback(value) end
                end
            }
        end
        
        return tabLib
    end
    
    return lib
end

return library
