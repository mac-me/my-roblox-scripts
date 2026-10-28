-- =================================================================
-- AUTOSYNC HUB (ASH) - FIXED ULTIMATE RECTANGLE EDITION
-- ERROR BYPASS & STABLE VERSION (MINT - RED - BLACK)
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

-- [ASSET ID] โลโก้ ASH ของคุณจากรูปภาพ
local LOGO_ASSET_ID = "rbxassetid://138379471192994" 

local LastDeathPosition = nil
local HasPrompted = false

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
IconStroke.Color = Color3.fromRGB(0, 255, 170) -- มิ้นต์
IconStroke.Thickness = 2
IconStroke.Parent = IconButton

-- ทำให้ปุ่มไอคอนลอยสามารถลากขยับได้
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
MainFrame.Size = UDim2.new(0, 750, 0, 480) -- แผ่นสี่เหลี่ยมผืนผ้าขนาดใหญ่
MainFrame.Active = true

MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame
MainStroke.Color = Color3.fromRGB(220, 40, 60) -- แดง
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- ทำให้หน้าต่างหลักลากเลื่อนได้
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

-- แถบหัวข้อด้านบน (TopBar)
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
TopBar.Size = UDim2.new(1, 0, 0, 55)
TopCorner.CornerRadius = UDim.new(0, 14)
TopCorner.Parent = TopBar

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
Title.Text = "AUTOSYNC HUB"
Title.TextColor3 = Color3.fromRGB(0, 255, 170) -- มิ้นต์
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseBtn.Parent = TopBar
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -45, 0, 12)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(220, 40, 60) -- แดง
CloseBtn.TextSize = 20

-- Content Area
local ContentScroll = Instance.new("ScrollingFrame")
local ContentList = Instance.new("UIListLayout")
ContentScroll.Parent = MainFrame
ContentScroll.BackgroundTransparency = 1
ContentScroll.Position = UDim2.new(0, 20, 0, 75)
ContentScroll.Size = UDim2.new(1, -40, 1, -95)
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 720)
ContentScroll.ScrollBarThickness = 4
ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 170)

ContentList.Parent = ContentScroll
ContentList.SortOrder = Enum.SortOrder.LayoutOrder
ContentList.Padding = UDim.new(0, 15)

-- =================================================================
-- 3. ฟังก์ชันการสร้าง UI Elements แบบระวัง Error
-- =================================================================
local function CreateLargeToggle(text, default, callback)
    local Frame = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local Btn = Instance.new("TextButton")
    local Corner = Instance.new("UICorner")
    local Indicator = Instance.new("Frame")
    
    Frame.Size = UDim2.new(0.98, 0, 0, 48)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    Frame.Parent = ContentScroll
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 8)
    fCorner.Parent = Frame
    
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    Btn.Size = UDim2.new(0, 52, 0, 26)
    Btn.Position = UDim2.new(1, -67, 0, 11)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Btn.Text = ""
    Btn.Parent = Frame
    Corner.CornerRadius = UDim.new(1, 0)
    Corner.Parent = Btn
    
    Indicator.Size = UDim2.new(0, 20, 0, 20)
    Indicator.Position = default and UDim2.new(1, -24, 0, 3) or UDim2.new(0, 4, 0, 3)
    Indicator.BackgroundColor3 = default and Color3.fromRGB(0, 255, 170) or Color3.fromRGB(130, 130, 130)
    Indicator.Parent = Btn
    local iCorner = Instance.new("UICorner")
    iCorner.CornerRadius = UDim.new(1, 0)
    iCorner.Parent = Indicator
    
    local enabled = default
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        local targetPos = enabled and UDim2.new(1, -24, 0, 3) or UDim2.new(0, 4, 0, 3)
        local targetColor = enabled and Color3.fromRGB(0, 255, 170) or Color3.fromRGB(130, 130, 130)
        TweenService:Create(Indicator, TweenInfo.new(0.2), {Position = targetPos, BackgroundColor3 = targetColor}):Play()
        
        -- ใช้ pcall เพื่อป้องกันโค้ดค้างหากฟังก์ชันด้านในรันไม่ได้
        pcall(callback, enabled)
    end)
end

local function CreateLargeSlider(text, min, max, default, callback)
    local Frame = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local ValueLabel = Instance.new("TextLabel")
    local Bar = Instance.new("Frame")
    local Fill = Instance.new("Frame")
    local Trigger = Instance.new("TextButton")
    
    Frame.Size = UDim2.new(0.98, 0, 0, 55)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    Frame.Parent = ContentScroll
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 8)
    fCorner.Parent = Frame
    
    Label.Size = UDim2.new(0.5, 0, 0, 25)
    Label.Position = UDim2.new(0, 15, 0, 4)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    ValueLabel.Size = UDim2.new(0.4, 0, 0, 25)
    ValueLabel.Position = UDim2.new(1, -115, 0, 4)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
    ValueLabel.TextSize = 14
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = Frame
    
    Bar.Size = UDim2.new(1, -30, 0, 6)
    Bar.Position = UDim2.new(0, 15, 0, 36)
    Bar.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    Bar.Parent = Frame
    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(1, 0)
    bCorner.Parent = Bar
    
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(220, 40, 60) -- แดง
    Fill.Parent = Bar
    local fiCorner = Instance.new("UICorner")
    fiCorner.CornerRadius = UDim.new(1, 0)
    fiCorner.Parent = Fill
    
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
        pcall(callback, val)
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

-- =================================================================
-- 4. บรรจุระบบฟังก์ชัน (เพิ่มระบบดักจับ ป้องกันการขึ้น Nil)
-- =================================================================

-- ปรับระดับความเร็วการวิ่งอย่างละเอียด
CreateLargeSlider("WalkSpeed Control (ความเร็วการวิ่ง)", 16, 250, 16, function(value)
    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = value
    end
end)

-- ปรับระดับแรงกระโดดอย่างละเอียด
CreateLargeSlider("JumpPower Control (แรงกระโดด)", 50, 300, 50, function(value)
    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid").UseJumpPower = true
        lp.Character:FindFirstChildOfClass("Humanoid").JumpPower = value
    end
end)

-- ปรับระยะความสูงช่วงสะโพก (ตัวลอย)
CreateLargeSlider("HipHeight Control (ปรับตัวลอยข้ามสิ่งกีดขวาง)", 0, 50, 0, function(value)
    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid").HipHeight = value
    end
end)

-- ระบบกระโดดรัวกลางอากาศ
local infJumpEnabled = false
CreateLargeToggle("Infinite Jump (กระโดดรัวบนอากาศ)", false, function(state)
    infJumpEnabled = state
end)
UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- ระบบล็อกเลือด (Safe Client God Mode)
local GodModeEnabled = false
CreateLargeToggle("God Mode Client (อมตะป้องกันเลือดลด)", false, function(state)
    GodModeEnabled = state
    if state then
        task.spawn(function()
            while GodModeEnabled do
                pcall(function()
                    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
                        lp.Character:FindFirstChildOfClass("Humanoid").MaxHealth = 999999
                        lp.Character:FindFirstChildOfClass("Humanoid").Health = 999999
                    end
                end)
                task.wait(0.1)
            end
        end)
    else
        if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
            lp.Character:FindFirstChildOfClass("Humanoid").MaxHealth = 100
            lp.Character:FindFirstChildOfClass("Humanoid").Health = 100
        end
    end
end)

-- ระบบล่องหนขั้นสุด ลบทุกอย่าง
local InvisibleEnabled = false
CreateLargeToggle("Absolute Invisibility (ล่องหนขั้นสุดลบตัวละคร)", false, function(state)
    InvisibleEnabled = state
    if lp.Character then
        for _, part in pairs(lp.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("Clothing") or part:IsA("Accessory") then
                if state then
                    if part:IsA("BasePart") or part:IsA("Decal") then
                        part.Transparency = 1
                    else
                        part.Enabled = false
                    end
                else
                    if part:IsA("BasePart") or part:IsA("Decal") then
                        part.Transparency = 0
                    else
                        part.Enabled = true
                    end
                end
            end
        end
    end
end)

-- บายพาสระบบตรวจจับแอนตี้ชีท (Safe Metatable Check)
CreateLargeToggle("Anti-Cheat Bypass (ข้ามการตรวจสอบของเซิร์ฟเวอร์)", false, function(state)
    if state then
        pcall(function()
            local mt = getrawmetatable(game)
            if mt and setreadonly then
                setreadonly(mt, false)
                local old = mt.__namecall
                mt.__namecall = newcclosure(function(self, ...)
                    local method = getnamecallmethod()
                    if tostring(method) == "Kick" or tostring(method) == "kick" then
                        return nil
                    end
                    return old(self, ...)
                end)
                setreadonly(mt, true)
            end
        end)
    end
end)

-- =================================================================
-- 5. ระบบบันทึกจุดจำตำแหน่งความตาย และปุ่มยืนยันถามก่อนวาร์ปกลับ
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
TeleportPromptFrame.ZIndex = 10

PromptCorner.CornerRadius = UDim.new(0, 12)
PromptCorner.Parent = TeleportPromptFrame
local pStroke = Instance.new("UIStroke")
pStroke.Color = Color3.fromRGB(0, 255, 170)
pStroke.Thickness = 1.5
pStroke.Parent = TeleportPromptFrame

PromptTitle.Parent = TeleportPromptFrame
PromptTitle.BackgroundTransparency = 1
PromptTitle.Size = UDim2.new(1, 0, 0, 60)
PromptTitle.Font = Enum.Font.GothamSemibold
PromptTitle.Text = "ตรวจพบจุดตายล่าสุด!\nคุณต้องการวาร์ปกลับไปตรงนั้นไหม?"
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

-- ดักจับระบบบันทึกจุดตาย
task.spawn(function()
    while task.wait(0.5) do
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
                task.wait(0.5)
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
-- 6. ระบบสลับหน้าการแสดงผล (Window Interface Toggling)
-- =================================================================
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconButton.Visible = true
end)

IconButton.MouseButton1Click:Connect(function()
    IconButton.Visible = false
    MainFrame.Visible = true
end)
