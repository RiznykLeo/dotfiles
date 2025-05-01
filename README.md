# My dotfiles


## Requirements

Ensure you have the following installed on your system

## Git

```
brew install git
```

## Stow

```
brew install stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git


```
$ git clone git@github.com/RiznykLeo/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
````

## Apps

### Helix

install spellchecker and ensure it's in PATH
```
$ npm/pnpm/bun i -g @vlabo/cspell-lsp
```

install ccase for case converions
```bash
cargo install ccase
```
