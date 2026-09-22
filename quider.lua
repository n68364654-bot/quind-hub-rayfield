-- ═══════════════════════════════════════════════════════════
--   Quind Hub — made by hashtrash
--   Custom UI (Rayfield-style, tabs on left) + 11 tabs
-- ═══════════════════════════════════════════════════════════

-- ═══════════════ CUSTOM UI LIBRARY ═══════════════
local UI = {}
do
    local Players = game:GetService("Players")
    local UIS     = game:GetService("UserInputService")
    local LP      = Players.LocalPlayer

    local function new(cls, props)
        local o = Instance.new(cls)
        for k, v in pairs(props) do
            if k ~= "Parent" then o[k] = v end
        end
        if props.Parent then o.Parent = props.Parent end
        return o
    end
    local function corner(p, r)
        local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r or 6); c.Parent = p; return c
    end
    local function pad(p, t, r, b, l)
        local x = Instance.new("UIPadding")
        x.PaddingTop=UDim.new(0,t or 0); x.PaddingRight=UDim.new(0,r or 0)
        x.PaddingBottom=UDim.new(0,b or 0); x.PaddingLeft=UDim.new(0,l or 0)
        x.Parent=p; return x
    end
    local function stroke(p, c, t, tr)
        local s = Instance.new("UIStroke")
        s.Color=c or Color3.fromRGB(55,55,75); s.Thickness=t or 1; s.Transparency=tr or 0
        s.Parent=p; return s
    end

    local C = {
        BG       = Color3.fromRGB(18,18,24),
        Sidebar  = Color3.fromRGB(24,24,32),
        Title    = Color3.fromRGB(28,28,38),
        Content  = Color3.fromRGB(22,22,28),
        Elem     = Color3.fromRGB(35,35,48),
        ElemHov  = Color3.fromRGB(46,46,62),
        Accent   = Color3.fromRGB(118,138,255),
        Accent2  = Color3.fromRGB(210,100,255),
        Text     = Color3.fromRGB(235,235,245),
        TextDim  = Color3.fromRGB(150,150,170),
        Toggle   = Color3.fromRGB(80,220,120),
        Danger   = Color3.fromRGB(255,80,90),
        Dark     = Color3.fromRGB(28,28,38),
    }

    function UI:CreateWindow(opts)
        opts = opts or {}
        local gui = new("ScreenGui", {
            Name="QuindUI", ResetOnSpawn=false,
            ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
        })
        local par = pcall(function() return game:GetService("CoreGui") end)
        gui.Parent = par and game:GetService("CoreGui") or LP:WaitForChild("PlayerGui")

        local main = new("Frame", {
            Size=UDim2.new(0,660,0,460),
            Position=UDim2.new(0.5,-330,0.5,-230),
            BackgroundColor3=C.BG, BorderSizePixel=0, Parent=gui, Active=true,
        })
        corner(main, 10); stroke(main, Color3.fromRGB(50,50,70), 1, 0.3)

        -- Title bar
        local tb = new("Frame", {
            Size=UDim2.new(1,0,0,36), BackgroundColor3=C.Title,
            BorderSizePixel=0, Parent=main,
        })
        corner(tb, 10)
        new("Frame", {
            Size=UDim2.new(1,0,0,12), Position=UDim2.new(0,0,1,-12),
            BackgroundColor3=C.Title, BorderSizePixel=0, Parent=tb,
        })
        new("TextLabel", {
            Size=UDim2.new(1,-100,1,0), Position=UDim2.new(0,16,0,0),
            BackgroundTransparency=1, Text=opts.Name or "UI",
            TextColor3=C.Text, TextSize=15, Font=Enum.Font.GothamBold,
            TextXAlignment=Enum.TextXAlignment.Left, Parent=tb,
        })
        new("TextLabel", {
            Size=UDim2.new(0,200,1,0), Position=UDim2.new(1,-280,0,0),
            BackgroundTransparency=1, Text=opts.Subtitle or "",
            TextColor3=C.TextDim, TextSize=11, Font=Enum.Font.Gotham,
            TextXAlignment=Enum.TextXAlignment.Right, Parent=tb,
        })

        -- Close button
        local closeB = new("TextButton", {
            Size=UDim2.new(0,24,0,24), Position=UDim2.new(1,-32,0,6),
            BackgroundColor3=C.Elem, Text="✕", TextColor3=C.Text,
            TextSize=13, Font=Enum.Font.GothamBold, BorderSizePixel=0, Parent=tb,
        })
        corner(closeB, 6)
        closeB.MouseButton1Click:Connect(function() gui:Destroy() end)

        -- Minimize
        local minB = new("TextButton", {
            Size=UDim2.new(0,24,0,24), Position=UDim2.new(1,-62,0,6),
            BackgroundColor3=C.Elem, Text="—", TextColor3=C.Text,
            TextSize=13, Font=Enum.Font.GothamBold, BorderSizePixel=0, Parent=tb,
        })
        corner(minB, 6)
        local min = false
        minB.MouseButton1Click:Connect(function()
            min = not min
            main.Size = min and UDim2.new(0,660,0,36) or UDim2.new(0,660,0,460)
        end)

        -- Drag
        local dragging, dragStart, startPos
        tb.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                dragging=true; dragStart=i.Position; startPos=main.Position
                i.Changed:Connect(function()
                    if i.UserInputState==Enum.UserInputState.End then dragging=false end
                end)
            end
        end)
        UIS.InputChanged:Connect(function(i)
            if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                local d = i.Position - dragStart
                main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X,
                                          startPos.Y.Scale, startPos.Y.Offset+d.Y)
            end
        end)

        -- Sidebar (LEFT)
        local side = new("Frame", {
            Size=UDim2.new(0,160,1,-46), Position=UDim2.new(0,10,0,42),
            BackgroundColor3=C.Sidebar, BorderSizePixel=0, Parent=main,
        })
        corner(side, 8)
        local sideScroll = new("ScrollingFrame", {
            Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
            BorderSizePixel=0, ScrollBarThickness=3,
            ScrollBarImageColor3=C.Accent, CanvasSize=UDim2.new(0,0,0,0),
            Parent=side,
        })
        pad(sideScroll, 6,6,6,6)
        local sideLay = new("UIListLayout", {
            Padding=UDim.new(0,4), SortOrder=Enum.SortOrder.LayoutOrder, Parent=sideScroll,
        })
        sideLay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            sideScroll.CanvasSize = UDim2.new(0,0,0, sideLay.AbsoluteContentSize.Y+12)
        end)

        -- Content area
        local content = new("Frame", {
            Size=UDim2.new(1,-180,1,-46), Position=UDim2.new(0,170,0,42),
            BackgroundColor3=C.Content, BorderSizePixel=0, Parent=main,
        })
        corner(content, 8)
        local contentScroll = new("ScrollingFrame", {
            Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
            BorderSizePixel=0, ScrollBarThickness=4,
            ScrollBarImageColor3=C.Accent, CanvasSize=UDim2.new(0,0,0,0),
            Parent=content,
        })
        pad(contentScroll, 8,8,8,8)
        local contentLay = new("UIListLayout", {
            Padding=UDim.new(0,6), SortOrder=Enum.SortOrder.LayoutOrder, Parent=contentScroll,
        })
        contentLay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            contentScroll.CanvasSize = UDim2.new(0,0,0, contentLay.AbsoluteContentSize.Y+12)
        end)

        -- Notifications
        local notifs = new("Frame", {
            Size=UDim2.new(0,260,1,-20), Position=UDim2.new(1,-270,0,10),
            BackgroundTransparency=1, Parent=gui,
        })
        new("UIListLayout", {Padding=UDim.new(0,6), SortOrder=Enum.SortOrder.LayoutOrder, Parent=notifs})

        local function notify(t, c, d)
            local n = new("Frame", {
                Size=UDim2.new(1,0,0,62), BackgroundColor3=C.Title,
                BorderSizePixel=0, Parent=notifs,
            })
            corner(n, 8); stroke(n, C.Accent, 1, 0.5)
            new("TextLabel", {
                Size=UDim2.new(1,-20,0,20), Position=UDim2.new(0,10,0,6),
                BackgroundTransparency=1, Text=t, TextColor3=C.Accent,
                Font=Enum.Font.GothamBold, TextSize=12,
                TextXAlignment=Enum.TextXAlignment.Left, Parent=n,
            })
            new("TextLabel", {
                Size=UDim2.new(1,-20,0,30), Position=UDim2.new(0,10,0,26),
                BackgroundTransparency=1, Text=c, TextColor3=C.Text,
                Font=Enum.Font.Gotham, TextSize=11, TextWrapped=true,
                TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Top,
                Parent=n,
            })
            task.spawn(function()
                task.wait(d or 4)
                for i=1,10 do n.BackgroundTransparency=i/10; task.wait(0.02) end
                n:Destroy()
            end)
        end

        local Win = {}
        local tabs, firstTab = {}, nil

        function Win:CreateTab(name)
            local btn = new("TextButton", {
                Size=UDim2.new(1,0,0,32), BackgroundColor3=C.Elem,
                BackgroundTransparency=1, Text="", BorderSizePixel=0, Parent=sideScroll,
            })
            corner(btn, 6)
            local lbl = new("TextLabel", {
                Size=UDim2.new(1,-20,1,0), Position=UDim2.new(0,12,0,0),
                BackgroundTransparency=1, Text=name, TextColor3=C.TextDim,
                Font=Enum.Font.GothamMedium, TextSize=13,
                TextXAlignment=Enum.TextXAlignment.Left, Parent=btn,
            })

            local page = new("Frame", {
                Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y,
                BackgroundTransparency=1, Visible=false, Parent=contentScroll,
            })
            local pl = new("UIListLayout", {
                Padding=UDim.new(0,6), SortOrder=Enum.SortOrder.LayoutOrder, Parent=page,
            })
            pl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                page.Size = UDim2.new(1,0,0, pl.AbsoluteContentSize.Y)
            end)

            local T = {Button=btn, Label=lbl, Page=page}
            btn.MouseButton1Click:Connect(function()
                for _, t in ipairs(tabs) do
                    t.Page.Visible=false; t.Label.TextColor3=C.TextDim; t.Button.BackgroundTransparency=1
                end
                page.Visible=true; lbl.TextColor3=C.Text; btn.BackgroundTransparency=0
            end)
            btn.MouseEnter:Connect(function()
                if not page.Visible then btn.BackgroundTransparency=0.5 end
            end)
            btn.MouseLeave:Connect(function()
                if not page.Visible then btn.BackgroundTransparency=1 end
            end)
            table.insert(tabs, T)
            if not firstTab then
                firstTab=T; page.Visible=true; lbl.TextColor3=C.Text; btn.BackgroundTransparency=0
            end

            local tab = {}

            function tab:CreateSection(text)
                local s = new("Frame", {
                    Size=UDim2.new(1,0,0,26), BackgroundTransparency=1, Parent=page,
                })
                new("TextLabel", {
                    Size=UDim2.new(1,0,0,20), Position=UDim2.new(0,4,0,2),
                    BackgroundTransparency=1, Text=text, TextColor3=C.Accent,
                    Font=Enum.Font.GothamBold, TextSize=12,
                    TextXAlignment=Enum.TextXAlignment.Left, Parent=s,
                })
                new("Frame", {
                    Size=UDim2.new(1,-8,0,1), Position=UDim2.new(0,4,1,-2),
                    BackgroundColor3=C.Accent, BackgroundTransparency=0.7,
                    BorderSizePixel=0, Parent=s,
                })
            end

            function tab:CreateButton(o)
                local b = new("TextButton", {
                    Size=UDim2.new(1,0,0,32), BackgroundColor3=C.Elem,
                    Text="", BorderSizePixel=0, AutoButtonColor=false, Parent=page,
                })
                corner(b, 6); stroke(b, Color3.fromRGB(55,55,75), 1, 0.3)
                new("TextLabel", {
                    Size=UDim2.new(1,-20,1,0), Position=UDim2.new(0,12,0,0),
                    BackgroundTransparency=1, Text=o.Name or "Button",
                    TextColor3=C.Text, Font=Enum.Font.GothamMedium, TextSize=12,
                    TextXAlignment=Enum.TextXAlignment.Left, Parent=b,
                })
                b.MouseEnter:Connect(function() b.BackgroundColor3=C.ElemHov end)
                b.MouseLeave:Connect(function() b.BackgroundColor3=C.Elem end)
                b.MouseButton1Click:Connect(function()
                    if o.Callback then pcall(o.Callback) end
                end)
            end

            function tab:CreateToggle(o)
                local f = new("Frame", {
                    Size=UDim2.new(1,0,0,32), BackgroundColor3=C.Elem,
                    BorderSizePixel=0, Parent=page,
                })
                corner(f, 6); stroke(f, Color3.fromRGB(55,55,75), 1, 0.3)
                new("TextLabel", {
                    Size=UDim2.new(1,-70,1,0), Position=UDim2.new(0,12,0,0),
                    BackgroundTransparency=1, Text=o.Name or "Toggle",
                    TextColor3=C.Text, Font=Enum.Font.GothamMedium, TextSize=12,
                    TextXAlignment=Enum.TextXAlignment.Left, Parent=f,
                })
                local sw = new("TextButton", {
                    Size=UDim2.new(0,40,0,20), Position=UDim2.new(1,-50,0.5,-10),
                    BackgroundColor3=C.Elem, Text="", BorderSizePixel=0,
                    AutoButtonColor=false, Parent=f,
                })
                corner(sw, 10); stroke(sw, Color3.fromRGB(70,70,90), 1, 0.3)
                local knob = new("Frame", {
                    Size=UDim2.new(0,16,0,16), Position=UDim2.new(0,2,0.5,-8),
                    BackgroundColor3=C.TextDim, BorderSizePixel=0, Parent=sw,
                })
                corner(knob, 8)
                local st = o.CurrentValue or false
                local function upd()
                    if st then
                        sw.BackgroundColor3=C.Toggle
                        knob.Position=UDim2.new(1,-18,0.5,-8)
                        knob.BackgroundColor3=Color3.fromRGB(255,255,255)
                    else
                        sw.BackgroundColor3=C.Elem
                        knob.Position=UDim2.new(0,2,0.5,-8)
                        knob.BackgroundColor3=C.TextDim
                    end
                end
                upd()
                sw.MouseButton1Click:Connect(function()
                    st = not st; upd()
                    if o.Callback then pcall(o.Callback, st) end
                end)
            end

            function tab:CreateSlider(o)
                local f = new("Frame", {
                    Size=UDim2.new(1,0,0,48), BackgroundColor3=C.Elem,
                    BorderSizePixel=0, Parent=page,
                })
                corner(f, 6); stroke(f, Color3.fromRGB(55,55,75), 1, 0.3)
                new("TextLabel", {
                    Size=UDim2.new(1,-120,0,20), Position=UDim2.new(0,12,0,4),
                    BackgroundTransparency=1, Text=o.Name or "Slider",
                    TextColor3=C.Text, Font=Enum.Font.GothamMedium, TextSize=12,
                    TextXAlignment=Enum.TextXAlignment.Left, Parent=f,
                })
                local vl = new("TextLabel", {
                    Size=UDim2.new(0,100,0,20), Position=UDim2.new(1,-112,0,4),
                    BackgroundTransparency=1, Text="", TextColor3=C.Accent,
                    Font=Enum.Font.GothamBold, TextSize=12,
                    TextXAlignment=Enum.TextXAlignment.Right, Parent=f,
                })
                local tr = new("Frame", {
                    Size=UDim2.new(1,-24,0,6), Position=UDim2.new(0,12,0,34),
                    BackgroundColor3=Color3.fromRGB(50,50,65),
                    BorderSizePixel=0, Parent=f,
                })
                corner(tr, 3)
                local fl = new("Frame", {
                    Size=UDim2.new(0,0,1,0), BackgroundColor3=C.Accent,
                    BorderSizePixel=0, Parent=tr,
                })
                corner(fl, 3)
                local range = o.Range or {0,100}
                local inc = o.Increment or 1
                local val = o.CurrentValue or range[1]
                local suf = o.Suffix or ""
                local mn, mx = range[1], range[2]
                local function snap(v) return math.clamp(math.floor((v-mn)/inc+0.5)*inc+mn, mn, mx) end
                local function upd()
                    local a = (val-mn)/(mx-mn)
                    fl.Size = UDim2.new(a,0,1,0)
                    vl.Text = tostring(val)..suf
                end
                upd()
                local drg=false
                local function setX(x)
                    local a = math.clamp((x-tr.AbsolutePosition.X)/tr.AbsoluteSize.X,0,1)
                    val = snap(mn + a*(mx-mn))
                    upd()
                    if o.Callback then pcall(o.Callback, val) end
                end
                tr.InputBegan:Connect(function(i)
                    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                        drg=true; setX(i.Position.X)
                    end
                end)
                UIS.InputChanged:Connect(function(i)
                    if drg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                        setX(i.Position.X)
                    end
                end)
                UIS.InputEnded:Connect(function(i)
                    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                        drg=false
                    end
                end)
            end

            function tab:CreateInput(o)
                local f = new("Frame", {
                    Size=UDim2.new(1,0,0,54), BackgroundColor3=C.Elem,
                    BorderSizePixel=0, Parent=page,
                })
                corner(f, 6); stroke(f, Color3.fromRGB(55,55,75), 1, 0.3)
                new("TextLabel", {
                    Size=UDim2.new(1,-24,0,20), Position=UDim2.new(0,12,0,4),
                    BackgroundTransparency=1, Text=o.Name or "Input",
                    TextColor3=C.Text, Font=Enum.Font.GothamMedium, TextSize=12,
                    TextXAlignment=Enum.TextXAlignment.Left, Parent=f,
                })
                local bx = new("TextBox", {
                    Size=UDim2.new(1,-24,0,22), Position=UDim2.new(0,12,0,26),
                    BackgroundColor3=C.Dark, Text=o.CurrentValue or "",
                    PlaceholderText=o.PlaceholderText or "",
                    TextColor3=C.Text, PlaceholderColor3=C.TextDim,
                    Font=Enum.Font.Gotham, TextSize=12, BorderSizePixel=0,
                    ClearTextOnFocus=false, Parent=f,
                })
                corner(bx, 4); pad(bx, 0,8,0,8)
                bx.FocusLost:Connect(function()
                    if o.Callback then pcall(o.Callback, bx.Text) end
                end)
                return bx
            end

            function tab:CreateDropdown(o)
                local f = new("Frame", {
                    Size=UDim2.new(1,0,0,36), BackgroundColor3=C.Elem,
                    BorderSizePixel=0, Parent=page,
                })
                corner(f, 6); stroke(f, Color3.fromRGB(55,55,75), 1, 0.3)
                new("TextLabel", {
                    Size=UDim2.new(1,-130,1,0), Position=UDim2.new(0,12,0,0),
                    BackgroundTransparency=1, Text=o.Name or "Dropdown",
                    TextColor3=C.Text, Font=Enum.Font.GothamMedium, TextSize=12,
                    TextXAlignment=Enum.TextXAlignment.Left, Parent=f,
                })
                local opts = o.Options or {}
                local cur = (o.CurrentOption and (type(o.CurrentOption)=="table" and o.CurrentOption[1] or o.CurrentOption)) or (opts[1] or "-")
                local vl = new("TextButton", {
                    Size=UDim2.new(0,120,0,22), Position=UDim2.new(1,-130,0.5,-11),
                    BackgroundColor3=C.Dark, Text=tostring(cur),
                    TextColor3=C.Text, Font=Enum.Font.Gotham, TextSize=11,
                    BorderSizePixel=0, Parent=f,
                })
                corner(vl, 4)
                vl.MouseButton1Click:Connect(function()
                    local idx=1
                    for i,oo in ipairs(opts) do if oo==cur then idx=i; break end end
                    idx = idx+1; if idx>#opts then idx=1 end
                    cur = opts[idx]; vl.Text = tostring(cur)
                    if o.Callback then pcall(o.Callback, {cur}) end
                end)
                local dd = {CurrentOption=cur}
                function dd:Refresh(newOpts)
                    opts = newOpts or opts; cur = opts[1]
                    vl.Text = tostring(cur)
                end
                return dd
            end

            function tab:CreateParagraph(o)
                local f = new("Frame", {
                    Size=UDim2.new(1,0,0,50), BackgroundColor3=Color3.fromRGB(30,30,42),
                    BorderSizePixel=0, Parent=page,
                })
                corner(f, 6); stroke(f, C.Accent, 1, 0.6)
                local tl = new("TextLabel", {
                    Size=UDim2.new(1,-20,0,20), Position=UDim2.new(0,10,0,4),
                    BackgroundTransparency=1, Text=o.Title or "Info",
                    TextColor3=C.Accent, Font=Enum.Font.GothamBold, TextSize=12,
                    TextXAlignment=Enum.TextXAlignment.Left, Parent=f,
                })
                local cl = new("TextLabel", {
                    Size=UDim2.new(1,-20,0,22), Position=UDim2.new(0,10,0,24),
                    BackgroundTransparency=1, Text=o.Content or "",
                    TextColor3=C.TextDim, Font=Enum.Font.Gotham, TextSize=11,
                    TextWrapped=true, TextXAlignment=Enum.TextXAlignment.Left,
                    TextYAlignment=Enum.TextYAlignment.Top, Parent=f,
                })
                local obj = {}
                function obj:Set(t)
                    if t and t.Title then tl.Text = t.Title end
                    if t and t.Content then cl.Text = t.Content end
                end
                return obj
            end

            return tab
        end

        function Win:Notify(o)
            notify(o.Title or "Quind", o.Content or "", o.Duration)
        end

        return Win
    end
end

-- ═══════════════ STATE ═══════════════
local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS        = game:GetService("UserInputService")
local Lighting   = game:GetService("Lighting")
local TS         = game:GetService("TeleportService")
local Http       = game:GetService("HttpService")
local VU         = game:GetService("VirtualUser")
local RS         = game:GetService("ReplicatedStorage")
local LP  = Players.LocalPlayer
local Cam = workspace.CurrentCamera

local S = {
    speedOn=false, speedVal=50, jumpOn=false, jumpVal=100, infJump=false,
    noclip=false, flyOn=false, flyVal=80, cframeFly=false,
    gravity=false, gravityVal=196.2, hipHeight=2, sitOn=false, walkOnWater=false,
    aimOn=false, aimFov=150, aimSmooth=0.25, aimPart="Head",
    aimVisCheck=true, aimTeamCheck=false, triggerBot=false,
    espOn=false, espName=true, espHP=true, espDist=true, espHL=true,
    espMurder=false, espSheriff=false, espInnocent=false,
    fullbright=false, noFog=false, fovOn=false, fovVal=70,
    freeze=false, antiFling=false, antiVoid=false, antiAfk=true,
    antiRag=false, autoResp=false, chatSpam=false, chatMsg="Quind Hub on top",
    ghost=false, charSize=1, camLock=false,
    hlWeapons=false, hideTools=false,
    autoEquipGun=false, autoEquipKnife=false, autoReload=false,
    spin=false, spinSpeed=5, jumpBoost=false,
    -- 18+ prank state
    rizzOn=false, sigmaOn=false, autoFlirt=false, yandereOn=false,
}
local flyBV, espCache, roleHL = nil, {}, {}

local Win = UI:CreateWindow({
    Name = "Quind Hub",
    Subtitle = "made by hashtrash",
})

local function nf(t, c, d) Win:Notify({Title=t, Content=c, Duration=d}) end
local function role(p)
    if not p or not p.Character then return "Unknown" end
    for _, t in ipairs(p.Character:GetChildren()) do
        if t:IsA("Tool") then
            local n = t.Name:lower()
            if n:find("knife") then return "Murderer" end
            if n:find("gun") or n:find("revolver") or n:find("pistol") then return "Sheriff" end
        end
    end
    return "Innocent"
end
local function hum() return LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") end
local function hrp() return LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") end
local function dist(a,b) return (a-b).Magnitude end
local function say(msg)
    pcall(function() RS.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All") end)
end

-- ═══════════════════════════════════════════════════════════
-- TAB 1: MOVEMENT
-- ═══════════════════════════════════════════════════════════
local T1 = Win:CreateTab("Movement")
T1:CreateSection("Speed")
T1:CreateToggle({Name="Enable Speed", Callback=function(v) S.speedOn=v end})
T1:CreateSlider({Name="Speed Value", Range={16,300}, Increment=1, Suffix=" ws", CurrentValue=50, Callback=function(v) S.speedVal=v end})
T1:CreateToggle({Name="Sprint (Shift x1.5)", Callback=function(v) _G.Q_sprint=v end})
T1:CreateToggle({Name="Walk On Water", Callback=function(v) S.walkOnWater=v end})
T1:CreateSection("Jump")
T1:CreateToggle({Name="Enable Jump Power", Callback=function(v) S.jumpOn=v end})
T1:CreateSlider({Name="Jump Power", Range={50,500}, Increment=1, CurrentValue=100, Callback=function(v) S.jumpVal=v end})
T1:CreateToggle({Name="Infinite Jump", Callback=function(v) S.infJump=v end})
T1:CreateToggle({Name="High Jump Boost (x2)", Callback=function(v) S.jumpBoost=v end})
T1:CreateSection("Fly & Noclip")
T1:CreateToggle({Name="Noclip", Callback=function(v) S.noclip=v end})
T1:CreateToggle({Name="Fly (BodyVelocity)", Callback=function(v) S.flyOn=v end})
T1:CreateSlider({Name="Fly Speed", Range={10,300}, Increment=1, CurrentValue=80, Callback=function(v) S.flyVal=v end})
T1:CreateToggle({Name="CFrame Fly", Callback=function(v) S.cframeFly=v end})
T1:CreateSection("Physics")
T1:CreateToggle({Name="Low Gravity", Callback=function(v) S.gravity=v end})
T1:CreateSlider({Name="Gravity Value", Range={10,196}, Increment=1, CurrentValue=50, Callback=function(v) S.gravityVal=v end})
T1:CreateSlider({Name="HipHeight", Range={0,20}, Increment=0.5, CurrentValue=2, Callback=function(v) S.hipHeight=v end})
T1:CreateSection("Extras")
T1:CreateToggle({Name="Auto-Sit (sliding)", Callback=function(v) S.sitOn=v end})
T1:CreateToggle({Name="Spin Character", Callback=function(v) S.spin=v end})
T1:CreateSlider({Name="Spin Speed", Range={1,30}, Increment=1, CurrentValue=5, Callback=function(v) S.spinSpeed=v end})
T1:CreateButton({Name="Reset Movement", Callback=function()
    S.speedOn,S.jumpOn,S.flyOn,S.noclip,S.infJump=false,false,false,false,false
    nf("Movement","сброшено")
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 2: COMBAT
-- ═══════════════════════════════════════════════════════════
local T2 = Win:CreateTab("Combat")
T2:CreateSection("Aimbot")
T2:CreateToggle({Name="Enable Aimbot (Camera)", Callback=function(v) S.aimOn=v end})
T2:CreateSlider({Name="Aimbot FOV (px)", Range={30,500}, Increment=5, CurrentValue=150, Callback=function(v) S.aimFov=v end})
T2:CreateSlider({Name="Smoothing", Range={0.05,1}, Increment=0.05, CurrentValue=0.25, Callback=function(v) S.aimSmooth=v end})
T2:CreateDropdown({Name="Target Part", Options={"Head","HumanoidRootPart","UpperTorso","Torso"},
    CurrentOption={"Head"}, Callback=function(o) S.aimPart = type(o)=="table" and o[1] or o end})
T2:CreateToggle({Name="Visible Check", Callback=function(v) S.aimVisCheck=v end})
T2:CreateToggle({Name="Team Check (skip Innocents)", Callback=function(v) S.aimTeamCheck=v end})
T2:CreateSection("Trigger")
T2:CreateToggle({Name="Trigger Bot", Callback=function(v) S.triggerBot=v end})
T2:CreateButton({Name="Force Fire Tool", Callback=function()
    if LP.Character then
        for _, t in ipairs(LP.Character:GetChildren()) do
            if t:IsA("Tool") then
                for _, r in ipairs(t:GetChildren()) do
                    if r:IsA("RemoteEvent") then pcall(function() r:FireServer() end) end
                end
            end
        end
    end
end})
T2:CreateButton({Name="Force Reload", Callback=function()
    if LP.Character then
        for _, t in ipairs(LP.Character:GetChildren()) do
            if t:IsA("Tool") then
                for _, r in ipairs(t:GetChildren()) do
                    if r:IsA("RemoteEvent") then pcall(function() r:FireServer("Reload") end) end
                end
            end
        end
    end
end})
T2:CreateToggle({Name="Auto Reload", Callback=function(v) S.autoReload=v end})
T2:CreateSection("Knife")
T2:CreateButton({Name="Auto-Equip Knife", Callback=function()
    for _, t in ipairs(LP.Backpack:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("knife") then t.Parent=LP.Character; nf("Knife","equipped"); return end
    end
    nf("Knife","нет")
end})
T2:CreateButton({Name="Swing Knife x5", Callback=function()
    task.spawn(function()
        for i=1,5 do
            if LP.Character then
                for _, t in ipairs(LP.Character:GetChildren()) do
                    if t:IsA("Tool") and t.Name:lower():find("knife") then
                        for _, r in ipairs(t:GetChildren()) do
                            if r:IsA("RemoteEvent") then pcall(function() r:FireServer() end) end
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end})
T2:CreateButton({Name="Face Nearest Player", Callback=function()
    local best, bd
    for _, p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and hrp() then
            local d = dist(p.Character.HumanoidRootPart.Position, hrp().Position)
            if not bd or d<bd then bd=d; best=p end
        end
    end
    if best and hrp() then
        local pos = best.Character.HumanoidRootPart.Position
        hrp().CFrame = CFrame.new(hrp().Position, Vector3.new(pos.X, hrp().Position.Y, pos.Z))
    end
end})
T2:CreateParagraph({Title="Про Silent Aim", Content="В MM2 урон валидируется сервером. Silent Aim и Kill Aura невозможны — только Camera Aimbot."})
T2:CreateButton({Name="Test Aimbot (highlight 3s)", Callback=function()
    local target = _G.Q_getClosest and _G.Q_getClosest()
    if target and target.Parent then
        local hl = Instance.new("Highlight", target.Parent)
        hl.FillColor = Color3.fromRGB(255,0,255); hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
        task.delay(3, function() hl:Destroy() end)
        nf("Aimbot","цель подсвечена")
    else nf("Aimbot","цель не найдена") end
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 3: ESP
-- ═══════════════════════════════════════════════════════════
local T3 = Win:CreateTab("ESP")
T3:CreateSection("Players")
T3:CreateToggle({Name="Enable Player ESP", Callback=function(v) S.espOn=v end})
T3:CreateToggle({Name="Show Name", CurrentValue=true, Callback=function(v) S.espName=v end})
T3:CreateToggle({Name="Show Health", CurrentValue=true, Callback=function(v) S.espHP=v end})
T3:CreateToggle({Name="Show Distance", CurrentValue=true, Callback=function(v) S.espDist=v end})
T3:CreateToggle({Name="Highlight Body", CurrentValue=true, Callback=function(v) S.espHL=v end})
T3:CreateSection("Role Filters")
T3:CreateToggle({Name="Murderer (Red HL)", Callback=function(v) S.espMurder=v end})
T3:CreateToggle({Name="Sheriff (Blue HL)", Callback=function(v) S.espSheriff=v end})
T3:CreateToggle({Name="Innocent (Green HL)", Callback=function(v) S.espInnocent=v end})
T3:CreateSection("Objects")
T3:CreateToggle({Name="Highlight Weapons", Callback=function(v) S.hlWeapons=v end})
T3:CreateToggle({Name="Highlight Coins", Callback=function(v) _G.Q_hlCoins=v end})
T3:CreateSection("Advanced")
T3:CreateToggle({Name="Ignore Dead", CurrentValue=true, Callback=function(v) _G.Q_ignoreDead=v end})
T3:CreateToggle({Name="Rainbow ESP", Callback=function(v) _G.Q_espRainbow=v end})
T3:CreateButton({Name="Clear All ESP", Callback=function()
    for _, e in pairs(espCache) do
        if e.hl then e.hl:Destroy() end
        if e.bg then e.bg:Destroy() end
    end
    espCache = {}; nf("ESP","очищено")
end})
T3:CreateButton({Name="Reset ESP", Callback=function()
    S.espOn=false; nf("ESP","сброшено")
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 4: VISUAL
-- ═══════════════════════════════════════════════════════════
local T4 = Win:CreateTab("Visual")
T4:CreateSection("Lighting")
T4:CreateToggle({Name="Fullbright", Callback=function(v) S.fullbright=v end})
T4:CreateToggle({Name="Remove Fog", Callback=function(v) S.noFog=v end})
T4:CreateButton({Name="Set Day (12:00)", Callback=function() Lighting.ClockTime=12 end})
T4:CreateButton({Name="Set Night (00:00)", Callback=function() Lighting.ClockTime=0 end})
T4:CreateButton({Name="Blood Moon", Callback=function()
    Lighting.Ambient=Color3.fromRGB(80,0,0)
    Lighting.OutdoorAmbient=Color3.fromRGB(60,0,0); Lighting.Brightness=1
end})
T4:CreateButton({Name="Reset Lighting", Callback=function()
    Lighting.Ambient=Color3.fromRGB(70,70,70)
    Lighting.OutdoorAmbient=Color3.fromRGB(128,128,128)
    Lighting.Brightness=1; Lighting.FogEnd=1e5; Lighting.ClockTime=14
    S.fullbright,S.noFog=false,false
end})
T4:CreateSection("Camera")
T4:CreateToggle({Name="FOV Changer", Callback=function(v) S.fovOn=v end})
T4:CreateSlider({Name="FOV Value", Range={40,140}, Increment=1, Suffix="°", CurrentValue=70, Callback=function(v) S.fovVal=v end})
T4:CreateButton({Name="First Person", Callback=function() LP.CameraMode=Enum.CameraMode.LockFirstPerson end})
T4:CreateButton({Name="Third Person", Callback=function() LP.CameraMode=Enum.CameraMode.Classic end})
T4:CreateButton({Name="Reset FOV", Callback=function() Cam.FieldOfView=70; S.fovOn=false end})
T4:CreateSection("Effects")
T4:CreateToggle({Name="Disable Shadows", Callback=function(v) Lighting.GlobalShadows = not v end})
T4:CreateButton({Name="Remove Particles", Callback=function()
    for _, o in ipairs(workspace:GetDescendants()) do
        if o:IsA("ParticleEmitter") or o:IsA("Fire") or o:IsA("Smoke") then o.Enabled=false end
    end
end})
T4:CreateButton({Name="Remove Textures", Callback=function()
    for _, o in ipairs(workspace:GetDescendants()) do
        if o:IsA("Decal") or o:IsA("Texture") then o.Transparency=1 end
    end
end})
T4:CreateButton({Name="Restore Textures", Callback=function()
    for _, o in ipairs(workspace:GetDescendants()) do
        if o:IsA("Decal") or o:IsA("Texture") then o.Transparency=0 end
    end
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 5: TELEPORT
-- ═══════════════════════════════════════════════════════════
local T5 = Win:CreateTab("Teleport")
local tpDD = T5:CreateDropdown({Name="Player", Options={"(refresh)"}, CurrentOption={"(refresh)"}, Callback=function() end})
T5:CreateButton({Name="Refresh Player List", Callback=function()
    local l = {}
    for _, p in ipairs(Players:GetPlayers()) do if p~=LP then table.insert(l, p.Name) end end
    if #l==0 then l={"(none)"} end
    tpDD:Refresh(l)
end})
T5:CreateSection("To Player")
T5:CreateButton({Name="Teleport To Selected", Callback=function()
    local t = Players:FindFirstChild(tpDD.CurrentOption)
    if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") and hrp() then
        hrp().CFrame = t.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
    end
end})
T5:CreateButton({Name="Teleport Behind Selected", Callback=function()
    local t = Players:FindFirstChild(tpDD.CurrentOption)
    if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") and hrp() then
        hrp().CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0,3,3)
    end
end})
T5:CreateButton({Name="Teleport To Random", Callback=function()
    local l = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then table.insert(l,p) end
    end
    if #l>0 and hrp() then
        local t = l[math.random(1,#l)]
        hrp().CFrame = t.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
    end
end})
T5:CreateSection("Map")
T5:CreateButton({Name="Teleport To Gun", Callback=function()
    for _, o in ipairs(workspace:GetDescendants()) do
        if o:IsA("Tool") or (o:IsA("BasePart") and o.Name:lower():find("gun")) then
            local pt = o:IsA("BasePart") and o or o:FindFirstChildWhichIsA("BasePart")
            if pt and hrp() then hrp().CFrame = pt.CFrame+Vector3.new(0,3,0); return end
        end
    end
    nf("TP","gun не найден")
end})
T5:CreateButton({Name="Teleport To Knife", Callback=function()
    for _, o in ipairs(workspace:GetDescendants()) do
        if o.Name:lower():find("knife") then
            local pt = o:IsA("BasePart") and o or o:FindFirstChildWhichIsA("BasePart")
            if pt and hrp() then hrp().CFrame = pt.CFrame+Vector3.new(0,3,0); return end
        end
    end
    nf("TP","knife не найден")
end})
T5:CreateButton({Name="Teleport To Random Coin", Callback=function()
    local coins = {}
    for _, o in ipairs(workspace:GetDescendants()) do
        if o.Name:lower():find("coin") and o:IsA("BasePart") then table.insert(coins, o) end
    end
    if #coins>0 and hrp() then hrp().CFrame = coins[math.random(1,#coins)].CFrame+Vector3.new(0,3,0)
    else nf("TP","монет нет") end
end})
T5:CreateSection("Coordinates")
local xI = T5:CreateInput({Name="X", PlaceholderText="0"})
local yI = T5:CreateInput({Name="Y", PlaceholderText="50"})
local zI = T5:CreateInput({Name="Z", PlaceholderText="0"})
T5:CreateButton({Name="Teleport To Coordinates", Callback=function()
    if hrp() then
        hrp().CFrame = CFrame.new(tonumber(xI.Text) or 0, tonumber(yI.Text) or 50, tonumber(zI.Text) or 0)
    end
end})
T5:CreateSection("Extras")
T5:CreateButton({Name="Save Position", Callback=function() if hrp() then _G.Q_saved = hrp().CFrame; nf("TP","сохранено") end end})
T5:CreateButton({Name="Load Position", Callback=function() if _G.Q_saved and hrp() then hrp().CFrame=_G.Q_saved end end})
T5:CreateButton({Name="Up +50", Callback=function() if hrp() then hrp().CFrame=hrp().CFrame+Vector3.new(0,50,0) end end})
T5:CreateButton({Name="Forward +50", Callback=function() if hrp() then hrp().CFrame=hrp().CFrame+Cam.CFrame.LookVector*50 end end})
T5:CreateButton({Name="To Spawn", Callback=function()
    local sp = workspace:FindFirstChildOfClass("SpawnLocation")
    if sp and hrp() then hrp().CFrame=sp.CFrame+Vector3.new(0,5,0) end
end})
T5:CreateButton({Name="To Highest Point", Callback=function()
    local top, y = nil, -math.huge
    for _, o in ipairs(workspace:GetDescendants()) do
        if o:IsA("BasePart") and o.Anchored and o.Position.Y>y then y=o.Position.Y; top=o end
    end
    if top and hrp() then hrp().CFrame=top.CFrame+Vector3.new(0,5,0) end
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 6: WEAPONS
-- ═══════════════════════════════════════════════════════════
local T6 = Win:CreateTab("Weapons")
T6:CreateSection("Equip")
T6:CreateButton({Name="Equip Gun", Callback=function()
    for _, t in ipairs(LP.Backpack:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("gun") then t.Parent=LP.Character; nf("Weapons","gun"); return end
    end
    nf("Weapons","gun нет")
end})
T6:CreateButton({Name="Equip Knife", Callback=function()
    for _, t in ipairs(LP.Backpack:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("knife") then t.Parent=LP.Character; nf("Weapons","knife"); return end
    end
    nf("Weapons","knife нет")
end})
T6:CreateButton({Name="Equip Any", Callback=function()
    for _, t in ipairs(LP.Backpack:GetChildren()) do
        if t:IsA("Tool") then t.Parent=LP.Character; nf("Weapons",t.Name); return end
    end
end})
T6:CreateToggle({Name="Auto-Equip Gun", Callback=function(v) S.autoEquipGun=v end})
T6:CreateToggle({Name="Auto-Equip Knife", Callback=function(v) S.autoEquipKnife=v end})
T6:CreateSection("Drop")
T6:CreateButton({Name="Drop Current", Callback=function()
    if LP.Character then for _, t in ipairs(LP.Character:GetChildren()) do
        if t:IsA("Tool") then t.Parent=LP.Backpack; break end
    end end
end})
T6:CreateButton({Name="Drop All", Callback=function()
    if LP.Character then for _, t in ipairs(LP.Character:GetChildren()) do
        if t:IsA("Tool") then t.Parent=LP.Backpack end
    end end
end})
T6:CreateSection("Tracking")
T6:CreateToggle({Name="Highlight Weapons", Callback=function(v) S.hlWeapons=v end})
T6:CreateToggle({Name="Hide Others' Tools", Callback=function(v) S.hideTools=v end})
T6:CreateToggle({Name="Auto Reload", Callback=function(v) S.autoReload=v end})
T6:CreateSection("Inventory")
local invP = T6:CreateParagraph({Title="Inventory", Content="?"})
T6:CreateButton({Name="Refresh Inventory", Callback=function()
    local l = {}
    for _, t in ipairs(LP.Backpack:GetChildren()) do if t:IsA("Tool") then table.insert(l, t.Name) end end
    if LP.Character then for _, t in ipairs(LP.Character:GetChildren()) do
        if t:IsA("Tool") then table.insert(l, "["..t.Name.."]") end
    end end
    invP:Set({Title="Inventory", Content=#l>0 and table.concat(l,", ") or "пусто"})
end})
T6:CreateButton({Name="Check Ammo", Callback=function()
    if not LP.Character then return end
    for _, t in ipairs(LP.Character:GetChildren()) do
        if t:IsA("Tool") then
            local a = t:FindFirstChild("Ammo") or t:FindFirstChild("AmmoValue") or t:FindFirstChild("Clip")
            if a then nf("Ammo", t.Name..": "..tostring(a.Value or a.Name)); return end
        end
    end
    nf("Ammo","счётчик не найден")
end})
T6:CreateSection("Utility")
T6:CreateButton({Name="Unequip All", Callback=function()
    if LP.Character then for _, t in ipairs(LP.Character:GetChildren()) do
        if t:IsA("Tool") then t.Parent=LP.Backpack end
    end end
end})
T6:CreateButton({Name="Reset Weapon Settings", Callback=function()
    S.hlWeapons,S.hideTools,S.autoEquipGun,S.autoEquipKnife=false,false,false,false
end})
T6:CreateButton({Name="Print Tools", Callback=function()
    print("=== Tools ==="); for _, t in ipairs(LP.Backpack:GetChildren()) do
        if t:IsA("Tool") then print(t.Name) end
    end
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 7: CHARACTER
-- ═══════════════════════════════════════════════════════════
local T7 = Win:CreateTab("Character")
T7:CreateSection("Size")
T7:CreateSlider({Name="Body Scale", Range={0.3,3}, Increment=0.1, CurrentValue=1, Callback=function(v)
    local h=hum(); if h then h.BodyHeightScale.Value=v; h.BodyWidthScale.Value=v; h.BodyDepthScale.Value=v; h.HeadScale.Value=v end
end})
T7:CreateSlider({Name="Head Scale", Range={0.3,3}, Increment=0.1, CurrentValue=1, Callback=function(v)
    if LP.Character then
        local hd = LP.Character:FindFirstChild("Head")
        if hd then for _, m in ipairs(hd:GetChildren()) do
            if m:IsA("SpecialMesh") then m.Scale=Vector3.new(v,v,v) end
        end end
    end
end})
T7:CreateSection("Visibility")
T7:CreateSlider({Name="Transparency", Range={0,1}, Increment=0.05, CurrentValue=0, Callback=function(v)
    if LP.Character then for _, p in ipairs(LP.Character:GetDescendants()) do
        if p:IsA("BasePart") then p.Transparency=v end
    end end
end})
T7:CreateToggle({Name="Ghost Mode", Callback=function(v) S.ghost=v end})
T7:CreateButton({Name="Hide Accessories", Callback=function()
    if LP.Character then for _, a in ipairs(LP.Character:GetChildren()) do
        if a:IsA("Accessory") or a:IsA("Hat") then a:Destroy() end
    end end
end})
T7:CreateSection("Actions")
T7:CreateButton({Name="Ragdoll", Callback=function() local h=hum(); if h then h.PlatformStand=true end end})
T7:CreateButton({Name="Unragdoll", Callback=function() local h=hum(); if h then h.PlatformStand=false end end})
T7:CreateButton({Name="Sit", Callback=function() local h=hum(); if h then h.Sit=true end end})
T7:CreateButton({Name="Stand", Callback=function() local h=hum(); if h then h.Sit=false end end})
T7:CreateButton({Name="Reset Character", Callback=function() if LP.Character then LP.Character:BreakJoints() end end})
T7:CreateSection("Emotes")
local emDD = T7:CreateDropdown({Name="Emote", Options={"wave","dance","dance2","dance3","laugh","cheer","point","salute"}, CurrentOption={"wave"}, Callback=function() end})
T7:CreateButton({Name="Play Emote", Callback=function()
    local h = hum()
    if h then
        local n = type(emDD.CurrentOption)=="table" and emDD.CurrentOption[1] or emDD.CurrentOption
        pcall(function() h:PlayEmote(n) end)
    end
end})
T7:CreateToggle({Name="Emote Spam", Callback=function(v) _G.Q_emoteSpam=v end})
T7:CreateSection("Camera")
T7:CreateToggle({Name="Lock Camera To Head", Callback=function(v) S.camLock=v end})
T7:CreateButton({Name="Reset Camera", Callback=function()
    Cam.CameraSubject = hum(); Cam.CameraType = Enum.CameraType.Custom
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 8: ROLES & INFO
-- ═══════════════════════════════════════════════════════════
local T8 = Win:CreateTab("Roles & Info")
local myRP = T8:CreateParagraph({Title="My Role", Content="-"})
local alP  = T8:CreateParagraph({Title="Alive", Content="-"})
local muP  = T8:CreateParagraph({Title="Murderer", Content="-"})
local shP  = T8:CreateParagraph({Title="Sheriff", Content="-"})
local dmP  = T8:CreateParagraph({Title="Dist Murderer", Content="-"})
local dsP  = T8:CreateParagraph({Title="Dist Sheriff", Content="-"})
T8:CreateButton({Name="Refresh My Role", Callback=function() myRP:Set({Title="My Role", Content=role(LP)}) end})
T8:CreateButton({Name="Scan All Roles", Callback=function()
    local a,m,s = 0,"-","-"
    for _, p in ipairs(Players:GetPlayers()) do
        local h = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
        if h and h.Health>0 then
            a=a+1; local r = role(p)
            if r=="Murderer" then m=p.Name end
            if r=="Sheriff" then s=p.Name end
        end
    end
    alP:Set({Title="Alive", Content=tostring(a)})
    muP:Set({Title="Murderer", Content=m})
    shP:Set({Title="Sheriff", Content=s})
end})
T8:CreateButton({Name="Print Roles", Callback=function()
    for _, p in ipairs(Players:GetPlayers()) do print(p.Name, role(p)) end
end})
T8:CreateButton({Name="Notify All Roles", Callback=function()
    local l={}; for _, p in ipairs(Players:GetPlayers()) do
        table.insert(l, p.Name..": "..role(p))
    end
    nf("Roles", table.concat(l,", "), 8)
end})
T8:CreateButton({Name="Who Has Knife?", Callback=function()
    for _, p in ipairs(Players:GetPlayers()) do
        if role(p)=="Murderer" then nf("Knife", p.Name); return end
    end
    nf("Knife","не найден")
end})
T8:CreateButton({Name="Who Has Gun?", Callback=function()
    for _, p in ipairs(Players:GetPlayers()) do
        if role(p)=="Sheriff" then nf("Gun", p.Name); return end
    end
    nf("Gun","не найден")
end})
T8:CreateSection("Detectors")
T8:CreateToggle({Name="Murderer Detector (Red)", Callback=function(v) S.espMurder=v end})
T8:CreateToggle({Name="Sheriff Detector (Blue)", Callback=function(v) S.espSheriff=v end})
T8:CreateToggle({Name="Innocent Detector (Green)", Callback=function(v) S.espInnocent=v end})
T8:CreateToggle({Name="Auto-Update Distances", Callback=function(v) _G.Q_autoDist=v end})
T8:CreateToggle({Name="Warn If Murderer <30", Callback=function(v) _G.Q_warnM=v end})
T8:CreateToggle({Name="Warn If Sheriff <30", Callback=function(v) _G.Q_warnS=v end})
T8:CreateSection("Stats")
T8:CreateButton({Name="Count Alive", Callback=function()
    local c=0; for _, p in ipairs(Players:GetPlayers()) do
        local h = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
        if h and h.Health>0 then c=c+1 end
    end
    nf("Alive", tostring(c))
end})
T8:CreateButton({Name="Count Dead", Callback=function()
    local c=0; for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            local h = p.Character:FindFirstChildOfClass("Humanoid")
            if not h or h.Health<=0 then c=c+1 end
        end
    end
    nf("Dead", tostring(c))
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 9: UTILITY
-- ═══════════════════════════════════════════════════════════
local T9 = Win:CreateTab("Utility")
T9:CreateSection("Server")
T9:CreateButton({Name="Rejoin", Callback=function() TS:Teleport(game.PlaceId, LP) end})
T9:CreateButton({Name="Server Hop (smallest)", Callback=function()
    local req = (syn and syn.request) or http_request or request
    if not req then return nf("Error","нет HTTP") end
    local ok, res = pcall(function()
        return req({Url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"})
    end)
    if ok and res and res.Body then
        local d = Http:JSONDecode(res.Body); local best
        for _, s in ipairs(d.data or {}) do
            if s.playing<s.maxPlayers and s.id~=game.JobId then
                if not best or s.playing<best.playing then best=s end
            end
        end
        if best then TS:TeleportToPlaceInstance(game.PlaceId, best.id, LP) end
    end
end})
T9:CreateButton({Name="Copy Job ID", Callback=function()
    if setclipboard then setclipboard(game.JobId); nf("Server","JobID скопирован") end
end})
T9:CreateSection("Character")
T9:CreateToggle({Name="Anti-AFK", CurrentValue=true, Callback=function(v) S.antiAfk=v end})
T9:CreateToggle({Name="Anti-Fling", Callback=function(v) S.antiFling=v end})
T9:CreateToggle({Name="Anti-Void", Callback=function(v) S.antiVoid=v end})
T9:CreateToggle({Name="Anti-Ragdoll", Callback=function(v) S.antiRag=v end})
T9:CreateToggle({Name="Auto-Respawn", Callback=function(v) S.autoResp=v end})
T9:CreateToggle({Name="Freeze", Callback=function(v) S.freeze=v end})
T9:CreateSection("Chat")
local chatI = T9:CreateInput({Name="Message", CurrentValue="Quind Hub on top", PlaceholderText="текст"})
T9:CreateToggle({Name="Chat Spam", Callback=function(v) S.chatSpam=v end})
T9:CreateButton({Name="Send Once", Callback=function() say(chatI.Text) end})
T9:CreateSection("System")
T9:CreateButton({Name="Show Ping", Callback=function()
    local s = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]
    nf("Ping", math.floor(s:GetValue()).." ms")
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 10: ANTI / PROTECTION
-- ═══════════════════════════════════════════════════════════
local T10 = Win:CreateTab("Anti / Protection")
T10:CreateSection("Auto-Defend")
T10:CreateToggle({Name="Auto-Flee From Murderer", Callback=function(v) _G.Q_flee=v end})
T10:CreateToggle({Name="Auto-Jump When Murderer Near", Callback=function(v) _G.Q_autoJumpM=v end})
T10:CreateToggle({Name="Auto-Teleport From Murderer", Callback=function(v) _G.Q_tpFrom=v end})
T10:CreateButton({Name="Panic: Random TP", Callback=function()
    if hrp() then hrp().CFrame = CFrame.new(math.random(-200,200), 80, math.random(-200,200)) end
end})
T10:CreateSection("Detections")
T10:CreateToggle({Name="Warn On Knife Equip", Callback=function(v) _G.Q_warnKnife=v end})
T10:CreateToggle({Name="Warn On Gun Equip", Callback=function(v) _G.Q_warnGun=v end})
T10:CreateToggle({Name="Warn On Approach (<15)", Callback=function(v) _G.Q_warnApproach=v end})
T10:CreateToggle({Name="Highlight Who's Looking At You", Callback=function(v) _G.Q_watchers=v end})
T10:CreateSection("Bypass")
T10:CreateButton({Name="Reset Velocity", Callback=function()
    local r = hrp(); if r then r.AssemblyLinearVelocity = Vector3.zero end
end})
T10:CreateButton({Name="Clear BodyMovers", Callback=function()
    if LP.Character then for _, o in ipairs(LP.Character:GetDescendants()) do
        if o:IsA("BodyVelocity") or o:IsA("BodyGyro") or o:IsA("BodyAngularVelocity") then o:Destroy() end
    end end
end})
T10:CreateButton({Name="Reset WalkSpeed", Callback=function()
    local h = hum(); if h then h.WalkSpeed=16 end; S.speedOn=false
end})
T10:CreateButton({Name="Reset JumpPower", Callback=function()
    local h = hum(); if h then h.JumpPower=50 end; S.jumpOn=false
end})
T10:CreateButton({Name="Panic: Disable All", Callback=function()
    S.speedOn,S.jumpOn,S.flyOn,S.noclip,S.aimOn,S.espOn,S.triggerBot=false,false,false,false,false,false,false
    S.antiFling,S.antiVoid,S.ghost=false,false,false
    _G.Q_flee,_G.Q_autoJumpM,_G.Q_tpFrom=false,false,false
    nf("PANIC","всё выключено",6)
end})
T10:CreateButton({Name="Panic: Reset Character", Callback=function()
    if LP.Character then LP.Character:BreakJoints() end
end})
T10:CreateButton({Name="Report Active", Callback=function()
    local on = {}; for k,v in pairs(S) do if v==true then table.insert(on,k) end end
    nf("Active", #on>0 and table.concat(on,", ") or "none", 8)
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 11: 18+  (meme/prank, no real NSFW)
-- ═══════════════════════════════════════════════════════════
local T11 = Win:CreateTab("18+")
T11:CreateParagraph({Title="Внимание", Content="Это мем-пранк таб. Никакого реального NSFW — только безобидные мемные приколы в духе MM2. Не используй на серьёзных серверах."})
T11:CreateSection("Ризз / Приколы в чате")
T11:CreateInput({Name="Rizz Text", CurrentValue="Я не Мурдерер, я МурдерТЫ 😏", PlaceholderText="твой текст"})
local rizzI
T11:CreateSection("Чат-приколы")
local rizzMessages = {
    "Ты такая сладкая, что у меня аж нож выпал 🍬",
    "Я не маньяк, я просто очень настойчивый 💕",
    "Дай мне шанс, я убью за тебя 💀",
    "Мурдерер? Забей, я лучше пойду с тобой 💋",
    "Ты мой Шериф, я твой Мурдерер 💕🔪",
    "Хочешь поцелуй? Только чур без ножа 😘",
    "Я потерял голову... когда увидел тебя 💘",
    "Скинь номер, я скину нож 🗡️😏",
}
T11:CreateButton({Name="Rizz Nearest Player (1 msg)", Callback=function()
    local t = _G.Q_getClosest and _G.Q_getClosest()
    if t and t.Parent then
        local plr = Players:GetPlayerFromCharacter(t.Parent)
        if plr then say(plr.Name..", "..rizzMessages[math.random(1,#rizzMessages)]) end
    else nf("Rizz","никого рядом") end
end})
T11:CreateToggle({Name="Auto-Rizz Everyone (spam)", Callback=function(v) S.rizzOn=v end})
T11:CreateButton({Name="Fake Ban Message", Callback=function()
    local r = math.random(1,5)
    local names = {"Nomik","Smokey","Boss","Gamer","Toxic"}
    say("[SERVER] "..names[r].." был забанен за 'подозрительный риззинг' (пранк)")
end})
T11:CreateButton({Name="Fake Admin Notice", Callback=function()
    say("[ADMIN] Хэштег trash заходит в игру... готовьтесь 🗿")
end})
T11:CreateButton({Name="Fake Doxx (шутка)", Callback=function()
    say("[DATA] IP: 127.0.0.1 | Страна: Антарктида | Возраст: 99 (шутка, шутка)")
end})
T11:CreateSection("Активности")
T11:CreateButton({Name="Slap Nearest (Kick Animation)", Callback=function()
    local h = hum()
    if h then
        local emote = math.random(1,3)
        pcall(function() h:PlayEmote("kick") end)
        nf("Slap","шлёпнул ✋")
    end
end})
T11:CreateButton({Name="Kiss Emote on Killer", Callback=function()
    local murderer
    for _, p in ipairs(Players:GetPlayers()) do
        if role(p)=="Murderer" then murderer=p; break end
    end
    if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") and hrp() then
        hrp().CFrame = murderer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,2)
        local h = hum()
        if h then pcall(function() h:PlayEmote("kiss") end) end
        nf("💋","поцеловал убийцу")
    else nf("💋","мурдерер не найден") end
end})
T11:CreateToggle({Name="Sigma Mode (walk anim + chat)", Callback=function(v) S.sigmaOn=v end})
T11:CreateToggle({Name="Chad Walk (медленный)", Callback=function(v) _G.Q_chadWalk=v end})
T11:CreateToggle({Name="Yandere Mode (следуй за ближайшим)", Callback=function(v) S.yandereOn=v end})
T11:CreateToggle({Name="Auto-Flirt With Murderer", Callback=function(v) S.autoFlirt=v end})
T11:CreateToggle({Name="Simp Mode (кидай оружие рядом)", Callback=function(v) _G.Q_simp=v end})
T11:CreateSection("Эффекты")
T11:CreateButton({Name="Gigachad Aura (particles)", Callback=function()
    if hrp() then
        local att = Instance.new("Attachment", hrp())
        local pe = Instance.new("ParticleEmitter", att)
        pe.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        pe.Rate = 30; pe.Lifetime = NumberRange.new(0.5,1)
        pe.Speed = NumberRange.new(2,5); pe.SpreadAngle = Vector2.new(180,180)
        pe.Color = ColorSequence.new(Color3.fromRGB(255,220,100))
        pe.Size = NumberSequence.new(0.3)
        task.delay(10, function() pe:Destroy(); att:Destroy() end)
        nf("🗿","gigachad aura активирована")
    end
end})
T11:CreateButton({Name="Dad Joke Spam (5 сообщений)", Callback=function()
    local jokes = {
        "Почему мурдерер не сдал тест? Он резал не по теме 💀",
        "Что сказал шериф ножу? 'Ты меня не режешь' 🔪",
        "Почему инносент проиграл? Он был слишком доверчивым 😔",
        "Как называется мурдерер на пенсии? Экс-резатель 👴",
        "Что общего у ножа и шутки? Оба ранят 💔",
    }
    task.spawn(function()
        for _, j in ipairs(jokes) do say(j); task.wait(1.5) end
    end)
end})
T11:CreateButton({Name="Rizz Meter (fake)", Callback=function()
    local score = math.random(1,100)
    nf("Rizz Meter", score.."/100 — "..(score>80 and "god tier 🗿" or score>50 and "mid 😐" or "скилл ишью 💀"))
end})
T11:CreateButton({Name="Blow Kiss Emote", Callback=function()
    local h = hum()
    if h then pcall(function() h:PlayEmote("point") end); nf("💋","воздушный поцелуй") end
end})
T11:CreateToggle({Name="Wink Emote Spam", Callback=function(v) _G.Q_wink=v end})
T11:CreateSection("Опасное (мемы)")
T11:CreateButton({Name="Fake Death Message", Callback=function()
    local names = {"Ты","Он","Она","Кто-то"}
    say("[KILL] "..names[math.random(1,#names)].." был убит... щекоткой 💀")
end})
T11:CreateButton({Name="Drop All Tools Near Sheriff", Callback=function()
    for _, p in ipairs(Players:GetPlayers()) do
        if role(p)=="Sheriff" and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and hrp() then
            hrp().CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
            if LP.Character then
                for _, t in ipairs(LP.Character:GetChildren()) do
                    if t:IsA("Tool") then t.Parent = LP.Backpack end
                end
            end
            nf("Simp","оружие у шерифа")
            return
        end
    end
    nf("Simp","шериф не найден")
end})

-- ═══════════════════════════════════════════════════════════
-- ═══════════════════ ЛОГИКА ═══════════════════
-- ═══════════════════════════════════════════════════════════

local function getClosest()
    local best, bd = nil, S.aimFov
    for _, p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            local h = p.Character:FindFirstChildOfClass("Humanoid")
            if h and h.Health>0 then
                if S.aimTeamCheck and role(p)=="Innocent" then continue end
                local part = p.Character:FindFirstChild(S.aimPart) or p.Character:FindFirstChild("HumanoidRootPart")
                if part then
                    local sp, on = Cam:WorldToViewportPoint(part.Position)
                    if on then
                        local d = (Vector2.new(sp.X,sp.Y) - Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)).Magnitude
                        if d < bd then bd = d; best = part end
                    end
                end
            end
        end
    end
    return best
end
_G.Q_getClosest = getClosest

-- MAIN LOOP
RunService.Heartbeat:Connect(function()
    local ch = LP.Character
    if not ch then return end
    local h = ch:FindFirstChildOfClass("Humanoid")
    if not h then return end

    if S.freeze then h.WalkSpeed=0; h.JumpPower=0
    else
        local sp = S.speedOn and S.speedVal or 16
        if _G.Q_sprint and UIS:IsKeyDown(Enum.KeyCode.LeftShift) then sp = sp*1.5 end
        if _G.Q_chadWalk then sp = math.min(sp, 4) end
        h.WalkSpeed = sp
        h.JumpPower = S.jumpOn and S.jumpVal or 50
        if S.jumpBoost then h.JumpPower = (S.jumpOn and S.jumpVal or 50)*2 end
    end

    local r = ch:FindFirstChild("HumanoidRootPart")
    if S.flyOn and r then
        if not flyBV or not flyBV.Parent then
            flyBV = Instance.new("BodyVelocity")
            flyBV.MaxForce = Vector3.new(9e9,9e9,9e9)
            flyBV.Velocity = Vector3.zero
            flyBV.Parent = r
        end
        local dir = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
        flyBV.Velocity = dir * S.flyVal
    else
        if flyBV then flyBV:Destroy() flyBV = nil end
    end

    if S.cframeFly and r then
        local move = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
        if move.Magnitude > 0 then r.CFrame = r.CFrame + move * (S.flyVal/60) end
    end

    if S.noclip or S.ghost then
        for _, p in ipairs(ch:GetDescendants()) do
            if p:IsA("BasePart") and p.CanCollide then p.CanCollide=false end
        end
    end

    workspace.Gravity = S.gravity and S.gravityVal or 196.2

    if S.spin and r then
        r.CFrame = r.CFrame * CFrame.Angles(0, math.rad(S.spinSpeed), 0)
    end
    if S.sitOn then h.Sit = true end
    if S.ghost then
        for _, p in ipairs(ch:GetDescendants()) do
            if p:IsA("BasePart") then p.Transparency = 0.7 end
        end
    end
    if S.antiRag and h.PlatformStand then h.PlatformStand = false end

    -- walk on water
    if S.walkOnWater and r then
        local ray = Ray.new(r.Position, Vector3.new(0,-10,0))
        local hit = workspace:FindPartOnRay(ray, ch)
        if hit and hit.Name:lower():find("water") then
            r.CFrame = r.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)

UIS.JumpRequest:Connect(function()
    if S.infJump and hum() then hum():ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- AIMBOT
RunService.RenderStepped:Connect(function()
    if S.aimOn then
        local t = getClosest()
        if t then
            if S.aimVisCheck then
                local ray = Ray.new(Cam.CFrame.Position, (t.Position - Cam.CFrame.Position).Unit * 500)
                local hit = workspace:FindPartOnRay(ray, LP.Character)
                if not hit or not hit:IsDescendantOf(t.Parent) then return end
            end
            Cam.CFrame = Cam.CFrame:Lerp(CFrame.new(Cam.CFrame.Position, t.Position), S.aimSmooth)
        end
    end
    if S.camLock then
        local hd = LP.Character and LP.Character:FindFirstChild("Head")
        if hd then Cam.CameraSubject = hd end
    end
end)

-- TRIGGER BOT
RunService.Heartbeat:Connect(function()
    if S.triggerBot then
        local t = getClosest()
        if t and LP.Character then
            for _, tool in ipairs(LP.Character:GetChildren()) do
                if tool:IsA("Tool") then
                    for _, r in ipairs(tool:GetChildren()) do
                        if r:IsA("RemoteEvent") then pcall(function() r:FireServer() end) end
                    end
                end
            end
        end
    end
end)

-- ESP
local function clearESP(p)
    local e = espCache[p]
    if e then
        if e.hl then e.hl:Destroy() end
        if e.bg then e.bg:Destroy() end
        espCache[p] = nil
    end
end

local function updateESP(p)
    if p == LP then return end
    local ch = p.Character
    if not ch or not S.espOn then clearESP(p); return end
    local h = ch:FindFirstChildOfClass("Humanoid")
    if _G.Q_ignoreDead and (not h or h.Health<=0) then clearESP(p); return end

    local e = espCache[p]
    if not e then
        e = {}
        e.hl = Instance.new("Highlight")
        e.hl.FillColor = Color3.fromRGB(255,60,60)
        e.hl.OutlineColor = Color3.fromRGB(255,255,255)
        e.hl.FillTransparency = 0.55
        e.hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        e.hl.Parent = ch
        e.bg = Instance.new("BillboardGui")
        e.bg.Size = UDim2.new(0,220,0,40)
        e.bg.StudsOffset = Vector3.new(0,3,0)
        e.bg.AlwaysOnTop = true
        e.bg.Parent = ch:FindFirstChild("Head") or ch:FindFirstChild("HumanoidRootPart")
        e.label = Instance.new("TextLabel")
        e.label.Size = UDim2.new(1,0,1,0)
        e.label.BackgroundTransparency = 1
        e.label.TextColor3 = Color3.fromRGB(255,255,255)
        e.label.TextStrokeTransparency = 0
        e.label.Font = Enum.Font.GothamBold
        e.label.TextSize = 14
        e.label.Parent = e.bg
        espCache[p] = e
    end
    e.hl.Parent = ch; e.hl.Enabled = S.espHL
    if _G.Q_espRainbow then e.hl.FillColor = Color3.fromHSV((tick()*0.3)%1, 1, 1) end
    local hd = ch:FindFirstChild("Head") or ch:FindFirstChild("HumanoidRootPart")
    if hd then e.bg.Parent = hd end
    local txt = {}
    if S.espName then table.insert(txt, p.Name) end
    if S.espHP and h then table.insert(txt, "["..math.floor(h.Health).."]") end
    if S.espDist and hrp() and ch:FindFirstChild("HumanoidRootPart") then
        table.insert(txt, math.floor(dist(ch.HumanoidRootPart.Position, hrp().Position)).."m")
    end
    e.label.Text = table.concat(txt, " ")
end

RunService.RenderStepped:Connect(function()
    for _, p in ipairs(Players:GetPlayers()) do updateESP(p) end
end)
Players.PlayerRemoving:Connect(clearESP)

-- Role highlights
RunService.RenderStepped:Connect(function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local r = role(p)
            local want = (S.espMurder and r=="Murderer") or (S.espSheriff and r=="Sheriff") or (S.espInnocent and r=="Innocent")
            local hl = roleHL[p]
            if want then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.FillTransparency = 0.6
                    hl.Parent = p.Character
                    roleHL[p] = hl
                end
                hl.FillColor = r=="Murderer" and Color3.fromRGB(255,0,0)
                             or r=="Sheriff" and Color3.fromRGB(0,120,255)
                             or Color3.fromRGB(0,255,0)
            elseif hl then hl:Destroy(); roleHL[p] = nil end
        end
    end
end)

-- Visual loop
RunService.Heartbeat:Connect(function()
    if S.fullbright then
        Lighting.Ambient = Color3.fromRGB(255,255,255)
        Lighting.Brightness = 2; Lighting.ClockTime = 12
    end
    if S.noFog then Lighting.FogEnd = 1e6; Lighting.FogStart = 1e6 end
    Cam.FieldOfView = S.fovOn and S.fovVal or 70
end)

-- Anti-fling
RunService.Heartbeat:Connect(function()
    if S.antiFling and LP.Character then
        for _, o in ipairs(LP.Character:GetDescendants()) do
            if o:IsA("BodyVelocity") or o:IsA("BodyAngularVelocity") or o:IsA("BodyGyro") then o:Destroy() end
        end
    end
end)

-- Anti-void
RunService.Heartbeat:Connect(function()
    if S.antiVoid and hrp() and hrp().Position.Y < -50 then hrp().CFrame = CFrame.new(0,50,0) end
end)

-- Anti-AFK
LP.Idled:Connect(function()
    if S.antiAfk then VU:CaptureController(); VU:ClickButton2(Vector2.new()) end
end)

-- Auto-respawn
LP.CharacterAdded:Connect(function()
    if S.autoResp then task.wait(0.5); if LP.Character then LP.Character:BreakJoints() end end
end)

-- Chat spam
task.spawn(function()
    while task.wait(2) do
        if S.chatSpam then say(S.chatMsg) end
    end
end)

-- Emote spam
task.spawn(function()
    while task.wait(1.5) do
        if _G.Q_emoteSpam and hum() then pcall(function() hum():PlayEmote("dance") end) end
        if _G.Q_wink and hum() then pcall(function() hum():PlayEmote("point") end) end
    end
end)

-- 18+ rizz spam
task.spawn(function()
    while task.wait(4) do
        if S.rizzOn then
            local t = _G.Q_getClosest and _G.Q_getClosest()
            if t and t.Parent then
                local plr = Players:GetPlayerFromCharacter(t.Parent)
                if plr then say(plr.Name..", "..rizzMessages[math.random(1,#rizzMessages)]) end
            end
        end
    end
end)

-- Yandere mode
RunService.Heartbeat:Connect(function()
    if S.yandereOn and hrp() then
        local best, bd
        for _, p in ipairs(Players:GetPlayers()) do
            if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local d = dist(p.Character.HumanoidRootPart.Position, hrp().Position)
                if not bd or d<bd then bd=d; best=p end
            end
        end
        if best and bd and bd > 4 then
            local target = best.Character.HumanoidRootPart
            local dir = (target.Position - hrp().Position).Unit
            hrp().CFrame = CFrame.new(hrp().Position + dir * 0.3, target.Position)
        end
    end
end)

-- Sigma mode
task.spawn(function()
    while task.wait(5) do
        if S.sigmaOn and hum() then
            local sigmas = {"🗿","Ноль эмоций.","Sigma rule #1: не быть инносентом.","Я не следую правилам, я их игнорирую.","🧊"}
            say(sigmas[math.random(1,#sigmas)])
            pcall(function() hum():PlayEmote("dance2") end)
        end
    end
end)

-- Auto-flirt with murderer
task.spawn(function()
    while task.wait(6) do
        if S.autoFlirt then
            for _, p in ipairs(Players:GetPlayers()) do
                if role(p)=="Murderer" then
                    say(p.Name..", ты выглядишь опасно... мне нравится 😏🔪")
                    break
                end
            end
        end
    end
end)

-- Simp mode
task.spawn(function()
    while task.wait(3) do
        if _G.Q_simp and LP.Character then
            for _, p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and hrp() then
                    if dist(p.Character.HumanoidRootPart.Position, hrp().Position) < 15 then
                        for _, t in ipairs(LP.Character:GetChildren()) do
                            if t:IsA("Tool") then t.Parent = LP.Backpack end
                        end
                        break
                    end
                end
            end
        end
    end
end)

-- Auto-equip
task.spawn(function()
    while task.wait(1) do
        if S.autoEquipGun and LP.Character then
            local has=false
            for _, t in ipairs(LP.Character:GetChildren()) do
                if t:IsA("Tool") and t.Name:lower():find("gun") then has=true end
            end
            if not has then for _, t in ipairs(LP.Backpack:GetChildren()) do
                if t:IsA("Tool") and t.Name:lower():find("gun") then t.Parent=LP.Character; break end
            end end
        end
        if S.autoEquipKnife and LP.Character then
            local has=false
            for _, t in ipairs(LP.Character:GetChildren()) do
                if t:IsA("Tool") and t.Name:lower():find("knife") then has=true end
            end
            if not has then for _, t in ipairs(LP.Backpack:GetChildren()) do
                if t:IsA("Tool") and t.Name:lower():find("knife") then t.Parent=LP.Character; break end
            end end
        end
    end
end)

-- Auto-reload
task.spawn(function()
    while task.wait(3) do
        if S.autoReload and LP.Character then
            for _, t in ipairs(LP.Character:GetChildren()) do
                if t:IsA("Tool") then
                    for _, r in ipairs(t:GetChildren()) do
                        if r:IsA("RemoteEvent") then pcall(function() r:FireServer("Reload") end) end
                    end
                end
            end
        end
    end
end)

-- Weapon highlight
task.spawn(function()
    while task.wait(0.5) do
        if S.hlWeapons then
            for _, o in ipairs(workspace:GetDescendants()) do
                if o:IsA("Tool") then
                    local hl = o:FindFirstChild("__Q_WeaponHL__")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "__Q_WeaponHL__"
                        hl.FillColor = Color3.fromRGB(255,200,0)
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Parent = o
                    end
                end
            end
        else
            for _, o in ipairs(workspace:GetDescendants()) do
                if o:IsA("Tool") then
                    local hl = o:FindFirstChild("__Q_WeaponHL__")
                    if hl then hl:Destroy() end
                end
            end
        end
    end
end)

-- Hide others' tools
task.spawn(function()
    while task.wait(0.3) do
        if S.hideTools then
            for _, p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character then
                    for _, t in ipairs(p.Character:GetChildren()) do
                        if t:IsA("Tool") then
                            for _, part in ipairs(t:GetDescendants()) do
                                if part:IsA("BasePart") then part.LocalTransparencyModifier = 1 end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Auto-dist + warnings
task.spawn(function()
    while task.wait(1) do
        if _G.Q_autoDist and hrp() then
            local dm, ds = "-", "-"
            for _, p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local r = role(p)
                    local d = math.floor(dist(p.Character.HumanoidRootPart.Position, hrp().Position))
                    if r=="Murderer" then dm = d.." studs" end
                    if r=="Sheriff" then ds = d.." studs" end
                end
            end
            dmP:Set({Title="Dist Murderer", Content=dm})
            dsP:Set({Title="Dist Sheriff", Content=ds})
        end
    end
end)

-- Auto-defend
RunService.Heartbeat:Connect(function()
    if not hrp() then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d = dist(p.Character.HumanoidRootPart.Position, hrp().Position)
            local r = role(p)
            if r=="Murderer" and d<30 then
                if _G.Q_warnM then nf("⚠ MURDERER", p.Name.." в "..math.floor(d), 2) end
                if _G.Q_flee then
                    local away = (hrp().Position - p.Character.HumanoidRootPart.Position).Unit * 40
                    hrp().CFrame = hrp().CFrame + away
                end
                if _G.Q_autoJumpM then
                    local h = hum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
                end
                if _G.Q_tpFrom then
                    hrp().CFrame = CFrame.new(math.random(-150,150), 80, math.random(-150,150))
                end
            end
            if r=="Sheriff" and d<30 and _G.Q_warnS then nf("⚠ SHERIFF", p.Name.." в "..math.floor(d), 2) end
        end
    end
end)

-- Watcher detector
task.spawn(function()
    while task.wait(0.5) do
        if _G.Q_watchers then
            for _, p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character and p.Character:FindFirstChild("Head") and hrp() then
                    local look = p.Character.Head.CFrame.LookVector
                    local toMe = (hrp().Position - p.Character.Head.Position).Unit
                    if look:Dot(toMe) > 0.85 then nf("👁","" ..p.Name.." смотрит", 1.5) end
                end
            end
        end
    end
end)

nf("Quind Hub", "Загружено. made by hashtrash.", 6)
