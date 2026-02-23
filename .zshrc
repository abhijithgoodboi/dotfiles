# main zsh settings. env in ~/.zprofile
# read second

# [ -f "$HOME/.zprofile" ] && source "$HOME/.zprofile"

# source global shell alias & variables files
[ -f "$XDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"
# [ -f "$XDG_CONFIG_HOME/shell/vars" ] && source "$XDG_CONFIG_HOME/shell/vars"
#
# export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

export DESKTOP_SESSION=dwm

# load modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors
autoload -U tetris # main attraction of zsh, obviously

# export LS_COLORS="di=0;37:ma=1;34"
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# cmp opts
zstyle ':completion:*' menu select # tab opens cmp menu
zstyle ':completion:*' special-dirs true # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} di=0\;37 ma=1\;34 # colorize cmp menu
# zstyle ':completion:*' file-list true # more detailed list
zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion
zstyle ':completion:*' rehash true

# main opts
setopt append_history inc_append_history share_history # better history
# on exit, history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
setopt auto_menu menu_complete # autocmp first menu match
setopt autocd # type a dir to cd
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt no_case_glob no_case_match # make cmp case insensitive
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
unsetopt prompt_sp # don't autoclean blanklines
stty stop undef # disable accidental ctrl s

# history opts
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh_history" # move histfile to cache
HISTCONTROL=ignoreboth # consecutive duplicates & commands starting with space are not saved


# # Reload updated history before each prompt
# autoload -Uz add-zsh-hook
# add-zsh-hook precmd history -n
#

# fzf setup
source <(fzf --zsh) # allow for fzf history widget


# binds
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^j" backward-word
bindkey "^k" forward-word
bindkey "^H" backward-kill-word
# ctrl J & K for going up and down in prev commands
bindkey "^J" history-search-forward
bindkey "^K" history-search-backward
bindkey '^R' fzf-history-widget


# open fff file manager with ctrl f
# openfff() {
#  fff <$TTY
#  zle redisplay
#}
#zle -N openfff
#bindkey '^f' openfff

# Run Neofetch on shell startup
command -v kotofetch >/dev/null && kotofetch

# set up prompt
# NEWLINE=$'\n'
# ROMPT=$'\n%F{white}%n %F{cyan}%~ %F{green}❯ %f'

# PROMPT="%F{#90ceaa}%n%f
# %F{#86aaec}%~%f ❯ "

PROMPT=$'\n'"%F{#86aaec}[%F{#90ceaa}%n%f %F{#86aaec}%~]%f%F{#90ceaa}$%f "

# PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%}"

# PROMPT="%F{#90ceaa}%n%f
# %F{#86aaec}[%~]%f%F{#90ceaa}$%f "

# PROMPT="%F{#90ceaa}[%n%f %F{#86aaec}%~]%f $ "


# autosuggestions
# requires zsh-autosuggestions
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting
# requires zsh-syntax-highlighting package
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/anastasia/.lmstudio/bin"
# End of LM Studio CLI section

export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/home/anastasia/.spicetify
export PATH=$PATH:/var/lib/snapd/snap/bin
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/scenefx.pc:$PKG_CONFIG_PATH

export PATH="$HOME/.npm-global/bin:$PATH"
