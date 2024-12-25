if CLIENT then
    resource.AddFile("resource/fonts/Montserrat-Medium.ttf")

    surface.CreateFont("FPSFont", {
        font = "Montserrat Medium",
        size = 24,
        weight = 500,
        antialias = true,
        shadow = false
    })

    local fpsCounter = {
        x = ScrW() - 150,
        y = 20,
        width = 93,
        height = 45,
        dragging = false,
        dragOffsetX = 0,
        dragOffsetY = 0
    }

    hook.Add("HUDPaint", "DrawFPSCounter", function()
        local fps = math.Round(1 / FrameTime())
        local text = "FPS: " .. fps
        surface.SetFont("FPSFont")
        local textWidth, textHeight = surface.GetTextSize(text)

        local padding = 10
        local boxWidth = fpsCounter.width
        local boxHeight = fpsCounter.height

        draw.RoundedBox(8, fpsCounter.x, fpsCounter.y, boxWidth, boxHeight, Color(0, 0, 0, 150))
        draw.SimpleText(text, "FPSFont", fpsCounter.x + padding, fpsCounter.y + padding, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end)

    hook.Add("Think", "DragFPSCounter", function()
        if fpsCounter.dragging then
            local mouseX, mouseY = gui.MousePos()
            fpsCounter.x = mouseX - fpsCounter.dragOffsetX
            fpsCounter.y = mouseY - fpsCounter.dragOffsetY
        end
    end)

    hook.Add("GUIMousePressed", "StartDraggingFPSCounter", function(mouseCode)
        if mouseCode == MOUSE_LEFT then
            local mouseX, mouseY = gui.MousePos()
            if mouseX >= fpsCounter.x and mouseX <= fpsCounter.x + fpsCounter.width and mouseY >= fpsCounter.y and mouseY <= fpsCounter.y + fpsCounter.height then
                fpsCounter.dragging = true
                fpsCounter.dragOffsetX = mouseX - fpsCounter.x
                fpsCounter.dragOffsetY = mouseY - fpsCounter.y
            end
        end
    end)

    hook.Add("GUIMouseReleased", "StopDraggingFPSCounter", function(mouseCode)
        if mouseCode == MOUSE_LEFT then
            fpsCounter.dragging = false
        end
    end)
end