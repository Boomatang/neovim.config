# neovim.config

Personal Neovim configuration built on kickstart.nvim with lazy.nvim plugin manager.

## Features

- Lazy.nvim plugin manager with auto-installation
- LSP support (lspconfig, nvim-cmp for completion)
- Telescope fuzzy finder
- Treesitter for syntax highlighting
- Git integration (gitsigns, fugitive)
- File navigation (oil.nvim, harpoon)
- Code formatting (conform.nvim)
- Additional plugins: todo-comments, obsidian, coverage, and more

## Quick Installation

Run the installation script with curl:

```bash
curl -fsSL https://raw.githubusercontent.com/Boomatang/neovim.config/main/install.sh | bash
```

The script will:
- Check for prerequisites (git)
- Safely detect if an existing configuration exists
- Automatically select a branch matching your hostname, or use `main` as default
- Clone the repository to `~/.config/nvim`

## Manual Installation

If you prefer manual installation:

1. Ensure git is installed
2. Backup any existing configuration:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```
3. Clone this repository:
   ```bash
   git clone https://github.com/Boomatang/neovim.config.git ~/.config/nvim
   ```
4. Launch nvim - plugins will auto-install on first run

## Prerequisites

- Neovim >= 0.9.0 (stable or nightly recommended)
- Git
- **Recommended:**
  - A [Nerd Font](https://www.nerdfonts.com/) for icons
  - [ripgrep](https://github.com/BurntSushi/ripgrep) for Telescope live grep
  - [fd](https://github.com/sharkdp/fd) for Telescope file finder
  - C compiler (gcc/clang) for treesitter
  - Language-specific tools (npm for TypeScript, go for Golang, etc.)

## First Launch

On first launch, lazy.nvim will automatically install all configured plugins. This may take 1-2 minutes depending on your connection.

After installation completes, Neovim is ready to use!

## Branch Strategy

This repository supports hostname-based branch selection:
- Create a branch named after your machine's hostname for machine-specific configurations
- The install script automatically detects and uses your hostname branch if it exists
- Falls back to `main` branch if no matching branch is found

Example: If your hostname is `workstation`, create a `workstation` branch for that machine's specific settings.

## Configuration Structure

```
~/.config/nvim/
├── init.lua              # Entry point, lazy.nvim setup
├── lua/
│   ├── options.lua       # Neovim options
│   ├── keymaps.lua       # Key mappings
│   ├── filetype.lua      # Filetype-specific settings
│   ├── custom/
│   │   └── plugins/      # Your custom plugins (won't conflict on updates)
│   └── plugins/          # Configured plugins
└── spell/                # Spell check dictionaries
```

## Customization

To add your own plugins without merge conflicts, place them in `lua/custom/plugins/`. See `lua/custom/plugins/init.lua` for details.

## Troubleshooting

**Plugins not loading:**
- Run `:Lazy sync` inside Neovim
- Check `:checkhealth lazy`

**LSP not working:**
- Verify language servers are installed: `:LspInfo`
- Run `:checkhealth lsp`

**Icons not displaying:**
- Install a [Nerd Font](https://www.nerdfonts.com/)
- Set your terminal to use the Nerd Font

## License

MIT License - see [LICENSE.md](LICENSE.md)
