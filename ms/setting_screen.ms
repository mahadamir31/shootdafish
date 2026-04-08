// Global default values
volume = 5
sensitivity = 5
fov = 5

// Slider constants
SLIDER_X = 30
SLIDER_WIDTH = 120
SLIDER_HEIGHT = 5
NOTCH_WIDTH = 10
NOTCH_HEIGHT = 20

// Settings buttons
settingsButtonList = []

backButton = new Button(0, -75, 100, 30)
backButton.setText("Back", 12)
settingsButtonList.push(backButton)

// Draw all settings buttons
drawSettingsButtons = function()
  
  for button in settingsButtonList
   
    button.draw()
    
  end

end

// Draw a single slider
drawSlider = function(label, value, y, minVal, maxVal)
  
  screen.drawText(label, -80, y, 12, "rgb(255,255,255)")
  screen.fillRect(SLIDER_X, y, SLIDER_WIDTH, SLIDER_HEIGHT, "rgb(100,100,100)")
  
  // Notch position
  local t = (value - minVal) / (maxVal - minVal)
  local notchX = (SLIDER_X - SLIDER_WIDTH/2) + t * SLIDER_WIDTH
  
  screen.fillRect(notchX, y, NOTCH_WIDTH, NOTCH_HEIGHT, "rgb(255,255,255)")
  screen.drawText(round(value), 110, y, 12, "rgb(255,255,255)")  
  
end

// Main settings draw function
drawsettings = function()
  
  screen.clear()
  screen.drawText("Settings", 0, 80, 20, "rgb(255,255,255)")
  
  drawSlider("Vol", volume, 40, 0, 10)
  drawSlider("Sens", sensitivity, 0, 0, 10)
  drawSlider("Fov", fov, -40, 0, 10)
  
  drawSettingsButtons()
  
end

// Slider and Notch logic
updateSlider = function(currentVal, y, minVal, maxVal)
  
  // Edges of slider bar
  local trackLeft = SLIDER_X - SLIDER_WIDTH/2
  local trackRight = SLIDER_X + SLIDER_WIDTH/2
  
  // Check if mouse is within slider bar
  if mouse.x > trackLeft and mouse.x < trackRight then
    
    if mouse.y > y - 15 and mouse.y < y + 15 then
      
      // Move notch around
      if mouse.pressed then
        
        // Convert mouse position to a 0-1 percentage along the track
        local t = (mouse.x - trackLeft) / SLIDER_WIDTH
        // Scale that percentage to the actual setting range
        local newVal = minVal + t * (maxVal - minVal)
        return max(min(newVal, maxVal), minVal)  
        
      end
    
    end
  
  end
  
  return currentVal
  
end

// Update all settings logic - called from update() in main()
updateSettings = function()
  
  volume = updateSlider(volume, 40, 0, 10)
  sensitivity = updateSlider(sensitivity, 0, 0, 10)
  fov = updateSlider(fov, -40, 0, 10)
  
  // Back button 
  2drectcol(mouse.x, mouse.y, 0, -75, 50, 15)
  if collided == 1 and mouse.pressed then
    
    mode = "start"
    collided = 0
    
  end

end