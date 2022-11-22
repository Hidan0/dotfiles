# User configuration
export MANPAGER='less'

####   ARCOLINUX SETTINGS   ####
export PAGER='most'

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  if [ -f "$HOME/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh" ]; then
    source $HOME/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh 
  fi
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  echo "suggestion"
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

setopt GLOB_DOTS
#share commands between terminal instances or not
# unsetopt SHARE_HISTORY
setopt SHARE_HISTORY

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups

# Make nano the default editor

export EDITOR='helix'
export VISUAL='helix'

# PATH
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

PATH=$PATH:/home/hidan0/.cargo/bin:/home/hidan0/.local/bin

### ALIASES ###
alias hx='helix'

#list
alias ls='exa --color=always --group-directories-first'
alias ll='exa -la --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias l.="exa -a | grep -E '^\.'"

#fix obvious typo's
alias cd..='cd ..'
alias pdw='pwd'
alias clr='clear'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='grep -E --color=auto'
alias fgrep='fgrep --color=auto'

# package man
alias pac='sudo pacman --color auto'
alias update='sudo pacman -Syyu'
alias yay='yay --color auto'
alias yup='yay -Syu'

# University
alias anno1='cd ~/University/Anno1/'
alias anno2='cd ~/University/Anno2/'
alias anno3='cd ~/University/Anno3/'
alias sweng='cd ~/University/Anno3/IngSoftware/'
alias swengl='cd ~/University/Anno3/IngSoftware/Lab'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

#free
alias free="free -mt"

#grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#add new fonts
alias update-fc='sudo fc-cache -fv'

#hardware info --short
alias hw="hwinfo --short"

#audio check pulseaudio or pipewire
alias audio="pactl info | grep 'Server Name'"

#check vulnerabilities microcode
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

#get fastest mirrors in your neighborhood
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"
#our experimental - best option for the moment
alias mirrorx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
alias mirrorxx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
alias ram='rate-mirrors --allow-root --disable-comments arch | sudo tee /etc/pacman.d/mirrorlist'
alias rams='rate-mirrors --allow-root --disable-comments --protocol https arch  | sudo tee /etc/pacman.d/mirrorlist'

#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

#iso and version used to install ArcoLinux
alias iso="cat /etc/dev-rel | awk -F '=' '/ISO/ {print $2}'"
alias isoo="cat /etc/dev-rel"

#Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

#get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

#shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

# git 
alias addall='git add .' # Git Add All
alias gadd='git add ' # Git Add
alias branch='git branch'
alias gclone='git clone'
alias commit='git commit -m'
alias gfetch='git fetch'
alias gstatus='git status'
alias pull='git pull origin'
alias push='git push origin'

# tmux
alias welcome='tmux new -s default'
alias tas='tmux attach-session -t'

# lf
alias lf='~/.dotfiles/scripts/lfub.sh'

alias !!=$history[1]

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#[[ -f ~/.zshrc-personal ]] && . ~/.zshrc-personal

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/hidan0/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=5000
unsetopt autocd beep extendedglob nomatch notify
bindkey -v

pfetch
eval "$(starship init zsh)"
