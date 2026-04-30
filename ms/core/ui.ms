// Shared drawing and formatting helpers used by multiple screens and widgets.
UI = object
  // Clears the frame and redraws the full-screen background sprite.
  drawBackground = function()
    screen.clear()
    screen.drawSprite(THEME.backgroundSprite, 0, 0, LAYOUT.screenWidth, LAYOUT.screenHeight)
  end

  drawInGameBackground = function()
    screen.clear()
    screen.drawSprite(THEME.inGameBackground, 0, 0, LAYOUT.screenWidth, LAYOUT.screenHeight)
  end
  
  // Draws a translucent panel over the background to improve text readability.
  drawPanel = function(x, y, width, height)
    screen.setAlpha(0)
    screen.fillRect(x, y, width, height, THEME.panelColor)
    screen.setAlpha(1)
  end

  // Draws a screen title using the shared menu font and styling.
  drawTitle = function(text, y)
    screen.setFont("PixelOperator")
    screen.drawText(text, 0, y, 20, THEME.textColor)
  end

  // Draws standard body text with a single helper call.
  drawBodyText = function(text, x, y, size, color)
    screen.setFont("PixelOperator")
    screen.drawText(text, x, y, size, color)
  end

  // Generic point-in-rectangle test used by buttons and sliders.
  isPointerInRect = function(x, y, halfWidth, halfHeight)
    return mouse.x > x - halfWidth and mouse.x < x + halfWidth and mouse.y > y - halfHeight and mouse.y < y + halfHeight
  end

  // Formats timer values to hundredths for UI display.
  formatTime = function(seconds)
    return round(seconds * 100) / 100 + "s"
  end
end
