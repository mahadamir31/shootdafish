// String ids used by the scene manager to switch between screens safely.
SCENES = object
  START = "start"
  NAME_INPUT = "nameinput"
  PLAY = "play"
  CONTROLS = "controls"
  SETTINGS = "settings"
  LEADERBOARD = "leaderboard"
  END = "end"
end

// Shared color and asset tokens so UI styling stays centralized.
THEME = object
  backgroundSprite = "backgroundgame"
  inGameBackground = "background_ingame"
  panelColor = "rgba(0,0,0,0.72)"
  buttonColor = "rgb(38,86,122)"
  textColor = "rgb(255,255,255)"
  mutedTextColor = "rgb(205,224,236)"
  successColor = "rgb(60,180,100)"
  dangerColor = "rgb(180,60,60)"
  trackColor = "rgb(100,100,100)"
  handleColor = "rgb(255,255,255)"
  highlightColor = "rgb(255,210,80)"
end

// Shared layout values for full-screen background rendering and other fixed measurements.
LAYOUT = object
  screenWidth = 400
  screenHeight = 200
end
