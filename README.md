# Fish in a Barrel

Fish in a Barrel is a microStudio game written in microScript. You control a fish inside a barrel while guns around the edge fire projectiles inward. The goal is to survive as long as possible, record your time, and navigate through the start menu, settings, controls, leaderboard, gameplay, and end screens.

## Project Contents

```text
fishinabarrel_20260430-024157_archive/
|-- project.json
|-- ms/
|   |-- main.ms
|   |-- core/
|   |-- models/
|   |-- screens/
|   |-- services/
|   `-- ui_utils/
|-- sprites/
|-- fishinabarrel/
|   |-- index.html
|   |-- microengine.js
|   |-- program.js
|   |-- manifest.json
|   `-- sprites/
|-- Fish in a Barrel Setup 1.0.0.exe
|-- Fish in a Barrel-1.0.0.dmg
`-- documentation.md
```

## Ways to Run the App

### 1. Run Through the microStudio Site

Use this option when you want to edit or run the original microStudio project.

https://microstudio.dev/i/jimbalaja/fishinabarrel/

This is the best option for development because it uses the original microScript source files.

### 2. Run the Exported Web Build

Use this option when you want to play the exported browser version.

Unzip and Open:

```text
fishinabarrel/index.html
```

If the browser blocks local files or assets, run the folder with a small local web server and open the served URL. The exported web build depends on nearby files such as `microengine.js`, `program.js`, fonts, and sprites, so keep the whole `fishinabarrel/` folder together.

### 3. Run on Windows

Use the Windows installer at the project root under Github Releases:

```text
Fish in a Barrel Setup 1.0.0.exe
```

Run the installer, then launch Fish in a Barrel from the installed app shortcut or Start menu entry.

### 4. Run on macOS

Use the macOS disk image at the project root under Github Releases:

```text
Fish in a Barrel-1.0.0.dmg
```

Open the DMG, install or drag the app as prompted, then launch Fish in a Barrel from Applications or the mounted disk image.

## Controls

- Mouse: move the fish.
- `R`: restart the current run.
- `N`: leave gameplay and return to the start screen.
- Name entry: type up to three letters, use Backspace to delete, and press Enter or Confirm to start.

## Source Layout

- `ms/main.ms`: microStudio entry point. Initializes state, registers screens, and delegates update/draw loops.
- `ms/core/`: shared app state, constants, input helpers, UI helpers, and scene management.
- `ms/screens/`: start, name input, play, controls, settings, leaderboard, and end screens.
- `ms/models/`: gameplay classes for the fish, guns, projectiles, and gun spawning.
- `ms/ui_utils/`: reusable button and slider components.
- `ms/services/`: local storage helpers for settings and best time.
- `sprites/`: source sprite assets used by the microStudio project.
- `fishinabarrel/`: exported web build assets.

## Notes

- The project is built around `init()`, `update()`, and `draw()` lifecycle.
- Settings and best-time data are stored locally through microStudio storage.
- The exported `fishinabarrel/` folder should be treated as a complete web build; moving only `index.html` may break assets.
