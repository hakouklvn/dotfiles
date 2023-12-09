# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


# [aliases]
alias ls='lsd'
alias l='ls'
alias ll='ls -lAh'
alias lt='ls --tree'
alias cls='clear'
alias mkdir='mkdir -pv'
alias cat='bat'
alias cd='z'
alias du='dust'

alias v='nvim'
alias vim='nvim'

alias calc='python /usr/bin/calc.py'
alias torrent='transmission-gtk'
alias wifi='nm-connection-editor'
alias scanNet='sudo iwlist wlp3s0 scan | grep -i ssid'

alias get='sudo pacman -S'
alias del='sudo pacman -Rns'
alias update='sudo pacman -Syu'
alias updateParu='paru -Syu'

alias grep='grep --color'

alias svelte='npx degit sveltejs/template'
alias sveltekit='npm init svelte@next'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias rustbook='rustup doc --book'
alias flutterGenerator='sh ~/Desktop/flutter-generator/flutterGenerator.sh'
alias nestGenerator='sh ~/Desktop/flutter-generator/nestGenerator.sh'

alias dmen='dmenu_run -fn "FiraCode:size=12" -l 20 -nb "#282c34" -nf "#cccccc" -sb "#d9e0ee" -sf "#1c1f24" -i -p "Hole world"'

# navigation
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

# [source]
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme


export PAGER="most"
export PATH=$PATH:~/.pub-cache/bin
export PATH=$PATH:~/.local/bin/scripts

export PATH=$PATH:~/.config/emacs/bin
export PATH="$DENO_INSTALL/bin:$PATH"

export MANPAGER="nvim +Man!"
export EDITOR="nvim"
export HISTCONTROL=ignoreboth
export LS_COLORS="$(vivid generate one-dark)"

setopt autocd

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


alias luamake=/home/hakouguelfen/.config/nvim/lua-language-server/3rd/luamake/luamake

# bun completions
[ -s "/home/hakouguelfen/.bun/_bun" ] && source "/home/hakouguelfen/.bun/_bun"

# Bun
export BUN_INSTALL="/home/hakouguelfen/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/home/hakouguelfen/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

eval "$(zoxide init zsh)"
export _ZO_ECHO_STYLE="case-insensitive"

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# opam configuration
[[ ! -r /home/hakouguelfen/.opam/opam-init/init.zsh ]] || source /home/hakouguelfen/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

[ -f "/home/hakouguelfen/.ghcup/env" ] && source "/home/hakouguelfen/.ghcup/env" # ghcup-env
# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
