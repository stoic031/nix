# 🍎 nix-config

Personal macOS system configuration managed with [nix-darwin](https://github.com/nix-darwin/nix-darwin) + [home-manager](https://github.com/nix-community/home-manager).

## 📦 Stack

| Tool | Role |
|---|---|
| [Nix Flakes](https://nixos.wiki/wiki/Flakes) | Reproducible builds |
| [nix-darwin](https://github.com/nix-darwin/nix-darwin) | macOS system management |
| [home-manager](https://github.com/nix-community/home-manager) | User environment |
| [Determinate Installer](https://determinate.systems) | Nix installation |

## 🗂️ Structure
```text
.
├── flake.nix
├── hosts/
│   └── mac/
│       └── default.nix
└── home/
    ├── default.nix
    ├── shell.nix
    ├── git.nix
    ├── neovim.nix
    ├── tmux.nix
    ├── packages.nix
    └── terminal/
        ├── options.nix
        └── default.nix
```
## 🚀 Installation

### 1. Install Nix (Determinate)

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### 2. Clone the repo

```bash
git clone <your-repo-url> ~/.config/nix
cd ~/.config/nix
```

### 3. Bootstrap nix-darwin (first time only)

```bash
nix run nix-darwin -- switch --flake ~/.config/nix#Andys-MacBook-Pro
```

### 4. Apply changes (subsequent runs)

```bash
darwin-rebuild switch --flake ~/.config/nix#Andys-MacBook-Pro
# or using the shell alias
rebuild
```

## ⚙️ Customization

### Personal information

Update `home/git.nix`:

```nix
settings = {
  user.name  = "Your Name";
  user.email = "your@email.com";
};
```

### Terminal, font & opacity

Update `home/default.nix`:

```nix
myConfig = {
  terminal  = "ghostty";   # ghostty | wezterm | kitty
  font.name = "SF Mono";
  font.size = 13;
  opacity   = 0.95;
};
```

### Hostname

Update `hosts/mac/default.nix` and `flake.nix` to match your machine's hostname:

```bash
scutil --get LocalHostName
```

## 🧹 Maintenance

```bash
# Remove all old generations (keeps current only)
nix-collect-garbage -d

# Keep last 7 days of generations
nix-collect-garbage --delete-older-than 7d

# Validate flake before building
nix flake check ~/.config/nix

# View available generations
darwin-rebuild --list-generations

# Roll back to previous generation
darwin-rebuild switch --rollback
```

## 📝 Notes

- **Neovim** (LazyVim) config lives at `~/.config/nvim` — not managed by Nix
- **Tmux** config lives at `~/.tmux.conf` — plugins managed by TPM
- `nix.enable = false` is required when using Determinate Installer
- `result` symlink is git-ignored

## 💻 Machine

| | |
|---|---|
| **Model** | MacBook Pro (Apple Silicon) |
| **Arch** | `aarch64-darwin` |
| **Hostname** | `Andys-MacBook-Pro` |
