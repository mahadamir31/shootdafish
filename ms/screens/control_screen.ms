// Read-only controls reference scene.
ControlsScreen = object
  isReady = 0

  // Creates the back button once for reuse.
  ensureSetup = function()
    if this.isReady then
      return
    end

    this.backButton = new Button(0, -88, 120, 24)
    this.backButton.setText("Back", 12)
    this.isReady = 1
  end

  // Lifecycle hook for entering the controls scene.
  enter = function()
    this.ensureSetup()
  end

  // Leaves the screen when the back button is pressed.
  update = function()
    this.ensureSetup()
    if this.backButton.wasPressed() then
      SceneManager.change(SCENES.START)
    end
  end

  // Draws the controls list and reflects the current look-input setting.
  draw = function()
    this.ensureSetup()
    UI.drawBackground()
    UI.drawTitle("Controls", 68)
    UI.drawBodyText("Mouse - Move", 0, 0, 12, THEME.textColor)

    this.backButton.draw()
  end
end
