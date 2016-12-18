alias ssh='cat ~/repos/dotfiles/.ssh/config.d/* >~/.ssh/config; ssh'
alias update-repos='ln -s ~/Documents/Repos/* ~/repos/'

alias vi='vim'
alias date='date +"%c"'

# ls
alias lt='ls -lt | head'
alias ll='ls -lah --color'
alias lf='ls -F --color'
alias l='ls -la --color'
alias lsd='ls -d */'
alias lm='ls -al | more'

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias back='cd $OLDPWD'

# history
alias h='history'
alias hm='history | more'

# grep
alias gi='grep -i'
alias htmlout='grep -oP "(?<=>)[^<>]*(?=<\/?)"'

# find
alias ff='find / -type f -name'
alias f.='find . -type f -name'
alias loc='find . -name \*!*\* -print'

# sed
alias dos2unix="sed -i 's/\r//'"
alias unix2dos="sed -i 's/\n/\n\r/'"
alias t2c="sed -i 's/\t/,/g'"

#ip
geoip() { curl http://freegeoip.net/csv/$1 ;}

# nfo
mynfo()
{
  if [ "$1" == "list" ]
  then
    ls $2 ~/repos/nfo/ 
    return 1
  fi

  if [ -e ~/repos/nfo/$1 ]
  then
    cat ~/repos/nfo/$1
  else
    echo "nothing found"
  fi
}
alias nfo=mynfo

# mount samsung
alias samsung='sudo jmtpfs -o allow_other /mnt/samsung/'

