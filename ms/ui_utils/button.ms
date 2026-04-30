// Reusable UI button component used across all menus and screens.
Button = class
  // Stores button geometry, text styling, and optional sprite display data.
  constructor = function(x, y, width, height)
    this.x = x
    this.y = y
    this.width = width
    this.height = height
    this.text = ""
    this.textPx = 12
    this.font = "PixelOperator"
    this.buttonColor = THEME.buttonColor
    this.textColor = THEME.textColor
    this.sprite = ""
    this.spriteWidth = 0
    this.spriteHeight = 0
    this.idleAlpha = 0.80
    this.hoverAlpha = 1
  end

  // Returns true when the mouse cursor is inside the button bounds.
  isHovering = function()
    // The shared helper expects half sizes, so width and height are divided by 2.
    return UI.isPointerInRect(this.x, this.y, this.width / 2, this.height / 2)
  end

  // Returns true only on the frame the user presses while hovering.
  wasPressed = function()
    return this.isHovering() and mouse.press
  end

  // Draws the button with hover feedback and optional sprite/text content.
  draw = function()
    local hovered = this.isHovering()
    if hovered then
      screen.setAlpha(this.hoverAlpha)
    else
      screen.setAlpha(this.idleAlpha)
    end

    if this.buttonColor != "" then
      screen.fillRect(this.x, this.y, this.width, this.height, this.buttonColor)
    end

    if this.sprite != "" then
      screen.drawSprite(this.sprite, this.x, this.y, this.spriteWidth, this.spriteHeight)
    end

    if this.text != "" then
      screen.setFont(this.font)
      screen.drawText(this.text, this.x, this.y, this.textPx, this.textColor)
    end

    // Reset alpha so later drawing calls are not accidentally translucent.
    screen.setAlpha(1)
  end

  // Updates the displayed label and font size.
  setText = function(text, textPx)
    this.text = text
    this.textPx = textPx
  end

  // Allows a screen to override the default font for this button.
  setFont = function(font)
    this.font = font
  end

  // Updates the button fill and text colors.
  setColors = function(buttonColor, textColor)
    this.buttonColor = buttonColor
    this.textColor = textColor
  end

  // Configures the sprite variant of the button.
  setSprite = function(sprite, width, height)
    this.sprite = sprite
    this.spriteWidth = width
    this.spriteHeight = height
  end
end
