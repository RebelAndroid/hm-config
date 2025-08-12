fish_add_path /var/home/admin/.nix-profile/bin /nix/var/nix/profiles/default/bin

alias mv 'mv -i'
alias ls 'eza -l --time-style=long-iso --icons=always'
alias imv 'nixGLIntel imv'
alias mpv 'nixGLIntel mpv'

zoxide init fish | source

direnv hook fish | source