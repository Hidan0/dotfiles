# My fish config

# export
set fish_greeting
set TERM "xterm-256color"
set EDITOR "nvim"

# Set VI mode
function fish_user_key_bindings
  fish_vi_key_bindings
end

# ALIASES

alias vim='nvim'
alias vi='nvim'

#list
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -la'
alias l='ls'
alias l.="ls -A | egrep '^\.'"

#fix obvious typo's
alias cd..='cd ..'
alias pdw="pwd"
alias nivm="nvim"

# Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# package man
alias pac='sudo pacman --color auto'
alias update='sudo pacman -Syyu'
alias yay='yay --color auto'
alias yup='yay -Syu'

# University
alias anno1='cd ~/University/Anno1/'
alias anno2='cd ~/University/Anno2/'
alias sisop='cd ~/University/Anno2/SistemiOperativi/'
alias sad='cd ~/University/Anno2/StatisticaAnalisiDati/'

# shutdown now
alias ssn='sudo shutdown now'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# git 
alias addall='git add .' # Git Add All
alias branch='git branch'
alias gclone='git clone'
alias commit='git commit -m'
alias gfetch='git fetch'
alias gstatus='git status'
alias pull='git pull origin'
alias push='git push origin'

# grub
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# starship propt 
starship init fish | source
