// Start menu scene. Owns the main navigation buttons shown at launch.
StartScreen = object
  isReady = 0
  buttons = []

  // Creates a lightweight menu entry that pairs an id with a reusable button component.
  createEntry = function(id, x, y, width, height, label, labelSize)
    local button = new Button(x, y, width, height)
    button.setText(label, labelSize)
    // A tiny object is enough here; we only need to route by id and draw/click the button.
    local entry = object end
    entry.id = id
    entry.button = button
    return entry
  end

  // creates buttons so the screen can be entered more than once without rebuilding.
  ensureSetup = function()
    if this.isReady then
      return
    end

    this.buttons = []
    this.buttons.push(this.createEntry("start", 0, 24, 150, 28, "Start", 12))
    this.buttons.push(this.createEntry("controls", 0, -10, 150, 28, "Controls", 12))
    this.buttons.push(this.createEntry("leaderboard", 0, -44, 190, 28, "Leaderboard", 12))
    this.buttons.push(this.createEntry("exit", 0, -78, 90, 28, "Exit", 12))

    local settingsEntry = this.createEntry("settings", -138, -70, 36, 36, "", 12)
    settingsEntry.button.setColors("", THEME.textColor)
    settingsEntry.button.setSprite("cog", 40, 40)
    this.buttons.push(settingsEntry)

    this.isReady = 1
  end

  // Scene lifecycle hook fired whenever this scene becomes active.
  enter = function()
    this.ensureSetup()
  end

  // Handles start-menu navigation.
  update = function()
    this.ensureSetup()

    for entry in this.buttons
      if entry.button.wasPressed() then
        if entry.id == "start" then
          AppState.beginNameEntry()
          SceneManager.change(SCENES.NAME_INPUT)
        elsif entry.id == "controls" then
          SceneManager.change(SCENES.CONTROLS)
        elsif entry.id == "settings" then
          SceneManager.change(SCENES.SETTINGS)
        elsif entry.id == "leaderboard" then
          SceneManager.change(SCENES.LEADERBOARD)
        elsif entry.id == "exit" then
          system.exit()
        end
        break
      end
    end
  end

  // Draws the start screen shell and all menu actions.
  draw = function()
    this.ensureSetup()
    UI.drawBackground()
    UI.drawPanel(0, 0, 320, 170)
    UI.drawTitle("Fish In a Barrel", 60)

    for entry in this.buttons
      entry.button.draw()
    end
  end
end
