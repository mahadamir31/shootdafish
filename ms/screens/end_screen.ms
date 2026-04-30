// End-of-run scene. Shows the finish time and records a local best if appropriate.
EndScreen = object
  isReady = 0

  // Creates the return-to-menu button once.
  ensureSetup = function()
    if this.isReady then
      return
    end

    this.menuButton = new Button(0, -70, 150, 28)
    this.menuButton.setText("Main Menu", 12)
    this.isReady = 1
  end

  // Finalizes the run whenever this scene becomes active.
  enter = function()
    this.ensureSetup()
    AppState.completeRun()
  end

  // Returns the player to the start screen and clears run state.
  update = function()
    this.ensureSetup()
    if this.menuButton.wasPressed() then
      AppState.resetRun()
      SceneManager.change(SCENES.START)
    end
  end

  // Draws the run summary and return action.
  draw = function()
    this.ensureSetup()
    UI.drawBackground()
    UI.drawPanel(0, -4, 280, 155)
    UI.drawTitle("Congratulations!", 40)
    UI.drawBodyText("Fish: " + AppState.getPlayerLabel(), 0, 8, 10, THEME.mutedTextColor)
    UI.drawBodyText("Finish Time", 0, -18, 10, THEME.textColor)
    UI.drawBodyText(UI.formatTime(AppState.run.gameTime), 0, -42, 16, THEME.highlightColor)
    this.menuButton.draw()
  end
end
