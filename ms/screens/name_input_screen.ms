// Name entry scene used before gameplay starts.
NameInputScreen = object
  isReady = 0

  // Creates the confirm/cancel buttons once.
  ensureSetup = function()
    if this.isReady then
      return
    end

    this.confirmButton = new Button(80, -34, 110, 28)
    this.confirmButton.setText("Confirm", 11)
    this.confirmButton.setColors(THEME.successColor, THEME.textColor)

    this.cancelButton = new Button(-80, -34, 110, 28)
    this.cancelButton.setText("Cancel", 11)
    this.cancelButton.setColors(THEME.dangerColor, THEME.textColor)

    this.isReady = 1
  end

  // Clears any previous text when the player returns to this screen.
  enter = function()
    this.ensureSetup()
    AppState.resetNameInput()
  end

  // Handles keyboard input and transitions to play or back to the menu.
  update = function()
    this.ensureSetup()
    Input.captureNameCharacters(AppState.nameInput.chars, 3)
    AppState.refreshNameBuffer()

    if (this.confirmButton.wasPressed() or keyboard.press.ENTER) and AppState.nameInput.buffer.length > 0 then
      AppState.confirmName()
      SceneManager.change(SCENES.PLAY)
    elsif this.cancelButton.wasPressed() then
      SceneManager.change(SCENES.START)
    end
  end

  // Draws the name entry panel and a blinking text cursor.
  draw = function()
    this.ensureSetup()
    UI.drawBackground()
    UI.drawPanel(0, 0, 240, 132)
    UI.drawTitle("Name Your Fish", 34)
    UI.drawBodyText("Three letters max", 0, 14, 9, THEME.mutedTextColor)

    local cursor = ""
    // Blink every half second by sampling the global timer.
    if floor(AppState.globalTime * 2) % 2 == 0 then
      cursor = "|"
    end

    UI.drawBodyText(AppState.nameInput.buffer + cursor, 0, -4, 18, THEME.highlightColor)
    this.confirmButton.draw()
    this.cancelButton.draw()
  end
end
