// Gameplay scene shell. Right now it provides HUD behavior and menu exits.
PlayScreen = object
  isReady = 0

  // Creates the reusable back button once.
  ensureSetup = function()
    if this.isReady then
      return
    end

    this.backButton = new Button(-168, 78, 40, 40)
    this.backButton.setColors("", THEME.textColor)
    this.backButton.setSprite("sprite", 46, 46)
    

    this.isReady = 1
  end

  // Lifecycle hook for entering gameplay.
  enter = function()
    this.ensureSetup()
    if AppState.run.gunControlz== 0 then
      AppState.run.gunControlz = new GunControlz()
    end
  end

  // Handles lightweight gameplay controls that already exist in the prototype.
  update = function()
    this.ensureSetup()

    if this.backButton.wasPressed() or keyboard.press.N then
      AppState.resetRun()
      SceneManager.change(SCENES.START)
      return
    end

    if keyboard.press.R then
      AppState.resetRun()
      AppState.run.timing = 1
      return
    end
    if AppState.run.gunControlz.update(AppState.run.fish, AppState.run.gameTime) then
      SceneManager.change(SCENES.END)
      return
    end
  end

  // Draws the current gameplay shell and timer HUD.
  draw = function()
    this.ensureSetup()
    UI.drawInGameBackground()
    this.backButton.draw()
    
    AppState.run.gunControlz.draw()
    AppState.run.fish.draw()

    screen.setDrawAnchor(-1, 0)
    UI.drawBodyText(UI.formatTime(AppState.run.gameTime), -195, -84, 14, THEME.textColor)
    screen.setDrawAnchor(0, 0)
      
  end
end
