Button = class
  constructor = function(x, y, width, height)
    this.x = x
    this.y = y
    this.width = width
    this.height = height
    
    this.text = ""
    this.textPx = 12
    this.buttonColor = "rgb(150,150,150)"
    this.textColor = "rgb(255,255,255)"
    this.sprite = ""
    this.sWidth = 0
    this.sHeight = 0
  end
  
  // Mouse hovering over the button function
  isHovering = function()
    local minX = this.x - this.width/2
    local minY = this.y - this.height/2
    local px = mouse.x
    local py = mouse.y
    
    if minX < px and px < minX+width then
      return (minY < py and py < minY+height)
    end
    
    return 0
  end

  // Redraw button.  
  draw = function()
    if isHovering() then
      screen.setAlpha(1)
    else
      screen.setAlpha(0.7)
    end

    // Draw Button Rectangle
    if buttonColor.length != 0 then
      screen.fillRect(x, y, width, height, buttonColor)
    end
    
    // Draw Text
    if text.length != 0 then
      screen.drawText(text, x, y, textPx, textColor)
    end
    
    if sprite.length != 0 then
      screen.drawSprite(sprite, x, y, sWidth, sHeight)
    end
  end

  
  hasClicked = function()
    return isHovering() and mouse.press
  end
  
  // Set the text and text size on a button.
  setText = function(newText, newTextPx)
    this.text = newText
    this.textPx = newTextPx
  end
  
  // Set the background color and text color of a button.
  setColors = function(newButtonColor, newTextColor)
    this.buttonColor = newButtonColor
    this.textColor = newTextColor
  end
  
  setSprite = function(newSprite, newSW, newSH)
    this.sprite = newSprite
    this.sWidth = newSW
    this.sHeight = newSH
  end
  
end