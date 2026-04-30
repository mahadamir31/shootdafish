// Centralized application state shared by every scene.
AppState = object
  // Creates the top-level runtime state for a new app session.
  init = function()
    this.globalTime = 0
    this.scene = SCENES.START
    this.settings = AppStorage.loadSettings()
    
    // Player stores profile-like state that survives scene changes.
    this.player = object
      name = ""
      // fish = 0   No need to store an instance of the fish class across scenes
    end
    
    // Placeholder leaderboard data until a real data source exists.
    this.leaderboard = [
      "JEB 99.99",
      "MAH 99.98",
      "RAH 99.97"
    ]
    
    this.bestTime = AppStorage.getBestTime()
    this.resetNameInput()
    this.resetRun()
  end

  // Resets the mutable state for one gameplay run.
  resetRun = function()
    this.run = object
      gameTime = 0
      timing = 0
      lives = 0
      fish = new Fish(this.player.name, 40)
      gunControlz = new GunControlz()
    end
  end

  // Resets the temporary text-entry state used by the name input screen.
  resetNameInput = function()
    this.nameInput = object
      chars = []
      buffer = ""
    end
  end

  // Prepares the app for a fresh name entry flow.
  beginNameEntry = function()
    this.resetNameInput()
    this.resetRun()
  end

  // Joins the typed character array into the visible string buffer.
  refreshNameBuffer = function()
    this.nameInput.buffer = this.nameInput.chars.join("")
  end

  // Commits the entered name to the player profile and starts a fresh timed run.
  confirmName = function()
    this.player.name = this.nameInput.buffer
    //this.player.fish = new Fish(this.player.name)  Idk what this helps with
    this.resetRun()
    this.run.timing = 1
  end

  // Advances app-wide timers once per frame.
  tick = function()
    this.globalTime += 1 / 60
    // Only the active play scene should accumulate gameplay time.
    if this.scene == SCENES.PLAY and this.run.timing then
      this.run.gameTime += 1 / 60
    end
  end

  // Finalizes the current run and persists a better best time if one was earned.
  completeRun = function()
    this.run.timing = 0
    this.bestTime = AppStorage.saveBestTime(this.run.gameTime)
  end

  // Saves the in-memory settings object back to storage.
  saveSettings = function()
    AppStorage.saveSettings(this.settings)
  end

  // Returns a safe fallback label for screens that display the player name.
  getPlayerLabel = function()
    if this.player.name != "" then
      return this.player.name
    else
      return "Anonymous"
    end
  end
end
