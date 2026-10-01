--[[ 
    🔥 RIDE A PET - ULTIMATE EGG FARM & ESP HUB (v0.17 - ULTRA COMPACT GUI) 🔥
    - VIP Badge: Bright Glowing Yellow (#FFFF00)
    - XUÂN Badge: White (#FFFFFF)
    - Ultra Compact UI Size: 580x340
]]

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer

-- Xóa GUI cũ nếu tồn tại
if CoreGui:FindFirstChild("RideAPetNexusHub") then
    CoreGui.RideAPetNexusHub:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RideAPetNexusHub"
screenGui.Parent = CoreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ==================== DATABASE TRỨNG & LUCK ====================
local EggDatabase = {
    {Name = "White Egg", Luck = "1", Weight = 1},
    {Name = "Brown Egg", Luck = "5", Weight = 2},
    {Name = "Cracked Egg", Luck = "30", Weight = 3},
    {Name = "Easter Egg", Luck = "50", Weight = 4},
    {Name = "Stone Egg", Luck = "100", Weight = 5},
    {Name = "Leaf Egg", Luck = "200", Weight = 6},
    {Name = "Mushroom Egg", Luck = "500", Weight = 7},
    {Name = "Flower Egg", Luck = "750", Weight = 8},
    {Name = "Slime Egg", Luck = "1,000", Weight = 9},
    {Name = "Ice Egg", Luck = "3,000", Weight = 10},
    {Name = "Glass Egg", Luck = "10,000", Weight = 11},
    {Name = "Golden Egg", Luck = "30,000", Weight = 12},
    {Name = "Diamond Egg", Luck = "90,000", Weight = 13},
    {Name = "Crystal Egg", Luck = "150,000", Weight = 14},
    {Name = "Skull Egg", Luck = "250,000", Weight = 15},
    {Name = "Asteroid Egg", Luck = "500,000", Weight = 16},
    {Name = "Dominus Egg", Luck = "700,000", Weight = 17},
    {Name = "Flaming Egg", Luck = "1 Million", Weight = 18},
    {Name = "Sinister Egg", Luck = "3 Million", Weight = 19},
    {Name = "Soul Egg", Luck = "7 Million", Weight = 20},
    {Name = "Tidal Egg", Luck = "8 Million", Weight = 21},
    {Name = "Aurora Egg", Luck = "300 Million", Weight = 22},
    {Name = "Galaxy Egg", Luck = "1.5 Billion", Weight = 23},
    {Name = "Bloom Egg", Luck = "2 Billion", Weight = 24},
    {Name = "Blackhole Egg", Luck = "100 Billion", Weight = 25},
    {Name = "Solaris Egg", Luck = "300 Billion", Weight = 26},
    {Name = "Cherub Egg", Luck = "1 Trillion", Weight = 27},
    {Name = "Volcanic Egg", Luck = "2.5 Trillion", Weight = 28},
}

table.sort(EggDatabase, function(a, b) return a.Weight > b.Weight end)

_G.SelectedEggs = {}
for i = 1, 10 do
    if EggDatabase[i] then
        _G.SelectedEggs[EggDatabase[i].Name] = true
    end
end

-- ==================== CONFIG PLAYER DEFAULT VALUES ====================
_G.CFrameSpeedEnabled = false
_G.SpeedVal = 300
_G.JumpPowerEnabled = false
_G.JumpPowerVal = 200
_G.LowGravity = false
_G.InfJump = false
_G.Noclip = false

-- ==================== BADGE FORMATTING (RICH TEXT) ====================
local badgeStr = ""
if LocalPlayer.Name == "PrisonDannie" or LocalPlayer.Name == "Danni00true" then
    badgeStr = ' <font color="#FFFF00"><b>VIP</b></font>' -- Vàng sáng chói
elseif LocalPlayer.Name == "hhjhjhj_738" then
    badgeStr = ' <font color="#FFFFFF"><b>XUÂN</b></font>' -- Trắng
end

-- ==================== FLOATING GLOW OPEN BUTTON ====================
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 42, 0, 42)
openBtn.Position = UDim2.new(0.02, 0, 0.15, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
openBtn.TextColor3 = Color3.fromRGB(192, 132, 252)
openBtn.Text = "🐾"
openBtn.Font = Enum.Font.SourceSansBold
openBtn.TextSize = 20
openBtn.Active = true
openBtn.Draggable = true
openBtn.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = openBtn

local openStroke = Instance.new("UIStroke")
openStroke.Color = Color3.fromRGB(192, 132, 252)
openStroke.Transparency = 0.1
openStroke.Thickness = 2
openStroke.Parent = openBtn

-- ==================== MAIN WINDOW (ULTRA COMPACT 580x340) ====================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 580, 0, 340)
mainFrame.Position = UDim2.new(0.5, -290, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(168, 85, 247)
mainStroke.Transparency = 0.2
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

local menuOpened = false
openBtn.MouseButton1Click:Connect(function()
    menuOpened = not menuOpened
    if menuOpened then
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 580, 0, 340)
        }):Play()
    else
        local tw = TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        })
        tw:Play()
        tw.Completed:Connect(function()
            if not menuOpened then mainFrame.Visible = false end
        end)
    end
end)

-- ==================== LEFT SIDEBAR ====================
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 145, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 13)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 10)
sidebarCorner.Parent = sidebar

-- Side Profile Header
local sideHeader = Instance.new("Frame")
sideHeader.Size = UDim2.new(1, 0, 0, 55)
sideHeader.BackgroundTransparency = 1
sideHeader.Parent = sidebar

local sideAvatar = Instance.new("ImageLabel")
sideAvatar.Size = UDim2.new(0, 26, 0, 26)
sideAvatar.Position = UDim2.new(0, 6, 0, 8)
sideAvatar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
sideAvatar.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
sideAvatar.Parent = sideHeader
local sac = Instance.new("UICorner") sac.CornerRadius = UDim.new(1, 0) sac.Parent = sideAvatar

local sideUserLabel = Instance.new("TextLabel")
sideUserLabel.Size = UDim2.new(1, -38, 0, 16)
sideUserLabel.Position = UDim2.new(0, 38, 0, 8)
sideUserLabel.BackgroundTransparency = 1
sideUserLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
sideUserLabel.Font = Enum.Font.SourceSansBold
sideUserLabel.TextSize = 10
sideUserLabel.RichText = true
sideUserLabel.TextXAlignment = Enum.TextXAlignment.Left
sideUserLabel.Parent = sideHeader
sideUserLabel.Text = LocalPlayer.Name .. badgeStr

local sideGameLabel = Instance.new("TextLabel")
sideGameLabel.Size = UDim2.new(1, -38, 0, 14)
sideGameLabel.Position = UDim2.new(0, 38, 0, 24)
sideGameLabel.BackgroundTransparency = 1
sideGameLabel.TextColor3 = Color3.fromRGB(170, 150, 210)
sideGameLabel.Text = "Ride A Pet"
sideGameLabel.Font = Enum.Font.SourceSansBold
sideGameLabel.TextSize = 9
sideGameLabel.TextXAlignment = Enum.TextXAlignment.Left
sideGameLabel.Parent = sideHeader

local sideDivider = Instance.new("Frame")
sideDivider.Size = UDim2.new(1, -12, 0, 1)
sideDivider.Position = UDim2.new(0, 6, 0, 52)
sideDivider.BackgroundColor3 = Color3.fromRGB(45, 35, 65)
sideDivider.BorderSizePixel = 0
sideDivider.Parent = sideHeader

local tabContainer = Instance.new("ScrollingFrame")
tabContainer.Size = UDim2.new(1, 0, 1, -55)
tabContainer.Position = UDim2.new(0, 0, 0, 55)
tabContainer.BackgroundTransparency = 1
tabContainer.BorderSizePixel = 0
tabContainer.CanvasSize = UDim2.new(0, 0, 0, 240)
tabContainer.ScrollBarThickness = 2
tabContainer.Parent = sidebar

local tcLayout = Instance.new("UIListLayout")
tcLayout.SortOrder = Enum.SortOrder.LayoutOrder
tcLayout.Padding = UDim.new(0, 4)
tcLayout.Parent = tabContainer

-- ==================== CONTENT AREA ====================
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -145, 1, 0)
contentArea.Position = UDim2.new(0, 145, 0, 0)
contentArea.BackgroundTransparency = 1
contentArea.ClipsDescendants = true
contentArea.Parent = mainFrame

local tabs = {}

local function createTab(name, isGrid)
    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.BorderSizePixel = 0
    tabFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
    tabFrame.ScrollBarThickness = 3
    tabFrame.ClipsDescendants = true
    tabFrame.Visible = false
    tabFrame.Parent = contentArea

    local returnCol1, returnCol2

    if isGrid then
        local leftCol = Instance.new("Frame")
        leftCol.Size = UDim2.new(0.485, 0, 0, 0)
        leftCol.Position = UDim2.new(0, 5, 0, 5)
        leftCol.AutomaticSize = Enum.AutomaticSize.Y
        leftCol.BackgroundTransparency = 1
        leftCol.Parent = tabFrame

        local lcLayout = Instance.new("UIListLayout")
        lcLayout.SortOrder = Enum.SortOrder.LayoutOrder
        lcLayout.Padding = UDim.new(0, 6)
        lcLayout.Parent = leftCol

        local rightCol = Instance.new("Frame")
        rightCol.Size = UDim2.new(0.485, 0, 0, 0)
        rightCol.Position = UDim2.new(0.505, 0, 0, 5)
        rightCol.AutomaticSize = Enum.AutomaticSize.Y
        rightCol.BackgroundTransparency = 1
        rightCol.Parent = tabFrame

        local rcLayout = Instance.new("UIListLayout")
        rcLayout.SortOrder = Enum.SortOrder.LayoutOrder
        rcLayout.Padding = UDim.new(0, 6)
        rcLayout.Parent = rightCol

        returnCol1, returnCol2 = leftCol, rightCol
    else
        local singleCol = Instance.new("Frame")
        singleCol.Size = UDim2.new(1, -10, 0, 0)
        singleCol.Position = UDim2.new(0, 5, 0, 5)
        singleCol.AutomaticSize = Enum.AutomaticSize.Y
        singleCol.BackgroundTransparency = 1
        singleCol.Parent = tabFrame

        local scLayout = Instance.new("UIListLayout")
        scLayout.SortOrder = Enum.SortOrder.LayoutOrder
        scLayout.Padding = UDim.new(0, 6)
        scLayout.Parent = singleCol

        returnCol1 = singleCol
    end

    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0.9, 0, 0, 28)
    tabBtn.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
    tabBtn.TextColor3 = Color3.fromRGB(150, 150, 180)
    tabBtn.Text = "   " .. name
    tabBtn.Font = Enum.Font.SourceSansBold
    tabBtn.TextSize = 11
    tabBtn.TextXAlignment = Enum.TextXAlignment.Left
    tabBtn.Parent = tabContainer

    local tBtnCorner = Instance.new("UICorner")
    tBtnCorner.CornerRadius = UDim.new(0, 5)
    tBtnCorner.Parent = tabBtn

    local activeBar = Instance.new("Frame")
    activeBar.Size = UDim2.new(0, 3, 0, 0)
    activeBar.Position = UDim2.new(0, 0, 0.5, 0)
    activeBar.AnchorPoint = Vector2.new(0, 0.5)
    activeBar.BackgroundColor3 = Color3.fromRGB(192, 132, 252)
    activeBar.BorderSizePixel = 0
    activeBar.Parent = tabBtn

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = activeBar

    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.Frame.Visible = false
            TweenService:Create(t.Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(14, 14, 20), TextColor3 = Color3.fromRGB(150, 150, 180)}):Play()
            TweenService:Create(t.Bar, TweenInfo.new(0.2), {Size = UDim2.new(0, 3, 0, 0)}):Play()
        end
        tabFrame.Visible = true
        TweenService:Create(tabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 18, 38), TextColor3 = Color3.fromRGB(220, 180, 255)}):Play()
        TweenService:Create(activeBar, TweenInfo.new(0.2), {Size = UDim2.new(0, 3, 0, 14)}):Play()
    end)

    table.insert(tabs, {Name = name, Frame = tabFrame, Button = tabBtn, Bar = activeBar})
    return returnCol1, returnCol2
end

local infoCol = createTab("ℹ️  Info", false)
local farmLeft, farmRight = createTab("🌾  Auto Farm", true)
local espLeft, espRight = createTab("👁  ESP Menu", true)
local playerLeft, playerRight = createTab("🏃  Player", true)
local miscLeft, miscRight = createTab("⭐  Misc", true)
local settingsLeft, settingsRight = createTab("⚙️  Settings", true)

tabs[1].Frame.Visible = true
tabs[1].Button.BackgroundColor3 = Color3.fromRGB(24, 18, 38)
tabs[1].Button.TextColor3 = Color3.fromRGB(220, 180, 255)
tabs[1].Bar.Size = UDim2.new(0, 3, 0, 14)

-- ==================== SECTION BUILDER ====================
local function createSection(parent, titleText)
    local sec = Instance.new("Frame")
    sec.Size = UDim2.new(1, 0, 0, 0)
    sec.AutomaticSize = Enum.AutomaticSize.Y
    sec.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
    sec.ClipsDescendants = true
    sec.Parent = parent

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 6)
    sCorner.Parent = sec

    local sStroke = Instance.new("UIStroke")
    sStroke.Color = Color3.fromRGB(168, 85, 247)
    sStroke.Transparency = 0.5
    sStroke.Thickness = 1
    sStroke.Parent = sec

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 26)
    title.Position = UDim2.new(0, 8, 0, 0)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(220, 200, 255)
    title.Text = titleText
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 11
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = sec

    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 18, 0, 18)
    minimizeBtn.Position = UDim2.new(1, -22, 0, 4)
    minimizeBtn.BackgroundTransparency = 1
    minimizeBtn.TextColor3 = Color3.fromRGB(180, 150, 220)
    minimizeBtn.Text = "-"
    minimizeBtn.Font = Enum.Font.SourceSansBold
    minimizeBtn.TextSize = 14
    minimizeBtn.Parent = sec

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.Position = UDim2.new(0, 0, 0, 26)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.ClipsDescendants = true
    container.Parent = sec

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    layout.Parent = container

    local padding = Instance.new("UIPadding")
    padding.PaddingBottom = UDim.new(0, 6)
    padding.Parent = container

    local minimized = false
    minimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            container.Visible = false
            sec.AutomaticSize = Enum.AutomaticSize.None
            sec.Size = UDim2.new(1, 0, 0, 26)
            minimizeBtn.Text = "+"
        else
            container.Visible = true
            sec.AutomaticSize = Enum.AutomaticSize.Y
            minimizeBtn.Text = "-"
        end
    end)

    return container, sec
end

local function createToggleInSec(parentSec, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 28)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    btn.TextColor3 = Color3.fromRGB(210, 210, 230)
    btn.Text = " " .. text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 10
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = parentSec

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 5)
    c.Parent = btn

    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 28, 0, 14)
    track.Position = UDim2.new(1, -34, 0.5, -7)
    track.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    track.Parent = btn

    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(1, 0)
    tc.Parent = track

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 10, 0, 10)
    dot.Position = UDim2.new(0, 2, 0.5, -5)
    dot.BackgroundColor3 = Color3.fromRGB(200, 200, 220)
    dot.Parent = track

    local dc = Instance.new("UICorner")
    dc.CornerRadius = UDim.new(1, 0)
    dc.Parent = dot

    local toggled = false
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            TweenService:Create(track, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(140, 60, 230)}):Play()
            TweenService:Create(dot, TweenInfo.new(0.2), {Position = UDim2.new(1, -12, 0.5, -5), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(track, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 60)}):Play()
            TweenService:Create(dot, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -5), BackgroundColor3 = Color3.fromRGB(200, 200, 220)}):Play()
        end
        callback(toggled)
    end)
end

local function createTextBoxInSec(parentSec, text, defaultVal, callback)
    local containerFrame = Instance.new("Frame")
    containerFrame.Size = UDim2.new(1, -10, 0, 28)
    containerFrame.Position = UDim2.new(0, 5, 0, 0)
    containerFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    containerFrame.Parent = parentSec

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 5)
    c.Parent = containerFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 6, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(210, 210, 230)
    label.Text = " " .. text
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = containerFrame

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 55, 0, 20)
    box.Position = UDim2.new(1, -60, 0.5, -10)
    box.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Text = tostring(defaultVal)
    box.Font = Enum.Font.SourceSansBold
    box.TextSize = 10
    box.Parent = containerFrame

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 4)
    bc.Parent = box

    box.FocusLost:Connect(function()
        callback(box.Text)
    end)
end

local function createButtonInSec(parentSec, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 28)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(25, 20, 38)
    btn.TextColor3 = Color3.fromRGB(220, 210, 240)
    btn.Text = " " .. text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 10
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = parentSec

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 5)
    c.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

-- ==================== TAB INFO (ĐÃ KHÔI PHỤC PHẦN GAME INFO) ====================
local infoSec1, _ = createSection(infoCol, "👋 Welcome!")
local profileInner = Instance.new("Frame")
profileInner.Size = UDim2.new(1, -10, 0, 48)
profileInner.Position = UDim2.new(0, 5, 0, 0)
profileInner.BackgroundColor3 = Color3.fromRGB(22, 22, 34)
profileInner.Parent = infoSec1

local piCorner = Instance.new("UICorner")
piCorner.CornerRadius = UDim.new(0, 5)
piCorner.Parent = profileInner

local avatarImg = Instance.new("ImageLabel")
avatarImg.Size = UDim2.new(0, 34, 0, 34)
avatarImg.Position = UDim2.new(0, 6, 0.5, -17)
avatarImg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
avatarImg.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
avatarImg.Parent = profileInner

local aiCorner = Instance.new("UICorner")
aiCorner.CornerRadius = UDim.new(1, 0)
aiCorner.Parent = avatarImg

local profileText = Instance.new("TextLabel")
profileText.Size = UDim2.new(0.6, 0, 1, 0)
profileText.Position = UDim2.new(0, 46, 0, 0)
profileText.BackgroundTransparency = 1
profileText.TextColor3 = Color3.fromRGB(230, 230, 245)
profileText.RichText = true
profileText.Text = LocalPlayer.Name .. badgeStr .. "\n@" .. LocalPlayer.Name
profileText.Font = Enum.Font.SourceSansBold
profileText.TextSize = 10
profileText.TextXAlignment = Enum.TextXAlignment.Left
profileText.Parent = profileInner

local verLabel = Instance.new("TextLabel")
verLabel.Size = UDim2.new(0, 45, 0, 16)
verLabel.Position = UDim2.new(1, -50, 0, 6)
verLabel.BackgroundColor3 = Color3.fromRGB(32, 32, 48)
verLabel.TextColor3 = Color3.fromRGB(180, 150, 220)
verLabel.Text = "v0.17"
verLabel.Font = Enum.Font.SourceSansBold
verLabel.TextSize = 9
verLabel.Parent = profileInner
local vlC = Instance.new("UICorner") vlC.CornerRadius = UDim.new(0, 3) vlC.Parent = verLabel

local statsGrid = Instance.new("Frame")
statsGrid.Size = UDim2.new(1, -10, 0, 38)
statsGrid.Position = UDim2.new(0, 5, 0, 0)
statsGrid.BackgroundTransparency = 1
statsGrid.Parent = infoSec1

local function createStatBox(parent, title, value, xPos)
    local box = Instance.new("Frame")
    box.Size = UDim2.new(0.235, 0, 1, 0)
    box.Position = UDim2.new(xPos, 0, 0, 0)
    box.BackgroundColor3 = Color3.fromRGB(22, 22, 34)
    box.Parent = parent

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 5)
    bc.Parent = box

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -4, 0, 14)
    t.Position = UDim2.new(0, 4, 0, 3)
    t.BackgroundTransparency = 1
    t.TextColor3 = Color3.fromRGB(170, 170, 200)
    t.Text = title
    t.Font = Enum.Font.SourceSansBold
    t.TextSize = 9
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = box

    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(1, -4, 0, 16)
    v.Position = UDim2.new(0, 4, 0, 17)
    v.BackgroundTransparency = 1
    v.TextColor3 = Color3.fromRGB(240, 240, 255)
    v.Text = value
    v.Font = Enum.Font.SourceSansBold
    v.TextSize = 10
    v.TextXAlignment = Enum.TextXAlignment.Left
    v.Parent = box

    return v
end

local playersVal = createStatBox(statsGrid, "👥 Players", tostring(#Players:GetPlayers()) .. "/" .. tostring(Players.MaxPlayers), 0)
local sessionStart = tick()
local sessionVal = createStatBox(statsGrid, "⏳ Session", "0s", 0.25)
local fpsVal = createStatBox(statsGrid, "⚡ FPS", "60", 0.5)
local pingVal = createStatBox(statsGrid, "🏓 Ping", "50ms", 0.75)

task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            playersVal.Text = tostring(#Players:GetPlayers()) .. "/" .. tostring(Players.MaxPlayers)
            local elapsed = math.floor(tick() - sessionStart)
            sessionVal.Text = elapsed .. "s"
            fpsVal.Text = math.floor(1 / RunService.RenderStepped:Wait())
            local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            pingVal.Text = math.floor(ping) .. "ms"
        end)
    end
end)

local function createInfoRow(parentSec, title, value)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -10, 0, 26)
    row.Position = UDim2.new(0, 5, 0, 0)
    row.BackgroundColor3 = Color3.fromRGB(22, 22, 34)
    row.Parent = parentSec
    local rc = Instance.new("UICorner") rc.CornerRadius = UDim.new(0, 5) rc.Parent = row

    local tLabel = Instance.new("TextLabel")
    tLabel.Size = UDim2.new(0.4, 0, 1, 0)
    tLabel.Position = UDim2.new(0, 6, 0, 0)
    tLabel.BackgroundTransparency = 1
    tLabel.TextColor3 = Color3.fromRGB(180, 170, 210)
    tLabel.Text = title
    tLabel.Font = Enum.Font.SourceSansBold
    tLabel.TextSize = 10
    tLabel.TextXAlignment = Enum.TextXAlignment.Left
    tLabel.Parent = row

    local vLabel = Instance.new("TextLabel")
    vLabel.Size = UDim2.new(0.6, -12, 1, 0)
    vLabel.Position = UDim2.new(0.4, 0, 0, 0)
    vLabel.BackgroundTransparency = 1
    vLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
    vLabel.Text = value
    vLabel.Font = Enum.Font.SourceSansBold
    vLabel.TextSize = 10
    vLabel.TextXAlignment = Enum.TextXAlignment.Right
    vLabel.Parent = row
end

-- Phần Khôi phục Game Info
local gameSec1, _ = createSection(infoCol, "🎮 Game Info")
createInfoRow(gameSec1, "Game Name:", "Ride A Pet")
createInfoRow(gameSec1, "Place ID:", tostring(game.PlaceId))
createInfoRow(gameSec1, "Job ID:", string.sub(game.JobId, 1, 12) .. "...")

local execSec1, _ = createSection(infoCol, "⚡ Executor Info")
local execName, execVer = "Unknown", "Unknown"
pcall(function()
    if identifyexecutor then
        execName, execVer = identifyexecutor()
    elseif getexecutorname then
        execName = getexecutorname()
    end
end)

createInfoRow(execSec1, "Name:", tostring(execName))
createInfoRow(execSec1, "Version:", tostring(execVer or "Latest"))

-- ==================== TAB AUTO FARM ====================
local farmSec1, _ = createSection(farmLeft, "Egg Automation")
local farmSec2, _ = createSection(farmRight, "Pets & Rebirth")
local farmSec3, _ = createSection(farmLeft, "🎯 Chọn Trứng Farm")

createToggleInSec(farmSec1, "Auto Farm Best Egg", function(state)
    _G.AutoFarmEgg = state
end)

createToggleInSec(farmSec2, "Auto Rebirth", function(state)
    _G.AutoRebirth = state
end)

createToggleInSec(farmSec2, "Auto Equip Best Pet", function(state)
    _G.AutoEquipBest = state
end)

local eggScrollBox = Instance.new("ScrollingFrame")
eggScrollBox.Size = UDim2.new(1, -10, 0, 130)
eggScrollBox.Position = UDim2.new(0, 5, 0, 0)
eggScrollBox.BackgroundTransparency = 1
eggScrollBox.BorderSizePixel = 0
eggScrollBox.CanvasSize = UDim2.new(0, 0, 0, #EggDatabase * 34)
eggScrollBox.ScrollBarThickness = 3
eggScrollBox.Parent = farmSec3

local esbLayout = Instance.new("UIListLayout")
esbLayout.SortOrder = Enum.SortOrder.LayoutOrder
esbLayout.Padding = UDim.new(0, 3)
esbLayout.Parent = eggScrollBox

for _, eggInfo in ipairs(EggDatabase) do
    local eggBtn = Instance.new("TextButton")
    eggBtn.Size = UDim2.new(1, -4, 0, 30)
    eggBtn.BackgroundColor3 = _G.SelectedEggs[eggInfo.Name] and Color3.fromRGB(45, 25, 70) or Color3.fromRGB(20, 20, 30)
    eggBtn.TextColor3 = Color3.fromRGB(230, 230, 250)
    eggBtn.Text = ""
    eggBtn.Parent = eggScrollBox

    local ec = Instance.new("UICorner")
    ec.CornerRadius = UDim.new(0, 5)
    ec.Parent = eggBtn

    local iconBox = Instance.new("Frame")
    iconBox.Size = UDim2.new(0, 22, 0, 22)
    iconBox.Position = UDim2.new(0, 4, 0.5, -11)
    iconBox.BackgroundColor3 = Color3.fromRGB(60, 50, 80)
    iconBox.Parent = eggBtn
    local ibc = Instance.new("UICorner") ibc.CornerRadius = UDim.new(1, 0) ibc.Parent = iconBox

    local iconEmoji = Instance.new("TextLabel")
    iconEmoji.Size = UDim2.new(1, 0, 1, 0)
    iconEmoji.BackgroundTransparency = 1
    iconEmoji.Text = "🥚"
    iconEmoji.TextSize = 12
    iconEmoji.Parent = iconBox

    local labelInfo = Instance.new("TextLabel")
    labelInfo.Size = UDim2.new(0.7, 0, 1, 0)
    labelInfo.Position = UDim2.new(0, 30, 0, 0)
    labelInfo.BackgroundTransparency = 1
    labelInfo.TextColor3 = Color3.fromRGB(240, 240, 255)
    labelInfo.Text = eggInfo.Name .. " (+" .. tostring(eggInfo.Luck) .. ")"
    labelInfo.Font = Enum.Font.SourceSansBold
    labelInfo.TextSize = 10
    labelInfo.TextXAlignment = Enum.TextXAlignment.Left
    labelInfo.Parent = eggBtn

    local checkBox = Instance.new("Frame")
    checkBox.Size = UDim2.new(0, 16, 0, 16)
    checkBox.Position = UDim2.new(1, -20, 0.5, -8)
    checkBox.BackgroundColor3 = _G.SelectedEggs[eggInfo.Name] and Color3.fromRGB(168, 85, 247) or Color3.fromRGB(45, 45, 60)
    checkBox.Parent = eggBtn
    local cbc = Instance.new("UICorner") cbc.CornerRadius = UDim.new(0, 3) cbc.Parent = checkBox

    local checkMark = Instance.new("TextLabel")
    checkMark.Size = UDim2.new(1, 0, 1, 0)
    checkMark.BackgroundTransparency = 1
    checkMark.TextColor3 = Color3.fromRGB(255, 255, 255)
    checkMark.Text = _G.SelectedEggs[eggInfo.Name] and "✓" or ""
    checkMark.TextSize = 10
    checkMark.Font = Enum.Font.SourceSansBold
    checkMark.Parent = checkBox

    eggBtn.MouseButton1Click:Connect(function()
        local currentVal = _G.SelectedEggs[eggInfo.Name]
        _G.SelectedEggs[eggInfo.Name] = not currentVal
        if _G.SelectedEggs[eggInfo.Name] then
            TweenService:Create(eggBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 25, 70)}):Play()
            TweenService:Create(checkBox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(168, 85, 247)}):Play()
            checkMark.Text = "✓"
        else
            TweenService:Create(eggBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 20, 30)}):Play()
            TweenService:Create(checkBox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 60)}):Play()
            checkMark.Text = ""
        end
    end)
end

-- ==================== TAB PLAYER ====================
local playerSec1, _ = createSection(playerLeft, "Movement")

createToggleInSec(playerSec1, "CFrame Speed", function(state)
    _G.CFrameSpeedEnabled = state
end)

createTextBoxInSec(playerSec1, "Speed Value", _G.SpeedVal, function(val)
    local num = tonumber(val)
    if num then _G.SpeedVal = num end
end)

createToggleInSec(playerSec1, "Jump Power", function(state)
    _G.JumpPowerEnabled = state
end)

createTextBoxInSec(playerSec1, "Jump Value", _G.JumpPowerVal, function(val)
    local num = tonumber(val)
    if num then _G.JumpPowerVal = num end
end)

createToggleInSec(playerSec1, "Low Gravity", function(state)
    _G.LowGravity = state
    Workspace.Gravity = state and 50 or 196.2
end)

createToggleInSec(playerSec1, "Infinite Jump", function(state)
    _G.InfJump = state
end)

createToggleInSec(playerSec1, "Noclip", function(state)
    _G.Noclip = state
end)

-- ==================== TAB ESP ====================
local espSec1, _ = createSection(espLeft, "Visuals")
createToggleInSec(espSec1, "ESP Player", function(state) _G.EspPlayer = state end)
createToggleInSec(espSec1, "ESP Egg", function(state)
    _G.EspEgg = state
    if not state then
        for _, descendant in ipairs(Workspace:GetDescendants()) do
            if descendant:IsA("Model") then
                local hl = descendant:FindFirstChild("StrictEgg_Highlight")
                if hl then hl:Destroy() end
                local tp = descendant.PrimaryPart or descendant:FindFirstChildWhichIsA("BasePart")
                if tp then
                    local bb = tp:FindFirstChild("StrictEgg_Billboard")
                    if bb then bb:Destroy() end
                end
            end
        end
    end
end)

local miscSec1, _ = createSection(miscLeft, "Teleport")
createButtonInSec(miscSec1, "📍 TP to Center Arena", function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = CFrame.new(140, 40316, 918) end
end)

local setSec1, _ = createSection(settingsLeft, "Preferences")
createButtonInSec(setSec1, "❌ Destroy GUI", function()
    screenGui:Destroy()
end)

-- ==================== HÀM RANCH & AUTO FARM ====================
local function GetMyRanch()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Folder") then
            local nameLower = string.lower(obj.Name)
            if nameLower:find("ranch") or nameLower:find("plot") or nameLower:find("base") or nameLower:find("land") or nameLower:find("housing") or nameLower:find("home") then
                local attributes = obj:GetAttributes()
                for _, attrVal in pairs(attributes) do
                    local valStr = tostring(attrVal)
                    if valStr == tostring(LocalPlayer.Name) or valStr == tostring(LocalPlayer.UserId) then
                        return obj
                    end
                end
                
                for _, child in ipairs(obj:GetDescendants()) do
                    if child:IsA("StringValue") or child:IsA("IntValue") then
                        local cValStr = tostring(child.Value)
                        if cValStr == tostring(LocalPlayer.Name) or cValStr == tostring(LocalPlayer.UserId) then
                            return obj
                        end
                    elseif child:IsA("ObjectValue") and child.Value == LocalPlayer then
                        return obj
                    end
                end
                
                if nameLower:find(string.lower(LocalPlayer.Name)) then
                    return obj
                end
            end
        end
    end
    return nil
end

local function GetRanchCenter()
    local myRanch = GetMyRanch()
    if not myRanch then return nil end
    
    local targetPart = nil
    for _, d in ipairs(myRanch:GetDescendants()) do
        local dName = string.lower(d.Name)
        if dName:find("nest") or dName:find("incubator") or dName:find("spot") or dName:find("pad") or dName:find("center") or dName:find("core") or dName:find("spawn") then
            if d:IsA("BasePart") then
                targetPart = d
                break
            elseif d:IsA("Model") then
                targetPart = d.PrimaryPart or d:FindFirstChildWhichIsA("BasePart")
                if targetPart then break end
            end
        end
    end
    
    if not targetPart then
        targetPart = myRanch.PrimaryPart or myRanch:FindFirstChildWhichIsA("BasePart")
    end
    
    if targetPart then
        return targetPart.CFrame + Vector3.new(0, 3, 0)
    end
    return nil
end

local function getEggLuckValue(eggName)
    for _, info in ipairs(EggDatabase) do
        if string.find(string.lower(eggName), string.lower(info.Name)) then
            return info.Luck, info.Weight
        end
    end
    return "Unknown", 0
end

local function isInsideBase(obj)
    local current = obj.Parent
    while current and current ~= Workspace do
        local nameLower = string.lower(current.Name)
        if string.find(nameLower, "ranch") or string.find(nameLower, "base") or string.find(nameLower, "plot") then
            return true
        end
        current = current.Parent
    end
    return false
end

local function isCarriedByPlayer(obj)
    local current = obj.Parent
    while current and current ~= Workspace do
        if current:IsA("Model") then
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Character == current then return true end
            end
        end
        current = current.Parent
    end
    return false
end

local function isValidEggModel(model)
    if not model:IsA("Model") then return false end
    if isInsideBase(model) then return false end
    if isCarriedByPlayer(model) then return false end

    local nameLower = string.lower(model.Name)
    local isEgg = string.find(nameLower, "egg")
    local isGarbage = string.find(nameLower, "base") or 
                      string.find(nameLower, "eggtracker") or 
                      string.find(nameLower, "eggo") or 
                      string.find(nameLower, "eggspawm") or 
                      string.find(nameLower, "eggspawn")
    return isEgg and not isGarbage
end

local function hasEggAncestor(item)
    local current = item.Parent
    while current and current ~= Workspace do
        if isValidEggModel(current) then return true end
        current = current.Parent
    end
    return false
end

local function applyESP(obj)
    if not _G.EspEgg then return end
    if not isValidEggModel(obj) then return end
    if hasEggAncestor(obj) then return end
    if obj:FindFirstChild("StrictEgg_Highlight") then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "StrictEgg_Highlight"
    highlight.Adornee = obj
    highlight.FillColor = Color3.fromRGB(255, 215, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = obj

    local targetPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
    if targetPart then
        if targetPart:FindFirstChild("StrictEgg_Billboard") then return end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "StrictEgg_Billboard"
        billboard.Adornee = targetPart
        billboard.Size = UDim2.new(0, 160, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.AlwaysOnTop = true

        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "Text"
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextStrokeTransparency = 0
        textLabel.TextSize = 10
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.Text = obj.Name
        textLabel.Parent = billboard

        billboard.Parent = targetPart

        task.spawn(function()
            while obj and obj.Parent and _G.EspEgg and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") do
                local hrp = LocalPlayer.Character.HumanoidRootPart
                local dist = (hrp.Position - targetPart.Position).Magnitude
                local luckVal = getEggLuckValue(obj.Name)
                textLabel.Text = string.format("%s\nLuck: +%s\n[%dm]", obj.Name, tostring(luckVal), math.floor(dist))
                task.wait(0.3)
            end
            if highlight then highlight:Destroy() end
            if billboard then billboard:Destroy() end
        end)
    end
end

task.spawn(function()
    while true do
        task.wait(1)
        if _G.EspEgg then
            for _, descendant in ipairs(Workspace:GetDescendants()) do
                applyESP(descendant)
            end
        end
    end
end)

Workspace.DescendantAdded:Connect(function(descendant)
    if _G.EspEgg then
        task.wait(0.3)
        applyESP(descendant)
    end
end)

-- ==================== AUTO FARM LOOP ====================
task.spawn(function()
    while true do
        task.wait(0.4)
        pcall(function()
            if _G.AutoFarmEgg then
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local bestEggModel = nil
                    local bestEggPart = nil
                    local highestWeight = -1

                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if obj:IsA("Model") and isValidEggModel(obj) then
                            local matchName = nil
                            for eggName, isSelected in pairs(_G.SelectedEggs) do
                                if isSelected and string.find(string.lower(obj.Name), string.lower(eggName)) then
                                    matchName = eggName
                                    break
                                end
                            end

                            if matchName then
                                local _, weight = getEggLuckValue(obj.Name)
                                if weight > highestWeight then
                                    highestWeight = weight
                                    bestEggModel = obj
                                    bestEggPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                                end
                            end
                        end
                    end

                    if bestEggModel and bestEggPart then
                        hrp.CFrame = bestEggPart.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.2)

                        for _, prompt in ipairs(bestEggModel:GetDescendants()) do
                            if prompt:IsA("ProximityPrompt") then
                                pcall(function() fireproximityprompt(prompt) end)
                            end
                        end

                        for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
                            if remote:IsA("RemoteEvent") then
                                local rName = string.lower(remote.Name)
                                if rName:find("egg") or rName:find("pick") or rName:find("grab") or rName:find("hold") or rName:find("take") or rName:find("buy") then
                                    pcall(function()
                                        remote:FireServer(bestEggModel)
                                        remote:FireServer(bestEggPart)
                                    end)
                                end
                            end
                        end

                        task.wait(0.4)

                        local ranchCFrame = GetRanchCenter()
                        if ranchCFrame then
                            hrp.CFrame = ranchCFrame
                        end
                    end
                end
            end

            if _G.AutoRebirth then
                for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
                    if obj:IsA("RemoteEvent") and (string.find(string.lower(obj.Name), "rebirth") or string.find(string.lower(obj.Name), "prest")) then
                        obj:FireServer()
                    end
                end
            end

            if _G.AutoEquipBest then
                for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
                    if obj:IsA("RemoteEvent") and (string.find(string.lower(obj.Name), "equip") or string.find(string.lower(obj.Name), "pet")) then
                        obj:FireServer("EquipBest")
                    end
                end
            end
        end)
    end
end)

-- ==================== PLAYER LOOPS ====================
RunService.RenderStepped:Connect(function(dt)
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local humanoid = char:FindFirstChildOfClass("Humanoid")

            if hrp and humanoid and _G.CFrameSpeedEnabled then
                if humanoid.MoveDirection.Magnitude > 0 then
                    hrp.CFrame = hrp.CFrame + (humanoid.MoveDirection * _G.SpeedVal * dt)
                end
            end

            if humanoid and _G.JumpPowerEnabled then
                humanoid.UseJumpPower = true
                humanoid.JumpPower = _G.JumpPowerVal
            end

            if _G.Noclip then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end
    end)
end)

UserInputService.JumpRequest:Connect(function()
    pcall(function()
        if _G.InfJump then
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end
    end)
end)

-- ESP Player Loop
task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function()
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local pChar = p.Character
                    local pHrp = pChar.HumanoidRootPart
                    if _G.EspPlayer then
                        local hl = pChar:FindFirstChild("NexusESP")
                        if not hl then
                            hl = Instance.new("Highlight")
                            hl.Name = "NexusESP"
                            hl.Adornee = pChar
                            hl.FillColor = Color3.fromRGB(192, 132, 252)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            hl.Parent = pChar
                        end

                        local bb = pHrp:FindFirstChild("PlayerESP_Billboard")
                        if not bb then
                            bb = Instance.new("BillboardGui")
                            bb.Name = "PlayerESP_Billboard"
                            bb.Adornee = pHrp
                            bb.Size = UDim2.new(0, 140, 0, 40)
                            bb.StudsOffset = Vector3.new(0, 2.5, 0)
                            bb.AlwaysOnTop = true

                            local lbl = Instance.new("TextLabel")
                            lbl.Name = "Text"
                            lbl.Size = UDim2.new(1, 0, 1, 0)
                            lbl.BackgroundTransparency = 1
                            lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                            lbl.TextStrokeTransparency = 0
                            lbl.TextSize = 10
                            lbl.Font = Enum.Font.SourceSansBold
                            lbl.Parent = bb

                            bb.Parent = pHrp
                        end

                        local textLbl = bb:FindFirstChild("Text")
                        if textLbl and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local myHrp = LocalPlayer.Character.HumanoidRootPart
                            local dist = (myHrp.Position - pHrp.Position).Magnitude
                            textLbl.Text = string.format("%s\n[%dm]", p.Name, math.floor(dist))
                        end
                    else
                        if pChar:FindFirstChild("NexusESP") then pChar.NexusESP:Destroy() end
                        if pHrp:FindFirstChild("PlayerESP_Billboard") then pHrp.PlayerESP_Billboard:Destroy() end
                    end
                end
            end
        end)
    end
end)

print("Ride A Pet - Hub v0.17 Ultra Compact Loaded Successfully!")
