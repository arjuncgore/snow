# Snow
Configuration for Nixos
> The word snow comes from snowflake (get it?) also it's a song by Red Hot Chili Peppers

## Setup
```bash
mkdir projects
git clone ... ~/projects/snow
sudo nixos-rebuild switch --impure --flake ~/projects/snow
stow ~/projects/snow/dotfiles
```
