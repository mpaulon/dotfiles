# path
typeset -U PATH
export PATH=$PATH:$HOME/bin

# env
export BROWSER=firefox
export EDITOR=vim

# aliases
source $HOME/.config/zsh/aliases
source $HOME/.config/zsh/keys
mkdir -p $HOME/.cache/zsh

# completion
autoload -Uz compinit
compinit -d $HOME/.cache/zsh/zcompdump
zstyle ':completion:*' menu select # active le menu de tab completion
setopt COMPLETE_ALIASES # complete les alias
zstyle ':completion::complete:*' gain-privileges 1 # active la completion pour sudo
zstyle ':completion:*' rehash true # rehashe automatiquement la completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Case-insensitive (uppercase from lowercase) completion

# history
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search
export HISTSIZE=100000
export HISTFILE="$HOME/.cache/zsh/history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# keybindings
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"              beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"               end-of-line
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

# git
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%b'

# prompt
autoload -Uz promptinit
promptinit

PROMPT='%B%(?.%F{green}√.%F{red}%?)%f%b %F{cyan}%m%f %B(%2~)%b %# '
RPROMPT='$vcs_info_msg_0_'

# custom commands
up() { source $HOME/.zshrc }

