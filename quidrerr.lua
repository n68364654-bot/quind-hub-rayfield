-- ═══════════════════════════════════════════════════════════
--   QUIND HUB ULTIMATE — made by hashtrash
--   30 tabs | 600+ funcs | music player | icons
-- ═══════════════════════════════════════════════════════════

-- ═══════════════ UI LIBRARY ═══════════════
local UI = {}
do
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local LP = Players.LocalPlayer
    local function new(c,p) local o=Instance.new(c); for k,v in pairs(p) do if k~="Parent" then o[k]=v end end; if p.Parent then o.Parent=p.Parent end; return o end
    local function corner(p,r) local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 6); c.Parent=p; return c end
    local function pad(p,t,r,b,l) local x=Instance.new("UIPadding"); x.PaddingTop=UDim.new(0,t or 0); x.PaddingRight=UDim.new(0,r or 0); x.PaddingBottom=UDim.new(0,b or 0); x.PaddingLeft=UDim.new(0,l or 0); x.Parent=p; return x end
    local function stroke(p,c,t,tr) local s=Instance.new("UIStroke"); s.Color=c or Color3.fromRGB(55,55,75); s.Thickness=t or 1; s.Transparency=tr or 0; s.Parent=p; return s end
    local C={BG=Color3.fromRGB(18,18,24),Sidebar=Color3.fromRGB(24,24,32),Title=Color3.fromRGB(28,28,38),Content=Color3.fromRGB(22,22,28),Elem=Color3.fromRGB(35,35,48),ElemHov=Color3.fromRGB(46,46,62),Accent=Color3.fromRGB(118,138,255),Text=Color3.fromRGB(235,235,245),TextDim=Color3.fromRGB(150,150,170),Toggle=Color3.fromRGB(80,220,120),Danger=Color3.fromRGB(255,80,90),Dark=Color3.fromRGB(28,28,38),Success=Color3.fromRGB(80,220,120),Info=Color3.fromRGB(118,180,255)}
    function UI:CreateWindow(opts)
        opts=opts or {}
        local gui=new("ScreenGui",{Name="QuindUI",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling})
        local par=pcall(function() return game:GetService("CoreGui") end)
        gui.Parent=par and game:GetService("CoreGui") or LP:WaitForChild("PlayerGui")
        local main=new("Frame",{Size=UDim2.new(0,720,0,500),Position=UDim2.new(0.5,-360,0.5,-250),BackgroundColor3=C.BG,BorderSizePixel=0,Parent=gui,Active=true})
        corner(main,10); stroke(main,Color3.fromRGB(50,50,70),1,0.3)
        local tb=new("Frame",{Size=UDim2.new(1,0,0,38),BackgroundColor3=C.Title,BorderSizePixel=0,Parent=main})
        corner(tb,10)
        new("Frame",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,1,-14),BackgroundColor3=C.Title,BorderSizePixel=0,Parent=tb})
        new("TextLabel",{Size=UDim2.new(1,-100,1,0),Position=UDim2.new(0,42,0,0),BackgroundTransparency=1,Text=opts.Name or "UI",TextColor3=C.Text,TextSize=15,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,Parent=tb})
        new("TextLabel",{Size=UDim2.new(0,240,1,0),Position=UDim2.new(1,-320,0,0),BackgroundTransparency=1,Text=opts.Subtitle or "",TextColor3=C.TextDim,TextSize=11,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Right,Parent=tb})
        new("TextLabel",{Size=UDim2.new(0,32,0,32),Position=UDim2.new(0,8,0,3),BackgroundTransparency=1,Text=opts.Icon or "🗿",TextSize=22,Font=Enum.Font.GothamBold,Parent=tb})
        local closeB=new("TextButton",{Size=UDim2.new(0,26,0,26),Position=UDim2.new(1,-34,0,6),BackgroundColor3=C.Elem,Text="✕",TextColor3=C.Text,TextSize=14,Font=Enum.Font.GothamBold,BorderSizePixel=0,Parent=tb})
        corner(closeB,6); closeB.MouseButton1Click:Connect(function() gui:Destroy() end)
        local minB=new("TextButton",{Size=UDim2.new(0,26,0,26),Position=UDim2.new(1,-66,0,6),BackgroundColor3=C.Elem,Text="—",TextColor3=C.Text,TextSize=14,Font=Enum.Font.GothamBold,BorderSizePixel=0,Parent=tb})
        corner(minB,6)
        local min=false
        minB.MouseButton1Click:Connect(function() min=not min; main.Size=min and UDim2.new(0,720,0,38) or UDim2.new(0,720,0,500) end)
        local dragging,dragStart,startPos
        tb.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                dragging=true; dragStart=i.Position; startPos=main.Position
                i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dragging=false end end)
            end
        end)
        UIS.InputChanged:Connect(function(i)
            if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                local d=i.Position-dragStart
                main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
            end
        end)
        local side=new("Frame",{Size=UDim2.new(0,180,1,-48),Position=UDim2.new(0,10,0,44),BackgroundColor3=C.Sidebar,BorderSizePixel=0,Parent=main})
        corner(side,8)
        local sideScroll=new("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=C.Accent,CanvasSize=UDim2.new(0,0,0,0),Parent=side})
        pad(sideScroll,6,6,6,6)
        local sideLay=new("UIListLayout",{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder,Parent=sideScroll})
        sideLay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() sideScroll.CanvasSize=UDim2.new(0,0,0,sideLay.AbsoluteContentSize.Y+12) end)
        local content=new("Frame",{Size=UDim2.new(1,-200,1,-48),Position=UDim2.new(0,200,0,44),BackgroundColor3=C.Content,BorderSizePixel=0,Parent=main})
        corner(content,8)
        local contentScroll=new("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=4,ScrollBarImageColor3=C.Accent,CanvasSize=UDim2.new(0,0,0,0),Parent=content})
        pad(contentScroll,8,8,8,8)
        local contentLay=new("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,Parent=contentScroll})
        contentLay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() contentScroll.CanvasSize=UDim2.new(0,0,0,contentLay.AbsoluteContentSize.Y+12) end)
        local notifs=new("Frame",{Size=UDim2.new(0,280,1,-20),Position=UDim2.new(1,-290,0,10),BackgroundTransparency=1,Parent=gui})
        new("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,Parent=notifs})
        local function notify(o)
            local typ=o.Type or "info"
            local col=typ=="success" and C.Success or typ=="error" and C.Danger or C.Info
            local ico=o.Icon or (typ=="success" and "✅" or typ=="error" and "❌" or "ℹ️")
            local n=new("Frame",{Size=UDim2.new(1,0,0,68),BackgroundColor3=C.Title,BorderSizePixel=0,Parent=notifs})
            corner(n,8); stroke(n,col,1,0.3)
            new("TextLabel",{Size=UDim2.new(0,32,0,32),Position=UDim2.new(0,8,0,8),BackgroundTransparency=1,Text=ico,TextSize=20,Font=Enum.Font.GothamBold,Parent=n})
            new("TextLabel",{Size=UDim2.new(1,-50,0,20),Position=UDim2.new(0,46,0,6),BackgroundTransparency=1,Text=o.Title or "Quind",TextColor3=col,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=n})
            new("TextLabel",{Size=UDim2.new(1,-50,0,34),Position=UDim2.new(0,46,0,26),BackgroundTransparency=1,Text=o.Content or "",TextColor3=C.Text,Font=Enum.Font.Gotham,TextSize=11,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,Parent=n})
            task.spawn(function() task.wait(o.Duration or 4); for i=1,10 do n.BackgroundTransparency=i/10; task.wait(0.02) end; n:Destroy() end)
        end
        local Win={}; local tabs,firstTab={},nil
        function Win:CreateTab(name,icon)
            local btn=new("TextButton",{Size=UDim2.new(1,0,0,34),BackgroundColor3=C.Elem,BackgroundTransparency=1,Text="",BorderSizePixel=0,Parent=sideScroll})
            corner(btn,6)
            new("TextLabel",{Size=UDim2.new(0,26,1,0),Position=UDim2.new(0,6,0,0),BackgroundTransparency=1,Text=icon or "•",TextSize=15,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,Parent=btn})
            local lbl=new("TextLabel",{Size=UDim2.new(1,-34,1,0),Position=UDim2.new(0,32,0,0),BackgroundTransparency=1,Text=name,TextColor3=C.TextDim,Font=Enum.Font.GothamMedium,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=btn})
            local page=new("Frame",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Visible=false,Parent=contentScroll})
            local pl=new("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,Parent=page})
            pl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() page.Size=UDim2.new(1,0,0,pl.AbsoluteContentSize.Y) end)
            local T={Button=btn,Label=lbl,Page=page}
            btn.MouseButton1Click:Connect(function()
                for _,t in ipairs(tabs) do t.Page.Visible=false; t.Label.TextColor3=C.TextDim; t.Button.BackgroundTransparency=1 end
                page.Visible=true; lbl.TextColor3=C.Text; btn.BackgroundTransparency=0
            end)
            btn.MouseEnter:Connect(function() if not page.Visible then btn.BackgroundTransparency=0.5 end end)
            btn.MouseLeave:Connect(function() if not page.Visible then btn.BackgroundTransparency=1 end end)
            table.insert(tabs,T)
            if not firstTab then firstTab=T; page.Visible=true; lbl.TextColor3=C.Text; btn.BackgroundTransparency=0 end
            local tab={}
            function tab:CreateSection(text,icon)
                local s=new("Frame",{Size=UDim2.new(1,0,0,26),BackgroundTransparency=1,Parent=page})
                new("TextLabel",{Size=UDim2.new(1,0,0,20),Position=UDim2.new(0,4,0,2),BackgroundTransparency=1,Text=(icon and icon.." " or "")..(text or ""),TextColor3=C.Accent,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=s})
                new("Frame",{Size=UDim2.new(1,-8,0,1),Position=UDim2.new(0,4,1,-2),BackgroundColor3=C.Accent,BackgroundTransparency=0.7,BorderSizePixel=0,Parent=s})
            end
            function tab:CreateButton(o)
                local b=new("TextButton",{Size=UDim2.new(1,0,0,34),BackgroundColor3=C.Elem,Text="",BorderSizePixel=0,AutoButtonColor=false,Parent=page})
                corner(b,6); stroke(b,Color3.fromRGB(55,55,75),1,0.3)
                new("TextLabel",{Size=UDim2.new(0,26,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=o.Icon or "▸",TextSize=14,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,Parent=b})
                new("TextLabel",{Size=UDim2.new(1,-50,1,0),Position=UDim2.new(0,36,0,0),BackgroundTransparency=1,Text=o.Name or "Button",TextColor3=C.Text,Font=Enum.Font.GothamMedium,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=b})
                b.MouseEnter:Connect(function() b.BackgroundColor3=C.ElemHov end)
                b.MouseLeave:Connect(function() b.BackgroundColor3=C.Elem end)
                b.MouseButton1Click:Connect(function() if o.Callback then pcall(o.Callback) end end)
            end
            function tab:CreateToggle(o)
                local f=new("Frame",{Size=UDim2.new(1,0,0,34),BackgroundColor3=C.Elem,BorderSizePixel=0,Parent=page})
                corner(f,6); stroke(f,Color3.fromRGB(55,55,75),1,0.3)
                new("TextLabel",{Size=UDim2.new(0,26,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=o.Icon or "◦",TextSize=14,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,Parent=f})
                new("TextLabel",{Size=UDim2.new(1,-100,1,0),Position=UDim2.new(0,36,0,0),BackgroundTransparency=1,Text=o.Name or "Toggle",TextColor3=C.Text,Font=Enum.Font.GothamMedium,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=f})
                local sw=new("TextButton",{Size=UDim2.new(0,40,0,20),Position=UDim2.new(1,-50,0.5,-10),BackgroundColor3=C.Elem,Text="",BorderSizePixel=0,AutoButtonColor=false,Parent=f})
                corner(sw,10); stroke(sw,Color3.fromRGB(70,70,90),1,0.3)
                local knob=new("Frame",{Size=UDim2.new(0,16,0,16),Position=UDim2.new(0,2,0.5,-8),BackgroundColor3=C.TextDim,BorderSizePixel=0,Parent=sw})
                corner(knob,8)
                local st=o.CurrentValue or false
                local function upd()
                    if st then sw.BackgroundColor3=C.Toggle; knob.Position=UDim2.new(1,-18,0.5,-8); knob.BackgroundColor3=Color3.fromRGB(255,255,255)
                    else sw.BackgroundColor3=C.Elem; knob.Position=UDim2.new(0,2,0.5,-8); knob.BackgroundColor3=C.TextDim end
                end
                upd()
                sw.MouseButton1Click:Connect(function() st=not st; upd(); if o.Callback then pcall(o.Callback,st) end end)
            end
            function tab:CreateSlider(o)
                local f=new("Frame",{Size=UDim2.new(1,0,0,50),BackgroundColor3=C.Elem,BorderSizePixel=0,Parent=page})
                corner(f,6); stroke(f,Color3.fromRGB(55,55,75),1,0.3)
                new("TextLabel",{Size=UDim2.new(0,26,0,20),Position=UDim2.new(0,10,0,4),BackgroundTransparency=1,Text=o.Icon or "≡",TextSize=14,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,Parent=f})
                new("TextLabel",{Size=UDim2.new(1,-150,0,20),Position=UDim2.new(0,36,0,4),BackgroundTransparency=1,Text=o.Name or "Slider",TextColor3=C.Text,Font=Enum.Font.GothamMedium,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=f})
                local vl=new("TextLabel",{Size=UDim2.new(0,100,0,20),Position=UDim2.new(1,-112,0,4),BackgroundTransparency=1,Text="",TextColor3=C.Accent,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Right,Parent=f})
                local tr=new("Frame",{Size=UDim2.new(1,-24,0,6),Position=UDim2.new(0,12,0,36),BackgroundColor3=Color3.fromRGB(50,50,65),BorderSizePixel=0,Parent=f})
                corner(tr,3)
                local fl=new("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=C.Accent,BorderSizePixel=0,Parent=tr})
                corner(fl,3)
                local range=o.Range or {0,100}; local inc=o.Increment or 1; local val=o.CurrentValue or range[1]; local suf=o.Suffix or ""; local mn,mx=range[1],range[2]
                local function snap(v) return math.clamp(math.floor((v-mn)/inc+0.5)*inc+mn,mn,mx) end
                local function upd() fl.Size=UDim2.new((val-mn)/(mx-mn),0,1,0); vl.Text=tostring(val)..suf end
                upd()
                local drg=false
                local function setX(x) local a=math.clamp((x-tr.AbsolutePosition.X)/tr.AbsoluteSize.X,0,1); val=snap(mn+a*(mx-mn)); upd(); if o.Callback then pcall(o.Callback,val) end end
                tr.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drg=true; setX(i.Position.X) end end)
                UIS.InputChanged:Connect(function(i) if drg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then setX(i.Position.X) end end)
                UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drg=false end end)
            end
            function tab:CreateInput(o)
                local f=new("Frame",{Size=UDim2.new(1,0,0,56),BackgroundColor3=C.Elem,BorderSizePixel=0,Parent=page})
                corner(f,6); stroke(f,Color3.fromRGB(55,55,75),1,0.3)
                new("TextLabel",{Size=UDim2.new(0,26,0,20),Position=UDim2.new(0,10,0,4),BackgroundTransparency=1,Text=o.Icon or "✎",TextSize=14,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,Parent=f})
                new("TextLabel",{Size=UDim2.new(1,-50,0,20),Position=UDim2.new(0,36,0,4),BackgroundTransparency=1,Text=o.Name or "Input",TextColor3=C.Text,Font=Enum.Font.GothamMedium,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=f})
                local bx=new("TextBox",{Size=UDim2.new(1,-24,0,22),Position=UDim2.new(0,12,0,28),BackgroundColor3=C.Dark,Text=o.CurrentValue or "",PlaceholderText=o.PlaceholderText or "",TextColor3=C.Text,PlaceholderColor3=C.TextDim,Font=Enum.Font.Gotham,TextSize=12,BorderSizePixel=0,ClearTextOnFocus=false,Parent=f})
                corner(bx,4); pad(bx,0,8,0,8)
                bx.FocusLost:Connect(function() if o.Callback then pcall(o.Callback,bx.Text) end end)
                return bx
            end
            function tab:CreateDropdown(o)
                local f=new("Frame",{Size=UDim2.new(1,0,0,38),BackgroundColor3=C.Elem,BorderSizePixel=0,Parent=page})
                corner(f,6); stroke(f,Color3.fromRGB(55,55,75),1,0.3)
                new("TextLabel",{Size=UDim2.new(0,26,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=o.Icon or "▼",TextSize=14,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,Parent=f})
                new("TextLabel",{Size=UDim2.new(1,-160,1,0),Position=UDim2.new(0,36,0,0),BackgroundTransparency=1,Text=o.Name or "Dropdown",TextColor3=C.Text,Font=Enum.Font.GothamMedium,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=f})
                local opts=o.Options or {}
                local cur=(o.CurrentOption and (type(o.CurrentOption)=="table" and o.CurrentOption[1] or o.CurrentOption)) or (opts[1] or "-")
                local vl=new("TextButton",{Size=UDim2.new(0,120,0,22),Position=UDim2.new(1,-130,0.5,-11),BackgroundColor3=C.Dark,Text=tostring(cur),TextColor3=C.Text,Font=Enum.Font.Gotham,TextSize=11,BorderSizePixel=0,Parent=f})
                corner(vl,4)
                vl.MouseButton1Click:Connect(function()
                    local idx=1
                    for i,oo in ipairs(opts) do if oo==cur then idx=i; break end end
                    idx=idx+1; if idx>#opts then idx=1 end
                    cur=opts[idx]; vl.Text=tostring(cur)
                    if o.Callback then pcall(o.Callback,{cur}) end
                end)
                local dd={CurrentOption=cur}
                function dd:Refresh(n) opts=n or opts; cur=opts[1]; vl.Text=tostring(cur) end
                return dd
            end
            function tab:CreateParagraph(o)
                local f=new("Frame",{Size=UDim2.new(1,0,0,54),BackgroundColor3=Color3.fromRGB(30,30,42),BorderSizePixel=0,Parent=page})
                corner(f,6); stroke(f,C.Accent,1,0.6)
                local tl=new("TextLabel",{Size=UDim2.new(1,-20,0,20),Position=UDim2.new(0,10,0,4),BackgroundTransparency=1,Text=(o.Icon and o.Icon.." " or "ℹ️ ")..(o.Title or "Info"),TextColor3=C.Accent,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=f})
                local cl=new("TextLabel",{Size=UDim2.new(1,-20,0,26),Position=UDim2.new(0,10,0,24),BackgroundTransparency=1,Text=o.Content or "",TextColor3=C.TextDim,Font=Enum.Font.Gotham,TextSize=11,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,Parent=f})
                local obj={}
                function obj:Set(t)
                    if t and t.Title then tl.Text=(t.Icon and t.Icon.." " or "ℹ️ ")..t.Title end
                    if t and t.Content then cl.Text=t.Content end
                end
                return obj
            end
            return tab
        end
        function Win:Notify(o) notify(o) end
        return Win
    end
end

-- ═══════════════ STATE ═══════════════
local Players=game:GetService("Players"); local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService"); local Lighting=game:GetService("Lighting")
local TS=game:GetService("TeleportService"); local Http=game:GetService("HttpService")
local VU=game:GetService("VirtualUser"); local RS=game:GetService("ReplicatedStorage")
local SS=game:GetService("SoundService"); local Debris=game:GetService("Debris")
local LP=Players.LocalPlayer; local Cam=workspace.CurrentCamera

local S={
    speedOn=false,speedVal=50,jumpOn=false,jumpVal=100,infJump=false,
    noclip=false,flyOn=false,flyVal=80,cframeFly=false,gravity=false,gravityVal=196.2,
    hipHeight=2,sitOn=false,walkOnWater=false,
    aimOn=false,aimFov=150,aimSmooth=0.25,aimPart="Head",aimVisCheck=true,aimTeamCheck=false,
    triggerBot=false,aimHoldKey=false,aimKey=Enum.KeyCode.E,aimSnap=false,aimPredict=0,aimFovCircle=false,
    espOn=false,espName=true,espHP=true,espDist=true,espHL=true,
    espMurder=false,espSheriff=false,espInnocent=false,
    fullbright=false,noFog=false,fovOn=false,fovVal=70,
    freeze=false,antiFling=false,antiVoid=false,antiAfk=true,antiRag=false,autoResp=false,
    chatSpam=false,chatMsg="Quind Hub on top",chatSpamRate=2,
    ghost=false,charSize=1,camLock=false,hlWeapons=false,hideTools=false,
    autoEquipGun=false,autoEquipKnife=false,autoReload=false,
    spin=false,spinSpeed=5,jumpBoost=false,
    rizzOn=false,sigmaOn=false,autoFlirt=false,yandereOn=false,
    autoHopDeath=false,autoHopLowHP=false,
    musicVolume=1,musicLoop=true,musicPlaying=false,
}
local flyBV,espCache,roleHL,aimCircle=nil,{},{},nil
local currentSound=nil
local Win=UI:CreateWindow({Name="Quind Hub Ultimate",Subtitle="made by hashtrash | 30 tabs",Icon="🗿"})
local function nf(t,c,d,typ,ic) Win:Notify({Title=t,Content=c,Duration=d,Type=typ or "info",Icon=ic}) end
local function role(p)
    if not p or not p.Character then return "Unknown" end
    for _,t in ipairs(p.Character:GetChildren()) do
        if t:IsA("Tool") then
            local n=t.Name:lower()
            if n:find("knife") then return "Murderer" end
            if n:find("gun") or n:find("revolver") or n:find("pistol") then return "Sheriff" end
        end
    end
    return "Innocent"
end
local function hum() return LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") end
local function hrp() return LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") end
local function dist(a,b) return (a-b).Magnitude end
local function say(m) pcall(function() RS.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(m,"All") end) end

-- ═══ TAB 1: 🏃 MOVEMENT (20) ═══
local T1=Win:CreateTab("Movement","🏃")
T1:CreateSection("Speed","⚡")
T1:CreateToggle({Name="Enable Speed",Icon="⚡",Callback=function(v) S.speedOn=v end})
T1:CreateSlider({Name="Speed Value",Icon="📊",Range={16,300},Increment=1,Suffix=" ws",CurrentValue=50,Callback=function(v) S.speedVal=v end})
T1:CreateToggle({Name="Sprint (Shift x1.5)",Icon="🏃",Callback=function(v) _G.Q_sprint=v end})
T1:CreateToggle({Name="Walk On Water",Icon="🌊",Callback=function(v) S.walkOnWater=v end})
T1:CreateSection("Jump","🦘")
T1:CreateToggle({Name="Enable Jump Power",Icon="🦘",Callback=function(v) S.jumpOn=v end})
T1:CreateSlider({Name="Jump Power",Icon="📊",Range={50,500},Increment=1,CurrentValue=100,Callback=function(v) S.jumpVal=v end})
T1:CreateToggle({Name="Infinite Jump",Icon="♾️",Callback=function(v) S.infJump=v end})
T1:CreateToggle({Name="High Jump Boost x2",Icon="🚀",Callback=function(v) S.jumpBoost=v end})
T1:CreateSection("Fly & Noclip","🕊️")
T1:CreateToggle({Name="Noclip",Icon="👻",Callback=function(v) S.noclip=v end})
T1:CreateToggle({Name="Fly (BodyVelocity)",Icon="🕊️",Callback=function(v) S.flyOn=v end})
T1:CreateSlider({Name="Fly Speed",Icon="📊",Range={10,300},Increment=1,CurrentValue=80,Callback=function(v) S.flyVal=v end})
T1:CreateToggle({Name="CFrame Fly",Icon="✨",Callback=function(v) S.cframeFly=v end})
T1:CreateSection("Physics","⚙️")
T1:CreateToggle({Name="Low Gravity",Icon="🌙",Callback=function(v) S.gravity=v end})
T1:CreateSlider({Name="Gravity Value",Icon="📊",Range={10,196},Increment=1,CurrentValue=50,Callback=function(v) S.gravityVal=v end})
T1:CreateSlider({Name="HipHeight",Icon="📏",Range={0,20},Increment=0.5,CurrentValue=2,Callback=function(v) S.hipHeight=v end})
T1:CreateSection("Extras","🎪")
T1:CreateToggle({Name="Auto-Sit",Icon="🪑",Callback=function(v) S.sitOn=v end})
T1:CreateToggle({Name="Spin Character",Icon="🌀",Callback=function(v) S.spin=v end})
T1:CreateSlider({Name="Spin Speed",Icon="📊",Range={1,30},Increment=1,CurrentValue=5,Callback=function(v) S.spinSpeed=v end})
T1:CreateButton({Name="Reset Movement",Icon="🔄",Callback=function()
    S.speedOn,S.jumpOn,S.flyOn,S.noclip,S.infJump=false,false,false,false,false; nf("Movement","сброшено",3,"success","✅")
end})

-- ═══ TAB 2: ⚔️ COMBAT (20) ═══
local T2=Win:CreateTab("Combat","⚔️")
T2:CreateSection("Aimbot","🎯")
T2:CreateToggle({Name="Enable Aimbot",Icon="🎯",Callback=function(v) S.aimOn=v end})
T2:CreateSlider({Name="Aimbot FOV",Icon="📊",Range={30,500},Increment=5,CurrentValue=150,Callback=function(v) S.aimFov=v end})
T2:CreateSlider({Name="Smoothing",Icon="📊",Range={0.05,1},Increment=0.05,CurrentValue=0.25,Callback=function(v) S.aimSmooth=v end})
T2:CreateDropdown({Name="Target Part",Icon="🎯",Options={"Head","HumanoidRootPart","UpperTorso","Torso"},CurrentOption={"Head"},Callback=function(o) S.aimPart=type(o)=="table" and o[1] or o end})
T2:CreateToggle({Name="Visible Check",Icon="👁️",Callback=function(v) S.aimVisCheck=v end})
T2:CreateToggle({Name="Team Check",Icon="👥",Callback=function(v) S.aimTeamCheck=v end})
T2:CreateSection("Trigger","🔫")
T2:CreateToggle({Name="Trigger Bot",Icon="⚡",Callback=function(v) S.triggerBot=v end})
T2:CreateButton({Name="Force Fire Tool",Icon="🔥",Callback=function()
    if LP.Character then for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") then for _,r in ipairs(t:GetChildren()) do if r:IsA("RemoteEvent") then pcall(function() r:FireServer() end) end end end end end
end})
T2:CreateButton({Name="Force Reload",Icon="🔄",Callback=function()
    if LP.Character then for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") then for _,r in ipairs(t:GetChildren()) do if r:IsA("RemoteEvent") then pcall(function() r:FireServer("Reload") end) end end end end end
end})
T2:CreateToggle({Name="Auto Reload",Icon="🔄",Callback=function(v) S.autoReload=v end})
T2:CreateSection("Knife","🔪")
T2:CreateButton({Name="Auto-Equip Knife",Icon="🔪",Callback=function()
    for _,t in ipairs(LP.Backpack:GetChildren()) do if t:IsA("Tool") and t.Name:lower():find("knife") then t.Parent=LP.Character; nf("Knife","equipped",3,"success"); return end end
    nf("Knife","нет в инвентаре",3,"error")
end})
T2:CreateButton({Name="Swing Knife x5",Icon="⚔️",Callback=function()
    task.spawn(function() for i=1,5 do
        if LP.Character then for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") and t.Name:lower():find("knife") then
            for _,r in ipairs(t:GetChildren()) do if r:IsA("RemoteEvent") then pcall(function() r:FireServer() end) end end
        end end end; task.wait(0.1)
    end end)
end})
T2:CreateButton({Name="Face Nearest",Icon="🧭",Callback=function()
    local best,bd
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and hrp() then
        local d=dist(p.Character.HumanoidRootPart.Position,hrp().Position); if not bd or d<bd then bd=d; best=p end
    end end
    if best and hrp() then local pos=best.Character.HumanoidRootPart.Position; hrp().CFrame=CFrame.new(hrp().Position,Vector3.new(pos.X,hrp().Position.Y,pos.Z)) end
end})
T2:CreateParagraph({Title="Про Silent Aim",Icon="⚠️",Content="Урон в MM2 валидируется сервером."})
T2:CreateButton({Name="Test Aimbot",Icon="🧪",Callback=function()
    local t=_G.Q_getClosest and _G.Q_getClosest()
    if t and t.Parent then local hl=Instance.new("Highlight",t.Parent); hl.FillColor=Color3.fromRGB(255,0,255); hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; task.delay(3,function() hl:Destroy() end); nf("Aimbot","цель подсвечена",3,"success")
    else nf("Aimbot","нет цели",3,"error") end
end})
T2:CreateButton({Name="Lock Camera To Nearest",Icon="📷",Callback=function()
    local best,bd
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and hrp() then
        local d=dist(p.Character.HumanoidRootPart.Position,hrp().Position); if not bd or d<bd then bd=d; best=p end
    end end
    if best then Cam.CameraSubject=best.Character:FindFirstChildOfClass("Humanoid") end
end})
T2:CreateButton({Name="Reset Combat",Icon="🔄",Callback=function() S.aimOn=false; S.triggerBot=false; nf("Combat","сброшено",3,"success") end})
T2:CreateButton({Name="Toggle Camera Lock",Icon="🔒",Callback=function()
    if Cam.CameraSubject==hum() then Cam.CameraSubject=nil else Cam.CameraSubject=hum() end
end})
T2:CreateButton({Name="Print Combat State",Icon="🖨️",Callback=function()
    print("Aim:",S.aimOn,"FOV:",S.aimFov,"Part:",S.aimPart,"Trigger:",S.triggerBot)
end})

-- ═══ TAB 3: 👁️ ESP (20) ═══
local T3=Win:CreateTab("ESP","👁️")
T3:CreateSection("Players","👥")
T3:CreateToggle({Name="Enable Player ESP",Icon="👁️",Callback=function(v) S.espOn=v end})
T3:CreateToggle({Name="Show Name",Icon="📛",CurrentValue=true,Callback=function(v) S.espName=v end})
T3:CreateToggle({Name="Show Health",Icon="❤️",CurrentValue=true,Callback=function(v) S.espHP=v end})
T3:CreateToggle({Name="Show Distance",Icon="📏",CurrentValue=true,Callback=function(v) S.espDist=v end})
T3:CreateToggle({Name="Highlight Body",Icon="✨",CurrentValue=true,Callback=function(v) S.espHL=v end})
T3:CreateSection("Role Filters","🎭")
T3:CreateToggle({Name="Murderer (Red)",Icon="🔴",Callback=function(v) S.espMurder=v end})
T3:CreateToggle({Name="Sheriff (Blue)",Icon="🔵",Callback=function(v) S.espSheriff=v end})
T3:CreateToggle({Name="Innocent (Green)",Icon="🟢",Callback=function(v) S.espInnocent=v end})
T3:CreateSection("Objects","📦")
T3:CreateToggle({Name="Highlight Weapons",Icon="🔫",Callback=function(v) S.hlWeapons=v end})
T3:CreateToggle({Name="Highlight Coins",Icon="💰",Callback=function(v) _G.Q_hlCoins=v end})
T3:CreateSection("Advanced","⚙️")
T3:CreateToggle({Name="Ignore Dead",Icon="💀",CurrentValue=true,Callback=function(v) _G.Q_ignoreDead=v end})
T3:CreateToggle({Name="Rainbow ESP",Icon="🌈",Callback=function(v) _G.Q_espRainbow=v end})
T3:CreateButton({Name="Clear All ESP",Icon="🧹",Callback=function()
    for _,e in pairs(espCache) do if e.hl then e.hl:Destroy() end; if e.bg then e.bg:Destroy() end end
    espCache={}; nf("ESP","очищено",3,"success")
end})
T3:CreateButton({Name="Reset ESP",Icon="🔄",Callback=function() S.espOn=false end})
T3:CreateButton({Name="Count Visible",Icon="📊",Callback=function()
    local c=0
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then local sp,on=Cam:WorldToViewportPoint(p.Character:GetPivot().Position); if on then c=c+1 end end end
    nf("ESP","видно: "..c,4,"info")
end})
T3:CreateButton({Name="Force Refresh ESP",Icon="🔄",Callback=function()
    for _,e in pairs(espCache) do if e.hl then e.hl:Destroy() end; if e.bg then e.bg:Destroy() end end
    espCache={}; nf("ESP","обновлено",3,"success")
end})
T3:CreateToggle({Name="Show Role In ESP",Icon="🎭",Callback=function(v) _G.Q_espRole=v end})
T3:CreateToggle({Name="Pulse Effect",Icon="💫",Callback=function(v) _G.Q_espPulse=v end})

-- ═══ TAB 4: 🎨 VISUAL (20) ═══
local T4=Win:CreateTab("Visual","🎨")
T4:CreateSection("Lighting","💡")
T4:CreateToggle({Name="Fullbright",Icon="☀️",Callback=function(v) S.fullbright=v end})
T4:CreateToggle({Name="Remove Fog",Icon="🌫️",Callback=function(v) S.noFog=v end})
T4:CreateButton({Name="Set Day (12:00)",Icon="🌞",Callback=function() Lighting.ClockTime=12 end})
T4:CreateButton({Name="Set Night (00:00)",Icon="🌙",Callback=function() Lighting.ClockTime=0 end})
T4:CreateButton({Name="Blood Moon",Icon="🌕",Callback=function() Lighting.Ambient=Color3.fromRGB(80,0,0); Lighting.OutdoorAmbient=Color3.fromRGB(60,0,0); Lighting.Brightness=1 end})
T4:CreateButton({Name="Reset Lighting",Icon="🔄",Callback=function()
    Lighting.Ambient=Color3.fromRGB(70,70,70); Lighting.OutdoorAmbient=Color3.fromRGB(128,128,128); Lighting.Brightness=1; Lighting.FogEnd=1e5; Lighting.ClockTime=14; S.fullbright,S.noFog=false,false
end})
T4:CreateSection("Camera","📷")
T4:CreateToggle({Name="FOV Changer",Icon="🎥",Callback=function(v) S.fovOn=v end})
T4:CreateSlider({Name="FOV Value",Icon="📊",Range={40,140},Increment=1,Suffix="°",CurrentValue=70,Callback=function(v) S.fovVal=v end})
T4:CreateButton({Name="First Person",Icon="👁️",Callback=function() LP.CameraMode=Enum.CameraMode.LockFirstPerson end})
T4:CreateButton({Name="Third Person",Icon="🎥",Callback=function() LP.CameraMode=Enum.CameraMode.Classic end})
T4:CreateButton({Name="Reset FOV",Icon="🔄",Callback=function() Cam.FieldOfView=70; S.fovOn=false end})
T4:CreateSection("Effects","✨")
T4:CreateToggle({Name="Disable Shadows",Icon="🌑",Callback=function(v) Lighting.GlobalShadows=not v end})
T4:CreateButton({Name="Remove Particles",Icon="✨",Callback=function()
    for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("ParticleEmitter") or o:IsA("Fire") or o:IsA("Smoke") then o.Enabled=false end end
end})
T4:CreateButton({Name="Remove Textures",Icon="🖼️",Callback=function()
    for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("Decal") or o:IsA("Texture") then o.Transparency=1 end end
end})
T4:CreateButton({Name="Restore Textures",Icon="🖼️",Callback=function()
    for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("Decal") or o:IsA("Texture") then o.Transparency=0 end end
end})
T4:CreateSection("Special","🌌")
T4:CreateButton({Name="Neon World",Icon="🌈",Callback=function()
    for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("BasePart") then o.Material=Enum.Material.Neon end end
    nf("Visual","neon world",3,"success")
end})
T4:CreateButton({Name="Glass World",Icon="🔷",Callback=function()
    for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("BasePart") then o.Material=Enum.Material.Glass; o.Transparency=0.5 end end
end})
T4:CreateButton({Name="Reset Materials",Icon="🔄",Callback=function()
    for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("BasePart") then o.Material=Enum.Material.Plastic; o.Transparency=0 end end
end})
T4:CreateToggle({Name="Ambient Black",Icon="⬛",Callback=function(v)
    if v then Lighting.Ambient=Color3.new(0,0,0); Lighting.OutdoorAmbient=Color3.new(0,0,0) end
end})

-- ═══ TAB 5: 📍 TELEPORT (20) ═══
local T5=Win:CreateTab("Teleport","📍")
local tpDD=T5:CreateDropdown({Name="Player",Icon="👤",Options={"(refresh)"},CurrentOption={"(refresh)"},Callback=function() end})
T5:CreateButton({Name="Refresh List",Icon="🔄",Callback=function()
    local l={}; for _,p in ipairs(Players:GetPlayers()) do if p~=LP then table.insert(l,p.Name) end end
    if #l==0 then l={"(none)"} end; tpDD:Refresh(l)
end})
T5:CreateSection("To Player","👤")
T5:CreateButton({Name="Teleport To Selected",Icon="📍",Callback=function()
    local t=Players:FindFirstChild(tpDD.CurrentOption)
    if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") and hrp() then hrp().CFrame=t.Character.HumanoidRootPart.CFrame+Vector3.new(0,3,0) end
end})
T5:CreateButton({Name="Teleport Behind",Icon="🎯",Callback=function()
    local t=Players:FindFirstChild(tpDD.CurrentOption)
    if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") and hrp() then hrp().CFrame=t.Character.HumanoidRootPart.CFrame*CFrame.new(0,3,3) end
end})
T5:CreateButton({Name="Teleport To Random",Icon="🎲",Callback=function()
    local l={}; for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then table.insert(l,p) end end
    if #l>0 and hrp() then local t=l[math.random(1,#l)]; hrp().CFrame=t.Character.HumanoidRootPart.CFrame+Vector3.new(0,3,0) end
end})
T5:CreateSection("Map","🗺️")
T5:CreateButton({Name="To Gun",Icon="🔫",Callback=function()
    for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("Tool") or (o:IsA("BasePart") and o.Name:lower():find("gun")) then
        local pt=o:IsA("BasePart") and o or o:FindFirstChildWhichIsA("BasePart"); if pt and hrp() then hrp().CFrame=pt.CFrame+Vector3.new(0,3,0); return end
    end end
    nf("TP","gun не найден",3,"error")
end})
T5:CreateButton({Name="To Knife",Icon="🔪",Callback=function()
    for _,o in ipairs(workspace:GetDescendants()) do if o.Name:lower():find("knife") then
        local pt=o:IsA("BasePart") and o or o:FindFirstChildWhichIsA("BasePart"); if pt and hrp() then hrp().CFrame=pt.CFrame+Vector3.new(0,3,0); return end
    end end
    nf("TP","knife не найден",3,"error")
end})
T5:CreateButton({Name="To Random Coin",Icon="💰",Callback=function()
    local coins={}; for _,o in ipairs(workspace:GetDescendants()) do if o.Name:lower():find("coin") and o:IsA("BasePart") then table.insert(coins,o) end end
    if #coins>0 and hrp() then hrp().CFrame=coins[math.random(1,#coins)].CFrame+Vector3.new(0,3,0) else nf("TP","монет нет",3,"error") end
end})
T5:CreateSection("Coordinates","📐")
local xI=T5:CreateInput({Name="X",Icon="📐",PlaceholderText="0"})
local yI=T5:CreateInput({Name="Y",Icon="📐",PlaceholderText="50"})
local zI=T5:CreateInput({Name="Z",Icon="📐",PlaceholderText="0"})
T5:CreateButton({Name="Teleport To XYZ",Icon="📍",Callback=function()
    if hrp() then hrp().CFrame=CFrame.new(tonumber(xI.Text) or 0,tonumber(yI.Text) or 50,tonumber(zI.Text) or 0) end
end})
T5:CreateSection("Extras","🎪")
T5:CreateButton({Name="Save Position",Icon="💾",Callback=function() if hrp() then _G.Q_saved=hrp().CFrame; nf("TP","saved",3,"success") end end})
T5:CreateButton({Name="Load Position",Icon="📂",Callback=function() if _G.Q_saved and hrp() then hrp().CFrame=_G.Q_saved end end})
T5:CreateButton({Name="Up +50",Icon="⬆️",Callback=function() if hrp() then hrp().CFrame=hrp().CFrame+Vector3.new(0,50,0) end end})
T5:CreateButton({Name="Forward +50",Icon="➡️",Callback=function() if hrp() then hrp().CFrame=hrp().CFrame+Cam.CFrame.LookVector*50 end end})
T5:CreateButton({Name="To Spawn",Icon="🏠",Callback=function()
    local sp=workspace:FindFirstChildOfClass("SpawnLocation"); if sp and hrp() then hrp().CFrame=sp.CFrame+Vector3.new(0,5,0) end
end})
T5:CreateButton({Name="To Highest Point",Icon="⛰️",Callback=function()
    local top,y=nil,-math.huge
    for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("BasePart") and o.Anchored and o.Position.Y>y then y=o.Position.Y; top=o end end
    if top and hrp() then hrp().CFrame=top.CFrame+Vector3.new(0,5,0) end
end})
T5:CreateButton({Name="To Center (0,50,0)",Icon="🎯",Callback=function() if hrp() then hrp().CFrame=CFrame.new(0,50,0) end end})
T5:CreateButton({Name="Random Map TP",Icon="🎲",Callback=function()
    if hrp() then hrp().CFrame=CFrame.new(math.random(-200,200),80,math.random(-200,200)) end
end})

-- ═══ TAB 6: 🔫 WEAPONS (20) ═══
local T6=Win:CreateTab("Weapons","🔫")
T6:CreateSection("Equip","⚔️")
T6:CreateButton({Name="Equip Gun",Icon="🔫",Callback=function()
    for _,t in ipairs(LP.Backpack:GetChildren()) do if t:IsA("Tool") and t.Name:lower():find("gun") then t.Parent=LP.Character; nf("Weapons","gun",3,"success"); return end end
end})
T6:CreateButton({Name="Equip Knife",Icon="🔪",Callback=function()
    for _,t in ipairs(LP.Backpack:GetChildren()) do if t:IsA("Tool") and t.Name:lower():find("knife") then t.Parent=LP.Character; nf("Weapons","knife",3,"success"); return end end
end})
T6:CreateButton({Name="Equip Any",Icon="🎒",Callback=function()
    for _,t in ipairs(LP.Backpack:GetChildren()) do if t:IsA("Tool") then t.Parent=LP.Character; nf("Weapons",t.Name,3,"success"); return end end
end})
T6:CreateToggle({Name="Auto-Equip Gun",Icon="🔫",Callback=function(v) S.autoEquipGun=v end})
T6:CreateToggle({Name="Auto-Equip Knife",Icon="🔪",Callback=function(v) S.autoEquipKnife=v end})
T6:CreateSection("Drop","⬇️")
T6:CreateButton({Name="Drop Current",Icon="⬇️",Callback=function()
    if LP.Character then for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") then t.Parent=LP.Backpack; break end end end
end})
T6:CreateButton({Name="Drop All",Icon="⬇️",Callback=function()
    if LP.Character then for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") then t.Parent=LP.Backpack end end end
end})
T6:CreateSection("Tracking","👁️")
T6:CreateToggle({Name="Highlight Weapons",Icon="✨",Callback=function(v) S.hlWeapons=v end})
T6:CreateToggle({Name="Hide Others' Tools",Icon="🙈",Callback=function(v) S.hideTools=v end})
T6:CreateToggle({Name="Auto Reload",Icon="🔄",Callback=function(v) S.autoReload=v end})
T6:CreateSection("Inventory","🎒")
local invP=T6:CreateParagraph({Title="Inventory",Icon="🎒",Content="?"})
T6:CreateButton({Name="Refresh Inventory",Icon="🔄",Callback=function()
    local l={}; for _,t in ipairs(LP.Backpack:GetChildren()) do if t:IsA("Tool") then table.insert(l,t.Name) end end
    if LP.Character then for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") then table.insert(l,"["..t.Name.."]") end end end
    invP:Set({Title="Inventory",Icon="🎒",Content=#l>0 and table.concat(l,", ") or "пусто"})
end})
T6:CreateButton({Name="Check Ammo",Icon="📊",Callback=function()
    if not LP.Character then return end
    for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") then
        local a=t:FindFirstChild("Ammo") or t:FindFirstChild("AmmoValue") or t:FindFirstChild("Clip")
        if a then nf("Ammo",t.Name..": "..tostring(a.Value or a.Name),4,"info"); return end
    end end
    nf("Ammo","не найден",3,"error")
end})
T6:CreateSection("Utility","🛠️")
T6:CreateButton({Name="Unequip All",Icon="🚫",Callback=function()
    if LP.Character then for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") then t.Parent=LP.Backpack end end end
end})
T6:CreateButton({Name="Reset Weapon Settings",Icon="🔄",Callback=function()
    S.hlWeapons,S.hideTools,S.autoEquipGun,S.autoEquipKnife=false,false,false,false
end})
T6:CreateButton({Name="Print Tools",Icon="🖨️",Callback=function()
    print("=== Tools ==="); for _,t in ipairs(LP.Backpack:GetChildren()) do if t:IsA("Tool") then print(t.Name) end end
end})
T6:CreateButton({Name="Count Tools On Map",Icon="📊",Callback=function()
    local c=0; for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("Tool") then c=c+1 end end
    nf("Weapons","tools: "..c,4,"info")
end})
T6:CreateButton({Name="Copy Inventory",Icon="📋",Callback=function()
    local l={}; for _,t in ipairs(LP.Backpack:GetChildren()) do if t:IsA("Tool") then table.insert(l,t.Name) end end
    if setclipboard then setclipboard(table.concat(l,", ")); nf("Weapons","скопировано",3,"success") end
end})
T6:CreateButton({Name="Spam Equip",Icon="🔁",Callback=function()
    task.spawn(function() for i=1,10 do
        if LP.Character then for _,t in ipairs(LP.Backpack:GetChildren()) do
            if t:IsA("Tool") then t.Parent=LP.Character; task.wait(0.05); t.Parent=LP.Backpack end
        end end
    task.wait(0.1) end end)
end})
T6:CreateButton({Name="Force Reload",Icon="🔄",Callback=function()
    if LP.Character then for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") then
        for _,r in ipairs(t:GetChildren()) do if r:IsA("RemoteEvent") then pcall(function() r:FireServer("Reload") end) end end
    end end end
end})

-- ═══ TAB 7: 👤 CHARACTER (20) ═══
local T7=Win:CreateTab("Character","👤")
T7:CreateSection("Size","📏")
T7:CreateSlider({Name="Body Scale",Icon="📏",Range={0.3,3},Increment=0.1,CurrentValue=1,Callback=function(v)
    local h=hum(); if h then h.BodyHeightScale.Value=v; h.BodyWidthScale.Value=v; h.BodyDepthScale.Value=v; h.HeadScale.Value=v end
end})
T7:CreateSlider({Name="Head Scale",Icon="🗣️",Range={0.3,3},Increment=0.1,CurrentValue=1,Callback=function(v)
    if LP.Character then local hd=LP.Character:FindFirstChild("Head")
        if hd then for _,m in ipairs(hd:GetChildren()) do if m:IsA("SpecialMesh") then m.Scale=Vector3.new(v,v,v) end end end
    end
end})
T7:CreateSection("Visibility","👁️")
T7:CreateSlider({Name="Transparency",Icon="👻",Range={0,1},Increment=0.05,CurrentValue=0,Callback=function(v)
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Transparency=v end end end
end})
T7:CreateToggle({Name="Ghost Mode",Icon="👻",Callback=function(v) S.ghost=v end})
T7:CreateButton({Name="Hide Accessories",Icon="🎩",Callback=function()
    if LP.Character then for _,a in ipairs(LP.Character:GetChildren()) do if a:IsA("Accessory") or a:IsA("Hat") then a:Destroy() end end end
end})
T7:CreateSection("Actions","🎬")
T7:CreateButton({Name="Ragdoll",Icon="💫",Callback=function() local h=hum(); if h then h.PlatformStand=true end end})
T7:CreateButton({Name="Unragdoll",Icon="🧍",Callback=function() local h=hum(); if h then h.PlatformStand=false end end})
T7:CreateButton({Name="Sit",Icon="🪑",Callback=function() local h=hum(); if h then h.Sit=true end end})
T7:CreateButton({Name="Stand",Icon="🧍",Callback=function() local h=hum(); if h then h.Sit=false end end})
T7:CreateButton({Name="Reset Character",Icon="☠️",Callback=function() if LP.Character then LP.Character:BreakJoints() end end})
T7:CreateSection("Emotes","💃")
local emDD=T7:CreateDropdown({Name="Emote",Icon="💃",Options={"wave","dance","dance2","dance3","laugh","cheer","point","salute"},CurrentOption={"wave"},Callback=function() end})
T7:CreateButton({Name="Play Emote",Icon="▶️",Callback=function()
    local h=hum(); if h then local n=type(emDD.CurrentOption)=="table" and emDD.CurrentOption[1] or emDD.CurrentOption; pcall(function() h:PlayEmote(n) end) end
end})
T7:CreateToggle({Name="Emote Spam",Icon="🔁",Callback=function(v) _G.Q_emoteSpam=v end})
T7:CreateSection("Camera","📷")
T7:CreateToggle({Name="Lock Camera To Head",Icon="🔒",Callback=function(v) S.camLock=v end})
T7:CreateButton({Name="Reset Camera",Icon="🔄",Callback=function() Cam.CameraSubject=hum(); Cam.CameraType=Enum.CameraType.Custom end})
T7:CreateButton({Name="First Person",Icon="👁️",Callback=function() LP.CameraMode=Enum.CameraMode.LockFirstPerson end})
T7:CreateButton({Name="Third Person",Icon="🎥",Callback=function() LP.CameraMode=Enum.CameraMode.Classic end})
T7:CreateButton({Name="Freeze Camera",Icon="📷",Callback=function() Cam.CameraType=Enum.CameraType.Scriptable end})

-- ═══ TAB 8: 🎭 ROLES & INFO (20) ═══
local T8=Win:CreateTab("Roles & Info","🎭")
local myRP=T8:CreateParagraph({Title="My Role",Icon="🎭",Content="-"})
local alP=T8:CreateParagraph({Title="Alive",Icon="👥",Content="-"})
local muP=T8:CreateParagraph({Title="Murderer",Icon="🔪",Content="-"})
local shP=T8:CreateParagraph({Title="Sheriff",Icon="🔫",Content="-"})
local dmP=T8:CreateParagraph({Title="Dist Murderer",Icon="📏",Content="-"})
local dsP=T8:CreateParagraph({Title="Dist Sheriff",Icon="📏",Content="-"})
T8:CreateButton({Name="Refresh My Role",Icon="🔄",Callback=function() myRP:Set({Title="My Role",Icon="🎭",Content=role(LP)}) end})
T8:CreateButton({Name="Scan All Roles",Icon="🔍",Callback=function()
    local a,m,s=0,"-","-"
    for _,p in ipairs(Players:GetPlayers()) do
        local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
        if h and h.Health>0 then a=a+1; local r=role(p); if r=="Murderer" then m=p.Name end; if r=="Sheriff" then s=p.Name end end
    end
    alP:Set({Title="Alive",Icon="👥",Content=tostring(a)}); muP:Set({Title="Murderer",Icon="🔪",Content=m}); shP:Set({Title="Sheriff",Icon="🔫",Content=s})
end})
T8:CreateButton({Name="Print Roles",Icon="🖨️",Callback=function() for _,p in ipairs(Players:GetPlayers()) do print(p.Name,role(p)) end end})
T8:CreateButton({Name="Notify All Roles",Icon="📢",Callback=function()
    local l={}; for _,p in ipairs(Players:GetPlayers()) do table.insert(l,p.Name..": "..role(p)) end
    nf("Roles",table.concat(l,", "),8)
end})
T8:CreateButton({Name="Who Has Knife?",Icon="🔪",Callback=function()
    for _,p in ipairs(Players:GetPlayers()) do if role(p)=="Murderer" then nf("Knife",p.Name,4,"success","🔪"); return end end
    nf("Knife","не найден",4,"error")
end})
T8:CreateButton({Name="Who Has Gun?",Icon="🔫",Callback=function()
    for _,p in ipairs(Players:GetPlayers()) do if role(p)=="Sheriff" then nf("Gun",p.Name,4,"success","🔫"); return end end
    nf("Gun","не найден",4,"error")
end})
T8:CreateSection("Detectors","🎯")
T8:CreateToggle({Name="Murderer (Red)",Icon="🔴",Callback=function(v) S.espMurder=v end})
T8:CreateToggle({Name="Sheriff (Blue)",Icon="🔵",Callback=function(v) S.espSheriff=v end})
T8:CreateToggle({Name="Innocent (Green)",Icon="🟢",Callback=function(v) S.espInnocent=v end})
T8:CreateToggle({Name="Auto-Update Distances",Icon="📏",Callback=function(v) _G.Q_autoDist=v end})
T8:CreateToggle({Name="Warn Murderer <30",Icon="⚠️",Callback=function(v) _G.Q_warnM=v end})
T8:CreateToggle({Name="Warn Sheriff <30",Icon="⚠️",Callback=function(v) _G.Q_warnS=v end})
T8:CreateSection("Stats","📊")
T8:CreateButton({Name="Count Alive",Icon="👥",Callback=function()
    local c=0; for _,p in ipairs(Players:GetPlayers()) do local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid"); if h and h.Health>0 then c=c+1 end end
    nf("Alive",tostring(c),4,"info")
end})
T8:CreateButton({Name="Count Dead",Icon="💀",Callback=function()
    local c=0; for _,p in ipairs(Players:GetPlayers()) do if p.Character then local h=p.Character:FindFirstChildOfClass("Humanoid"); if not h or h.Health<=0 then c=c+1 end end end
    nf("Dead",tostring(c),4,"info")
end})
T8:CreateButton({Name="Copy Role",Icon="📋",Callback=function()
    if setclipboard then setclipboard(role(LP)); nf("Roles","скопировано",3,"success") end
end})
T8:CreateButton({Name="List Innocents",Icon="😇",Callback=function()
    local l={}; for _,p in ipairs(Players:GetPlayers()) do if role(p)=="Innocent" then table.insert(l,p.Name) end end
    nf("Innocents",#l>0 and table.concat(l,", ") or "none",6)
end})
T8:CreateButton({Name="Reset Role Detectors",Icon="🔄",Callback=function()
    S.espMurder,S.espSheriff,S.espInnocent=false,false,false
end})

-- ═══ TAB 9: 🛠️ UTILITY (20) ═══
local T9=Win:CreateTab("Utility","🛠️")
T9:CreateSection("Server","🌐")
T9:CreateButton({Name="Rejoin",Icon="🔄",Callback=function() TS:Teleport(game.PlaceId,LP) end})
T9:CreateButton({Name="Server Hop (smallest)",Icon="🌐",Callback=function()
    local req=(syn and syn.request) or http_request or request; if not req then return nf("Error","нет HTTP",3,"error") end
    local ok,res=pcall(function() return req({Url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"}) end)
    if ok and res and res.Body then
        local d=Http:JSONDecode(res.Body); local best
        for _,s in ipairs(d.data or {}) do if s.playing<s.maxPlayers and s.id~=game.JobId then if not best or s.playing<best.playing then best=s end end end
        if best then TS:TeleportToPlaceInstance(game.PlaceId,best.id,LP) end
    end
end})
T9:CreateButton({Name="Copy Job ID",Icon="📋",Callback=function()
    if setclipboard then setclipboard(game.JobId); nf("Server","скопировано",3,"success") end
end})
T9:CreateSection("Character","🧍")
T9:CreateToggle({Name="Anti-AFK",Icon="🛡️",CurrentValue=true,Callback=function(v) S.antiAfk=v end})
T9:CreateToggle({Name="Anti-Fling",Icon="🛡️",Callback=function(v) S.antiFling=v end})
T9:CreateToggle({Name="Anti-Void",Icon="🛡️",Callback=function(v) S.antiVoid=v end})
T9:CreateToggle({Name="Anti-Ragdoll",Icon="🛡️",Callback=function(v) S.antiRag=v end})
T9:CreateToggle({Name="Auto-Respawn",Icon="♻️",Callback=function(v) S.autoResp=v end})
T9:CreateToggle({Name="Freeze",Icon="🧊",Callback=function(v) S.freeze=v end})
T9:CreateSection("Chat","💬")
local chatI=T9:CreateInput({Name="Message",Icon="💬",CurrentValue="Quind Hub on top",PlaceholderText="текст"})
T9:CreateToggle({Name="Chat Spam",Icon="🔁",Callback=function(v) S.chatSpam=v end})
T9:CreateButton({Name="Send Once",Icon="📤",Callback=function() say(chatI.Text) end})
T9:CreateSection("System","📊")
T9:CreateButton({Name="Show Ping",Icon="📡",Callback=function()
    local s=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]; nf("Ping",math.floor(s:GetValue()).." ms",4,"info","📡")
end})
T9:CreateButton({Name="Show FPS",Icon="🎬",Callback=function() nf("FPS",math.floor(1/RunService.RenderStepped:Wait()).." fps",3,"info") end})
T9:CreateButton({Name="Copy Place ID",Icon="📋",Callback=function()
    if setclipboard then setclipboard(tostring(game.PlaceId)); nf("Util","скопировано",3,"success") end
end})
T9:CreateButton({Name="Show Place ID",Icon="📋",Callback=function() nf("Place ID",tostring(game.PlaceId),4,"info") end})
T9:CreateButton({Name="Show Memory",Icon="💾",Callback=function() nf("Memory",math.floor(collectgarbage("count")).." KB",4,"info") end})
T9:CreateButton({Name="Reset All Settings",Icon="🔄",Callback=function()
    for k,v in pairs(S) do if type(v)=="boolean" then S[k]=false end end; S.antiAfk=true; nf("Util","reset",4,"success")
end})

-- ═══ TAB 10: 🛡️ ANTI / PROTECTION (20) ═══
local T10=Win:CreateTab("Anti / Protection","🛡️")
T10:CreateSection("Auto-Defend","🛡️")
T10:CreateToggle({Name="Auto-Flee From Murderer",Icon="🏃",Callback=function(v) _G.Q_flee=v end})
T10:CreateToggle({Name="Auto-Jump When Near",Icon="🦘",Callback=function(v) _G.Q_autoJumpM=v end})
T10:CreateToggle({Name="Auto-Teleport From",Icon="📍",Callback=function(v) _G.Q_tpFrom=v end})
T10:CreateButton({Name="Panic: Random TP",Icon="🚨",Callback=function()
    if hrp() then hrp().CFrame=CFrame.new(math.random(-200,200),80,math.random(-200,200)) end
end})
T10:CreateSection("Detections","👁️")
T10:CreateToggle({Name="Warn On Knife Equip",Icon="🔪",Callback=function(v) _G.Q_warnKnife=v end})
T10:CreateToggle({Name="Warn On Gun Equip",Icon="🔫",Callback=function(v) _G.Q_warnGun=v end})
T10:CreateToggle({Name="Warn On Approach",Icon="⚠️",Callback=function(v) _G.Q_warnApproach=v end})
T10:CreateToggle({Name="Who's Looking At Me",Icon="👁️",Callback=function(v) _G.Q_watchers=v end})
T10:CreateSection("Bypass","🔧")
T10:CreateButton({Name="Reset Velocity",Icon="🛑",Callback=function()
    local r=hrp(); if r then r.AssemblyLinearVelocity=Vector3.zero end
end})
T10:CreateButton({Name="Clear BodyMovers",Icon="🧹",Callback=function()
    if LP.Character then for _,o in ipairs(LP.Character:GetDescendants()) do
        if o:IsA("BodyVelocity") or o:IsA("BodyGyro") or o:IsA("BodyAngularVelocity") then o:Destroy() end
    end end
end})
T10:CreateButton({Name="Reset WalkSpeed",Icon="🔄",Callback=function() local h=hum(); if h then h.WalkSpeed=16 end; S.speedOn=false end})
T10:CreateButton({Name="Reset JumpPower",Icon="🔄",Callback=function() local h=hum(); if h then h.JumpPower=50 end; S.jumpOn=false end})
T10:CreateButton({Name="Panic: Disable All",Icon="🚨",Callback=function()
    S.speedOn,S.jumpOn,S.flyOn,S.noclip,S.aimOn,S.espOn,S.triggerBot=false,false,false,false,false,false,false
    S.antiFling,S.antiVoid,S.ghost=false,false,false
    _G.Q_flee,_G.Q_autoJumpM,_G.Q_tpFrom=false,false,false
    nf("PANIC","всё выключено",6,"error","🚨")
end})
T10:CreateButton({Name="Panic: Reset Character",Icon="☠️",Callback=function() if LP.Character then LP.Character:BreakJoints() end end})
T10:CreateButton({Name="Report Active",Icon="📊",Callback=function()
    local on={}; for k,v in pairs(S) do if v==true then table.insert(on,k) end end
    nf("Active",#on>0 and table.concat(on,", ") or "none",8,"info")
end})
T10:CreateSection("Extra","🛡️")
T10:CreateToggle({Name="Anti-Ragdoll Loop",Icon="🦴",Callback=function(v) S.antiRag=v end})
T10:CreateToggle({Name="Auto-Heal (клиент)",Icon="❤️",Callback=function(v) _G.Q_autoHeal=v end})
T10:CreateButton({Name="Force Unanchor",Icon="🔓",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Anchored=false end end end
end})
T10:CreateButton({Name="Force Unfreeze",Icon="🧊",Callback=function()
    local h=hum(); if h then h.WalkSpeed=16; h.JumpPower=50 end; S.freeze=false
end})
T10:CreateButton({Name="Emergency Leave",Icon="🚪",Callback=function() TS:Teleport(game.PlaceId,LP) end})

-- ═══ TAB 11: 🔞 18+ (20) ═══
local T11=Win:CreateTab("18+","🔞")
T11:CreateParagraph({Title="Внимание",Icon="⚠️",Content="Мем-пранк таб. Без реального NSFW."})
local rizzMessages={"Ты такая сладкая, что нож выпал 🍬","Я не маньяк, я настойчивый 💕","Дай шанс, я убью за тебя 💀","Мурдерер? Забей, пойдём 💋","Ты мой Шериф, я твой Мурдерер 💕🔪","Хочешь поцелуй? Без ножа 😘","Я потерял голову... 💘","Скинь номер, скину нож 🗡️😏"}
local rizzI=T11:CreateInput({Name="Rizz Text",Icon="💬",CurrentValue="Я не Мурдерер, я МурдерТЫ 😏",PlaceholderText="твой текст"})
T11:CreateSection("Ризз","💋")
T11:CreateButton({Name="Rizz Nearest",Icon="💋",Callback=function()
    local t=_G.Q_getClosest and _G.Q_getClosest()
    if t and t.Parent then local plr=Players:GetPlayerFromCharacter(t.Parent); if plr then say(plr.Name..", "..rizzMessages[math.random(1,#rizzMessages)]) end
    else nf("Rizz","никого рядом",3,"error") end
end})
T11:CreateToggle({Name="Auto-Rizz Spam",Icon="🔁",Callback=function(v) S.rizzOn=v end})
T11:CreateButton({Name="Fake Ban Message",Icon="🚫",Callback=function()
    local names={"Nomik","Smokey","Boss","Gamer","Toxic"}; say("[SERVER] "..names[math.random(1,5)].." забанен за риззинг (пранк)")
end})
T11:CreateButton({Name="Fake Admin Notice",Icon="👑",Callback=function() say("[ADMIN] Хэштег trash заходит в игру... 🗿") end})
T11:CreateButton({Name="Fake Doxx",Icon="🌐",Callback=function() say("[DATA] IP: 127.0.0.1 | Страна: Антарктида | Возраст: 99 (шутка)") end})
T11:CreateSection("Активности","🎪")
T11:CreateButton({Name="Slap Nearest",Icon="✋",Callback=function() local h=hum(); if h then pcall(function() h:PlayEmote("kick") end); nf("Slap","✋",3,"success") end end})
T11:CreateButton({Name="Kiss Killer",Icon="💋",Callback=function()
    local murderer; for _,p in ipairs(Players:GetPlayers()) do if role(p)=="Murderer" then murderer=p; break end end
    if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") and hrp() then
        hrp().CFrame=murderer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,2)
        local h=hum(); if h then pcall(function() h:PlayEmote("kiss") end) end
        nf("💋","поцеловал убийцу",3,"success")
    else nf("💋","не найден",3,"error") end
end})
T11:CreateToggle({Name="Sigma Mode",Icon="🗿",Callback=function(v) S.sigmaOn=v end})
T11:CreateToggle({Name="Chad Walk",Icon="🚶",Callback=function(v) _G.Q_chadWalk=v end})
T11:CreateToggle({Name="Yandere Mode",Icon="💕",Callback=function(v) S.yandereOn=v end})
T11:CreateToggle({Name="Auto-Flirt With Murderer",Icon="😏",Callback=function(v) S.autoFlirt=v end})
T11:CreateToggle({Name="Simp Mode",Icon="🥺",Callback=function(v) _G.Q_simp=v end})
T11:CreateSection("Эффекты","✨")
T11:CreateButton({Name="Gigachad Aura",Icon="🗿",Callback=function()
    if hrp() then
        local att=Instance.new("Attachment",hrp()); local pe=Instance.new("ParticleEmitter",att)
        pe.Texture="rbxasset://textures/particles/sparkles_main.dds"; pe.Rate=30; pe.Lifetime=NumberRange.new(0.5,1); pe.Speed=NumberRange.new(2,5)
        pe.SpreadAngle=Vector2.new(180,180); pe.Color=ColorSequence.new(Color3.fromRGB(255,220,100)); pe.Size=NumberSequence.new(0.3)
        task.delay(10,function() pe:Destroy(); att:Destroy() end); nf("🗿","aura",3,"success")
    end
end})
T11:CreateButton({Name="Dad Jokes",Icon="😂",Callback=function()
    local jokes={"Мурдерер не сдал тест — резал не по теме 💀","Шериф ножу: 'Ты меня не режешь' 🔪","Инносент проиграл — слишком доверчивый 😔","Мурдерер на пенсии = экс-резатель 👴","Общее у ножа и шутки — оба ранят 💔"}
    task.spawn(function() for _,j in ipairs(jokes) do say(j); task.wait(1.5) end end)
end})
T11:CreateButton({Name="Rizz Meter",Icon="📊",Callback=function()
    local s=math.random(1,100); nf("Rizz",s.."/100 — "..(s>80 and "god tier 🗿" or s>50 and "mid 😐" or "скилл ишью 💀"),5,"info","💯")
end})
T11:CreateToggle({Name="Wink Emote Spam",Icon="😉",Callback=function(v) _G.Q_wink=v end})
T11:CreateButton({Name="Fake Death Message",Icon="💀",Callback=function()
    local names={"Ты","Он","Она","Кто-то"}; say("[KILL] "..names[math.random(1,4)].." убит... щекоткой 💀")
end})
T11:CreateButton({Name="Drop Tools Near Sheriff",Icon="🥺",Callback=function()
    for _,p in ipairs(Players:GetPlayers()) do if role(p)=="Sheriff" and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and hrp() then
        hrp().CFrame=p.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
        if LP.Character then for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") then t.Parent=LP.Backpack end end end
        nf("Simp","оружие у шерифа",3,"success"); return
    end end
    nf("Simp","шериф не найден",3,"error")
end})

-- ═══ TAB 12: 🎯 AIMBOT PRO (20) ═══
local T12=Win:CreateTab("Aimbot Pro","🎯")
T12:CreateSection("Основное","🎯")
T12:CreateToggle({Name="Enable Aimbot Pro",Icon="🎯",Callback=function(v) S.aimOn=v end})
T12:CreateToggle({Name="Snap Aim",Icon="⚡",Callback=function(v) S.aimSnap=v end})
T12:CreateSlider({Name="FOV Radius",Icon="🎯",Range={30,500},Increment=5,CurrentValue=150,Callback=function(v) S.aimFov=v end})
T12:CreateSlider({Name="Smoothing",Icon="📊",Range={0.05,1},Increment=0.05,CurrentValue=0.25,Callback=function(v) S.aimSmooth=v end})
T12:CreateSlider({Name="Prediction",Icon="🔮",Range={0,20},Increment=0.5,CurrentValue=0,Callback=function(v) S.aimPredict=v end})
T12:CreateToggle({Name="Visible Check",Icon="👁️",Callback=function(v) S.aimVisCheck=v end})
T12:CreateToggle({Name="Team Check",Icon="👥",Callback=function(v) S.aimTeamCheck=v end})
T12:CreateDropdown({Name="Priority",Icon="🎯",Options={"Closest to crosshair","Closest distance","Lowest health","Highest threat"},CurrentOption={"Closest to crosshair"},Callback=function(o) _G.Q_aimPriority=type(o)=="table" and o[1] or o end})
T12:CreateSection("Цели","👤")
T12:CreateDropdown({Name="Target Part",Icon="🎯",Options={"Head","HumanoidRootPart","UpperTorso","Torso","Random"},CurrentOption={"Head"},Callback=function(o) S.aimPart=type(o)=="table" and o[1] or o end})
T12:CreateToggle({Name="Prioritize Murderer",Icon="🔪",Callback=function(v) _G.Q_aimMurderer=v end})
T12:CreateToggle({Name="Prioritize Sheriff",Icon="🔫",Callback=function(v) _G.Q_aimSheriff=v end})
T12:CreateToggle({Name="Ignore Murderer",Icon="🛡️",Callback=function(v) _G.Q_aimIgnoreMurderer=v end})
T12:CreateSection("Визуал","👁️")
T12:CreateToggle({Name="Draw FOV Circle",Icon="⭕",Callback=function(v) S.aimFovCircle=v end})
T12:CreateToggle({Name="Target Highlight",Icon="✨",Callback=function(v) _G.Q_aimHL=v end})
T12:CreateSection("Клавиши","⌨️")
T12:CreateToggle({Name="Hold Key Mode",Icon="⌨️",Callback=function(v) S.aimHoldKey=v end})
T12:CreateButton({Name="Set Aimbot Key",Icon="⌨️",Callback=function()
    nf("Keybind","Нажми клавишу...",5,"info","⌨️")
    local conn; conn=UIS.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.Keyboard then
            S.aimKey=input.KeyCode; nf("Keybind","Установлено: "..input.KeyCode.Name,3,"success","✅"); conn:Disconnect()
        end
    end)
end})
T12:CreateSection("Авто","⚡")
T12:CreateButton({Name="Force Fire",Icon="🔥",Callback=function()
    if LP.Character then for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") then for _,r in ipairs(t:GetChildren()) do if r:IsA("RemoteEvent") then pcall(function() r:FireServer() end) end end end end end
end})
T12:CreateToggle({Name="Trigger Bot",Icon="⚡",Callback=function(v) S.triggerBot=v end})
T12:CreateButton({Name="Reset Aimbot",Icon="🔄",Callback=function()
    S.aimOn=false; S.aimSnap=false; S.triggerBot=false; if aimCircle then aimCircle:Remove(); aimCircle=nil end; nf("Aimbot","reset",3,"success")
end})

-- ═══ TAB 13: 🌐 SERVER (20) ═══
local T13=Win:CreateTab("Server","🌐")
T13:CreateSection("Инфо","📊")
T13:CreateButton({Name="Show Place ID",Icon="📋",Callback=function() nf("Place ID",tostring(game.PlaceId),5,"info") end})
T13:CreateButton({Name="Show Job ID",Icon="📋",Callback=function() nf("Job ID",game.JobId,5,"info") end})
T13:CreateButton({Name="Copy Job ID",Icon="📋",Callback=function() if setclipboard then setclipboard(game.JobId); nf("Server","скопировано",3,"success") end end})
T13:CreateButton({Name="Show Player Count",Icon="👥",Callback=function() nf("Players",tostring(#Players:GetPlayers()),3,"info") end})
T13:CreateButton({Name="Show My Ping",Icon="📡",Callback=function()
    local s=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]; nf("Ping",math.floor(s:GetValue()).." ms",4,"info")
end})
T13:CreateButton({Name="Show Locale",Icon="🌍",Callback=function()
    local ok,r=pcall(function() return game:GetService("LocalizationService").RobloxLocaleId end)
    nf("Locale",ok and r or "?",4,"info")
end})
T13:CreateSection("Хоппинг","🚀")
T13:CreateButton({Name="Rejoin This",Icon="🔄",Callback=function() TS:Teleport(game.PlaceId,LP) end})
T13:CreateButton({Name="Hop Smallest",Icon="🌐",Callback=function()
    local req=(syn and syn.request) or http_request or request; if not req then return end
    local ok,res=pcall(function() return req({Url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"}) end)
    if ok and res and res.Body then
        local d=Http:JSONDecode(res.Body); local best
        for _,s in ipairs(d.data or {}) do if s.playing<s.maxPlayers and s.id~=game.JobId then if not best or s.playing<best.playing then best=s end end end
        if best then TS:TeleportToPlaceInstance(game.PlaceId,best.id,LP); nf("Server","hopping...",3,"success") end
    end
end})
T13:CreateButton({Name="Hop Largest",Icon="🌐",Callback=function()
    local req=(syn and syn.request) or http_request or request; if not req then return end
    local ok,res=pcall(function() return req({Url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"}) end)
    if ok and res and res.Body then
        local d=Http:JSONDecode(res.Body)
        for _,s in ipairs(d.data or {}) do if s.playing<s.maxPlayers and s.id~=game.JobId then TS:TeleportToPlaceInstance(game.PlaceId,s.id,LP); return end end
    end
end})
T13:CreateButton({Name="Hop Random",Icon="🎲",Callback=function()
    local req=(syn and syn.request) or http_request or request; if not req then return end
    local ok,res=pcall(function() return req({Url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"}) end)
    if ok and res and res.Body then
        local d=Http:JSONDecode(res.Body); local list={}
        for _,s in ipairs(d.data or {}) do if s.id~=game.JobId then table.insert(list,s.id) end end
        if #list>0 then TS:TeleportToPlaceInstance(game.PlaceId,list[math.random(1,#list)],LP) end
    end
end})
T13:CreateSection("Авто-хоп","🤖")
T13:CreateToggle({Name="Auto-Hop On Death",Icon="💀",Callback=function(v) S.autoHopDeath=v end})
T13:CreateToggle({Name="Auto-Hop On Low HP",Icon="❤️",Callback=function(v) S.autoHopLowHP=v end})
T13:CreateSection("Список","📋")
T13:CreateButton({Name="List Servers",Icon="🖨️",Callback=function()
    local req=(syn and syn.request) or http_request or request; if not req then return end
    local ok,res=pcall(function() return req({Url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"}) end)
    if ok and res and res.Body then
        local d=Http:JSONDecode(res.Body); print("=== Servers ===")
        for _,s in ipairs(d.data or {}) do print(s.id,s.playing.."/"..s.maxPlayers) end
        nf("Server",#(d.data or {}).." в консоли",4,"success")
    end
end})
T13:CreateButton({Name="Force Leave",Icon="🚪",Callback=function() LP:Kick("leave requested") end})
T13:CreateButton({Name="Copy Place ID",Icon="📋",Callback=function() if setclipboard then setclipboard(tostring(game.PlaceId)); nf("Server","ok",3,"success") end end})
T13:CreateButton({Name="Show Server Time",Icon="🕐",Callback=function() nf("Time",os.date("%H:%M:%S"),4,"info","🕐") end})
T13:CreateButton({Name="Show Uptime",Icon="⏱️",Callback=function() nf("Uptime",math.floor(tick()).." sec",4,"info") end})
T13:CreateButton({Name="Show Players List",Icon="👥",Callback=function()
    local l={}; for _,p in ipairs(Players:GetPlayers()) do table.insert(l,p.Name) end
    nf("Players",table.concat(l,", "),8,"info")
end})

-- ═══ TAB 14: 💬 CHAT (20) ═══
local T14=Win:CreateTab("Chat","💬")
T14:CreateSection("Отправка","📤")
local chatMsgI=T14:CreateInput({Name="Message",Icon="💬",CurrentValue="Quind Hub on top",PlaceholderText="введи текст"})
T14:CreateButton({Name="Send Once",Icon="📤",Callback=function() say(chatMsgI.Text) end})
T14:CreateToggle({Name="Chat Spam",Icon="🔁",Callback=function(v) S.chatSpam=v end})
T14:CreateSlider({Name="Spam Rate",Icon="⏱️",Range={0.5,10},Increment=0.5,CurrentValue=2,Callback=function(v) S.chatSpamRate=v end})
T14:CreateButton({Name="Send 'GG'",Icon="🎮",Callback=function() say("GG EZ") end})
T14:CreateButton({Name="Send 'ggwp'",Icon="🎮",Callback=function() say("ggwp") end})
T14:CreateButton({Name="Send 'I am innocent'",Icon="😇",Callback=function() say("I am innocent, trust me") end})
T14:CreateButton({Name="Send 'Sheriff here'",Icon="🔫",Callback=function() say("Sheriff here, don't shoot!") end})
T14:CreateSection("Спам-паки","📦")
T14:CreateButton({Name="Emoji Pack",Icon="😀",Callback=function()
    local e={"😀","🎉","🚀","💯","🔥","⭐","🎮","👑"}
    task.spawn(function() for i=1,8 do say(e[i]); task.wait(0.7) end end)
end})
T14:CreateButton({Name="ASCII Art",Icon="🎨",Callback=function() say("( ͡° ͜ʖ ͡°)"); task.wait(1); say("¯\\_(ツ)_/¯") end})
T14:CreateButton({Name="Dad Joke Spam",Icon="😂",Callback=function()
    local j={"Why did the murderer cross? To knife you.","Sheriff walks into a bar. Shoots.","Innocent: I'm innocent! Murderer: I know 😏"}
    task.spawn(function() for _,s in ipairs(j) do say(s); task.wait(1.5) end end)
end})
T14:CreateButton({Name="Russian Roulette",Icon="🎲",Callback=function()
    local m={"🔫","💀","😱","🫣","😵"}
    task.spawn(function() for _,msg in ipairs(m) do say(msg); task.wait(1) end end)
end})
T14:CreateSection("Фильтр","🧹")
T14:CreateButton({Name="Clear Local Chat",Icon="🧹",Callback=function()
    pcall(function() for _,g in ipairs(game:GetService("CoreGui"):GetDescendants()) do if g:IsA("Frame") and g.Name:lower():find("chat") then g:Destroy() end end end)
    nf("Chat","попытка очистки",3,"info")
end})
T14:CreateButton({Name="Reset Chat",Icon="🔄",Callback=function() S.chatSpam=false; S.chatMsg="Quind Hub on top"; nf("Chat","reset",3,"success") end})
T14:CreateButton({Name="Spam Whisper",Icon="🤫",Callback=function() say("psst...") end})
T14:CreateButton({Name="Announce Rizz",Icon="💋",Callback=function() say("Я король ризза этого сервера 🗿") end})
T14:CreateButton({Name="Spam Lenny",Icon="🎭",Callback=function() say("( ͡° ͜ʖ ͡°)") end})
T14:CreateButton({Name="Copy Last Msg",Icon="📋",Callback=function() if setclipboard then setclipboard(chatMsgI.Text); nf("Chat","скопировано",3,"success") end end})
T14:CreateButton({Name="Spam ASCII Cat",Icon="🐱",Callback=function() say("=^..^=") end})

-- ═══ TAB 15: ⚙️ CONFIG (20) ═══
local T15=Win:CreateTab("Config","⚙️")
T15:CreateSection("Save / Load","💾")
T15:CreateButton({Name="Save Config",Icon="💾",Callback=function()
    _G.Q_cfg={}; for k,v in pairs(S) do _G.Q_cfg[k]=v end; nf("Config","saved",3,"success","💾")
end})
T15:CreateButton({Name="Load Config",Icon="📂",Callback=function()
    if _G.Q_cfg then for k,v in pairs(_G.Q_cfg) do S[k]=v end; nf("Config","loaded",3,"success","📂")
    else nf("Config","нет данных",3,"error") end
end})
T15:CreateButton({Name="Reset All",Icon="🔄",Callback=function()
    for k,v in pairs(S) do if type(v)=="boolean" then S[k]=false end end; S.antiAfk=true; nf("Config","reset",4,"success")
end})
T15:CreateSection("Slot","📁")
T15:CreateButton({Name="Save Slot 1",Icon="1️⃣",Callback=function() _G.Q_slot1={}; for k,v in pairs(S) do _G.Q_slot1[k]=v end; nf("Config","Slot 1 saved",3,"success") end})
T15:CreateButton({Name="Save Slot 2",Icon="2️⃣",Callback=function() _G.Q_slot2={}; for k,v in pairs(S) do _G.Q_slot2[k]=v end; nf("Config","Slot 2 saved",3,"success") end})
T15:CreateButton({Name="Load Slot 1",Icon="1️⃣",Callback=function() if _G.Q_slot1 then for k,v in pairs(_G.Q_slot1) do S[k]=v end; nf("Config","Slot 1 loaded",3,"success") end end})
T15:CreateButton({Name="Load Slot 2",Icon="2️⃣",Callback=function() if _G.Q_slot2 then for k,v in pairs(_G.Q_slot2) do S[k]=v end; nf("Config","Slot 2 loaded",3,"success") end end})
T15:CreateSection("Keybinds","⌨️")
T15:CreateButton({Name="Toggle UI (RightShift)",Icon="⌨️",Callback=function()
    UIS.InputBegan:Connect(function(i,g)
        if not g and i.KeyCode==Enum.KeyCode.RightShift then
            local gui=LP:WaitForChild("PlayerGui"):FindFirstChild("QuindUI")
            if gui then for _,c in ipairs(gui:GetChildren()) do if c:IsA("Frame") then c.Visible=not c.Visible end end end
        end
    end)
    nf("Keybind","RightShift",4,"success")
end})
T15:CreateButton({Name="Panic (P)",Icon="🚨",Callback=function()
    UIS.InputBegan:Connect(function(i,g)
        if not g and i.KeyCode==Enum.KeyCode.P then
            S.speedOn,S.jumpOn,S.flyOn,S.noclip,S.aimOn,S.espOn,S.triggerBot=false,false,false,false,false,false,false
            nf("PANIC","all off",4,"error","🚨")
        end
    end)
    nf("Keybind","P",4,"success")
end})
T15:CreateSection("UI","🎨")
T15:CreateButton({Name="UI Info",Icon="ℹ️",Callback=function() nf("UI","Custom UI, 30 tabs",4,"info") end})
T15:CreateButton({Name="Toggle Notifs",Icon="🔔",Callback=function() _G.Q_noNotif=not _G.Q_noNotif; nf("UI","notifs: "..tostring(not _G.Q_noNotif),3,"info") end})
T15:CreateSection("Info","📊")
T15:CreateButton({Name="Report Active",Icon="📋",Callback=function()
    local on={}; for k,v in pairs(S) do if v==true then table.insert(on,k) end end
    nf("Active",#on>0 and table.concat(on,", ") or "none",10,"info")
end})
T15:CreateButton({Name="Show FPS",Icon="📊",Callback=function() nf("FPS",math.floor(1/RunService.RenderStepped:Wait()),3,"info") end})
T15:CreateButton({Name="Show Memory",Icon="💾",Callback=function() nf("Memory",math.floor(collectgarbage("count")).." KB",4,"info") end})
T15:CreateButton({Name="Script Info",Icon="ℹ️",Callback=function() nf("Quind Hub","made by hashtrash | 30 tabs | 600 funcs",5,"info","🗿") end})
T15:CreateButton({Name="Reset Settings Only",Icon="🔄",Callback=function()
    S.speedOn,S.jumpOn,S.flyOn,S.noclip,S.aimOn,S.espOn,S.triggerBot=false,false,false,false,false,false,false
end})

-- ═══ TAB 16: 🌀 EXPLOITS (20) ═══
local T16=Win:CreateTab("Exploits","🌀")
T16:CreateSection("Anti","🛡️")
T16:CreateToggle({Name="Anti-Kick",Icon="🛡️",Callback=function(v)
    if v then pcall(function()
        local mt=getrawmetatable and getrawmetatable(game)
        if mt then setreadonly(mt,false); local old=mt.__namecall
            mt.__namecall=newcclosure(function(self,...)
                local m=getnamecallmethod()
                if m=="Kick" and self==LP then return nil end
                return old(self,...)
            end)
            setreadonly(mt,true)
        end
    end); nf("Anti-Kick","ON",4,"success") end
end})
T16:CreateToggle({Name="Anti-Teleport",Icon="📍",Callback=function(v) _G.Q_antiTP=v end})
T16:CreateToggle({Name="Anti-Freeze",Icon="🧊",Callback=function(v) _G.Q_antiFreeze=v end})
T16:CreateSection("Movement","🏃")
T16:CreateToggle({Name="Massless Character",Icon="⚖️",Callback=function(v)
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Massless=v end end end
end})
T16:CreateToggle({Name="Jump Glitch",Icon="🦘",Callback=function(v) _G.Q_jumpGlitch=v end})
T16:CreateButton({Name="Speed Glitch",Icon="⚡",Callback=function()
    if hrp() then hrp().AssemblyLinearVelocity=Cam.CFrame.LookVector*200+Vector3.new(0,50,0); nf("Glitch","burst",3,"success") end
end})
T16:CreateSection("Teleport","📍")
T16:CreateButton({Name="Micro-TP (10 studs)",Icon="➡️",Callback=function() if hrp() then hrp().CFrame=hrp().CFrame+Cam.CFrame.LookVector*10 end end})
T16:CreateButton({Name="Teleport Spam x10",Icon="🌀",Callback=function()
    task.spawn(function() for i=1,10 do if hrp() then hrp().CFrame=hrp().CFrame+Cam.CFrame.LookVector*15 end; task.wait(0.1) end end)
end})
T16:CreateButton({Name="Force Respawn",Icon="♻️",Callback=function() if LP.Character then LP.Character:BreakJoints() end end})
T16:CreateSection("Server","🌐")
T16:CreateButton({Name="Fire All Remotes",Icon="🔥",Callback=function()
    for _,o in ipairs(game:GetDescendants()) do if o:IsA("RemoteEvent") then pcall(function() o:FireServer() end) end end
    nf("Exploits","fired all",3,"success")
end})
T16:CreateButton({Name="Dump Game Info",Icon="📋",Callback=function()
    print("=== GAME INFO ==="); print("PlaceId:",game.PlaceId); print("JobId:",game.JobId); print("Players:",#Players:GetPlayers()); print("Workspace children:",#workspace:GetChildren()); nf("Exploits","в консоли",3,"success")
end})
T16:CreateButton({Name="Dump Players",Icon="👥",Callback=function()
    print("=== PLAYERS ===")
    for _,p in ipairs(Players:GetPlayers()) do
        local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
        print(p.Name,"Role:"..role(p),"HP:"..(h and math.floor(h.Health) or 0))
    end
    nf("Exploits","в консоли",3,"success")
end})
T16:CreateButton({Name="Copy Client Info",Icon="📋",Callback=function()
    local info="PlaceId:"..game.PlaceId.." JobId:"..game.JobId
    if setclipboard then setclipboard(info); nf("Exploits","скопировано",3,"success") end
end})
T16:CreateSection("Fake","😇")
T16:CreateButton({Name="Fake Godmode (visual)",Icon="😇",Callback=function()
    local h=hum(); if h then h.MaxHealth=math.huge; h.Health=math.huge end; nf("Fake","только клиент",4,"info")
end})
T16:CreateButton({Name="Reset Character",Icon="☠️",Callback=function() if LP.Character then LP.Character:BreakJoints() end end})
T16:CreateButton({Name="Disable All",Icon="🔄",Callback=function()
    _G.Q_antiTP=false; _G.Q_antiFreeze=false; _G.Q_jumpGlitch=false; nf("Exploits","off",3,"success")
end})
T16:CreateButton({Name="Emergency Stop",Icon="🚨",Callback=function()
    for k,v in pairs(S) do if type(v)=="boolean" then S[k]=false end end; S.antiAfk=true; nf("PANIC","off",6,"error","🚨")
end})

-- ═══ TAB 17: 🎣 AUTO-FARM (20) ═══
local T17=Win:CreateTab("Auto-Farm","🎣")
T17:CreateSection("Монеты","💰")
T17:CreateToggle({Name="Auto-Collect Coins",Icon="💰",Callback=function(v) _G.Q_farmCoins=v end})
T17:CreateSlider({Name="Farm Radius",Icon="📏",Range={10,500},Increment=10,CurrentValue=100,Callback=function(v) _G.Q_farmRadius=v end})
T17:CreateSlider({Name="Farm Speed",Icon="⚡",Range={10,200},Increment=5,CurrentValue=80,Callback=function(v) _G.Q_farmSpeed=v end})
T17:CreateToggle({Name="Only If Safe",Icon="🛡️",Callback=function(v) _G.Q_farmSafe=v end})
T17:CreateSection("Оружие","🔫")
T17:CreateToggle({Name="Auto-Pickup Weapons",Icon="🎁",Callback=function(v) _G.Q_farmWeapons=v end})
T17:CreateToggle({Name="Auto-Equip Best",Icon="⚔️",Callback=function(v) _G.Q_bestWeapon=v end})
T17:CreateToggle({Name="Pickup Gun If Sheriff",Icon="🔫",Callback=function(v) _G.Q_farmGun=v end})
T17:CreateToggle({Name="Pickup Knife If Murderer",Icon="🔪",Callback=function(v) _G.Q_farmKnife=v end})
T17:CreateSection("Защита","🛡️")
T17:CreateToggle({Name="Auto-Flee While Farming",Icon="🏃",Callback=function(v) _G.Q_farmFlee=v end})
T17:CreateToggle({Name="Stop If Murderer Near",Icon="⚠️",Callback=function(v) _G.Q_farmStop=v end})
T17:CreateToggle({Name="Auto-Hide In Crowd",Icon="👥",Callback=function(v) _G.Q_farmHide=v end})
T17:CreateSection("Статистика","📊")
local farmCountP=T17:CreateParagraph({Title="Collected",Icon="💰",Content="0 монет"})
T17:CreateButton({Name="Reset Counter",Icon="🔄",Callback=function()
    _G.Q_farmCollected=0; farmCountP:Set({Title="Collected",Icon="💰",Content="0 монет"}); nf("Farm","reset",3,"success")
end})
T17:CreateButton({Name="Show Farm Path",Icon="🗺️",Callback=function() nf("Farm","визуализация — WIP",4,"info") end})
T17:CreateButton({Name="TP To Nearest Coin",Icon="📍",Callback=function()
    local best,bd=nil,math.huge
    for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("BasePart") and o.Name:lower():find("coin") and hrp() then
        local d=(o.Position-hrp().Position).Magnitude; if d<bd then bd=d; best=o end
    end end
    if best and hrp() then hrp().CFrame=best.CFrame+Vector3.new(0,3,0); nf("Farm","→ coin",3,"success") else nf("Farm","нет монет",3,"error") end
end})
T17:CreateButton({Name="TP To Nearest Tool",Icon="📍",Callback=function()
    local best,bd=nil,math.huge
    for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("Tool") and hrp() then
        local h=o:FindFirstChildWhichIsA("BasePart"); if h then local d=(h.Position-hrp().Position).Magnitude; if d<bd then bd=d; best=h end end
    end end
    if best and hrp() then hrp().CFrame=best.CFrame+Vector3.new(0,3,0); nf("Farm","→ tool",3,"success") else nf("Farm","нет оружия",3,"error") end
end})
T17:CreateSection("Авто","🎮")
T17:CreateToggle({Name="Auto-Rejoin After Round",Icon="🔄",Callback=function(v) _G.Q_autoRejoin=v end})
T17:CreateToggle({Name="Auto-Ready",Icon="✅",Callback=function(v) _G.Q_autoReady=v end})
T17:CreateButton({Name="Print Farm Stats",Icon="🖨️",Callback=function()
    print("Collected:",_G.Q_farmCollected or 0,"Radius:",_G.Q_farmRadius or 100)
end})
T17:CreateButton({Name="Reset Farm",Icon="🔄",Callback=function()
    _G.Q_farmCoins=false; _G.Q_farmWeapons=false; _G.Q_farmCollected=0; nf("Farm","reset",3,"success")
end})

-- ═══ TAB 18: 🏆 STATS (20) ═══
local T18=Win:CreateTab("Stats","🏆")
T18:CreateSection("Мои","👤")
local myStatP=T18:CreateParagraph({Title="My Stats",Icon="📊",Content="нажми Refresh"})
T18:CreateButton({Name="Refresh My Stats",Icon="🔄",Callback=function()
    local h=hum(); local ping=math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    myStatP:Set({Title="My Stats",Icon="📊",Content="Role: "..role(LP).." | HP: "..(h and math.floor(h.Health) or 0).." | Ping: "..ping.."ms"})
end})
T18:CreateSection("Лидеры","🥇")
T18:CreateButton({Name="Show Alive (console)",Icon="👥",Callback=function()
    print("=== ALIVE ===")
    for _,p in ipairs(Players:GetPlayers()) do
        local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
        if h and h.Health>0 then print(p.Name,"Role:"..role(p),"HP:"..math.floor(h.Health)) end
    end
    nf("Stats","консоль",3,"success")
end})
T18:CreateButton({Name="Show Dead (console)",Icon="💀",Callback=function()
    print("=== DEAD ===")
    for _,p in ipairs(Players:GetPlayers()) do
        local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
        if not h or h.Health<=0 then print(p.Name) end
    end
    nf("Stats","консоль",3,"success")
end})
T18:CreateButton({Name="Rank By HP",Icon="❤️",Callback=function()
    local list={}
    for _,p in ipairs(Players:GetPlayers()) do
        local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
        if h then table.insert(list,{p.Name,math.floor(h.Health)}) end
    end
    table.sort(list,function(a,b) return a[2]>b[2] end)
    local out={}; for i,v in ipairs(list) do table.insert(out,i.."."..v[1].."("..v[2]..")") end
    nf("Rank HP",table.concat(out," | "),10,"info","❤️")
end})
T18:CreateButton({Name="Rank By Distance",Icon="📏",Callback=function()
    if not hrp() then return end
    local list={}
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(list,{p.Name,math.floor((p.Character.HumanoidRootPart.Position-hrp().Position).Magnitude)})
        end
    end
    table.sort(list,function(a,b) return a[2]<b[2] end)
    local out={}; for i,v in ipairs(list) do table.insert(out,i.."."..v[1].."("..v[2].."m)") end
    nf("Rank Dist",table.concat(out," | "),10,"info","📏")
end})
T18:CreateSection("Роли","🎭")
local roleStatP=T18:CreateParagraph({Title="Roles",Icon="🎭",Content="нажми Scan"})
T18:CreateButton({Name="Scan Roles",Icon="🔍",Callback=function()
    local m,s,i=0,0,0
    for _,p in ipairs(Players:GetPlayers()) do local r=role(p); if r=="Murderer" then m=m+1 elseif r=="Sheriff" then s=s+1 else i=i+1 end end
    roleStatP:Set({Title="Roles",Icon="🎭",Content="🔪 "..m.." | 🔫 "..s.." | 😇 "..i})
end})
T18:CreateButton({Name="K/D (session)",Icon="📊",Callback=function() nf("K/D","В MM2 нет клиентского счётчика",4,"info") end})
T18:CreateSection("История","📜")
T18:CreateButton({Name="Log Current Round",Icon="📝",Callback=function()
    _G.Q_roundLog=_G.Q_roundLog or {}
    table.insert(_G.Q_roundLog,{time=os.date("%H:%M:%S"),players=#Players:GetPlayers(),myRole=role(LP)})
    nf("Log","#"..#_G.Q_roundLog,3,"success")
end})
T18:CreateButton({Name="Show Round Log",Icon="📋",Callback=function()
    if not _G.Q_roundLog or #_G.Q_roundLog==0 then return nf("Log","пусто",3,"info") end
    print("=== ROUND LOG ===")
    for _,e in ipairs(_G.Q_roundLog) do print(e.time,"Players:"..e.players,"MyRole:"..e.myRole) end
    nf("Log",#_G.Q_roundLog.." в консоли",3,"success")
end})
T18:CreateButton({Name="Clear Log",Icon="🧹",Callback=function() _G.Q_roundLog={}; nf("Log","очищено",3,"success") end})
T18:CreateSection("Система","📡")
T18:CreateButton({Name="Show Ping",Icon="📡",Callback=function()
    local s=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]; nf("Ping",math.floor(s:GetValue()).." ms",4,"info","📡")
end})
T18:CreateButton({Name="Show FPS",Icon="🎬",Callback=function() nf("FPS",math.floor(1/RunService.RenderStepped:Wait()).." fps",4,"info","🎬") end})
T18:CreateButton({Name="Show Memory",Icon="💾",Callback=function() nf("Memory",math.floor(collectgarbage("count")).." KB",4,"info","💾") end})
T18:CreateButton({Name="Show Uptime",Icon="⏱️",Callback=function() nf("Uptime",math.floor(tick()).." sec",4,"info","⏱️") end})
T18:CreateButton({Name="Copy Report",Icon="📋",Callback=function()
    local ping=math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    local r="Quind Report | Place:"..game.PlaceId.." | Players:"..#Players:GetPlayers().." | Ping:"..ping.."ms | Role:"..role(LP)
    if setclipboard then setclipboard(r); nf("Stats","скопировано",3,"success") end
end})
T18:CreateButton({Name="Full Stats Dump",Icon="🖨️",Callback=function()
    print("=== FULL STATS ===")
    print("PlaceId:",game.PlaceId,"Players:",#Players:GetPlayers(),"MyRole:",role(LP))
    nf("Stats","консоль",3,"success")
end})

-- ═══ TAB 19: 📢 TROLL (20) ═══
local T19=Win:CreateTab("Troll","📢")
T19:CreateParagraph({Title="Осторожно",Icon="⚠️",Content="Троллинг = риск бана. На альт-аккаунте."})
T19:CreateSection("Звуки","🔊")
T19:CreateButton({Name="Sound Near Target",Icon="🔊",Callback=function()
    local target=_G.Q_getClosest and _G.Q_getClosest()
    if target and target.Parent then
        local s=Instance.new("Sound"); s.SoundId="rbxassetid://9125402735"; s.Volume=3; s.Parent=target; s:Play()
        task.delay(5,function() s:Destroy() end); nf("Sound","played",3,"success","🔊")
    else nf("Sound","нет цели",3,"error") end
end})
T19:CreateButton({Name="Bass Boost",Icon="🎵",Callback=function()
    if hrp() then
        for i=1,5 do local s=Instance.new("Sound",hrp()); s.SoundId="rbxassetid://9120386436"; s.Volume=5; s:Play(); task.delay(2,function() s:Destroy() end); task.wait(0.2) end
        nf("Sound","bass boost",3,"success","🎵")
    end
end})
T19:CreateSection("Действия","🎪")
T19:CreateButton({Name="Throw Tools",Icon="🎲",Callback=function()
    if LP.Character then for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") then t.Parent=LP.Backpack end end; nf("Troll","спрятано",3,"success") end
end})
T19:CreateButton({Name="Fake Lag (2s)",Icon="📡",Callback=function()
    nf("Troll","лаг...",2,"info"); task.wait(2); nf("Troll","ок",2,"success")
end})
T19:CreateButton({Name="Drop All",Icon="⬇️",Callback=function()
    if LP.Character then for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") then t.Parent=LP.Backpack end end; nf("Troll","всё в бэкпак",3,"success") end
end})
T19:CreateSection("Чат","💬")
local trollMsgI=T19:CreateInput({Name="Troll Msg",Icon="💬",CurrentValue="Я мурдерер 😏",PlaceholderText="текст"})
T19:CreateButton({Name="Send Troll Message",Icon="📤",Callback=function() say(trollMsgI.Text) end})
T19:CreateButton({Name="Spam HELP x5",Icon="🆘",Callback=function()
    task.spawn(function() for i=1,5 do say("HELP HELP HELP"); task.wait(1) end end)
end})
T19:CreateButton({Name="Fake Rage Quit",Icon="😤",Callback=function() say("ВСЁ Я УХОЖУ ЭТА ИГРА СЛОМАНА 😤😤😤") end})
T19:CreateButton({Name="Fake Admin Message",Icon="👑",Callback=function() say("[ADMIN] Игрок кикнут за подозрительное поведение") end})
T19:CreateSection("Движение","🏃")
T19:CreateToggle({Name="Random Jump Spam",Icon="🦘",Callback=function(v) _G.Q_trollJump=v end})
T19:CreateToggle({Name="Random Spin",Icon="🌀",Callback=function(v) _G.Q_trollSpin=v end})
T19:CreateToggle({Name="Crouch Spam",Icon="🪑",Callback=function(v) _G.Q_trollCrouch=v end})
T19:CreateToggle({Name="Emote Loop",Icon="💃",Callback=function(v) _G.Q_trollEmote=v end})
T19:CreateSection("Эффекты","✨")
T19:CreateButton({Name="Rainbow Body",Icon="🌈",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then p.Color=Color3.fromHSV(math.random(),1,1) end end
        nf("Troll","радуга",3,"success","🌈") end
end})
T19:CreateButton({Name="Giant Head",Icon="🗣️",Callback=function()
    if LP.Character then local hd=LP.Character:FindFirstChild("Head")
        if hd then for _,m in ipairs(hd:GetChildren()) do if m:IsA("SpecialMesh") then m.Scale=Vector3.new(4,4,4) end end end
        nf("Troll","голова x4",3,"success")
    end
end})
T19:CreateButton({Name="Tiny Body",Icon="🐜",Callback=function()
    local h=hum(); if h then h.BodyHeightScale.Value=0.3; h.BodyWidthScale.Value=0.3; h.BodyDepthScale.Value=0.3; h.HeadScale.Value=0.3 end
end})

-- ═══ TAB 20: 🎬 REPLAY (20) ═══
local T20=Win:CreateTab("Replay","🎬")
T20:CreateSection("Запись","📍")
T20:CreateToggle({Name="Record Positions",Icon="🔴",Callback=function(v) _G.Q_recording=v end})
T20:CreateSlider({Name="Interval",Icon="⏱️",Range={0.1,2},Increment=0.1,CurrentValue=0.5,Callback=function(v) _G.Q_recInterval=v end})
T20:CreateButton({Name="Stop",Icon="⏹️",Callback=function() _G.Q_recording=false; nf("Replay","stopped ("..#(_G.Q_recFrames or {}).." frames)",3,"success","⏹️") end})
T20:CreateButton({Name="Clear",Icon="🧹",Callback=function() _G.Q_recFrames={}; nf("Replay","cleared",3,"success") end})
T20:CreateButton({Name="Play (visual)",Icon="▶️",Callback=function()
    if not _G.Q_recFrames or #_G.Q_recFrames==0 then return nf("Replay","пусто",3,"error") end
    nf("Replay","воспроизведение",3,"info")
end})
T20:CreateButton({Name="Recording Info",Icon="📊",Callback=function()
    local c=_G.Q_recFrames and #_G.Q_recFrames or 0; nf("Replay","кадров: "..c,4,"info","📊")
end})
T20:CreateSection("Snapshots","📸")
T20:CreateButton({Name="Save Position",Icon="📍",Callback=function()
    if hrp() then _G.Q_snapshot={CFrame=hrp().CFrame,time=os.date("%H:%M:%S")}; nf("Replay","saved",3,"success","📍") end
end})
T20:CreateButton({Name="Restore Snapshot",Icon="↩️",Callback=function()
    if _G.Q_snapshot and hrp() then hrp().CFrame=_G.Q_snapshot.CFrame; nf("Replay","restored",3,"success","↩️") end
end})
T20:CreateButton({Name="Screenshot (view)",Icon="📸",Callback=function() nf("Replay","недоступно",4,"info") end})
T20:CreateSection("Path","🏃")
T20:CreateButton({Name="Dump Path",Icon="🖨️",Callback=function()
    if _G.Q_recFrames and #_G.Q_recFrames>0 then
        print("=== RECORDED PATH ==="); for i,f in ipairs(_G.Q_recFrames) do if i<=20 then print(i,tostring(f.Position)) end end
        nf("Replay","в консоли",3,"success")
    end
end})
T20:CreateButton({Name="Auto-Patrol",Icon="🤖",Callback=function() nf("Replay","patrol WIP",4,"info") end})
T20:CreateSection("Ghost","👻")
T20:CreateToggle({Name="Show Ghost Trail",Icon="👻",Callback=function(v) _G.Q_ghostTrail=v end})
T20:CreateToggle({Name="Save Ghost Every 0.5s",Icon="💾",Callback=function(v) _G.Q_saveGhost=v end})
T20:CreateButton({Name="Clear Trail",Icon="🧹",Callback=function()
    for _,p in ipairs(_G.Q_ghostTrailParts or {}) do if p and p.Parent then p:Destroy() end end
    _G.Q_ghostTrailParts={}; nf("Replay","cleared",3,"success")
end})
T20:CreateSection("Waypoints","🚩")
T20:CreateButton({Name="Set Waypoint",Icon="🚩",Callback=function()
    if hrp() then _G.Q_waypoint=hrp().CFrame; nf("Replay","set",3,"success","🚩") end
end})
T20:CreateButton({Name="Go To Waypoint",Icon="🎯",Callback=function()
    if _G.Q_waypoint and hrp() then hrp().CFrame=_G.Q_waypoint; nf("Replay","ok",3,"success")
    else nf("Replay","waypoint не установлен",3,"error") end
end})
T20:CreateButton({Name="Loop Between 2 Points",Icon="🔁",Callback=function()
    if not _G.Q_wp1 or not _G.Q_wp2 then return nf("Replay","установи wp1/wp2",3,"error") end
    task.spawn(function() local t=true; for i=1,10 do if hrp() then hrp().CFrame=t and _G.Q_wp1 or _G.Q_wp2 end; t=not t; task.wait(0.5) end end)
    nf("Replay","loop 10x",3,"success")
end})
T20:CreateButton({Name="Set WP1",Icon="1️⃣",Callback=function() if hrp() then _G.Q_wp1=hrp().CFrame; nf("Replay","WP1",3,"success") end end})
T20:CreateButton({Name="Set WP2",Icon="2️⃣",Callback=function() if hrp() then _G.Q_wp2=hrp().CFrame; nf("Replay","WP2",3,"success") end end})

-- ═══ TAB 21: 🔐 SECURITY (20) ═══
local T21=Win:CreateTab("Security","🔐")
T21:CreateParagraph({Title="Защита",Icon="🛡️",Content="Детект читеров и защита."})
T21:CreateSection("Detection","🔍")
T21:CreateToggle({Name="Detect Speed Hackers",Icon="⚡",Callback=function(v) _G.Q_detectSpeed=v end})
T21:CreateToggle({Name="Detect Fliers",Icon="🕊️",Callback=function(v) _G.Q_detectFliers=v end})
T21:CreateToggle({Name="Detect Teleporters",Icon="📍",Callback=function(v) _G.Q_detectTP=v end})
T21:CreateButton({Name="Report Suspicious",Icon="🚨",Callback=function()
    print("=== SUSPICIOUS ===")
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character then local h=p.Character:FindFirstChildOfClass("Humanoid")
            if h and h.WalkSpeed>30 then print(p.Name,"Speed:",h.WalkSpeed) end
        end
    end
    nf("Security","в консоли",4,"info")
end})
T21:CreateSection("Anti-Spy","👁️")
T21:CreateToggle({Name="Hide My Name",Icon="🙈",Callback=function(v) _G.Q_hideName=v end})
T21:CreateToggle({Name="Hide My Tools",Icon="🔫",Callback=function(v) S.hideTools=v end})
T21:CreateToggle({Name="Go Invisible",Icon="👻",Callback=function(v) S.ghost=v end})
T21:CreateSection("Anti-Attack","🛡️")
T21:CreateToggle({Name="Anti-Kick",Icon="🚫",Callback=function(v) S.antiKick=v end})
T21:CreateToggle({Name="Anti-Freeze",Icon="🧊",Callback=function(v) _G.Q_antiFreeze=v end})
T21:CreateToggle({Name="Anti-Fling Strong",Icon="🛡️",Callback=function(v) _G.Q_antiFlingStrong=v end})
T21:CreateToggle({Name="Anti-Void Aggressive",Icon="🌌",Callback=function(v) _G.Q_antiVoidAggressive=v end})
T21:CreateToggle({Name="Auto-Heal On Damage",Icon="❤️",Callback=function(v) _G.Q_autoHeal=v end})
T21:CreateSection("Логи","📜")
local secLogP=T21:CreateParagraph({Title="Last Event",Icon="📝",Content="-"})
T21:CreateButton({Name="Clear Log",Icon="🧹",Callback=function()
    _G.Q_secLog={}; secLogP:Set({Title="Last Event",Icon="📝",Content="cleared"}); nf("Security","cleared",3,"success")
end})
T21:CreateButton({Name="Show Log",Icon="📋",Callback=function()
    if not _G.Q_secLog or #_G.Q_secLog==0 then return nf("Security","пусто",3,"info") end
    print("=== SECURITY LOG ===")
    for _,e in ipairs(_G.Q_secLog) do print(e.time,e.msg) end
    nf("Security",#_G.Q_secLog.." в консоли",3,"success")
end})
T21:CreateSection("Emergency","🚨")
T21:CreateButton({Name="Lockdown",Icon="🔒",Callback=function()
    for k,v in pairs(S) do if type(v)=="boolean" then S[k]=false end end; S.antiAfk=true; nf("Security","LOCKDOWN",6,"error","🔒")
end})
T21:CreateButton({Name="Leave Server",Icon="🚪",Callback=function() TS:Teleport(game.PlaceId,LP) end})
T21:CreateButton({Name="Character Reset",Icon="☠️",Callback=function() if LP.Character then LP.Character:BreakJoints() end end})
T21:CreateButton({Name="Full Panic",Icon="🚨",Callback=function()
    for k,v in pairs(S) do if type(v)=="boolean" then S[k]=false end end; S.antiAfk=true
    _G.Q_antiFreeze=false; _G.Q_flee=false; _G.Q_tpFrom=false
    nf("PANIC","всё off",8,"error","🚨")
end})

-- ═══ TAB 22: 🎵 MUSIC (20) — НОВЫЙ ═══
local T22=Win:CreateTab("Music","🎵")
T22:CreateParagraph({Title="Музыка",Icon="🎵",Content="Клиентский плеер. Играет локально, другие не слышат."})
T22:CreateSection("Управление","🎵")
T22:CreateButton({Name="Play / Pause",Icon="▶️",Callback=function()
    if currentSound and currentSound.Parent then
        if currentSound.IsPlaying then currentSound:Pause() else currentSound:Resume() end
        nf("Music",currentSound.IsPlaying and "play" or "pause",3,"info","🎵")
    else nf("Music","ничего не играет",3,"error") end
end})
T22:CreateButton({Name="Stop",Icon="⏹️",Callback=function()
    if currentSound then currentSound:Stop(); nf("Music","stopped",3,"success") end
end})
T22:CreateButton({Name="Restart",Icon="🔄",Callback=function()
    if currentSound then currentSound.TimePosition=0; currentSound:Play(); nf("Music","restart",3,"success") end
end})
T22:CreateSlider({Name="Volume",Icon="🔊",Range={0,3},Increment=0.1,CurrentValue=1,Callback=function(v)
    S.musicVolume=v; if currentSound then currentSound.Volume=v end
end})
T22:CreateToggle({Name="Loop",Icon="🔁",CurrentValue=true,Callback=function(v)
    S.musicLoop=v; if currentSound then currentSound.Looped=v end
end})
T22:CreateToggle({Name="3D Sound (positional)",Icon="📡",Callback=function(v)
    if currentSound then currentSound.PlayOnRemove=false end
end})
T22:CreateSection("Пресеты","📻")
local presets={
    ["Lo-Fi Chill"]=1837879082, ["Chill Beat"]=1836318263, ["Ambient"]=1838457613,
    ["Epic Battle"]=1836194475, ["Sad Piano"]=1840462187, ["Retro Synth"]=1839514431,
    ["Vaporwave"]=1842271990, ["Dark Trap"]=1844268608, ["Happy Pop"]=1835870517,
    ["Horror Amb"]=1842578625,
}
for name,id in pairs(presets) do
    T22:CreateButton({Name=name,Icon="🎵",Callback=function()
        if currentSound then currentSound:Destroy() end
        currentSound=Instance.new("Sound")
        currentSound.SoundId="rbxassetid://"..id
        currentSound.Volume=S.musicVolume
        currentSound.Looped=S.musicLoop
        currentSound.Parent=SS
        currentSound:Play()
        nf("Music",name.." ▶",3,"success","🎵")
    end})
end
T22:CreateSection("Свой трек","🎼")
local musicIdI=T22:CreateInput({Name="Sound ID",Icon="🎼",CurrentValue="1837879082",PlaceholderText="id"})
T22:CreateButton({Name="Play Custom ID",Icon="▶️",Callback=function()
    local id=tonumber(musicIdI.Text) or 0
    if id<=0 then return nf("Music","неверный ID",3,"error") end
    if currentSound then currentSound:Destroy() end
    currentSound=Instance.new("Sound")
    currentSound.SoundId="rbxassetid://"..id
    currentSound.Volume=S.musicVolume
    currentSound.Looped=S.musicLoop
    currentSound.Parent=SS
    currentSound:Play()
    nf("Music","playing "..id,3,"success","🎵")
end})
T22:CreateButton({Name="Play Random Preset",Icon="🎲",Callback=function()
    local keys={}; for k in pairs(presets) do table.insert(keys,k) end
    local pick=keys[math.random(1,#keys)]
    if currentSound then currentSound:Destroy() end
    currentSound=Instance.new("Sound")
    currentSound.SoundId="rbxassetid://"..presets[pick]
    currentSound.Volume=S.musicVolume; currentSound.Looped=S.musicLoop
    currentSound.Parent=SS; currentSound:Play()
    nf("Music","random: "..pick,3,"success","🎲")
end})
T22:CreateSection("Дополнительно","🎶")
T22:CreateSlider({Name="Playback Speed",Icon="⚡",Range={0.5,2},Increment=0.05,CurrentValue=1,Callback=function(v)
    if currentSound then currentSound.PlaybackSpeed=v end
end})
T22:CreateButton({Name="Music Info",Icon="ℹ️",Callback=function()
    if currentSound then
        local t=math.floor(currentSound.TimePosition)
        local d=math.floor(currentSound.TimeLength)
        nf("Music","Time: "..t.."/"..d.."s | Vol: "..currentSound.Volume,5,"info","🎵")
    else nf("Music","ничего не играет",3,"error") end
end})
T22:CreateButton({Name="Stop All Client Sounds",Icon="🔇",Callback=function()
    for _,s in ipairs(SS:GetChildren()) do if s:IsA("Sound") then s:Stop() end end
    nf("Music","все звуки остановлены",3,"success","🔇")
end})
T22:CreateButton({Name="Volume +10%",Icon="🔊",Callback=function()
    if currentSound then currentSound.Volume=math.min(currentSound.Volume+0.1,3) end
end})
T22:CreateButton({Name="Volume -10%",Icon="🔉",Callback=function()
    if currentSound then currentSound.Volume=math.max(currentSound.Volume-0.1,0) end
end})

-- ═══ TAB 23: 🎯 PRACTICE (20) — НОВЫЙ ═══
local T23=Win:CreateTab("Practice","🎯")
T23:CreateSection("Aim Тренировка","🎯")
T23:CreateButton({Name="Snap To Random Target",Icon="🎯",Callback=function()
    local list={}
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character and p.Character:FindFirstChild("Head") then table.insert(list,p) end end
    if #list>0 then
        local t=list[math.random(1,#list)]
        Cam.CFrame=CFrame.new(Cam.CFrame.Position,t.Character.Head.Position)
        nf("Practice","→ "..t.Name,2,"success","🎯")
    end
end})
T23:CreateButton({Name="Flick Test (random)",Icon="⚡",Callback=function()
    local ok=math.random(1,2)==1
    nf("Flick",ok and "HIT" or "MISS",2,ok and "success" or "error","⚡")
end})
T23:CreateButton({Name="Mouse Sensitivity (fake)",Icon="🖱️",Callback=function() nf("Practice","требует настройки Roblox",4,"info") end})
T23:CreateToggle({Name="Practice Mode On",Icon="🎯",Callback=function(v) _G.Q_practice=v end})
T23:CreateSection("Реакция","⚡")
T23:CreateButton({Name="Reaction Test",Icon="⚡",Callback=function()
    local t=tick(); task.wait(math.random(1,3)); nf("Reaction",math.floor((tick()-t)*1000).."ms reaction (fake)",5,"info","⚡")
end})
T23:CreateButton({Name="Start Practice Session",Icon="▶️",Callback=function()
    _G.Q_practice={start=tick(), hits=0, misses=0}
    nf("Practice","session started",3,"success","▶️")
end})
T23:CreateButton({Name="End Practice Session",Icon="⏹️",Callback=function()
    if _G.Q_practice then
        local dur=math.floor(tick()-_G.Q_practice.start)
        nf("Practice","Time: "..dur.."s",5,"info","⏹️"); _G.Q_practice=nil
    else nf("Practice","не запущено",3,"error") end
end})
T23:CreateSection("Цели","🎯")
T23:CreateButton({Name="Spawn Aim Target (parts)",Icon="🎯",Callback=function()
    local p=Instance.new("Part"); p.Size=Vector3.new(3,3,3); p.Shape=Enum.PartType.Ball
    p.BrickColor=BrickColor.Red(); p.Material=Enum.Material.Neon; p.Anchored=true
    if hrp() then p.Position=hrp().Position+Cam.CFrame.LookVector*50 else p.Position=Vector3.new(0,50,0) end
    p.Parent=workspace; Debris:AddItem(p,30)
    nf("Practice","target spawned",3,"success","🎯")
end})
T23:CreateButton({Name="Spawn 5 Targets",Icon="🎯",Callback=function()
    for i=1,5 do
        local p=Instance.new("Part"); p.Size=Vector3.new(2,2,2); p.Shape=Enum.PartType.Ball
        p.BrickColor=BrickColor.Red(); p.Material=Enum.Material.Neon; p.Anchored=true
        if hrp() then p.Position=hrp().Position+Cam.CFrame.LookVector*(30+i*5)+Vector3.new(math.random(-10,10),math.random(-5,5),0) end
        p.Parent=workspace; Debris:AddItem(p,30)
    end
    nf("Practice","5 targets",3,"success","🎯")
end})
T23:CreateButton({Name="Clear Targets",Icon="🧹",Callback=function()
    for _,o in ipairs(workspace:GetChildren()) do if o:IsA("Part") and o.BrickColor==BrickColor.Red() and o.Anchored then o:Destroy() end end
    nf("Practice","cleared",3,"success")
end})
T23:CreateSection("Таймеры","⏱️")
T23:CreateButton({Name="Start 30s Timer",Icon="⏱️",Callback=function()
    nf("Timer","30s",2,"info","⏱️"); task.delay(30,function() nf("Timer","Время! 30s",5,"success","⏱️") end)
end})
T23:CreateButton({Name="Start 60s Timer",Icon="⏱️",Callback=function()
    nf("Timer","60s",2,"info","⏱️"); task.delay(60,function() nf("Timer","Время! 60s",5,"success","⏱️") end)
end})
T23:CreateButton({Name="Show Session Stats",Icon="📊",Callback=function()
    if _G.Q_practice then nf("Session","hits:".._G.Q_practice.hits.." misses:".._G.Q_practice.misses,5,"info")
    else nf("Session","не запущена",3,"error") end
end})
T23:CreateButton({Name="Register Hit",Icon="✅",Callback=function()
    if _G.Q_practice then _G.Q_practice.hits=_G.Q_practice.hits+1; nf("Hit",_G.Q_practice.hits.." total",2,"success","✅") end
end})
T23:CreateButton({Name="Register Miss",Icon="❌",Callback=function()
    if _G.Q_practice then _G.Q_practice.misses=_G.Q_practice.misses+1; nf("Miss",_G.Q_practice.misses.." total",2,"error","❌") end
end})
T23:CreateButton({Name="Reset Session",Icon="🔄",Callback=function() _G.Q_practice=nil; nf("Practice","reset",3,"success") end})
T23:CreateSection("Stats","📊")
T23:CreateButton({Name="Accuracy %",Icon="📊",Callback=function()
    if _G.Q_practice and (_G.Q_practice.hits+_G.Q_practice.misses)>0 then
        local acc=math.floor(_G.Q_practice.hits/(_G.Q_practice.hits+_G.Q_practice.misses)*100)
        nf("Accuracy",acc.."%",5,"info","📊")
    else nf("Accuracy","нет данных",3,"error") end
end})
T23:CreateButton({Name="Reset All Practice",Icon="🧹",Callback=function() _G.Q_practice=nil; nf("Practice","reset",3,"success") end})

-- ═══ TAB 24: 🎨 SKINS (20) — НОВЫЙ ═══
local T24=Win:CreateTab("Skins","🎨")
T24:CreateParagraph({Title="Клиентские скины",Icon="🎨",Content="Меняет цвет и материал своего персонажа. Другие могут не увидеть."})
T24:CreateSection("Цвет","🌈")
T24:CreateButton({Name="Red",Icon="🔴",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromRGB(220,40,40) end end end
end})
T24:CreateButton({Name="Blue",Icon="🔵",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromRGB(40,80,220) end end end
end})
T24:CreateButton({Name="Green",Icon="🟢",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromRGB(40,220,80) end end end
end})
T24:CreateButton({Name="Purple",Icon="🟣",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromRGB(180,80,220) end end end
end})
T24:CreateButton({Name="Gold",Icon="🟡",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromRGB(255,200,40) end end end
end})
T24:CreateButton({Name="Black",Icon="⬛",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromRGB(20,20,20) end end end
end})
T24:CreateButton({Name="White",Icon="⬜",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromRGB(240,240,240) end end end
end})
T24:CreateButton({Name="Rainbow",Icon="🌈",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromHSV(math.random(),1,1) end end end
end})
T24:CreateSection("Материал","💎")
T24:CreateButton({Name="Neon",Icon="💡",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Material=Enum.Material.Neon end end end
end})
T24:CreateButton({Name="ForceField",Icon="⚡",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Material=Enum.Material.ForceField end end end
end})
T24:CreateButton({Name="Glass",Icon="🔷",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Material=Enum.Material.Glass; p.Transparency=0.5 end end end
end})
T24:CreateButton({Name="Ice",Icon="🧊",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Material=Enum.Material.Ice end end end
end})
T24:CreateButton({Name="Metal",Icon="⚙️",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Material=Enum.Material.Metal end end end
end})
T24:CreateButton({Name="Wood",Icon="🪵",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Material=Enum.Material.Wood end end end
end})
T24:CreateButton({Name="Reset Material",Icon="🔄",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Material=Enum.Material.Plastic end end end
end})
T24:CreateSection("Пресеты","⚡")
T24:CreateButton({Name="Rainbow Pulsing",Icon="🌈",Callback=function()
    task.spawn(function() for i=1,60 do if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromHSV((tick()+i*0.05)%1,1,1) end end end; task.wait(0.1) end end)
end})
T24:CreateButton({Name="Shadow (black + transparent)",Icon="🌑",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.new(0,0,0); p.Material=Enum.Material.Neon; p.Transparency=0.3 end end end
end})
T24:CreateButton({Name="Golden God",Icon="👑",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromRGB(255,200,40); p.Material=Enum.Material.Neon end end end
end})
T24:CreateButton({Name="Reset All Skins",Icon="🔄",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromRGB(200,200,200); p.Material=Enum.Material.Plastic; p.Transparency=0 end end end
    nf("Skins","reset",3,"success")
end})
T24:CreateButton({Name="Random Skin",Icon="🎲",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromHSV(math.random(),1,1); p.Material=Enum.Material.Neon end end end
end})

-- ═══ TAB 25: 🗺️ MAPS (20) — НОВЫЙ ═══
local T25=Win:CreateTab("Maps","🗺️")
T25:CreateParagraph({Title="Карты",Icon="🗺️",Content="Показывает текущую карту и даёт полезные точки."})
T25:CreateSection("Инфо","📊")
T25:CreateButton({Name="Show Current Map Name",Icon="📋",Callback=function()
    local mapName="unknown"
    for _,o in ipairs(workspace:GetChildren()) do
        if o:IsA("Model") and o.Name:lower():find("map") then mapName=o.Name; break end
        if o:IsA("Folder") and o.Name:lower():find("map") then mapName=o.Name; break end
    end
    nf("Map",mapName,6,"info","🗺️")
end})
T25:CreateButton({Name="List Workspace Children",Icon="🖨️",Callback=function()
    print("=== WORKSPACE ===")
    for _,o in ipairs(workspace:GetChildren()) do print(o.ClassName,o.Name) end
    nf("Map","в консоли",3,"success")
end})
T25:CreateButton({Name="Count Parts",Icon="📊",Callback=function()
    local c=0; for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("BasePart") then c=c+1 end end
    nf("Map","parts: "..c,4,"info")
end})
T25:CreateSection("Точки","📍")
T25:CreateButton({Name="List Spawn Locations",Icon="🏠",Callback=function()
    local l={}; for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("SpawnLocation") then table.insert(l,o.Name) end end
    nf("Spawns",#l..": "..table.concat(l,", "),6,"info")
end})
T25:CreateButton({Name="TP To Random Spawn",Icon="🎲",Callback=function()
    local sp={}; for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("SpawnLocation") then table.insert(sp,o) end end
    if #sp>0 and hrp() then hrp().CFrame=sp[math.random(1,#sp)].CFrame+Vector3.new(0,3,0) end
end})
T25:CreateButton({Name="TP To Highest Part",Icon="⛰️",Callback=function()
    local top,y=nil,-math.huge
    for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("BasePart") and o.Anchored and o.Position.Y>y then y=o.Position.Y; top=o end end
    if top and hrp() then hrp().CFrame=top.CFrame+Vector3.new(0,5,0) end
end})
T25:CreateButton({Name="TP To Lowest Part",Icon="🕳️",Callback=function()
    local low,y=nil,math.huge
    for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("BasePart") and o.Anchored and o.Position.Y<y then y=o.Position.Y; low=o end end
    if low and hrp() then hrp().CFrame=low.CFrame+Vector3.new(0,5,0) end
end})
T25:CreateButton({Name="TP To Center Of Map",Icon="🎯",Callback=function()
    if hrp() then hrp().CFrame=CFrame.new(0,50,0) end
end})
T25:CreateButton({Name="TP To Random Part",Icon="🎲",Callback=function()
    local parts={}; for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("BasePart") and o.Anchored then table.insert(parts,o) end end
    if #parts>0 and hrp() then hrp().CFrame=parts[math.random(1,#parts)].CFrame+Vector3.new(0,5,0) end
end})
T25:CreateSection("Крупные модели","📦")
T25:CreateButton({Name="Find Biggest Model",Icon="📦",Callback=function()
    local biggest,size=nil,0
    for _,o in ipairs(workspace:GetChildren()) do
        if o:IsA("Model") then
            local _,s=o:GetBoundingBox()
            local sz=s.X*s.Y*s.Z
            if sz>size then size=sz; biggest=o end
        end
    end
    if biggest then nf("Model",biggest.Name.." size "..math.floor(size),6,"info") end
end})
T25:CreateButton({Name="TP To Biggest Model",Icon="📍",Callback=function()
    local biggest,size=nil,0
    for _,o in ipairs(workspace:GetChildren()) do
        if o:IsA("Model") then
            local _,s=o:GetBoundingBox()
            local sz=s.X*s.Y*s.Z
            if sz>size then size=sz; biggest=o end
        end
    end
    if biggest then local cf=biggest:GetModelCFrame(); if hrp() then hrp().CFrame=cf+Vector3.new(0,10,0) end; nf("Map","→ "..biggest.Name,3,"success") end
end})
T25:CreateSection("Поиск","🔍")
T25:CreateButton({Name="Find Coins",Icon="💰",Callback=function()
    local c=0; for _,o in ipairs(workspace:GetDescendants()) do if o.Name:lower():find("coin") then c=c+1 end end
    nf("Search","coins: "..c,4,"info")
end})
T25:CreateButton({Name="Find Tools",Icon="🔫",Callback=function()
    local c=0; for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("Tool") then c=c+1 end end
    nf("Search","tools: "..c,4,"info")
end})
T25:CreateButton({Name="Find NPCs",Icon="👤",Callback=function()
    local c=0; for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("Model") and o:FindFirstChildOfClass("Humanoid") and not Players:GetPlayerFromCharacter(o) then c=c+1 end end
    nf("Search","NPCs: "..c,4,"info")
end})
T25:CreateButton({Name="Find Vehicles",Icon="🚗",Callback=function()
    local c=0; for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("VehicleSeat") then c=c+1 end end
    nf("Search","vehicles: "..c,4,"info")
end})
T25:CreateButton({Name="TP To Nearest Coin",Icon="💰",Callback=function()
    local best,bd=nil,math.huge
    for _,o in ipairs(workspace:GetDescendants()) do
        if o.Name:lower():find("coin") and o:IsA("BasePart") and hrp() then
            local d=(o.Position-hrp().Position).Magnitude; if d<bd then bd=d; best=o end
        end
    end
    if best and hrp() then hrp().CFrame=best.CFrame+Vector3.new(0,3,0) end
end})
T25:CreateButton({Name="Reset Map Data",Icon="🔄",Callback=function() nf("Map","reset",3,"success") end})

-- ═══ TAB 26: 📊 TELEMETRY (20) — НОВЫЙ ═══
local T26=Win:CreateTab("Telemetry","📊")
T26:CreateSection("Live Stats","📊")
local teleP=T26:CreateParagraph({Title="Live",Icon="📊",Content="нажми Update"})
T26:CreateButton({Name="Update Live Stats",Icon="🔄",Callback=function()
    local ping=math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    local fps=math.floor(1/RunService.RenderStepped:Wait())
    local mem=math.floor(collectgarbage("count"))
    teleP:Set({Title="Live",Icon="📊",Content="Ping:"..ping.."ms FPS:"..fps.." Mem:"..mem.."KB"})
end})
T26:CreateToggle({Name="Auto Update",Icon="♻️",Callback=function(v) _G.Q_teleAuto=v end})
T26:CreateSection("Network","📡")
T26:CreateButton({Name="Show Incoming KB",Icon="📥",Callback=function()
    local s=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]
    nf("Net","ping "..math.floor(s:GetValue()).."ms",4,"info","📡")
end})
T26:CreateButton({Name="Show Outgoing KB",Icon="📤",Callback=function() nf("Net","outgoing WIP",4,"info") end})
T26:CreateButton({Name="Ping Test x5",Icon="📡",Callback=function()
    task.spawn(function() for i=1,5 do
        local s=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]
        nf("Ping "..i,math.floor(s:GetValue()).."ms",2,"info","📡"); task.wait(0.5)
    end end)
end})
T26:CreateSection("Performance","⚡")
T26:CreateButton({Name="Measure FPS (3s avg)",Icon="🎬",Callback=function()
    local frames=0; local t=tick()
    while tick()-t<3 do frames=frames+1; RunService.RenderStepped:Wait() end
    nf("FPS",math.floor(frames/3).." fps avg",5,"info","🎬")
end})
T26:CreateButton({Name="Show Part Count",Icon="📦",Callback=function()
    local c=0; for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("BasePart") then c=c+1 end end
    nf("Parts",tostring(c),5,"info")
end})
T26:CreateButton({Name="Show Script Count",Icon="📜",Callback=function()
    local c=0; for _,o in ipairs(game:GetDescendants()) do if o:IsA("Script") or o:IsA("LocalScript") then c=c+1 end end
    nf("Scripts",tostring(c),5,"info")
end})
T26:CreateButton({Name="Show Instance Count",Icon="🗂️",Callback=function()
    local c=0; for _ in ipairs(game:GetDescendants()) do c=c+1 end
    nf("Instances",tostring(c),5,"info")
end})
T26:CreateSection("Timers","⏱️")
T26:CreateButton({Name="Start Session Timer",Icon="▶️",Callback=function()
    _G.Q_sessionStart=tick(); nf("Timer","started",3,"success","▶️")
end})
T26:CreateButton({Name="Show Session Duration",Icon="⏱️",Callback=function()
    if _G.Q_sessionStart then nf("Duration",math.floor(tick()-_G.Q_sessionStart).."s",4,"info","⏱️") else nf("Timer","не запущен",3,"error") end
end})
T26:CreateButton({Name="Reset Session Timer",Icon="🔄",Callback=function() _G.Q_sessionStart=tick(); nf("Timer","reset",3,"success") end})
T26:CreateSection("Логирование","📜")
T26:CreateButton({Name="Start Logging Pings",Icon="📝",Callback=function()
    _G.Q_pingLog={}
    task.spawn(function() for i=1,30 do
        local p=math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
        table.insert(_G.Q_pingLog,p); task.wait(1)
    end end)
    nf("Log","30 pings...",3,"info")
end})
T26:CreateButton({Name="Show Ping Log",Icon="📋",Callback=function()
    if _G.Q_pingLog and #_G.Q_pingLog>0 then
        local avg=0; for _,p in ipairs(_G.Q_pingLog) do avg=avg+p end; avg=math.floor(avg/#_G.Q_pingLog)
        nf("Ping Log","avg: "..avg.."ms, samples: "..#_G.Q_pingLog,6,"info")
    else nf("Log","пусто",3,"error") end
end})
T26:CreateButton({Name="Clear Ping Log",Icon="🧹",Callback=function() _G.Q_pingLog={}; nf("Log","cleared",3,"success") end})
T26:CreateButton({Name="Dump Full Report",Icon="🖨️",Callback=function()
    print("=== TELEMETRY ===")
    print("PlaceId:",game.PlaceId,"Players:",#Players:GetPlayers())
    print("FPS avg over 1s:",math.floor(1/RunService.RenderStepped:Wait()))
    nf("Telemetry","консоль",3,"success")
end})
T26:CreateButton({Name="Copy Report",Icon="📋",Callback=function()
    local ping=math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    local r="Ping:"..ping.."ms Players:"..#Players:GetPlayers().." Place:"..game.PlaceId
    if setclipboard then setclipboard(r); nf("Telemetry","скопировано",3,"success") end
end})

-- ═══ TAB 27: 🔔 NOTIFICATIONS (20) — НОВЫЙ ═══
local T27=Win:CreateTab("Notifications","🔔")
T27:CreateSection("Тест","🧪")
T27:CreateButton({Name="Test Info",Icon="ℹ️",Callback=function() nf("Test","info notification",4,"info","ℹ️") end})
T27:CreateButton({Name="Test Success",Icon="✅",Callback=function() nf("Test","success",4,"success","✅") end})
T27:CreateButton({Name="Test Error",Icon="❌",Callback=function() nf("Test","error",4,"error","❌") end})
T27:CreateButton({Name="Test Long Message",Icon="📝",Callback=function() nf("Test","Это длинное сообщение для проверки переноса строк и читабельности текста в уведомлениях",8,"info") end})
T27:CreateButton({Name="Spam 5 Notifs",Icon="🔔",Callback=function()
    task.spawn(function() for i=1,5 do nf("Spam",i.."/5",2,"info","🔔"); task.wait(0.5) end end)
end})
T27:CreateSection("Настройки","⚙️")
T27:CreateSlider({Name="Default Duration",Icon="⏱️",Range={1,15},Increment=1,CurrentValue=4,Callback=function(v) _G.Q_notifDur=v end})
T27:CreateToggle({Name="Mute All Notifs",Icon="🔇",Callback=function(v) _G.Q_noNotif=v end})
T27:CreateToggle({Name="Show Timestamps",Icon="🕐",Callback=function(v) _G.Q_notifTime=v end})
T27:CreateSection("События","📢")
T27:CreateToggle({Name="Notify On Player Join",Icon="👋",Callback=function(v) _G.Q_notifJoin=v end})
T27:CreateToggle({Name="Notify On Player Leave",Icon="👋",Callback=function(v) _G.Q_notifLeave=v end})
T27:CreateToggle({Name="Notify On My Death",Icon="💀",Callback=function(v) _G.Q_notifDeath=v end})
T27:CreateToggle({Name="Notify On My Respawn",Icon="♻️",Callback=function(v) _G.Q_notifRespawn=v end})
T27:CreateToggle({Name="Notify On Murderer Near",Icon="⚠️",Callback=function(v) _G.Q_notifMurder=v end})
T27:CreateSection("Действия","🎯")
T27:CreateButton({Name="Clear All Notifs",Icon="🧹",Callback=function()
    pcall(function()
        local gui=LP:WaitForChild("PlayerGui"):FindFirstChild("QuindUI")
        if gui then for _,f in ipairs(gui:GetChildren()) do if f:IsA("Frame") then for _,c in ipairs(f:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end end end end
    end)
    nf("Notifs","cleared",3,"success")
end})
T27:CreateButton({Name="Show Notif Stats",Icon="📊",Callback=function() nf("Notifs","всего показано: "..(_G.Q_notifCount or 0),5,"info") end})
T27:CreateButton({Name="Reset Notif Counter",Icon="🔄",Callback=function() _G.Q_notifCount=0; nf("Notifs","reset",3,"success") end})
T27:CreateButton({Name="Test Rainbow Color",Icon="🌈",Callback=function() nf("Rainbow","🎨🌈🎨",5,"info","🌈") end})
T27:CreateButton({Name="Test Icon Set",Icon="🎭",Callback=function() nf("Icons","🎯⚡🔥💎👑",5,"info","🎭") end})
T27:CreateButton({Name="Mega Notif",Icon="💥",Callback=function() nf("MEGA","█████████ 💥",8,"error","💥") end})
T27:CreateButton({Name="Reset Notif Settings",Icon="🔄",Callback=function()
    _G.Q_noNotif=false; _G.Q_notifDur=4; nf("Notifs","settings reset",3,"success")
end})

-- ═══ TAB 28: 🎲 RANDOM (20) — НОВЫЙ ═══
local T28=Win:CreateTab("Random","🎲")
T28:CreateSection("Генераторы","🎲")
T28:CreateButton({Name="Random Number 1-100",Icon="🎲",Callback=function() nf("Random",math.random(1,100),4,"info","🎲") end})
T28:CreateButton({Name="Coin Flip",Icon="🪙",Callback=function() nf("Coin",math.random(1,2)==1 and "Орёл" or "Решка",4,"info","🪙") end})
T28:CreateButton({Name="Dice Roll (1-6)",Icon="🎲",Callback=function() nf("Dice",math.random(1,6),4,"info","🎲") end})
T28:CreateButton({Name="Random Color",Icon="🎨",Callback=function() nf("Color",tostring(Color3.fromHSV(math.random(),1,1)),4,"info","🎨") end})
T28:CreateButton({Name="Random Emoji",Icon="😀",Callback=function()
    local e={"😀","🎉","🚀","💯","🔥","⭐","🎮","👑","🗿","💎"}
    nf("Emoji",e[math.random(1,#e)],4,"info","😀")
end})
T28:CreateButton({Name="Random Joke",Icon="😂",Callback=function()
    local j={"Почему мурдерер плакал? Нож затупился.","Шериф купил очки. Теперь никого не убивает.","Инносент: 'Я невиновен!' Мурдерер: 'Верю, но нож не верит.'"}
    nf("Joke",j[math.random(1,#j)],6,"info","😂")
end})
T28:CreateSection("Действия","🎯")
T28:CreateButton({Name="Random TP",Icon="📍",Callback=function()
    if hrp() then hrp().CFrame=CFrame.new(math.random(-200,200),80,math.random(-200,200)) end
end})
T28:CreateButton({Name="Random Emote",Icon="💃",Callback=function()
    local h=hum(); if h then local e={"wave","dance","dance2","dance3","laugh","cheer","point","salute"}; pcall(function() h:PlayEmote(e[math.random(1,#e)]) end) end
end})
T28:CreateButton({Name="Random Color Body",Icon="🌈",Callback=function()
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromHSV(math.random(),1,1) end end end
end})
T28:CreateButton({Name="Random Spin",Icon="🌀",Callback=function()
    if hrp() then hrp().CFrame=hrp().CFrame*CFrame.Angles(0,math.random()*math.pi*2,0) end
end})
T28:CreateSection("Решения","🤔")
T28:CreateButton({Name="Yes / No",Icon="❓",Callback=function() nf("Decision",math.random(1,2)==1 and "Да" or "Нет",4,"info","❓") end})
T28:CreateButton({Name="Who Is Murderer?",Icon="🔪",Callback=function()
    local list={}; for _,p in ipairs(Players:GetPlayers()) do table.insert(list,p.Name) end
    if #list>0 then nf("Random Picker","Murderer: "..list[math.random(1,#list)],5,"info","🔪") end
end})
T28:CreateButton({Name="Random Player",Icon="👤",Callback=function()
    local list={}; for _,p in ipairs(Players:GetPlayers()) do if p~=LP then table.insert(list,p.Name) end end
    if #list>0 then nf("Random",list[math.random(1,#list)],4,"info","👤") end
end})
T28:CreateButton({Name="Magic 8-Ball",Icon="🔮",Callback=function()
    local a={"Да","Нет","Возможно","Сомнительно","Определённо","Не сегодня","Спроси позже","100% да"}
    nf("8-Ball",a[math.random(1,#a)],4,"info","🔮")
end})
T28:CreateSection("Скины","🎨")
T28:CreateButton({Name="Random Material",Icon="💎",Callback=function()
    local m={Enum.Material.Neon,Enum.Material.Glass,Enum.Material.Ice,Enum.Material.Metal,Enum.Material.ForceField,Enum.Material.Plastic}
    if LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.Material=m[math.random(1,#m)] end end end
end})
T28:CreateButton({Name="Random Hat (spawn)",Icon="🎩",Callback=function()
    local p=Instance.new("Part",workspace); p.Shape=Enum.PartType.Ball; p.Size=Vector3.new(1,1,1)
    p.Material=Enum.Material.Neon; p.Color=Color3.fromHSV(math.random(),1,1); p.Anchored=true
    if hrp() then p.CFrame=hrp().CFrame+Vector3.new(0,4,0) end
    Debris:AddItem(p,15)
end})
T28:CreateButton({Name="Random Teleport Near",Icon="📍",Callback=function()
    if hrp() then hrp().CFrame=hrp().CFrame+Vector3.new(math.random(-30,30),0,math.random(-30,30)) end
end})
T28:CreateButton({Name="Chaos Mode (random spam)",Icon="🌀",Callback=function()
    task.spawn(function() for i=1,10 do
        if hrp() then hrp().CFrame=hrp().CFrame+Vector3.new(math.random(-20,20),math.random(0,10),math.random(-20,20)) end
        task.wait(0.3)
    end end)
    nf("Chaos","10 random jumps",4,"info","🌀")
end})
T28:CreateButton({Name="Fortune Cookie",Icon="🥠",Callback=function()
    local f={"Скоро тебя найдёт Мурдерер.","Твой Шериф тебя подведёт.","В следующем раунде ты победишь.","Нож — твой лучший друг.","Не доверяй никому.","Ты выживешь."}
    nf("🥠",f[math.random(1,#f)],6,"info","🥠")
end})

-- ═══ TAB 29: ⌨️ HOTKEYS (20) — НОВЫЙ ═══
local T29=Win:CreateTab("Hotkeys","⌨️")
T29:CreateSection("Основные","⌨️")
T29:CreateButton({Name="Bind Toggle UI (RightShift)",Icon="⌨️",Callback=function()
    UIS.InputBegan:Connect(function(i,g)
        if not g and i.KeyCode==Enum.KeyCode.RightShift then
            local gui=LP:WaitForChild("PlayerGui"):FindFirstChild("QuindUI")
            if gui then for _,c in ipairs(gui:GetChildren()) do if c:IsA("Frame") then c.Visible=not c.Visible end end end
        end
    end)
    nf("Hotkey","RightShift",3,"success")
end})
T29:CreateButton({Name="Bind Panic (P)",Icon="🚨",Callback=function()
    UIS.InputBegan:Connect(function(i,g)
        if not g and i.KeyCode==Enum.KeyCode.P then
            for k,v in pairs(S) do if type(v)=="boolean" then S[k]=false end end
            S.antiAfk=true; nf("PANIC","P pressed",4,"error","🚨")
        end
    end)
    nf("Hotkey","P",3,"success")
end})
T29:CreateButton({Name="Bind Noclip Toggle (N)",Icon="👻",Callback=function()
    UIS.InputBegan:Connect(function(i,g)
        if not g and i.KeyCode==Enum.KeyCode.N then S.noclip=not S.noclip; nf("Noclip",S.noclip and "ON" or "OFF",2,"info") end
    end)
    nf("Hotkey","N",3,"success")
end})
T29:CreateButton({Name="Bind Fly Toggle (F)",Icon="🕊️",Callback=function()
    UIS.InputBegan:Connect(function(i,g)
        if not g and i.KeyCode==Enum.KeyCode.F then S.flyOn=not S.flyOn; nf("Fly",S.flyOn and "ON" or "OFF",2,"info") end
    end)
    nf("Hotkey","F",3,"success")
end})
T29:CreateButton({Name="Bind Speed Toggle (X)",Icon="⚡",Callback=function()
    UIS.InputBegan:Connect(function(i,g)
        if not g and i.KeyCode==Enum.KeyCode.X then S.speedOn=not S.speedOn; nf("Speed",S.speedOn and "ON" or "OFF",2,"info") end
    end)
    nf("Hotkey","X",3,"success")
end})
T29:CreateButton({Name="Bind ESP Toggle (E)",Icon="👁️",Callback=function()
    UIS.InputBegan:Connect(function(i,g)
        if not g and i.KeyCode==Enum.KeyCode.E then S.espOn=not S.espOn; nf("ESP",S.espOn and "ON" or "OFF",2,"info") end
    end)
    nf("Hotkey","E",3,"success")
end})
T29:CreateSection("Расширенные","⌨️")
T29:CreateButton({Name="Bind TP To Spawn (T)",Icon="🏠",Callback=function()
    UIS.InputBegan:Connect(function(i,g)
        if not g and i.KeyCode==Enum.KeyCode.T then
            local sp=workspace:FindFirstChildOfClass("SpawnLocation")
            if sp and hrp() then hrp().CFrame=sp.CFrame+Vector3.new(0,5,0) end
        end
    end)
    nf("Hotkey","T",3,"success")
end})
T29:CreateButton({Name="Bind Random TP (R)",Icon="🎲",Callback=function()
    UIS.InputBegan:Connect(function(i,g)
        if not g and i.KeyCode==Enum.KeyCode.R then
            if hrp() then hrp().CFrame=CFrame.new(math.random(-200,200),80,math.random(-200,200)) end
        end
    end)
    nf("Hotkey","R",3,"success")
end})
T29:CreateButton({Name="Bind Kill Self (K)",Icon="☠️",Callback=function()
    UIS.InputBegan:Connect(function(i,g)
        if not g and i.KeyCode==Enum.KeyCode.K then if LP.Character then LP.Character:BreakJoints() end end
    end)
    nf("Hotkey","K",3,"success")
end})
T29:CreateButton({Name="Bind Dance Emote (G)",Icon="💃",Callback=function()
    UIS.InputBegan:Connect(function(i,g)
        if not g and i.KeyCode==Enum.KeyCode.G then local h=hum(); if h then pcall(function() h:PlayEmote("dance") end) end end
    end)
    nf("Hotkey","G",3,"success")
end})
T29:CreateSection("Свои","🎯")
T29:CreateButton({Name="Custom Bind Example",Icon="⌨️",Callback=function()
    nf("Hotkey","Используй Set Aimbot Key из Combat",4,"info")
end})
T29:CreateButton({Name="List All Hotkeys",Icon="📋",Callback=function()
    nf("Hotkeys","RShift:UI | P:Panic | N:Noclip | F:Fly | X:Speed | E:ESP | T:Spawn | R:RandomTP | K:Kill | G:Dance",10,"info","📋")
end})
T29:CreateButton({Name="Remove All Hotkeys",Icon="🧹",Callback=function()
    nf("Hotkeys","при следующем перезапуске",4,"info")
end})
T29:CreateButton({Name="Hotkey Help",Icon="❓",Callback=function()
    nf("Help","Бинды работают локально в сессии",5,"info","❓")
end})
T29:CreateSection("Модификаторы","⚙️")
T29:CreateToggle({Name="Enable Modifier Mode",Icon="⌨️",Callback=function(v) _G.Q_modMode=v end})
T29:CreateButton({Name="Reset All Hotkeys",Icon="🔄",Callback=function() nf("Hotkeys","reset (перезапусти скрипт)",4,"success") end})
T29:CreateButton({Name="Show Modifier Mode Status",Icon="📊",Callback=function()
    nf("Modifier",_G.Q_modMode and "ON" or "OFF",3,"info")
end})

-- ═══ TAB 30: ℹ️ ABOUT (20) — НОВЫЙ ═══
local T30=Win:CreateTab("About","ℹ️")
T30:CreateSection("Информация","ℹ️")
T30:CreateParagraph({Title="Quind Hub Ultimate",Icon="🗿",Content="30 табов | 600+ функций | Музыкальный плеер | made by hashtrash"})
T30:CreateParagraph({Title="Версия",Icon="📌",Content="v3.0 Ultimate | Build 2026"})
T30:CreateParagraph({Title="Автор",Icon="✍️",Content="hashtrash"})
T30:CreateButton({Name="Show Credits",Icon="🏆",Callback=function()
    nf("Credits","hashtrash (author) | Quind Hub 2026",6,"info","🏆")
end})
T30:CreateButton({Name="Show Features List",Icon="📋",Callback=function()
    nf("Features","Aimbot, ESP, Farm, Music, Troll, Skins, Telemetry, ...",8,"info","📋")
end})
T30:CreateButton({Name="Show Tab Count",Icon="📊",Callback=function() nf("Tabs","30 табов",3,"info","📊") end})
T30:CreateButton({Name="Show Function Count",Icon="📊",Callback=function() nf("Funcs","600+ функций",3,"info","📊") end})
T30:CreateSection("Помощь","❓")
T30:CreateButton({Name="How To Use",Icon="❓",Callback=function()
    nf("Help","Кликай по кнопкам в табах слева. Тумблеры включают функции. Слайдеры меняют значения.",8,"info","❓")
end})
T30:CreateButton({Name="Hotkey List",Icon="⌨️",Callback=function()
    nf("Hotkeys","RShift:UI | P:Panic | N:Noclip | F:Fly | X:Speed | E:ESP",8,"info","⌨️")
end})
T30:CreateButton({Name="Common Issues",Icon="⚠️",Callback=function()
    nf("Issues","Если функция не работает — экзекьютор не поддерживает. Попробуй Delta/Xeno/Solara.",8,"info","⚠️")
end})
T30:CreateSection("Ссылки","🌐")
T30:CreateButton({Name="Copy GitHub URL",Icon="📋",Callback=function()
    if setclipboard then setclipboard("https://raw.githubusercontent.com/n68364654-bot/quind-hub-rayfield/refs/heads/main/loader.lua"); nf("Links","скопировано",3,"success") end
end})
T30:CreateButton({Name="Copy Loadstring",Icon="📋",Callback=function()
    local ls='loadstring(game:HttpGet("https://raw.githubusercontent.com/n68364654-bot/quind-hub-rayfield/refs/heads/main/loader.lua"))()'
    if setclipboard then setclipboard(ls); nf("Links","скопировано",3,"success") end
end})
T30:CreateSection("Действия","🎯")
T30:CreateButton({Name="Reload Script",Icon="🔄",Callback=function()
    nf("Reload","через 2 секунды...",3,"info","🔄")
    task.wait(2)
    if LP.Character then LP.Character:BreakJoints() end
end})
T30:CreateButton({Name="Toggle Notifications",Icon="🔔",Callback=function() _G.Q_noNotif=not _G.Q_noNotif; nf("UI","notifs: "..tostring(not _G.Q_noNotif),3,"info") end})
T30:CreateButton({Name="Toggle Minimize (Tip)",Icon="➖",Callback=function() nf("Tip","жми — в шапке окна",4,"info") end})
T30:CreateButton({Name="Reset Everything",Icon="🔄",Callback=function()
    for k,v in pairs(S) do if type(v)=="boolean" then S[k]=false end end; S.antiAfk=true; nf("Reset","всё сброшено",5,"success")
end})
T30:CreateButton({Name="Show Version",Icon="📌",Callback=function() nf("Version","v3.0 Ultimate",4,"info","📌") end})

-- ═══════════════════ ЛОГИКА ═══════════════════
local function getClosest()
    local best,bd=nil,S.aimFov
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            local h=p.Character:FindFirstChildOfClass("Humanoid")
            if h and h.Health>0 then
                if S.aimTeamCheck and role(p)=="Innocent" then continue end
                if _G.Q_aimIgnoreMurderer and role(p)=="Murderer" then continue end
                local pn=S.aimPart
                if pn=="Random" then local pts={"Head","HumanoidRootPart","UpperTorso","Torso"}; pn=pts[math.random(1,#pts)] end
                local part=p.Character:FindFirstChild(pn) or p.Character:FindFirstChild("HumanoidRootPart")
                if part then
                    local sp,on=Cam:WorldToViewportPoint(part.Position)
                    if on then
                        local d=(Vector2.new(sp.X,sp.Y)-Vector2.new(Cam.ViewportSize.X/2,Cam.ViewportSize.Y/2)).Magnitude
                        if _G.Q_aimMurderer and role(p)=="Murderer" then d=d*0.3 end
                        if _G.Q_aimSheriff and role(p)=="Sheriff" then d=d*0.5 end
                        if d<bd then bd=d; best=part end
                    end
                end
            end
        end
    end
    return best
end
_G.Q_getClosest=getClosest

RunService.Heartbeat:Connect(function()
    local ch=LP.Character; if not ch then return end
    local h=ch:FindFirstChildOfClass("Humanoid"); if not h then return end
    if S.freeze then h.WalkSpeed=0; h.JumpPower=0
    else
        local sp=S.speedOn and S.speedVal or 16
        if _G.Q_sprint and UIS:IsKeyDown(Enum.KeyCode.LeftShift) then sp=sp*1.5 end
        if _G.Q_chadWalk then sp=math.min(sp,4) end
        h.WalkSpeed=sp; h.JumpPower=S.jumpOn and S.jumpVal or 50
        if S.jumpBoost then h.JumpPower=(S.jumpOn and S.jumpVal or 50)*2 end
    end
    local r=ch:FindFirstChild("HumanoidRootPart")
    if S.flyOn and r then
        if not flyBV or not flyBV.Parent then
            flyBV=Instance.new("BodyVelocity"); flyBV.MaxForce=Vector3.new(9e9,9e9,9e9); flyBV.Velocity=Vector3.zero; flyBV.Parent=r
        end
        local dir=Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir=dir+Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir=dir-Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir=dir-Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir=dir+Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir=dir+Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir=dir-Vector3.new(0,1,0) end
        flyBV.Velocity=dir*S.flyVal
    else if flyBV then flyBV:Destroy(); flyBV=nil end end
    if S.cframeFly and r then
        local mv=Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then mv=mv+Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then mv=mv-Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then mv=mv-Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then mv=mv+Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then mv=mv+Vector3.new(0,1,0) end
        if mv.Magnitude>0 then r.CFrame=r.CFrame+mv*(S.flyVal/60) end
    end
    if S.noclip or S.ghost then
        for _,p in ipairs(ch:GetDescendants()) do if p:IsA("BasePart") and p.CanCollide then p.CanCollide=false end end
    end
    workspace.Gravity=S.gravity and S.gravityVal or 196.2
    if S.spin and r then r.CFrame=r.CFrame*CFrame.Angles(0,math.rad(S.spinSpeed),0) end
    if S.sitOn then h.Sit=true end
    if S.ghost then for _,p in ipairs(ch:GetDescendants()) do if p:IsA("BasePart") then p.Transparency=0.7 end end end
    if S.antiRag and h.PlatformStand then h.PlatformStand=false end
    if S.walkOnWater and r then
        local ray=Ray.new(r.Position,Vector3.new(0,-10,0)); local hit=workspace:FindPartOnRay(ray,ch)
        if hit and hit.Name:lower():find("water") then r.CFrame=r.CFrame+Vector3.new(0,3,0) end
    end
    if _G.Q_antiFreeze and r and r.Anchored then r.Anchored=false end
    if _G.Q_jumpGlitch and h then
        if h:GetState()~=Enum.HumanoidStateType.Jumping and h:GetState()~=Enum.HumanoidStateType.Freefall then
            h:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

UIS.JumpRequest:Connect(function() if S.infJump and hum() then hum():ChangeState(Enum.HumanoidStateType.Jumping) end end)

RunService.RenderStepped:Connect(function()
    if S.aimOn and (not S.aimHoldKey or UIS:IsKeyDown(S.aimKey)) then
        local t=getClosest()
        if t then
            if S.aimVisCheck then
                local ray=Ray.new(Cam.CFrame.Position,(t.Position-Cam.CFrame.Position).Unit*500)
                local hit=workspace:FindPartOnRay(ray,LP.Character)
            end
            local tp=t.Position
            if S.aimPredict>0 then
                local hrpPart=t.Parent:FindFirstChild("HumanoidRootPart")
                if hrpPart then tp=tp+hrpPart.AssemblyLinearVelocity*(S.aimPredict/60) end
            end
            if S.aimSnap then Cam.CFrame=CFrame.new(Cam.CFrame.Position,tp)
            else Cam.CFrame=Cam.CFrame:Lerp(CFrame.new(Cam.CFrame.Position,tp),S.aimSmooth) end
            if _G.Q_aimHL then
                if not t.Parent:FindFirstChild("__Q_AimHL__") then
                    local hl=Instance.new("Highlight"); hl.Name="__Q_AimHL__"; hl.FillColor=Color3.fromRGB(255,0,255); hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent=t.Parent
                    task.delay(0.5,function() if hl then hl:Destroy() end end)
                end
            end
        end
    end
    if S.camLock then local hd=LP.Character and LP.Character:FindFirstChild("Head"); if hd then Cam.CameraSubject=hd end end
    if S.aimFovCircle then
        if not aimCircle then
            aimCircle=Drawing.new("Circle"); aimCircle.Thickness=2; aimCircle.Color=Color3.fromRGB(118,138,255); aimCircle.Filled=false; aimCircle.Transparency=1
        end
        aimCircle.Radius=S.aimFov; aimCircle.Position=Vector2.new(Cam.ViewportSize.X/2,Cam.ViewportSize.Y/2); aimCircle.Visible=true
    else if aimCircle then aimCircle.Visible=false end end
end)

RunService.Heartbeat:Connect(function()
    if S.triggerBot then
        local t=getClosest()
        if t and LP.Character then
            for _,tool in ipairs(LP.Character:GetChildren()) do
                if tool:IsA("Tool") then for _,r in ipairs(tool:GetChildren()) do if r:IsA("RemoteEvent") then pcall(function() r:FireServer() end) end end end
            end
        end
    end
end)

local function clearESP(p)
    local e=espCache[p]
    if e then if e.hl then e.hl:Destroy() end; if e.bg then e.bg:Destroy() end; espCache[p]=nil end
end

local function updateESP(p)
    if p==LP then return end
    local ch=p.Character
    if not ch or not S.espOn then clearESP(p); return end
    local h=ch:FindFirstChildOfClass("Humanoid")
    if _G.Q_ignoreDead and (not h or h.Health<=0) then clearESP(p); return end
    local e=espCache[p]
    if not e then
        e={}
        e.hl=Instance.new("Highlight"); e.hl.FillColor=Color3.fromRGB(255,60,60); e.hl.OutlineColor=Color3.fromRGB(255,255,255); e.hl.FillTransparency=0.55; e.hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; e.hl.Parent=ch
        e.bg=Instance.new("BillboardGui"); e.bg.Size=UDim2.new(0,220,0,40); e.bg.StudsOffset=Vector3.new(0,3,0); e.bg.AlwaysOnTop=true; e.bg.Parent=ch:FindFirstChild("Head") or ch:FindFirstChild("HumanoidRootPart")
        e.label=Instance.new("TextLabel"); e.label.Size=UDim2.new(1,0,1,0); e.label.BackgroundTransparency=1; e.label.TextColor3=Color3.fromRGB(255,255,255); e.label.TextStrokeTransparency=0; e.label.Font=Enum.Font.GothamBold; e.label.TextSize=14; e.label.Parent=e.bg
        espCache[p]=e
    end
    e.hl.Parent=ch; e.hl.Enabled=S.espHL
    if _G.Q_espRainbow then e.hl.FillColor=Color3.fromHSV((tick()*0.3)%1,1,1) end
    local hd=ch:FindFirstChild("Head") or ch:FindFirstChild("HumanoidRootPart")
    if hd then e.bg.Parent=hd end
    local txt={}
    if S.espName then table.insert(txt,p.Name) end
    if S.espHP and h then table.insert(txt,"["..math.floor(h.Health).."]") end
    if S.espDist and hrp() and ch:FindFirstChild("HumanoidRootPart") then table.insert(txt,math.floor(dist(ch.HumanoidRootPart.Position,hrp().Position)).."m") end
    if _G.Q_espRole then table.insert(txt,role(p)) end
    e.label.Text=table.concat(txt," ")
end

RunService.RenderStepped:Connect(function()
    for _,p in ipairs(Players:GetPlayers()) do updateESP(p) end
end)
Players.PlayerRemoving:Connect(clearESP)

RunService.RenderStepped:Connect(function()
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local r=role(p)
            local want=(S.espMurder and r=="Murderer") or (S.espSheriff and r=="Sheriff") or (S.espInnocent and r=="Innocent")
            local hl=roleHL[p]
            if want then
                if not hl then
                    hl=Instance.new("Highlight"); hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; hl.FillTransparency=0.6; hl.Parent=p.Character; roleHL[p]=hl
                end
                hl.FillColor=r=="Murderer" and Color3.fromRGB(255,0,0) or r=="Sheriff" and Color3.fromRGB(0,120,255) or Color3.fromRGB(0,255,0)
            elseif hl then hl:Destroy(); roleHL[p]=nil end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if S.fullbright then Lighting.Ambient=Color3.fromRGB(255,255,255); Lighting.Brightness=2; Lighting.ClockTime=12 end
    if S.noFog then Lighting.FogEnd=1e6; Lighting.FogStart=1e6 end
    Cam.FieldOfView=S.fovOn and S.fovVal or 70
end)

RunService.Heartbeat:Connect(function()
    if S.antiFling and LP.Character then
        for _,o in ipairs(LP.Character:GetDescendants()) do
            if o:IsA("BodyVelocity") or o:IsA("BodyAngularVelocity") or o:IsA("BodyGyro") then o:Destroy() end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if S.antiVoid and hrp() and hrp().Position.Y<-50 then hrp().CFrame=CFrame.new(0,50,0) end
end)

LP.Idled:Connect(function() if S.antiAfk then VU:CaptureController(); VU:ClickButton2(Vector2.new()) end end)

LP.CharacterAdded:Connect(function()
    if S.autoResp then task.wait(0.5); if LP.Character then LP.Character:BreakJoints() end end
end)

task.spawn(function()
    while task.wait(S.chatSpamRate or 2) do
        if S.chatSpam then say(S.chatMsg) end
    end
end)

task.spawn(function()
    while task.wait(1.5) do
        if _G.Q_emoteSpam and hum() then pcall(function() hum():PlayEmote("dance") end) end
        if _G.Q_wink and hum() then pcall(function() hum():PlayEmote("point") end) end
    end
end)

task.spawn(function()
    while task.wait(4) do
        if S.rizzOn then
            local t=_G.Q_getClosest and _G.Q_getClosest()
            if t and t.Parent then
                local plr=Players:GetPlayerFromCharacter(t.Parent)
                if plr then say(plr.Name..", "..rizzMessages[math.random(1,#rizzMessages)]) end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if S.yandereOn and hrp() then
        local best,bd
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local d=dist(p.Character.HumanoidRootPart.Position,hrp().Position)
                if not bd or d<bd then bd=d; best=p end
            end
        end
        if best and bd and bd>4 then
            local target=best.Character.HumanoidRootPart
            local dir=(target.Position-hrp().Position).Unit
            hrp().CFrame=CFrame.new(hrp().Position+dir*0.3,target.Position)
        end
    end
end)

task.spawn(function()
    while task.wait(5) do
        if S.sigmaOn and hum() then
            local sigmas={"🗿","Ноль эмоций.","Sigma rule #1: не быть инносентом.","Я не следую правилам.","🧊"}
            say(sigmas[math.random(1,#sigmas)])
            pcall(function() hum():PlayEmote("dance2") end)
        end
    end
end)

task.spawn(function()
    while task.wait(6) do
        if S.autoFlirt then
            for _,p in ipairs(Players:GetPlayers()) do
                if role(p)=="Murderer" then say(p.Name..", ты выглядишь опасно... мне нравится 😏🔪"); break end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if S.autoEquipGun and LP.Character then
            local has=false; for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") and t.Name:lower():find("gun") then has=true end end
            if not has then for _,t in ipairs(LP.Backpack:GetChildren()) do if t:IsA("Tool") and t.Name:lower():find("gun") then t.Parent=LP.Character; break end end end
        end
        if S.autoEquipKnife and LP.Character then
            local has=false; for _,t in ipairs(LP.Character:GetChildren()) do if t:IsA("Tool") and t.Name:lower():find("knife") then has=true end end
            if not has then for _,t in ipairs(LP.Backpack:GetChildren()) do if t:IsA("Tool") and t.Name:lower():find("knife") then t.Parent=LP.Character; break end end end
        end
    end
end)

task.spawn(function()
    while task.wait(3) do
        if S.autoReload and LP.Character then
            for _,t in ipairs(LP.Character:GetChildren()) do
                if t:IsA("Tool") then for _,r in ipairs(t:GetChildren()) do if r:IsA("RemoteEvent") then pcall(function() r:FireServer("Reload") end) end end end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if S.hlWeapons then
            for _,o in ipairs(workspace:GetDescendants()) do
                if o:IsA("Tool") then
                    local hl=o:FindFirstChild("__Q_WeaponHL__")
                    if not hl then hl=Instance.new("Highlight"); hl.Name="__Q_WeaponHL__"; hl.FillColor=Color3.fromRGB(255,200,0); hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent=o end
                end
            end
        else
            for _,o in ipairs(workspace:GetDescendants()) do
                if o:IsA("Tool") then local hl=o:FindFirstChild("__Q_WeaponHL__"); if hl then hl:Destroy() end end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.3) do
        if S.hideTools then
            for _,p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character then
                    for _,t in ipairs(p.Character:GetChildren()) do
                        if t:IsA("Tool") then for _,part in ipairs(t:GetDescendants()) do if part:IsA("BasePart") then part.LocalTransparencyModifier=1 end end end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if _G.Q_autoDist and hrp() then
            local dm,ds="-","-"
            for _,p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local r=role(p); local d=math.floor(dist(p.Character.HumanoidRootPart.Position,hrp().Position))
                    if r=="Murderer" then dm=d.." studs" end
                    if r=="Sheriff" then ds=d.." studs" end
                end
            end
            dmP:Set({Title="Dist Murderer",Icon="📏",Content=dm})
            dsP:Set({Title="Dist Sheriff",Icon="📏",Content=ds})
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not hrp() then return end
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d=dist(p.Character.HumanoidRootPart.Position,hrp().Position)
            local r=role(p)
            if r=="Murderer" and d<30 then
                if _G.Q_warnM then nf("⚠ MURDERER",p.Name.." в "..math.floor(d),2,"error","⚠️") end
                if _G.Q_flee then local aw=(hrp().Position-p.Character.HumanoidRootPart.Position).Unit*40; hrp().CFrame=hrp().CFrame+aw end
                if _G.Q_autoJumpM then local h=hum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end
                if _G.Q_tpFrom then hrp().CFrame=CFrame.new(math.random(-150,150),80,math.random(-150,150)) end
            end
            if r=="Sheriff" and d<30 and _G.Q_warnS then nf("⚠ SHERIFF",p.Name.." в "..math.floor(d),2,"error","⚠️") end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if _G.Q_watchers then
            for _,p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character and p.Character:FindFirstChild("Head") and hrp() then
                    local look=p.Character.Head.CFrame.LookVector
                    local toMe=(hrp().Position-p.Character.Head.Position).Unit
                    if look:Dot(toMe)>0.85 then nf("👁",p.Name.." смотрит",1.5,"info","👁️") end
                end
            end
        end
    end
end)

local prevKnife,prevGun={},{}
task.spawn(function()
    while task.wait(1) do
        if _G.Q_warnKnife or _G.Q_warnGun then
            for _,p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character then
                    local hk,hg=false,false
                    for _,t in ipairs(p.Character:GetChildren()) do
                        if t:IsA("Tool") then
                            local n=t.Name:lower()
                            if n:find("knife") then hk=true end
                            if n:find("gun") or n:find("revolver") or n:find("pistol") then hg=true end
                        end
                    end
                    if hk and not prevKnife[p] and _G.Q_warnKnife then nf("🔪 Knife",p.Name.." взял нож",3,"error","🔪") end
                    if hg and not prevGun[p] and _G.Q_warnGun then nf("🔫 Gun",p.Name.." взял пистолет",3,"error","🔫") end
                    prevKnife[p],prevGun[p]=hk,hg
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(2) do
        if S.autoHopDeath then
            if not hum() or hum().Health<=0 then
                nf("Server","auto-hop...",3,"info","🌐"); task.wait(2); TS:Teleport(game.PlaceId,LP)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(2) do
        if S.autoHopLowHP and hum() and hum().Health<20 and hum().Health>0 then
            nf("Server","auto-hop low HP...",3,"info","🌐"); task.wait(1); TS:Teleport(game.PlaceId,LP)
        end
    end
end)

-- Auto-farm coins
task.spawn(function()
    while task.wait(0.3) do
        if _G.Q_farmCoins and hrp() then
            local skip=false
            if _G.Q_farmStop then
                for _,p in ipairs(Players:GetPlayers()) do
                    if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        if role(p)=="Murderer" and (p.Character.HumanoidRootPart.Position-hrp().Position).Magnitude<40 then skip=true; break end
                    end
                end
            end
            if not skip then
                local best,bd=nil,_G.Q_farmRadius or 100
                for _,o in ipairs(workspace:GetDescendants()) do
                    if o:IsA("BasePart") and o.Name:lower():find("coin") then
                        local d=(o.Position-hrp().Position).Magnitude; if d<bd then bd=d; best=o end
                    end
                end
                if best then
                    local dir=(best.Position-hrp().Position).Unit
                    hrp().CFrame=CFrame.new(hrp().Position+dir*((_G.Q_farmSpeed or 80)/60),best.Position)
                    if bd<3 then _G.Q_farmCollected=(_G.Q_farmCollected or 0)+1; farmCountP:Set({Title="Collected",Icon="💰",Content=_G.Q_farmCollected.." монет"}) end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if (_G.Q_farmWeapons or _G.Q_farmGun or _G.Q_farmKnife) and LP.Character then
            local myRole=role(LP)
            for _,o in ipairs(workspace:GetDescendants()) do
                if o:IsA("Tool") and hrp() then
                    local handle=o:FindFirstChildWhichIsA("BasePart")
                    if handle and (handle.Position-hrp().Position).Magnitude<5 then
                        local n=o.Name:lower(); local should=false
                        if _G.Q_farmWeapons then should=true end
                        if _G.Q_farmGun and n:find("gun") and myRole=="Sheriff" then should=true end
                        if _G.Q_farmKnife and n:find("knife") and myRole=="Murderer" then should=true end
                        if should then pcall(function() firetouchinterest(LP.Character.HumanoidRootPart,handle,0) end) end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(5) do
        if _G.Q_autoRejoin then
            local allDead=true
            for _,p in ipairs(Players:GetPlayers()) do
                local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
                if h and h.Health>0 then allDead=false; break end
            end
            if allDead then nf("Farm","rejoin...",3,"info","🔄"); task.wait(3); TS:Teleport(game.PlaceId,LP) end
        end
    end
end)

-- Troll
task.spawn(function() while task.wait(0.8) do if _G.Q_trollJump and hum() then hum():ChangeState(Enum.HumanoidStateType.Jumping) end end end)
task.spawn(function() while task.wait(0.3) do if _G.Q_trollSpin and hrp() then hrp().CFrame=hrp().CFrame*CFrame.Angles(0,math.rad(30),0) end end end)
task.spawn(function() while task.wait(1.2) do if _G.Q_trollCrouch and hum() then hum.Sit=not hum.Sit end end end)
task.spawn(function() while task.wait(2) do
    if _G.Q_trollEmote and hum() then
        local e={"wave","dance","dance2","dance3","laugh","cheer","point","salute"}
        pcall(function() hum():PlayEmote(e[math.random(1,#e)]) end)
    end
end end)

-- Replay recording
_G.Q_recFrames=_G.Q_recFrames or {}
task.spawn(function()
    while task.wait(_G.Q_recInterval or 0.5) do
        if _G.Q_recording and hrp() then
            table.insert(_G.Q_recFrames,{Position=hrp().Position,CFrame=hrp().CFrame})
            if #_G.Q_recFrames>500 then table.remove(_G.Q_recFrames,1) end
        end
    end
end)

_G.Q_ghostTrailParts=_G.Q_ghostTrailParts or {}
task.spawn(function()
    while task.wait(0.5) do
        if _G.Q_ghostTrail and hrp() then
            local ghost=Instance.new("Part"); ghost.Size=Vector3.new(2,5,2); ghost.CFrame=hrp().CFrame
            ghost.Anchored=true; ghost.CanCollide=false; ghost.Material=Enum.Material.ForceField
            ghost.Color=Color3.fromRGB(150,200,255); ghost.Transparency=0.5; ghost.Parent=workspace
            table.insert(_G.Q_ghostTrailParts,ghost)
            if #_G.Q_ghostTrailParts>30 then local old=table.remove(_G.Q_ghostTrailParts,1); if old then old:Destroy() end end
            task.delay(5,function() if ghost and ghost.Parent then ghost:Destroy() end end)
        end
    end
end)

-- Security
_G.Q_secLog=_G.Q_secLog or {}
local function secLog(m)
    table.insert(_G.Q_secLog,{time=os.date("%H:%M:%S"),msg=m})
    if #_G.Q_secLog>50 then table.remove(_G.Q_secLog,1) end
    secLogP:Set({Title="Last Event",Icon="📝",Content=m})
end

task.spawn(function()
    while task.wait(2) do
        if _G.Q_detectSpeed then
            for _,p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character then
                    local h=p.Character:FindFirstChildOfClass("Humanoid")
                    if h and h.WalkSpeed>30 then secLog("⚡ "..p.Name.." speed:"..math.floor(h.WalkSpeed)); nf("🚨 Speed",p.Name,3,"error","🚨") end
                end
            end
        end
    end
end)

task.spawn(function()
    local lastY={}
    while task.wait(1) do
        if _G.Q_detectFliers then
            for _,p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local y=p.Character.HumanoidRootPart.Position.Y
                    if lastY[p] and y-lastY[p]>15 then secLog("🕊️ "..p.Name.." flier"); nf("🚨 Flier",p.Name,3,"error","🚨") end
                    lastY[p]=y
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if _G.Q_antiFlingStrong and LP.Character then
            for _,o in ipairs(LP.Character:GetDescendants()) do
                if o:IsA("BodyVelocity") or o:IsA("BodyAngularVelocity") or o:IsA("BodyGyro") or o:IsA("BodyPosition") then o:Destroy() end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.3) do
        if _G.Q_antiVoidAggressive and hrp() and hrp().Position.Y<0 then hrp().CFrame=CFrame.new(hrp().Position.X,50,hrp().Position.Z) end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if _G.Q_autoHeal then local h=hum(); if h and h.Health<h.MaxHealth then h.Health=h.MaxHealth end end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if _G.Q_hideName and LP.Character then
            local head=LP.Character:FindFirstChild("Head")
            if head then for _,o in ipairs(head:GetChildren()) do if o:IsA("BillboardGui") then o.Enabled=false end end end
        end
    end
end)

task.spawn(function()
    local lastPos={}
    while task.wait(1) do
        if _G.Q_detectTP then
            for _,p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local pos=p.Character.HumanoidRootPart.Position
                    if lastPos[p] and (pos-lastPos[p]).Magnitude>100 then secLog("📍 "..p.Name.." TP"); nf("🚨 TP",p.Name,3,"error","🚨") end
                    lastPos[p]=pos
                end
            end
        end
    end
end)

-- Telemetry auto update
task.spawn(function()
    while task.wait(2) do
        if _G.Q_teleAuto then
            local ping=math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
            local mem=math.floor(collectgarbage("count"))
            teleP:Set({Title="Live",Icon="📊",Content="Ping:"..ping.."ms Mem:"..mem.."KB"})
        end
    end
end)

-- Notifications: join/leave
Players.PlayerAdded:Connect(function(p) if _G.Q_notifJoin then nf("👋 Join",p.Name,3,"info","👋") end end)
Players.PlayerRemoving:Connect(function(p) if _G.Q_notifLeave then nf("👋 Leave",p.Name,3,"info","👋") end end)

LP.CharacterAdded:Connect(function()
    if _G.Q_notifRespawn then nf("♻️ Respawn","ты возродился",3,"success","♻️") end
end)

-- Notification counter wrap
local _oldNf=nf
nf=function(t,c,d,typ,ic)
    if _G.Q_noNotif then return end
    _G.Q_notifCount=(_G.Q_notifCount or 0)+1
    _oldNf(t,c,d or _G.Q_notifDur,typ,ic)
end

-- Ready
nf("🗿 Quind Hub Ultimate","Загружено! 30 табов, 600+ функций, музыка. made by hashtrash.",8,"success","🗿")
task.delay(1.5,function() nf("💡 Совет","RightShift — скрыть UI. P — паника. Открой 🎵 Music для плеера.",7,"info","💡") end)
