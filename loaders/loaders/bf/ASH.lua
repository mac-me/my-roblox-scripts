-- =================================================================
-- AUTOSYNC HUB (ASH) - ULTIMATE CUSTOM FULL EDITION v4
-- THEME: PREMIUM MINT - RED - BLACK (MAXIMUM DETAILED CONTROLS)
-- =================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = lp:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [ASSET ID] โลโก้ ASH สไตล์อักษรไขว้ มิ้นต์-แดง-ดำ ของคุณ
local LOGO_ASSET_ID = "rbxassetid://138379471192994" 

-- ตัวแปรควบคุมระบบ Backend
local LastDeathPosition = nil
local HasPrompted = false
local infJumpEnabled = false
local AimbotEnabled = false
local AutoClickEnabled = false
local EspEnabled = false
local flyEnabled = false
local flySpeed = 50

-- =================================================================
-- 1. สร้างปุ่มย่อไอคอนลอยทรงจัตุรัส (Draggable Logo Toggle)
-- =================================================================
local IconButton = Instance.new("ImageButton")
local IconCorner = Instance.new("UICorner")
local IconStroke = Instance.new("UIStroke")

IconButton.Name = "ASH_ToggleIcon"
IconButton.Parent = ScreenGui
IconButton.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
IconButton.Position = UDim2.new(0.02, 0, 0.2, 0)
IconButton.Size = UDim2.new(0, 55, 0, 55)
IconButton.Image = LOGO_ASSET_ID
IconButton.Visible = false
IconButton.Active = true

IconCorner.CornerRadius = UDim.new(0, 12)
IconCorner.Parent = IconButton
IconStroke.Color = Color3.fromRGB(0, 255, 170)
IconStroke.Thickness = 2
IconStroke.Parent = IconButton

-- ระบบเลื่อนปุ่มอิสระ (Draggable Icon)
local draggingIcon, dragInputIcon, dragStartIcon, startPosIcon
IconButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingIcon = true
        dragStartIcon = input.Position
        startPosIcon = IconButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then draggingIcon = false end
        end)
    end
end)
IconButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputIcon = input
    end
end)
RunService.RenderStepped:Connect(function()
    if draggingIcon and dragInputIcon then
        local delta = dragInputIcon.Position - dragStartIcon
        IconButton.Position = UDim2.new(startPosIcon.X.Scale, startPosIcon.X.Offset + delta.X, startPosIcon.Y.Scale, startPosIcon.Y.Offset + delta.Y)
    end
end)

-- =================================================================
-- 2. สร้างหน้าต่างหลักขนาดใหญ่ (Large Rectangle Window)
-- =================================================================
local MainFrame = Instance.new("Frame")
local MainCorner = Instance.new("UICorner")
local MainStroke = Instance.new("UIStroke")
local TopBar = Instance.new("Frame")
local TopCorner = Instance.new("UICorner")
local LogoImg = Instance.new("ImageLabel")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")

MainFrame.Name = "AutoSyncMainLarge"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
MainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 780, 0, 520) -- แผ่นสี่เหลี่ยมผืนผ้าขนาดใหญ่สะใจ
MainFrame.Active = true

MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame
MainStroke.Color = Color3.fromRGB(220, 40, 60)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- แถบหัวข้อบนลากย้ายหน้าต่างได้ (Draggable MainFrame via TopBar)
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
TopBar.Size = UDim2.new(1, 0, 0, 55)
TopCorner.CornerRadius = UDim.new(0, 14)
TopCorner.Parent = TopBar

local draggingMain, dragInputMain, dragStartMain, startPosMain
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingMain = true
        dragStartMain = input.Position
        startPosMain = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then draggingMain = false end
        end)
    end
end)
TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputMain = input
    end
end)
RunService.RenderStepped:Connect(function()
    if draggingMain and dragInputMain then
        local delta = dragInputMain.Position - dragStartMain
        MainFrame.Position = UDim2.new(startPosMain.X.Scale, startPosMain.X.Offset + delta.X, startPosMain.Y.Scale, startPosMain.Y.Offset + delta.Y)
    end
end)

LogoImg.Parent = TopBar
LogoImg.BackgroundTransparency = 1
LogoImg.Position = UDim2.new(0, 15, 0, 7)
LogoImg.Size = UDim2.new(0, 40, 0, 40)
LogoImg.Image = LOGO_ASSET_ID

Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 68, 0, 0)
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "AUTOSYNC HUB - PREMIUM ULTIMATE SUITE"
Title.TextColor3 = Color3.fromRGB(0, 255, 170)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseBtn.Parent = TopBar
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -45, 0, 12)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(220, 40, 60)
CloseBtn.TextSize = 20

-- ระบบสลับหน้าแท็บภายในพื้นที่ขนาดใหญ่ (Sidebar Layout)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Sidebar.Position = UDim2.new(0, 0, 0, 55)
Sidebar.Size = UDim2.new(0, 180, 1, -55)

local ContainerFrame = Instance.new("Frame")
ContainerFrame.Name = "ContainerFrame"
ContainerFrame.Parent = MainFrame
ContainerFrame.BackgroundTransparency = 1
ContainerFrame.Position = UDim2.new(0, 195, 0, 70)
ContainerFrame.Size = UDim2.new(1, -210, 1, -85)

local SideList = Instance.new("UIListLayout")
SideList.Parent = Sidebar
SideList.Padding = UDim.new(0, 5)
SideList.SortOrder = Enum.SortOrder.LayoutOrder

local tabPages = {}
local currentActiveTab = nil

local function AddTab(name, order)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 42)
    TabBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    TabBtn.BackgroundTransparency = 1
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.Text = "  " .. name
    TabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    TabBtn.TextSize = 13
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.LayoutOrder = order
    TabBtn.Parent = Sidebar
    
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 170)
    Page.CanvasSize = UDim2.new(0, 0, 0, 800)
    Page.Parent = ContainerFrame
    
    local PageList = Instance.new("UIListLayout")
    PageList.Parent = Page
    PageList.Padding = UDim.new(0, 12)
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    
    tabPages[name] = {Button = TabBtn, Scroll = Page}
    
    TabBtn.MouseButton1Click:Connect(function()
        for tName, tData in pairs(tabPages) do
            if tName == name then
                currentActiveTab = name
                tData.Scroll.Visible = true
                tData.Button.TextColor3 = Color3.fromRGB(0, 255, 170)
                tData.Button.BackgroundTransparency = 0
                tData.Button.BackgroundColor3 = Color3.fromRGB(26, 40, 36)
            else
                tData.Scroll.Visible = false
                tData.Button.TextColor3 = Color3.fromRGB(180, 180, 180)
                tData.Button.BackgroundTransparency = 1
            end
        end
    end)
    return Page
end

-- สร้าง 4 แท็บเมนูหลัก
local PagePlayer = AddTab("Player Physical", 1)
local PageCombat = AddTab("Combat & Aim", 2)
local PageVisuals = AddTab("Visuals & World", 3)
local PageDeveloper = AddTab("Developer Tools", 4)

-- เซ็ตเริ่มต้นหน้าแรก
tabPages["Player Physical"].Scroll.Visible = true
tabPages["Player Physical"].Button.TextColor3 = Color3.fromRGB(0, 255, 170)
tabPages["Player Physical"].Button.BackgroundTransparency = 0
tabPages["Player Physical"].Button.BackgroundColor3 = Color3.fromRGB(26, 40, 36)

-- =================================================================
-- 3. ส่วนประกอบ UI Elements ปรับระดับละเอียด (Detailed Controllers)
-- =================================================================
local function CreateDetailToggle(parent, text, default, callback)
    local Frame = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local Btn = Instance.new("TextButton")
    local Corner = Instance.new("UICorner")
    local Indicator = Instance.new("Frame")
    
    Frame.Size = UDim2.new(0.98, 0, 0, 46)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    Frame.Parent = parent
    local fCorner = Instance.new("UICorner") ; fCorner.CornerRadius = UDim.new(0, 6) ; fCorner.Parent = Frame
    
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    Btn.Size = UDim2.new(0, 48, 0, 24)
    Btn.Position = UDim2.new(1, -62, 0, 11)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Btn.Text = ""
    Btn.Parent = Frame
    Corner.CornerRadius = UDim.new(1, 0) ; Corner.Parent = Btn
    
    Indicator.Size = UDim2.new(0, 18, 0, 18)
    Indicator.Position = default and UDim2.new(1, -22, 0, 3) or UDim2.new(0, 4, 0, 3)
    Indicator.BackgroundColor3 = default and Color3.fromRGB(0, 255, 170) or Color3.fromRGB(130, 130, 130)
    Indicator.Parent = Btn
    local iCorner = Instance.new("UICorner") ; iCorner.CornerRadius = UDim.new(1, 0) ; iCorner.Parent = Indicator
    
    local enabled = default
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        local targetPos = enabled and UDim2.new(1, -22, 0, 3) or UDim2.new(0, 4, 0, 3)
        local targetColor = enabled and Color3.fromRGB(0, 255, 170) or Color3.fromRGB(130, 130, 130)
        TweenService:Create(Indicator, TweenInfo.new(0.15), {Position = targetPos, BackgroundColor3 = targetColor}):Play()
        task.spawn(callback, enabled)
    end)
end

local function CreateDetailSlider(parent, text, min, max, default, callback)
    local Frame = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local ValueLabel = Instance.new("TextLabel")
    local Bar = Instance.new("Frame")
    local Fill = Instance.new("Frame")
    local Trigger = Instance.new("TextButton")
    
    Frame.Size = UDim2.new(0.98, 0, 0, 52)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    Frame.Parent = parent
    local fCorner = Instance.new("UICorner") ; fCorner.CornerRadius = UDim.new(0, 6) ; fCorner.Parent = Frame
    
    Label.Size = UDim2.new(0.6, 0, 0, 22)
    Label.Position = UDim2.new(0, 12, 0, 4)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    ValueLabel.Size = UDim2.new(0.3, 0, 0, 22)
    ValueLabel.Position = UDim2.new(1, -112, 0, 4)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
    ValueLabel.TextSize = 13
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = Frame
    
    Bar.Size = UDim2.new(1, -24, 0, 5)
    Bar.Position = UDim2.new(0, 12, 0, 34)
    Bar.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    Bar.Parent = Frame
    local bCorner = Instance.new("UICorner") ; bCorner.CornerRadius = UDim.new(1, 0) ; bCorner.Parent = Bar
    
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(220, 40, 60)
    Fill.Parent = Bar
    local fiCorner = Instance.new("UICorner") ; fiCorner.CornerRadius = UDim.new(1, 0) ; fiCorner.Parent = Fill
    
    Trigger.Size = UDim2.new(1, 0, 1, 0)
    Trigger.BackgroundTransparency = 1
    Trigger.Text = ""
    Trigger.Parent = Bar
    
    local dragging = false
    local function update(input)
        local pos = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        local val = math.floor(min + (pos * (max - min)))
        ValueLabel.Text = tostring(val)
        task.spawn(callback, val)
    end
    Trigger.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; update(input) end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then update(input) end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

local function CreateDetailButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.98, 0, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Btn.Font = Enum.Font.GothamBold
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 13
    Btn.Parent = parent
    local bC = Instance.new("UICorner") ; bC.CornerRadius = UDim.new(0, 6) ; bC.Parent = Btn
    
    Btn.MouseEnter:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 40, 60)}):Play() end)
    Btn.MouseLeave:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}):Play() end)
    Btn.MouseButton1Click:Connect(function() task.spawn(callback) end)
end

-- =================================================================
-- 4. บรรจุฟังก์ชันการทำงานแยกตามหมวดหมู่อย่างละเอียด (Detailed Backend Execution)
-- =================================================================

-- [TAB 1: PLAYER PHYSICAL - ปรับแต่งกายภาพตัวละครละเอียดมาก]
CreateDetailSlider(PagePlayer, "WalkSpeed (ความเร็วขั้นละเอียด)", 16, 500, 16, function(v)
    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = v
    end
end)

CreateDetailSlider(PagePlayer, "JumpPower (แรงกระโดดขั้นละเอียด)", 50, 500, 50, function(v)
    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid").UseJumpPower = true
        lp.Character:FindFirstChildOfClass("Humanoid").JumpPower = v
    end
end)

CreateDetailSlider(PagePlayer, "HipHeight Modifier (ปรับความสูงช่วงสะโพก)", 0, 50, 0, function(v)
    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid").HipHeight = v
    end
end)

CreateDetailToggle(PagePlayer, "Infinite Jump (กระโดดรัวๆ กลางอากาศ)", false, function(state)
    infJumpEnabled = state
end)
UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

CreateDetailToggle(PagePlayer, "Fly Mode (โหมดบินอิสระ)", false, function(state)
    flyEnabled = state
    if state then
        task.spawn(function()
            local torso = lp.Character:WaitForChild("HumanoidRootPart")
            local bv = Instance.new("BodyVelocity", torso)
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            while flyEnabled and lp.Character and torso do
                local cam = workspace.CurrentCamera.CFrame
                local move = Vector3.new(0,0,0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.RightVector end
                bv.Velocity = move * flySpeed
                task.wait()
            end
            bv:Destroy()
        end)
    end
end)
CreateDetailSlider(PagePlayer, "Fly Speed Control (ระดับความเร็วการบิน)", 10, 300, 50, function(v)
    flySpeed = v
end)

-- [TAB 2: COMBAT & AIM - โหมดล็อกเป้า ยิงออโต้ อมตะ บายพาสชีท]
CreateDetailToggle(PageCombat, "Enable Aimbot (ล็อกเป้าผู้เล่นใกล้สุดอัตโนมัติ)", false, function(s) AimbotEnabled = s end)
task.spawn(function()
    while task.wait() do
        if AimbotEnabled then
            pcall(function()
                local target, shortDist = nil, math.huge
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local d = (v.Character.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).Magnitude
                        if d < shortDist then target = v; shortDist = d end
                    end
                end
                if target then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.HumanoidRootPart.Position) end
            end)
        end
    end
end)

CreateDetailToggle(PageCombat, "Auto Fire / Fast Clicker (ระบบคลิก-ยิงรัวความถี่สูง)", false, function(s) AutoClickEnabled = s end)
task.spawn(function()
    while task.wait(0.04) do
        if AutoClickEnabled then
            pcall(function()
                local vim = game:GetService("VirtualInputManager")
                vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                task.wait(0.01)
                vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end)
        end
    end
end)

local GodModeEnabled = false
CreateDetailToggle(PageCombat, "Server-Side God Mode Bypass (ระบบเลือดไม่จำกัดอมตะ)", false, function(state)
    GodModeEnabled = state
    if state then
        task.spawn(function()
            while GodModeEnabled do
                pcall(function()
                    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
                        local hum = lp.Character:FindFirstChildOfClass("Humanoid")
                        hum.MaxHealth = math.huge
                        hum.Health = math.huge
                        hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                    end
                end)
                task.wait(0.1)
            end
        end)
    else
        if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
            local hum = lp.Character:FindFirstChildOfClass("Humanoid")
            hum.MaxHealth = 100
            hum.Health = 100
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        end
    end
end)

CreateDetailToggle(PageCombat, "Anti-Cheat Bypass Core (บายพาสข้ามระบบตรวจจับ)", false, function(state)
    if state then
        local mt = getrawmetatable(game)
        if setreadonly then setreadonly(mt, false) end
        local old = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if tostring(method) == "Kick" or tostring(method) == "kick" or tostring(self):lower():find("cheat") then
                return nil
            end
            return old(self, ...)
        end)
        if setreadonly then setreadonly(mt, true) end
    end
end)

-- [TAB 3: VISUALS & WORLD - ระบบส่องทะลุ ล่องหน ปรับสภาพแวดล้อม]
CreateDetailToggle(PageVisuals, "Player ESP Box (มองเห็นผู้เล่นทะลุกำแพง)", false, function(s)
    EspEnabled = s
    if not s then
        for _, v in pairs(Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("ASH_ESP") then v.Character.ASH_ESP:Destroy() end
        end
    end
end)
task.spawn(function()
    while task.wait(1) do
        if EspEnabled then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= lp and v.Character and not v.Character:FindFirstChild("ASH_ESP") then
                    local h = Instance.new("Highlight")
                    h.Name = "ASH_ESP"
                    h.FillColor = Color3.fromRGB(0, 255, 170)
                    h.OutlineColor = Color3.fromRGB(220, 40, 60)
                    h.Parent = v.Character
                end
            end
        end
    end
end)

CreateDetailButton(PageVisuals, "Scan All Objects & Mobs (แสดงพิกัดม็อบและของทั้งหมด)", function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj:FindFirstChild("Humanoid") or obj.Name:lower():find("mob") or obj.Name:lower():find("item")) then
            if not obj:FindFirstChild("ASH_ESP") then
                local h = Instance.new("Highlight")
                h.Name = "ASH_ESP"
                h.FillColor = Color3.fromRGB(220, 40, 60)
                h.Parent = obj
            end
        end
    end
end)

local absoluteInvis = false
local storedCharacterParts = {}
CreateDetailToggle(PageVisuals, "Absolute Invisibility (ล่องหนขั้นสุดลบทุกอย่าง)", false, function(state)
    absoluteInvis = state
    if state then
        if lp.Character then
            for _, part in pairs(lp.Character:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("Clothing") or part:IsA("Accessory") then
                    table.insert(storedCharacterParts, {Part = part, OldParent = part.Parent})
                    part.Parent = nil
                end
            end
        end
    else
        for _, info in pairs(storedCharacterParts) do
            if info.Part then info.Part.Parent = info.OldParent end
        end
        storedCharacterParts = {}
    end
end)

CreateDetailSlider(PageVisuals, "Map Gravity (แรงโน้มถ่วงสภาพแมพ)", 0, 196, 196, function(v) workspace.Gravity = v end)
CreateDetailButton(PageVisuals, "FullBright / Clear Fog (ปรับสภาพแสงสว่างลบหมอก)", function()
    local lt = game:GetService("Lighting")
    lt.Brightness = 3
    lt.ClockTime = 14
    lt.FogEnd = 999999
    lt.GlobalShadows = false
end)

-- [TAB 4: DEVELOPER TOOLS - รันสด แกะโค้ด ดักฟังฟังก์ชัน]
local TextboxCode = Instance.new("TextBox")
TextboxCode.Size = UDim2.new(0.98, 0, 0, 170)
TextboxCode.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
TextboxCode.Font = Enum.Font.Code
TextboxCode.MultiLine = true
TextboxCode.ClearTextOnFocus = false
TextboxCode.Text = "-- ป้อนสคริปต์ภาษา Lua สดเพื่อรันภายใน AutoSync Hub"
TextboxCode.TextColor3 = Color3.fromRGB(240, 240, 240)
TextboxCode.TextSize = 12
TextboxCode.TextXAlignment = Enum.TextXAlignment.Left
TextboxCode.TextYAlignment = Enum.TextYAlignment.Top
TextboxCode.Parent = PageDeveloper
local tC = Instance.new("UICorner") ; tC.CornerRadius = UDim.new(0, 6) ; tC.Parent = TextboxCode

CreateDetailButton(PageDeveloper, "EXECUTE LUA LIVE CODE", function()
    local code = TextboxCode.Text
    if loadstring then pcall(loadstring(code)) else warn("คำสั่ง loadstring ถูกบล็อกโดย Executor") end
end)
CreateDetailButton(PageDeveloper, "Run Dark Dex Explorer (แกะส่องไฟล์ตัวเต็ม)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
end)
CreateDetailButton(PageDeveloper, "Run Hydroxide Remote Spy (ดักฟังฟังก์ชันคำสั่งแมพ)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/hydroxide.lua"))()
end)

-- =================================================================
-- 5. ระบบบันทึกพิกัดจุดตาย และกล่อง Pop-up ยืนยันถามก่อนวาร์ปกลับ
-- =================================================================
local TeleportPromptFrame = Instance.new("Frame")
local PromptCorner = Instance.new("UICorner")
local PromptTitle = Instance.new("TextLabel")
local YesBtn = Instance.new("TextButton")
local NoBtn = Instance.new("TextButton")

TeleportPromptFrame.Name = "ASH_Prompt"
TeleportPromptFrame.Parent = ScreenGui
TeleportPromptFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
TeleportPromptFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
TeleportPromptFrame.Size = UDim2.new(0, 320, 0, 130)
TeleportPromptFrame.Visible = false
TeleportPromptFrame.ZIndex = 20

PromptCorner.CornerRadius = UDim.new(0, 12) ; PromptCorner.Parent = TeleportPromptFrame
local pStroke = Instance.new("UIStroke") ; pStroke.Color = Color3.fromRGB(0, 255, 170) ; pStroke.Thickness = 1.5 ; pStroke.Parent = TeleportPromptFrame

PromptTitle.Parent = TeleportPromptFrame
PromptTitle.BackgroundTransparency = 1
PromptTitle.Size = UDim2.new(1, 0, 0, 60)
PromptTitle.Font = Enum.Font.GothamSemibold
PromptTitle.Text = "ตรวจพบจุดตายล่าสุด!
คุณต้องการเกิดและวาร์ปกลับไปตรงนั้นไหม?"
PromptTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
PromptTitle.TextSize = 13

YesBtn.Parent = TeleportPromptFrame
YesBtn.BackgroundColor3 = Color3.fromRGB(16, 48, 38)
YesBtn.Position = UDim2.new(0, 20, 0, 75)
YesBtn.Size = UDim2.new(0, 120, 0, 35)
YesBtn.Font = Enum.Font.GothamBold
YesBtn.Text = "ใช่ วาร์ปเลย"
YesBtn.TextColor3 = Color3.fromRGB(0, 255, 170)
local yC = Instance.new("UICorner") ; yC.CornerRadius = UDim.new(0,6) ; yC.Parent = YesBtn

NoBtn.Parent = TeleportPromptFrame
NoBtn.BackgroundColor3 = Color3.fromRGB(48, 20, 24)
NoBtn.Position = UDim2.new(1, -140, 0, 75)
NoBtn.Size = UDim2.new(0, 120, 0, 35)
NoBtn.Font = Enum.Font.GothamBold
NoBtn.Text = "ไม่ ขอบคุณ"
NoBtn.TextColor3 = Color3.fromRGB(220, 40, 60)
local nC = Instance.new("UICorner") ; nC.CornerRadius = UDim.new(0,6) ; nC.Parent = NoBtn

task.spawn(function()
    while task.wait(0.4) do
        pcall(function()
            if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
                local hum = lp.Character:FindFirstChildOfClass("Humanoid")
                hum.Died:Connect(function()
                    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and not HasPrompted then
                        LastDeathPosition = lp.Character.HumanoidRootPart.CFrame
                        HasPrompted = true
                    end
                end)
            end
            if HasPrompted and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and LastDeathPosition then
                task.wait(0.6)
                TeleportPromptFrame.Visible = true
                HasPrompted = false
            end
        end)
    end
end)

YesBtn.MouseButton1Click:Connect(function()
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and LastDeathPosition then
        lp.Character.HumanoidRootPart.CFrame = LastDeathPosition
    end
    TeleportPromptFrame.Visible = false
    LastDeathPosition = nil
end)

NoBtn.MouseButton1Click:Connect(function()
    TeleportPromptFrame.Visible = false
    LastDeathPosition = nil
end)

-- =================================================================
-- 6. ระบบสลับอินเตอร์เฟซและย่อหน้าต่าง (Interface Minimization)
-- =================================================================
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconButton.Visible = true
end)

IconButton.MouseButton1Click:Connect(function()
    IconButton.Visible = false
    MainFrame.Visible = true
end)
