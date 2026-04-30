// Reusable horizontal slider for numeric settings.
Slider = class
  // Stores layout and numeric bounds for one slider control.
  constructor = function(label, x, y, width, minValue, maxValue, value)
    this.label = label
    this.x = x
    this.y = y
    this.width = width
    this.minValue = minValue
    this.maxValue = maxValue
    this.value = value
    this.trackHeight = 6
    this.handleWidth = 12
    this.handleHeight = 22
  end

  // Programmatically updates the slider's value from state.
  setValue = function(value)
    this.value = value
  end

  // Returns true when the pointer is near enough to drag this slider.
  isHovering = function()
    return UI.isPointerInRect(this.x, this.y, this.width / 2, 15)
  end

  // Converts mouse position into a clamped value while the mouse button is held.
  update = function()
    if not mouse.pressed then
      return
    end

    if not this.isHovering() then
      return
    end

    local trackLeft = this.x - this.width / 2
    local t = (mouse.x - trackLeft) / this.width
    // Clamp the interpolation factor so the handle never leaves the track.
    if t < 0 then
      t = 0
    elsif t > 1 then
      t = 1
    end

    // Linear interpolation from normalized track space into the configured value range.
    this.value = this.minValue + t * (this.maxValue - this.minValue)
  end

  // Draws the slider label, track, handle, and current value.
  draw = function()
    local trackLeft = this.x - this.width / 2
    local t = (this.value - this.minValue) / (this.maxValue - this.minValue)
    // Converts the current numeric value back into a pixel position on the track.
    local handleX = trackLeft + t * this.width

    UI.drawBodyText(this.label, -88, this.y, 10, THEME.textColor)
    screen.fillRect(this.x, this.y, this.width, this.trackHeight, THEME.trackColor)
    screen.fillRect(handleX, this.y, this.handleWidth, this.handleHeight, THEME.handleColor)
    UI.drawBodyText(round(this.value), 110, this.y, 10, THEME.textColor)
  end
end
