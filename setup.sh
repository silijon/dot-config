#!/usr/bin/env bash

set -euo pipefail

USERNAME="$(logname)"  # Get the non-root user
USER_HOME="/home/$USERNAME"
DOTCONFIG_REPO="https://github.com/silijon/dot-config.git"
NEOVIM_REPO="https://github.com/neovim/neovim"
NEOVIM_SRC_DIR="/usr/local/src/neovim"

log() {
  echo -e "\033[1;32m==> $1\033[0m"
}

# 1. Update apt
log "Running apt update..."
apt update

# 2. Install sudo and add user to sudo group
if ! command -v sudo >/dev/null; then
  log "Installing sudo..."
  apt install -y sudo
else
  log "sudo already installed. Skipping."
fi
if ! groups $USERNAME | grep -q sudo; then
  log "Adding $USERNAME to sudo group..."
  usermod -aG sudo "$USERNAME"
else
  log "$USERNAME already in sudo group. Skipping."
fi

# 3. Install packages
REQUIRED_PKGS=(git zsh tmux fd-find ripgrep autojump ranger)
log "Installing base packages..."
for pkg in "${REQUIRED_PKGS[@]}"; do
  if ! dpkg -s "$pkg" >/dev/null 2>&1; then
    log "Installing $pkg..."
    apt install -y "$pkg"
  else
    log "$pkg already installed. Skipping."
  fi
done

# 4. Clone dot-config
if [ ! -d "$USER_HOME/dot-config" ]; then
  log "Cloning dot-config..."
  sudo -u "$USERNAME" git clone "$DOTCONFIG_REPO" "$USER_HOME/dot-config"
else
  log "dot-config already cloned. Skipping."
fi

# 5. Clone TPM
if [ ! -d "$USER_HOME/.tmux/plugins/tpm" ]; then
  log "Installing tmux plugin manager (TPM)..."
  sudo -u "$USERNAME" git clone https://github.com/tmux-plugins/tpm "$USER_HOME/.tmux/plugins/tpm"
else
  log "TPM already installed. Skipping."
fi

# 6. Install oh-my-zsh
if [ ! -d "$USER_HOME/.oh-my-zsh" ]; then
  log "Installing oh-my-zsh..."
  sudo -u "$USERNAME" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
else
  log "oh-my-zsh already installed. Skipping."
fi

# 7. Remove default .zshrc
if [ -f "$USER_HOME/.zshrc" ]; then
  log "Removing default .zshrc..."
  rm -f "$USER_HOME/.zshrc"
else
  log "No default .zshrc found. Skipping."
fi

# 8–10. Symlinks
log "Creating symlinks..."
ln -sf "$USER_HOME/dot-config/.zshrc" "$USER_HOME/.zshrc"
ln -sf "$USER_HOME/dot-config/.tmux.conf" "$USER_HOME/.tmux.conf"
ln -sf "$USER_HOME/dot-config/.gitconfig" "$USER_HOME/.gitconfig"
ln -sf "$USER_HOME/dot-config/kali.zsh-theme" "$USER_HOME/.oh-my-zsh/themes/kali.zsh-theme"

# 11. Install tmux plugins
log "Installing tmux plugins..."
if sudo -u "$USERNAME" tmux has-session 2>/dev/null || sudo -u "$USERNAME" tmux start-server 2>/dev/null; then
  sudo -u "$USERNAME" tmux new-session -d -s temp_session && \
    sudo -u "$USERNAME" tmux send-keys -t temp_session 'run-shell ~/.tmux/plugins/tpm/scripts/install_plugins.sh' C-m && \
    sleep 2 && sudo -u "$USERNAME" tmux kill-session -t temp_session
else
  log "Unable to initialize tmux server. Skipping tmux plugin install."
fi

# 12–16. Install Neovim from source
if ! command -v nvim >/dev/null; then
  log "Installing Neovim from source..."
  apt install -y ninja-build gettext cmake curl build-essential
  if [ ! -d "$NEOVIM_SRC_DIR" ]; then
    git clone "$NEOVIM_REPO" "$NEOVIM_SRC_DIR"
  else
    log "Neovim source already cloned. Skipping clone."
  fi
  cd "$NEOVIM_SRC_DIR"
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  make install

  update-alternatives --install /usr/bin/vim vim /usr/local/bin/nvim 60
  update-alternatives --install /usr/bin/vi vi /usr/local/bin/nvim 60
  update-alternatives --install /usr/bin/view view /usr/local/bin/nvim 60
  update-alternatives --install /usr/bin/vimdiff vimdiff /usr/local/bin/nvim 60
else
  log "Neovim already built and installed. Skipping."
fi

# 17. Symlink Neovim config
log "Linking Neovim config..."
mkdir -p "$USER_HOME/.config"
ln -sf "$USER_HOME/dot-config/nvim" "$USER_HOME/.config/nvim"

# 18. Final message
log "Setup complete. Switching to home directory and sourcing shell..."
cd "$USER_HOME"
sudo -u "$USERNAME" chsh -s $(which zsh) "$USERNAME"

log "You may need to log out and back in for shell changes to take effect."
