// Simple leaderboard scene showing placeholder rankings and the local best time.
LeaderboardScreen = object
  isReady = 0

  // Creates the back button once for this screen.
  ensureSetup = function()
    if this.isReady then
      return
    end

    this.backButton = new Button(0, -88, 120, 24)
    this.backButton.setText("Back", 12)
    this.isReady = 1
  end

  // Lifecycle hook for entering the leaderboard.
  enter = function()
    this.ensureSetup()
  end

  // Returns to the start screen.
  update = function()
    this.ensureSetup()
    if this.backButton.wasPressed() then
      SceneManager.change(SCENES.START)
    end
  end

  // Draws the ranking list and the player's locally stored best result.
  draw = function()
    this.ensureSetup()
    UI.drawBackground()
    UI.drawPanel(0, -6, 320, 175)
    UI.drawTitle("The Top Swimmas", 68)

    local y = 32
    UI.drawBodyText("1. " + AppState.leaderboard[0], 0, y, 11, "rgb(255,215,0)")
    UI.drawBodyText("2. " + AppState.leaderboard[1], 0, y - 22, 11, "rgb(192,192,192)")
    UI.drawBodyText("3. " + AppState.leaderboard[2], 0, y - 44, 11, "rgb(205,127,50)")

    local bestText = "No local record yet"
    if AppState.bestTime != 0 then
      // Reuses the current player label because the best-time record is stored locally.
      bestText = "Best: " + AppState.getPlayerLabel() + " " + UI.formatTime(AppState.bestTime)
    end

    UI.drawBodyText(bestText, 0, -54, 10, THEME.textColor)
    this.backButton.draw()
  end
end
