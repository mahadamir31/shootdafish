// Persistence service for settings and local record data.
AppStorage = object
  // Keys used with microStudio's storage API.
  settingsKey = "app_settings"
  bestTimeKey = "best_time"

  // Loads saved settings or returns defaults on first run.
  loadSettings = function()
    local settings = storage.get(this.settingsKey)
    if settings == 0 then
      // microScript uses 0 as the missing value, so defaults are created here.
      settings = object
        volume = 5
        sensitivity = 5
        fov = 5
        mouseControls = 0
        showTimer = 1
      end
    end
    return settings
  end

  // Persists the full settings object.
  saveSettings = function(settings)
    storage.set(this.settingsKey, settings)
  end

  // Reads the stored best time, or 0 if none exists yet.
  getBestTime = function()
    return storage.get(this.bestTimeKey)
  end

  // Saves a run only when it beats the current local best.
  saveBestTime = function(time)
    local bestTime = this.getBestTime()
    if bestTime == 0 or time > bestTime then
      // Higher time is better, so overwrite only on improvement.
      bestTime = time
      storage.set(this.bestTimeKey, bestTime)
    end
    return bestTime
  end
end
