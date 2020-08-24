# path
typeset -U PATH

# env
export BROWSER=qutebrowser
export EDITOR=vim
export COLORFGBG=";0" #pour dire à ip -c que le background est sombre
mkdir -p $HOME/.cache/zsh

# completion
autoload -Uz compinit
compinit -d $HOME/.cache/zsh/zcompdump
zstyle ':completion:*' menu select # active le menu de tab completion
zstyle ':completion::complete:*' gain-privileges 1 # active la completion pour sudo
zstyle ':completion:*' rehash true # rehashe automatiquement la completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Case-insensitive (uppercase from lowercase) completion

# aliases
source $HOME/.config/zsh/aliases
source $HOME/.config/zsh/functions
source $HOME/.config/zsh/keys

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

HCOLOR=$((($(hostname | md5sum | sed "s/[a-f]//g" | head -c 3) + 172) % 210 + 19))

PROMPT='%B%(?.%F{green}√.%F{red}%?)%f%b%@ %F{$HCOLOR}%m%f %B(%2~)%b %# '
RPROMPT='$vcs_info_msg_0_'

# custom commands
up() { 
  exec zsh
}

precmd() {
  # set terminal title to host:pwd
  print -Pn "\e]0;%~\a"
}

preexec() {
  if [[ "$HOST" =~ ^(lemp3|lemp4|lemp5)$ ]] && [[ $2 == python* ]] && type nvidia-smi > /dev/null; then
    CUDA_VISIBLE_DEVICES=""
    smi=$(nvidia-smi --query-gpu=index,memory.used --format=csv)
    IFS=$'\n'
    for line in ${=smi}
    do
      GPU=$(echo $line |cut -d',' -f 1)
      memory=$(echo $line |cut -d',' -f 2)
      if ! [ "$GPU" = "index" ]; then
        if [ "$memory" = " 0 MiB" ]; then
          echo "Running using GPU $GPU"
          export CUDA_VISIBLE_DEVICES="$GPU"
          break
        fi
      fi
    done
    if [ "$CUDA_VISIBLE_DEVICES" = "" ]; then
      echo "Running using CPU"
      export CUDA_VISIBLE_DEVICES=""
    fi
  fi
}

# désactive Ctrl+S
stty -ixon

# vim: set filetype=zsh :
