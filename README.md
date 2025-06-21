# 🚀 John's Dotfiles

> **Disclaimer**: All the goofy flat humor in this README is attributed to AI generation. The human maintainer, while very passionate about many things, may occassionally be more sardonic in person.

Welcome to my personal command-line paradise! This repository contains everything you need to transform a fresh Linux system into a productivity powerhouse. Think of it as a one-click ticket to developer heaven. ✨

## 🎯 What This Does

The `setup.sh` script is your magical setup wizard that turns a bare-bones system into a fully-configured development environment. Here's the epic journey it takes you on:

### 🏗️ Foundation Building
- **Updates your system** - Because nobody likes old packages
- **Installs sudo** (if missing) and adds you to the sudo group - Power to the people!
- **Installs essential tools** that every developer needs:
  - `curl` - For grabbing things from the internet
  - `git` - Version control mastery
  - `zsh` - A shell that doesn't hate you
  - `tmux` - Terminal multiplexing magic
  - `fd-find` - Like `find` but faster and friendlier
  - `ripgrep` - Grep on steroids
  - `fzf` - Fuzzy finding goodness
  - `zoxide` - Smart directory jumping
  - `ranger` - File manager that looks cool

### 🎨 Making Things Pretty & Functional
- **Clones this repository** to your home directory
- **Sets up Oh-My-Zsh** - Because vanilla bash is so last decade
- **Installs TPM** (Tmux Plugin Manager) - Plugins for your terminal multiplexer
- **Creates strategic symlinks** for all your config files:
  - `.zshrc` → Your shell configuration
  - `.tmux.conf` → Terminal multiplexer settings
  - `.gitconfig` → Git configuration
  - Custom `kali.zsh-theme` → That sweet, sweet terminal aesthetic

### 🔥 The Neovim Experience
Here's where things get exciting! The script:
- **Builds Neovim from source** - Fresh, bleeding-edge goodness
- **Sets up system alternatives** so `vim`, `edit`, `view`, and `vimdiff` all point to Neovim
- **Links your Neovim configuration** with a sophisticated plugin ecosystem
- Gives you a **two-tier setup**: minimal for quick edits, full IDE mode for serious work

### 🎭 The Grand Finale
- **Switches your default shell to Zsh** - Welcome to the future
- **Activates tmux plugins** automatically
- Leaves you with a beautifully configured environment ready for action

## 🚀 Quick Start

Ready to transform your system? It's as easy as:

```bash
# Make sure you're running as root or with sudo
sudo ./setup.sh
```

That's it! Grab a coffee ☕ and watch the magic happen.

## 🎮 What You Get

### Terminal Superpowers
- **Zsh with Oh-My-Zsh** and a custom Kali-inspired theme
- **Smart autosuggestions** and syntax highlighting
- **Vi-mode** for modal editing in your shell
- **Zoxide integration** for intelligent directory navigation

### Neovim Paradise
- **Lua-based configuration** with lazy loading
- **Telescope** for fuzzy finding everything
- **Harpoon** for lightning-fast file navigation
- **LSP support** when you need full IDE features
- **Beautiful Carbonfox colorscheme**
- **Oil.nvim** for editing your filesystem like a buffer

### Tmux Mastery
- **Plugin manager** pre-installed and configured
- **Seamless navigation** between tmux panes and vim splits
- **Persistent sessions** that survive reboots

## 🎯 Pro Tips

- Run `NVIM_FULL_IDE_SETUP=1 nvim` for the complete IDE experience
- Use `nvim` for quick edits with minimal startup time
- Press `Space` in Neovim - it's your leader key to everything
- Try `-` in Neovim to open Oil and edit your filesystem
- The setup is idempotent - run it multiple times safely

## 🔧 What's Included

- **Alacritty terminal config** - GPU-accelerated terminal goodness
- **VS Code settings** - For when you need a GUI
- **Git configuration** - Sensible defaults for version control
- **Custom Zsh theme** - That terminal bling you've been looking for

## 🌟 The Philosophy

This isn't just a collection of config files - it's a carefully curated development environment that prioritizes:
- **Speed** - Everything loads fast and stays responsive
- **Productivity** - Keyboard-driven workflows that keep you in the zone
- **Aesthetics** - Because ugly terminals make sad developers
- **Reliability** - Tested configurations that just work

Log out, log back in, and welcome to your new command-line home! 🏠

---

*Made with ❤️ and an unhealthy obsession with terminal productivity*
