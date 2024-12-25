if SERVER then
    util.AddNetworkString("TogglePanel")
    util.AddNetworkString("OpenOptimizationPanel")
    util.AddNetworkString("ApplyOptimization")

    concommand.Add("panel", function(ply)
        if ply:IsAdmin() then
            net.Start("TogglePanel")
            net.Send(ply)
        end
    end)

    net.Receive("ApplyOptimization", function(len, ply)
        if ply:IsAdmin() then
            local optimizationType = net.ReadString()
            if optimizationType == "easy" then
                ply:ConCommand("r_drawtracers 0")
                ply:ConCommand("mat_queue_mode -1")
                ply:ConCommand("cl_threaded_bone_setup 1")
                ply:ConCommand("r_3dsky 0")
                ply:ConCommand("r_shadows 0")
                ply:ConCommand("r_dynamic 0")
                ply:ConCommand("r_lod 2")
                ply:ConCommand("r_rootlod 2")
                ply:ConCommand("r_waterforceexpensive 0")
                ply:ConCommand("r_waterforcereflectentities 0")
                ply:ConCommand("r_maxdlights 0")
                ply:ConCommand("r_maxmodeldecal 0")
                ply:ConCommand("r_drawparticles 0")
                ply:ConCommand("r_drawrain 0")
                ply:ConCommand("r_drawropes 0")
            elseif optimizationType == "medium" then
                ply:ConCommand("r_drawtracers 0")
                ply:ConCommand("mat_queue_mode -1")
                ply:ConCommand("cl_threaded_bone_setup 1")
                ply:ConCommand("r_3dsky 0")
                ply:ConCommand("r_shadows 0")
                ply:ConCommand("r_dynamic 0")
                ply:ConCommand("mat_specular 0")
                ply:ConCommand("mat_bumpmap 0")
                ply:ConCommand("r_lod 2")
                ply:ConCommand("r_rootlod 2")
                ply:ConCommand("r_waterforceexpensive 0")
                ply:ConCommand("r_waterforcereflectentities 0")
                ply:ConCommand("r_cheapwaterend 1")
                ply:ConCommand("r_cheapwaterstart 1")
                ply:ConCommand("r_maxdlights 0")
                ply:ConCommand("r_maxmodeldecal 0")
                ply:ConCommand("r_maxnewsamples 0")
                ply:ConCommand("r_maxsampledist 1")
                ply:ConCommand("r_decal_cullsize 15")
                ply:ConCommand("r_drawflecks 0")
                ply:ConCommand("r_drawmodeldecals 0")
                ply:ConCommand("r_drawparticles 0")
                ply:ConCommand("r_drawrain 0")
                ply:ConCommand("r_drawropes 0")
                ply:ConCommand("r_drawskybox 0")
                ply:ConCommand("r_drawsprites 0")
                ply:ConCommand("r_drawtranslucentworld 0")
            elseif optimizationType == "hardcore" then
                ply:ConCommand("r_drawtracers 0")
                ply:ConCommand("mat_queue_mode -1")
                ply:ConCommand("cl_threaded_bone_setup 1")
                ply:ConCommand("r_3dsky 0")
                ply:ConCommand("r_shadows 0")
                ply:ConCommand("r_dynamic 0")
                ply:ConCommand("mat_specular 0")
                ply:ConCommand("mat_bumpmap 0")
                ply:ConCommand("r_lod 2")
                ply:ConCommand("r_rootlod 2")
                ply:ConCommand("r_waterforceexpensive 0")
                ply:ConCommand("r_waterforcereflectentities 0")
                ply:ConCommand("r_cheapwaterend 1")
                ply:ConCommand("r_cheapwaterstart 1")
                ply:ConCommand("r_maxdlights 0")
                ply:ConCommand("r_maxmodeldecal 0")
                ply:ConCommand("r_maxnewsamples 0")
                ply:ConCommand("r_maxsampledist 1")
                ply:ConCommand("r_decal_cullsize 15")
                ply:ConCommand("r_drawflecks 0")
                ply:ConCommand("r_drawmodeldecals 0")
                ply:ConCommand("r_drawparticles 0")
                ply:ConCommand("r_drawrain 0")
                ply:ConCommand("r_drawropes 0")
                ply:ConCommand("r_drawskybox 0")
                ply:ConCommand("r_drawsprites 0")
                ply:ConCommand("r_drawtranslucentworld 0")
                ply:ConCommand("r_drawviewmodel 0")
                ply:ConCommand("r_eyegloss 0")
                ply:ConCommand("r_eyemove 0")
                ply:ConCommand("r_eyeshift_x 0")
                ply:ConCommand("r_eyeshift_y 0")
                ply:ConCommand("r_eyeshift_z 0")
                ply:ConCommand("r_eyesize 0")
            elseif optimizationType == "default" then
                ply:ConCommand("r_drawtracers 1")
                ply:ConCommand("mat_queue_mode 2")
                ply:ConCommand("cl_threaded_bone_setup 0")
                ply:ConCommand("r_3dsky 1")
                ply:ConCommand("r_shadows 1")
                ply:ConCommand("r_dynamic 1")
                ply:ConCommand("mat_specular 1")
                ply:ConCommand("mat_bumpmap 1")
                ply:ConCommand("r_drawviewmodel 1")
                ply:ConCommand("r_drawskybox 1")
            end
        end
    end)
end

if CLIENT then
    local panel
    local optimizationPanel
    local fpsColor = Color(255, 255, 255)
    local boxColor = Color(0, 0, 0, 150)
    local boxCornerRadius = 8
    local fpsCounterX = ScrW() - 150
    local fpsCounterY = 20
    local dragging = false
    local dragOffsetX = 0
    local dragOffsetY = 0
    local currentLanguage = "en"

    surface.CreateFont("CloseButtonFont", {
        font = "Montserrat Medium",
        size = 24,
        weight = 500,
        antialias = true,
        shadow = false
    })

    surface.CreateFont("HeaderFont", {
        font = "Montserrat Medium",
        size = 18,
        weight = 500,
        antialias = true,
        shadow = false
    })

    surface.CreateFont("LinkFont", {
        font = "Montserrat Medium",
        size = 18,
        weight = 500,
        antialias = true,
        shadow = false,
        underline = true
    })

local translations = {
    ["en"] = {
        ["Optimization"] = "Optimization",
        ["Easy"] = "Easy",
        ["Medium"] = "Medium",
        ["Hardcore"] = "Hardcore",
        ["Load Default Config"] = "Load Default Config",
        ["FPS Text Color"] = "FPS Text Color",
        ["Box Settings"] = "Box Settings",
        ["Corner Radius"] = "Corner Radius",
        ["Switch to Russian"] = "Switch to Russian",
        ["Switch to English"] = "Switch to English"
    },
    ["ru"] = {
        ["Optimization"] = "Оптимизация",
        ["Easy"] = "Легкий",
        ["Medium"] = "Средний",
        ["Hardcore"] = "Хардкор",
        ["Load Default Config"] = "Загрузить дефолтный конфиг",
        ["FPS Text Color"] = "Цвет текста FPS",
        ["Box Settings"] = "Настройки прямоугольника",
        ["Corner Radius"] = "Закругленность углов",
        ["Switch to Russian"] = "Переключить на русский",
        ["Switch to English"] = "Переключить на английский"
    }
}

local currentLanguage = "en"

local function translate(key)
    return translations[currentLanguage][key] or key
end

    local function createOptimizationPanel()
        optimizationPanel = vgui.Create("DFrame")
        optimizationPanel:SetSize(400, 600)
        optimizationPanel:Center()
        optimizationPanel:SetTitle("Оптимизация")
        optimizationPanel:SetDraggable(true)
        optimizationPanel:ShowCloseButton(false)
        optimizationPanel:MakePopup()

        optimizationPanel.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50, 200))
        end

        local closeButton = vgui.Create("DButton", optimizationPanel)
        closeButton:SetText("")
        closeButton:SetSize(24, 24)
        closeButton:SetPos(optimizationPanel:GetWide() - 28, 4)

        closeButton.Paint = function(self, w, h)
            draw.SimpleText("X", "CloseButtonFont", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        closeButton.DoClick = function()
            optimizationPanel:Remove()
            optimizationPanel = nil
        end

        local optimizationHeader = vgui.Create("DLabel", optimizationPanel)
        optimizationHeader:SetText(translate("Optimization"))
        optimizationHeader:SetFont("HeaderFont")
        optimizationHeader:SizeToContents()
        optimizationHeader:SetPos(25, 50)

        local easyButton = vgui.Create("DButton", optimizationPanel)
        easyButton:SetText("")
        easyButton:SetSize(350, 50)
        easyButton:SetPos(25, 80)

        easyButton.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(70, 70, 70, 200))
            draw.SimpleText(translate("Easy"), "HeaderFont", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        easyButton.DoClick = function()
            net.Start("ApplyOptimization")
            net.WriteString("easy")
            net.SendToServer()
            notification.AddLegacy("Легкая оптимизация применена", NOTIFY_GENERIC, 5)
            surface.PlaySound("buttons/button15.wav")
        end

        local mediumButton = vgui.Create("DButton", optimizationPanel)
        mediumButton:SetText("")
        mediumButton:SetSize(350, 50)
        mediumButton:SetPos(25, 140)

        mediumButton.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(70, 70, 70, 200))
            draw.SimpleText(translate("Medium"), "HeaderFont", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        mediumButton.DoClick = function()
            net.Start("ApplyOptimization")
            net.WriteString("medium")
            net.SendToServer()
            notification.AddLegacy("Средняя оптимизация применена", NOTIFY_GENERIC, 5)
            surface.PlaySound("buttons/button15.wav")
        end

        local hardcoreButton = vgui.Create("DButton", optimizationPanel)
        hardcoreButton:SetText("")
        hardcoreButton:SetSize(350, 50)
        hardcoreButton:SetPos(25, 200)

        hardcoreButton.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(70, 70, 70, 200))
            draw.SimpleText(translate("Hardcore"), "HeaderFont", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        hardcoreButton.DoClick = function()
            net.Start("ApplyOptimization")
            net.WriteString("hardcore")
            net.SendToServer()
            notification.AddLegacy("Хардкорная оптимизация применена", NOTIFY_GENERIC, 5)
            surface.PlaySound("buttons/button15.wav")
        end

        local defaultConfigButton = vgui.Create("DButton", optimizationPanel)
        defaultConfigButton:SetText("")
        defaultConfigButton:SetSize(350, 50)
        defaultConfigButton:SetPos(25, 260)

        defaultConfigButton.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(70, 70, 70, 200))
            draw.SimpleText(translate("Load Default Config"), "HeaderFont", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        defaultConfigButton.DoClick = function()
            net.Start("ApplyOptimization")
            net.WriteString("default")
            net.SendToServer()
            notification.AddLegacy("Дефолтный конфиг загружен", NOTIFY_GENERIC, 5)
            surface.PlaySound("buttons/button15.wav")
        end
    end

    local function createPanel()
        panel = vgui.Create("DFrame")
        panel:SetSize(400, 600)
        panel:Center()
        panel:SetTitle("Настройки FPS Счетчика")
        panel:SetDraggable(true)
        panel:ShowCloseButton(false)
        panel:MakePopup()

        panel.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50, 200))
        end

        local closeButton = vgui.Create("DButton", panel)
        closeButton:SetText("")
        closeButton:SetSize(24, 24)
        closeButton:SetPos(panel:GetWide() - 28, 4)

        closeButton.Paint = function(self, w, h)
            draw.SimpleText("X", "CloseButtonFont", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        closeButton.DoClick = function()
            panel:Remove()
            panel = nil
        end

        local optimizationLink = vgui.Create("DLabel", panel)
        optimizationLink:SetText(translate("Optimization"))
        optimizationLink:SetFont("LinkFont")
        optimizationLink:SetTextColor(Color(255, 255, 255))
        optimizationLink:SizeToContents()
        optimizationLink:SetPos(25, 30)
        optimizationLink:SetMouseInputEnabled(true)

        optimizationLink.DoClick = function()
            panel:Remove()
            createOptimizationPanel()
        end

        optimizationLink.Paint = function(self, w, h)
            if self:IsHovered() then
                self:SetTextColor(Color(200, 200, 200))
            else
                self:SetTextColor(Color(255, 255, 255))
            end
        end

        local scrollPanel = vgui.Create("DScrollPanel", panel)
        scrollPanel:SetSize(350, 500)
        scrollPanel:SetPos(25, 60)

        local sbar = scrollPanel:GetVBar()
        sbar:SetWide(6)
        sbar.Paint = function(self, w, h)
            -- No background
        end
        sbar.btnUp.Paint = function(self, w, h)
            -- No background
        end
        sbar.btnDown.Paint = function(self, w, h)
            -- No background
        end
        sbar.btnGrip.Paint = function(self, w, h)
            local color = self:IsHovered() and Color(200, 200, 200) or Color(255, 255, 255)
            draw.RoundedBox(4, 0, 0, w, h, color)
        end

        local fpsColorHeader = vgui.Create("DLabel", scrollPanel)
        fpsColorHeader:SetText(translate("FPS Text Color"))
        fpsColorHeader:SetFont("HeaderFont")
        fpsColorHeader:SizeToContents()
        fpsColorHeader:SetPos(0, 0)

        local colorMixer = vgui.Create("DColorMixer", scrollPanel)
        colorMixer:SetSize(350, 200)
        colorMixer:SetPos(0, 30)
        colorMixer:SetPalette(true)
        colorMixer:SetAlphaBar(false)
        colorMixer:SetWangs(true)
        colorMixer:SetColor(fpsColor)

        colorMixer.ValueChanged = function(self, color)
            fpsColor = color
        end

        local boxSettingsHeader = vgui.Create("DLabel", scrollPanel)
        boxSettingsHeader:SetText(translate("Box Settings"))
        boxSettingsHeader:SetFont("HeaderFont")
        boxSettingsHeader:SizeToContents()
        boxSettingsHeader:SetPos(0, 240)

        local boxColorMixer = vgui.Create("DColorMixer", scrollPanel)
        boxColorMixer:SetSize(350, 200)
        boxColorMixer:SetPos(0, 270)
        boxColorMixer:SetPalette(true)
        boxColorMixer:SetAlphaBar(true)
        boxColorMixer:SetWangs(true)
        boxColorMixer:SetColor(boxColor)

        boxColorMixer.ValueChanged = function(self, color)
            boxColor = color
        end

        local cornerRadiusSlider = vgui.Create("DNumSlider", scrollPanel)
        cornerRadiusSlider:SetSize(350, 50)
        cornerRadiusSlider:SetPos(0, 480)
        cornerRadiusSlider:SetText(translate("Corner Radius"))
        cornerRadiusSlider:SetMin(0)
        cornerRadiusSlider:SetMax(32)
        cornerRadiusSlider:SetDecimals(0)
        cornerRadiusSlider:SetValue(boxCornerRadius)

        cornerRadiusSlider.OnValueChanged = function(self, value)
            boxCornerRadius = value
        end

        local languageButton = vgui.Create("DButton", panel)
        languageButton:SetText("Switch to Russian")
        languageButton:SetSize(150, 30)
        languageButton:SetPos(25, 550)

        languageButton.DoClick = function()
            if currentLanguage == "en" then
                currentLanguage = "ru"
                languageButton:SetText("Switch to English")
            else
                currentLanguage = "en"
                languageButton:SetText("Switch to Russian")
            end
            panel:Remove()
            createPanel()
        end
    end

    net.Receive("TogglePanel", function()
        if not panel then
            createPanel()
        else
            panel:Remove()
            panel = nil
        end
    end)

    hook.Add("HUDPaint", "DrawFPSCounter", function()
        local fps = math.Round(1 / FrameTime())
        local text = "FPS: " .. fps
        surface.SetFont("FPSFont")
        local textWidth, textHeight = surface.GetTextSize(text)

        local padding = 10
        local boxWidth = 93
        local boxHeight = 45

        draw.RoundedBox(boxCornerRadius, fpsCounterX, fpsCounterY, boxWidth, boxHeight, boxColor)
        draw.SimpleText(text, "FPSFont", fpsCounterX + padding, fpsCounterY + padding, fpsColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end)

    hook.Add("Think", "DragFPSCounter", function()
        if dragging then
            local mouseX, mouseY = gui.MousePos()
            fpsCounterX = mouseX - dragOffsetX
            fpsCounterY = mouseY - dragOffsetY
        end
    end)

    hook.Add("GUIMousePressed", "StartDraggingFPSCounter", function(mouseCode)
        if mouseCode == MOUSE_LEFT then
            local mouseX, mouseY = gui.MousePos()
            if mouseX >= fpsCounterX and mouseX <= fpsCounterX + 93 and mouseY >= fpsCounterY and mouseY <= fpsCounterY + 45 then
                dragging = true
                dragOffsetX = mouseX - fpsCounterX
                dragOffsetY = mouseY - fpsCounterY
            end
        end
    end)

    hook.Add("GUIMouseReleased", "StopDraggingFPSCounter", function(mouseCode)
        if mouseCode == MOUSE_LEFT then
            dragging = false
        end
    end)
end