# Custom EWW Widgets

A personal collection of [EWW](https://github.com/elkowar/eww) widgets for my Arch Linux + [Omarchy](https://github.com/basecamp/omarchy) + Hyprland environment.

## General Requirements

- [EWW](https://github.com/elkowar/eww) (ElKowars wacky widgets) — Wayland build
- [Hyprland](https://hyprland.org/) window manager
- A Nerd Font (e.g. JetBrainsMono Nerd Font)
- Wayland compositor (Hyprland/Wayland)

---

## Widgets

### 🔍 AI Spotlight (`ai-spotlight/`)

A macOS Spotlight-style search bar powered by [OpenCode](https://opencode.ai/) CLI. Press a hotkey, type a prompt, select your AI model, and get a response rendered right in the bar — all without leaving your keyboard flow.

**Features:**
- Prompt submission via Enter key
- Model selector dropdown with live search/filter
- Scrollable response area
- Screenshot attachment (select a screen region and attach it to your prompt)
- Graceful error handling when OpenCode is not installed
- Configurable model provider and default model via `config.sh`

#### Requirements

- [`opencode`](https://opencode.ai/) CLI installed and configured
- [`eww`](https://github.com/elkowar/eww) (Wayland build)
- [`grim`](https://git.sr.ht/~emersion/grim) — Wayland screenshot tool
- [`slurp`](https://github.com/emersion/slurp) — Region selection tool
- `notify-send` — Desktop notifications (for error messages)
- Hyprland (for keybinding submap)

#### Installation

1. **Clone this repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/custom-widgets ~/.config/custom-widgets
   # or wherever you want it
   ```

2. **Configure your model provider** by editing `ai-spotlight/config.sh`:
   ```bash
   # Filter models by provider prefix (empty = show all models)
   export MODEL_PROVIDER="github-copilot"
   
   # The model selected by default when the widget opens
   export DEFAULT_MODEL="github-copilot/gpt-5-mini"
   ```

   **Not a GitHub Copilot user?** Change to your provider:
   ```bash
   # OpenAI
   export MODEL_PROVIDER="openai"
   export DEFAULT_MODEL="openai/gpt-4o"
   
   # Google
   export MODEL_PROVIDER="google"
   export DEFAULT_MODEL="google/gemini-2.0-flash"
   
   # Show all providers
   export MODEL_PROVIDER=""
   export DEFAULT_MODEL="openai/gpt-4o"
   ```
   
   Valid model IDs can be listed with: `opencode models`

3. **Make scripts executable:**
   ```bash
   chmod +x ai-spotlight/scripts/*.sh ai-spotlight/config.sh
   ```

4. **Add the keybinding** to your Hyprland config (e.g. `~/.config/hypr/bindings.conf`):
   ```ini
   # Toggle AI Spotlight with SUPER+SHIFT+L
   unbind = SUPER SHIFT, L
   bind = SUPER SHIFT, L, exec, /path/to/custom-widgets/ai-spotlight/scripts/toggle.sh
   
   submap = spotlight
   bind = , Escape, exec, /path/to/custom-widgets/ai-spotlight/scripts/toggle.sh
   bind = SUPER SHIFT, L, exec, /path/to/custom-widgets/ai-spotlight/scripts/toggle.sh
   submap = reset
   ```
   Replace `/path/to/custom-widgets` with the actual path where you cloned this repo.

5. **Reload Hyprland config:**
   ```bash
   hyprctl reload
   ```

#### Usage

- **`SUPER + SHIFT + L`** — Toggle the AI Spotlight bar
- **Type your prompt** and press **Enter** to send
- **Click the model selector** (top right) to change AI models — type to filter
- **Click the camera icon** (📷) to attach a screenshot region to your prompt
- **`Escape`** — Close the widget

#### Notes

- The widget uses `opencode run` CLI — no direct API calls are made
- Screenshot uses `grim` + `slurp` (Wayland-native, does not conflict with Omarchy's built-in screenshot tool which uses different key bindings)
- Logs are written to `/tmp/ask.log` and `/tmp/search.log` for debugging
