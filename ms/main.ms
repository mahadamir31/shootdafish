// Registers every scene object with the scene manager so the app can navigate by id.
registerScreens = function()
  SceneManager.register(SCENES.START, StartScreen)
  SceneManager.register(SCENES.NAME_INPUT, NameInputScreen)
  SceneManager.register(SCENES.PLAY, PlayScreen)
  SceneManager.register(SCENES.CONTROLS, ControlsScreen)
  SceneManager.register(SCENES.SETTINGS, SettingsScreen)
  SceneManager.register(SCENES.LEADERBOARD, LeaderboardScreen)
  SceneManager.register(SCENES.END, EndScreen)
end

// Engine entry point. Initializes global app state and opens the start screen.
init = function()
  AppState.init()
  registerScreens()
  SceneManager.change(SCENES.START)
end

// Engine update loop. Advances shared state first, then lets the active scene react.
update = function()
  AppState.tick()
  SceneManager.update()
end

// Engine draw loop. Delegates rendering to whichever scene is currently active.
draw = function()
  SceneManager.draw()
end
