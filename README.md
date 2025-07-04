# RiznykLeo dotfiles

## Requirements

Ensure you have git and stow installed on your system before proceeding.

```bash
brew install git stow
```

## Setup

First, check out the dotfiles repo in your $HOME directory using git:

```bash
git clone git@github.com/RiznykLeo/dotfiles.git
cd dotfiles
```

Then use GNU stow to create symlinks:

```bash
stow .
```

## Apps

Install main workflow apps

```bash
brew install fish tmux nvim zoxide fzf exa rg lazydocker eza bat

```

Add TPM

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

```

Start tmux and install the plugins `Ctrl+I`
