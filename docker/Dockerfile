# Development Environment Dockerfile
# Usage: docker build --build-arg BASE_IMAGE=debian:bookworm --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) -t my-dev-env .

ARG BASE_IMAGE=debian:bookworm
FROM ${BASE_IMAGE}

# Build arguments for user/group IDs
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USERNAME=developer

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV USERNAME=${USERNAME}
ENV USER_HOME=/home/${USERNAME}
ENV DOTFILES_DIR=/opt/dotfiles
ENV DOTCONFIG_REPO=https://github.com/silijon/dot-config.git
ENV TERM=xterm-256color
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Create necessary directories
RUN mkdir -p ${DOTFILES_DIR}

# Update apt and install required packages
RUN apt-get update && \
    apt-get install -y \
        sudo \
        curl \
        ca-certificates \
        git \
        unzip \
        zsh \
        tmux \
        fd-find \
        ripgrep \
        fzf \
        zoxide \
        ranger \
        python3-venv \
        nodejs \
        npm \
    && rm -rf /var/lib/apt/lists/*

# Create user and group with specified IDs
RUN groupadd -g ${GROUP_ID} ${USERNAME} && \
    useradd -u ${USER_ID} -g ${GROUP_ID} -m -s /bin/zsh ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create user directories
RUN mkdir -p ${USER_HOME}/.config ${USER_HOME}/.tmux/plugins && \
    chown -R ${USERNAME}:${USERNAME} ${USER_HOME}

# Clone dotfiles repository and set proper ownership
RUN git clone ${DOTCONFIG_REPO} ${DOTFILES_DIR} && \
    chown -R ${USER_ID}:${GROUP_ID} ${DOTFILES_DIR}

# Switch to user for installations that should be user-owned
USER ${USERNAME}

# Install tmux plugin manager (TPM)
RUN git clone https://github.com/tmux-plugins/tpm ${USER_HOME}/.tmux/plugins/tpm

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Remove default .zshrc if it exists
RUN rm -f ${USER_HOME}/.zshrc

# Create symlinks for configuration files
RUN ln -sfT ${DOTFILES_DIR}/.zshrc ${USER_HOME}/.zshrc && \
    ln -sfT ${DOTFILES_DIR}/.tmux.conf ${USER_HOME}/.tmux.conf && \
    ln -sfT ${DOTFILES_DIR}/.gitconfig ${USER_HOME}/.gitconfig && \
    ln -sfT ${DOTFILES_DIR}/kali.zsh-theme ${USER_HOME}/.oh-my-zsh/themes/kali.zsh-theme && \
    ln -sfT ${DOTFILES_DIR}/.zshenv ${USER_HOME}/.zshenv

# Switch back to root for system-wide installations
USER root

# Install Neovim from latest release
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && \
    rm -rf /opt/nvim && \
    tar -C /opt -xzf nvim-linux-x86_64.tar.gz && \
    rm nvim-linux-x86_64.tar.gz

# Set up update-alternatives for Neovim
RUN NVIM_PATH="/opt/nvim-linux-x86_64/bin/nvim" && \
    update-alternatives --install /usr/bin/vim vim "$NVIM_PATH" 60 && \
    update-alternatives --set vim "$NVIM_PATH" && \
    update-alternatives --install /usr/bin/edit edit "$NVIM_PATH" 60 && \
    update-alternatives --install /usr/bin/view view "$NVIM_PATH" 60 && \
    update-alternatives --install /usr/bin/vimdiff vimdiff "$NVIM_PATH" 60 && \
    update-alternatives --install /usr/bin/nvim nvim "$NVIM_PATH" 60

# Symlink Neovim config (as user) and ensure proper permissions
USER ${USERNAME}
RUN ln -sfT ${DOTFILES_DIR}/nvim ${USER_HOME}/.config/nvim && \
    mkdir -p ${USER_HOME}/.local/share/nvim && \
    mkdir -p ${USER_HOME}/.cache/nvim

# Run the lazy installs for nvim so that's all done and image is read-to-use
RUN NVIM_FULL_IDE_SETUP=1 nvim --headless -c "Lazy! sync" -c "MasonToolsInstallSync" -c "qa" || true

# Set working directory and switch to user
WORKDIR ${USER_HOME}

# Default command
CMD ["/bin/zsh"]
