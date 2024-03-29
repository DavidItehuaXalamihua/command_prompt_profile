# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###################################################
#### INICIA BLOQUE DE PERSONALIZACIÓN DE DAVID ####
###################################################

# autocompletar
bind "set show-all-if-ambiguous on"
bind 'set completion-ignore-case on'
bind "TAB:menu-complete"

#inicio de las variables de David
user=$(whoami)
desktop="/home/$user/Desktop"
downloads="/home/$user/Downloads"
scripts="/home/$user/Desktop/.scripts"
poshthemes="/home/$user/.poshthemes"

# para escribir en la siguiente linea
PS1="\W \n> "


# DIX Alias
alias open="xdg-open"
alias cls="clear"
alias ls="ls -l"
#funciones de David

function profile-edit(){
    t="$(pwd)"
    cd $home
    code .bashrc
    cd $t
}

function profile-backup(){
    t="$(pwd)"
    cd "/home/$user/Desktop/.bashrc_backups"
    cat "/home/$user/.bashrc" | tee "/home/$user/Desktop/.bashrc_backups/bashrc.txt">/dev/null
    cat "/home/$user/.bashrc" | tee "/home/$user/Desktop/.bashrc_backups/.bashrc">/dev/null
    cat "/home/$user/.inputrc" | tee "/home/$user/Desktop/.bashrc_backups/inputrc.txt">/dev/null
    bash push.sh
    cd $t
}

function profile-help (){
	echo "cd /home/$user"
	echo "Opc 1) sudo nano .bashrc"
    echo "Opc 2) code .bashrc"
}

function add-content(){
    echo "Opc. 1:"
    echo 'echo "palabra" >> filename.txt'
    echo "Opc. 2:"
    echo 'echo "palabra" | tee -a filename.txt>/dev/null'
    echo "si solo se usa un > solo se sustituye la info del archivo y se borra todo lo que tenía previamente"
    echo "ayuda: https://www.cyberciti.biz/faq/linux-append-text-to-end-of-file/"
}

function scb(){
	echo "pwd | xclip -selection clipboard"
    echo 'echo "palabra" | xclip -selection clipbard'
}

function today(){
    echo This is a `date +"%A %d in %B of %Y (%r)"` return
}

function find_largest_files() {
    du -h -x -s -- * | sort -r -h | head -20;
}

function eb (){
    exec bash
}

function web_env(){
    mkdir $1

    html=$(cat <<-END
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
</head>
<body>
	
</body>
</html>
END
)

    
    touch $1/index.html
    touch $1/index.js
    touch $1/style.css

    echo $html >> $1/index.html
}

function zip-help(){
    echo "ayuda: https://phoenixnap.com/kb/how-to-zip-a-file-in-linux"
    echo "zip basico:"
    echo "zip nombre_zip_final fileSample1.txt fileSample2.xlsm fileSample3.csv fileSample4.pdf"
    echo "En caso de zipear un folder el método de recursividad a usar es -r"
    echo "zip -r nombre_folder carpeta_a_zippear"
}

function unzip-help(){
    echo "comando básico"
    echo "unzip file.zip"
    echo "Para unzipear a un a una carpeta se usa el atributo -d"
    echo "unzip file.zip -d folder"
}

function find-help(){
    echo "ayuda 1: https://www.redhat.com/sysadmin/linux-find-command"
    echo "ayuda 2: https://www.ionos.com/digitalguide/server/configuration/linux-find-command/"
    echo "find ./ -name *.txt"
}

function replace-help(){
    echo "ayuda: https://linuxhandbook.com/replace-string-bash/"
    echo 'line="Use a Retina Image for Higher Resolution Displays"'
    echo 
    echo "Sustituir solo una vez"
    echo 'newline="${line/a/A}"'
    echo
    echo "Sustituir todas las apariciones"
    echo 'newLine="${line//a/A}"'
}

function scb-pwd(){
    pwd | xclip -selection clipboard
}

function for-loop(){
    echo "ayuda 1: https://www.cyberciti.biz/faq/bash-for-loop/"
    echo "ayuda 2: https://linuxize.com/post/how-to-compare-strings-in-bash/"
    echo "ejem 1:"
    echo 'for n in "David" "Daniel" "Jesus" "Venny"'
    echo "do"
    echo 'echo "hola $n"'
    echo "done"
    echo "---------------------"
    echo "for n in  {1..10} (para el salto -step- sería {1..10..3})"
    echo "do"
    echo 'echo "num $n"'
    echo "done"
    echo "---------------------"
    echo "for ((x=1; x<=10; x++)"
    echo "do"
    echo 'echo "iter $x"'
    echo "done"
    echo "---------------------"
    echo "for f in /home/user/Desktop/*"
    echo "do"
    echo 'echo "$f"'
    echo "done"
    echo "---------------------"
    echo "for x in /home/user/Desktop/*"
    echo "do"
    echo 'if ["$x" =~ .*.txt.*]; then'
    echo 'echo "$x"'
    echo "fi"
    echo "done"
    
}

function upgrade(){
    t="$(pwd)"
    cd $scripts
    sudo bash upgrade.sh
    cd $t
}

function cierre_bmv(){
    t="$(pwd)"
    cd /home/$user/Desktop/.BMV/
    python3 main.py
    bash push.sh
    cd $t
}

function usb_remotly(){
    t="$(pwd)"
    cd /home/$user/Desktop/.scripts
    bash usb_remotly.sh
    cd $t
}

function work-sites(){
    t="$(pwd)"
    cd /home/$user/Desktop/.scripts/
    bash work-sites.sh
    cd $t
}

#function help-git(){}

#iniciar neofetch
neofetch

cd /home/$user/Desktop

#iniciar  el tema de oh-my-posh
#set theme bash tutorial: https://calebschoepp.com/blog/2021/how-to-setup-oh-my-posh-on-ubuntu/
# path posh themes: /home/dix/.poshthemes
#eval "$(oh-my-posh init bash)"
#config bash https://ohmyposh.dev/docs/installation/customize

#eval "$(oh-my-posh init bash --config ~/.poshthemes/huvix.omp.json)" && ls
#eval "$(oh-my-posh init bash --config ~/.poshthemes/json.omp.json)" && ls
#caracteres https://github.com/olorunfemidavis/Font-Awesome-Cheat-Charp
eval "$(oh-my-posh init bash --config ~/.poshthemes/marcduiker.omp.json)" 
#eval "$(oh-my-posh init bash --config ~/.poshthemes/probua.minimal.omp.json)" && ls
#eval "$(oh-my-posh init bash --config ~/.poshthemes/spaceship.omp.json)" && ls
#eval "$(oh-my-posh init bash --config ~/.poshthemes/star.omp.json)" && ls
#eval "$(oh-my-posh init bash --config ~/.poshthemes/the-unnamed.omp.json)" && ls
#eval "$(oh-my-posh init bash --config ~/.poshthemes/tiwahu.omp.json)" && ls

#eval "$(oh-my-posh init bash --config ~/.poshthemes/night-owl.omp.json)" && ls
#eval "$(oh-my-posh init bash --config ~/.poshthemes/thecyberden.omp.json)" && ls

#inicio de fish para autocompletar palabras
#fish
