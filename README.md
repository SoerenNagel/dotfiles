# Dotfiles

This repository contains my personal dotfiles for **Zsh**, **Oh My Zsh**, and associated tooling. It configures my shell environment with Powerlevel10k, Vim-style keybindings, custom aliases, and paths for personal binaries and software.

## Features

- **Zsh with Oh My Zsh**  
  - Powerlevel10k theme.
  - Syntax highlighting via `zsh-syntax-highlighting`.
  - Vi-mode keybindings.
  - Menu selection for tab completion with Vim keys.

- **Custom Aliases & Keybindings**  
  - Aliases for `ls`, `tree`, `vim` (as `nvim`), and project-specific commands.
  - Keybindings for session management via `tmux-sessionizer`.

- **Path Customization**  
  Adds paths to personal binaries and scripts:
  - `nvim`, `quarto`, `tmux-sessionizer`, `lazygit`, and project scripts.
  - **NOTE**: If these can be installed directly, these can be removed.

- **Environment Setup**  
  - Conda initialization for Python environments.
  - Julia setup via `juliaup` with multi-threading enabled.

---

## Dependencies

To get this setup fully working, the following packages and tools should be installed:

### Shell & Prompt
- `zsh` – Z shell
- `oh-my-zsh` – framework for managing Zsh configuration
- `powerlevel10k` – Zsh theme with instant prompt
- `zsh-syntax-highlighting` – syntax highlighting for commands

### Text Editor
- `nvim`
- `zathura`

### File Utilities
- `eza` – replacement for `ls`, `ll`, `tree`
- `RSLURM` 

### Terminal Multiplexing / Session Management
- `tmux` – terminal multiplexer
- `tmux-sessionizer` – session management tool
- `lazygit` – git terminal UI

### Languages / Environment Managers
- **Python**: `conda` or `miniconda` – for Python environment management
- **Julia**: `juliaup` – for managing Julia installations
  - `JULIA_NUM_THREADS` is set in `.zshrc` for parallelism


### Optional / Supporting Packages
- `xdg-open` – used in alias `view` (Otherwise remove alias)

---

## BackUp existing Configuration

## SetUp

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow */
```




