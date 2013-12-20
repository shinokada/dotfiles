# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/bin:/usr/sbin:/sbin:/usr/bin:/usr/X11/bin:/usr/local/sbin

############
# Ruby rbenv
############

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# required for https://github.com/imathis/octopress/issues/144
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8


##########
# Vagrant
# VirtualBox
##########

#export PATH="$PATH:/Applications/VirtualBox.app/Contents/MacOS"
#export PATH="$PATH:/usr/bin"


#############
# MYSQL
#############

#export MYSQL_HOME=/usr/local/mysql
#export PATH="/usr/local/mysql/bin:$PATH"

export PATH=~/bin:/usr/local/mysql/bin:$PATH

#alias mmysql='/Applications/MAMP/Library/bin/mysql'
alias start_mysql='sudo /usr/local/mysql/support-files/mysql.server start'
alias stop_mysql='sudo /usr/local/mysql/support-files/mysql.server stop'
#alias restart_mysql ='sudo /usr/local/mysql/support-files/mysql.server restart'

############
# GIT
############
export PATH="/usr/local/git/bin:/usr/local/bin:$PATH"


###########
# Selenium
###########

alias selenium='java -jar /usr/local/bin/selenium-server-standalone-2.25.0.jar'

############
# Node
############
# NVM
export NVM_HOME="$HOME/.nvm"
if [ -f "$NVM_HOME/nvm.sh" ]; then
source "$NVM_HOME/nvm.sh"
fi

# NVM Tab completion (not working)
if [ -f "NVM_HOME/bash_completion" ]; then
source "NVM_HOME/bash_completion"
fi


# NPM Tab Completion
if npm -v >/dev/null 2>&1; then 
. <(npm completion)
fi


#############
# Virtual environment code
# https://github.com/croach/nodejs-step-by-step/blob/master/02-02.md
##############

# Checks that the child directory is a subdirectory of the parent
is_subdirectory() {
    local child="$1"
    local parent="$2"
    if [[ "${child##${parent}}" != "$child" ]]; then
        return 0
    else
        return 1
    fi
}

# Activates a new environment
activate_env() {
    # Check if the directory we've cd'ed into is a node environment directory
    # (i.e., it contains a node_modules folder) and that a node envrionment
    # does not already exist before creating a new one.
    if [ -d "node_modules" ] && [ -z "$_ENV_DIR" ]; then

        # Save the old PATH variable so we can revert back to it when we leave
        # the environment
        export _OLD_PATH="$PATH"

        # An environment is essentially nothing more than an environment
        # variable (_ENV_DIR) pointing the parent directory of our node
        # environment. Create the variable and point it to $PWD.
        export _ENV_DIR="$pwd"

        # Add the bin folder for all local NPM installs to the PATH
        export PATH="$(npm bin):$PATH"

        # If an activation script exists, execute it
        if [ -e ".activate" ]; then
            source .activate
        fi
    fi
}

# Deactivates the current envrionment
deactivate_env() {
    # Make sure that an envrionment does exist and that the new
    # directory is not a subdirectory of the envrionment directory
    if [ -n "$_ENV_DIR" ] && ! is_subdirectory "$pwd" "$_ENV_DIR"; then

        # Run the deactivation script if it exists
        if [[ -e "$_ENV_DIR/.deactivate" ]]; then
            source "$_ENV_DIR/.deactivate"
        fi

        # Revert back to the original PATH
        export PATH="$_OLD_PATH"

        # Destroy the environment
        unset _ENV_DIR
        unset _OLD_PATH
    fi
}

env_cd() {
    builtin cd "$@" && deactivate_env && activate_env
}

alias cd="env_cd"

###### end of virtual environment code

##########
# start an HTTP server from a directory, optionally specifying the port
# cd to/dir/where/index.html and server
# will open in the default browser
##########

function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    python -m SimpleHTTPServer "$port"
}

##########
# disable autocorrect 
##########
unsetopt correct_all


##########
# atlas will open three websites 
##########

function atlas(){
    open -a Google\ Chrome.app https://sites.google.com/a/canacad.ac.jp/teaching-and-learning-systems/the-myp-ca/MYP-unit-planning\#TOC-MYP-Planner-Stage-2 http://canacad.rubiconatlas.org/Atlas/Develop/View/Default https://docs.google.com/a/canacad.ac.jp/document/d/1kKvKw2YL4Kjkr3juEXsLXaLuTHJxAylr3XETPL1kGOM/edit
}


###########
# ALIASES
# From Linux-101-Hacks.pdf
# also alias is lodaed from oh-my zsh pluings above plugins=(git)
###########

alias cd1="cd .." 
alias cd2="cd ../.." 
alias cd3="cd ../../.." 
alias cd4="cd ../../../.." 
alias cd5="cd ../../../../.." 

function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; } 


#####
# for postgreSQL
#####
export PGHOST=localhost


#####
# for phpunit in laravel
#####
alias t='php artisan test'


####
# Create a directory and change into it at the same time
####
function mkdcd () {
    mkdir "$1" && cd "$1"
}

####
# yeoman
#####
export PATH=$PATH:/usr/local/share/npm/bin


export PATH=$PATH:/opt/local/bin


######
# Packer 
#########

export PATH="$PATH:/usr/local/packer"

########
# zsh-users / zsh-syntax-highlighting
#########

source /Users/teacher/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

########
# Bazaar
#########

export PYTHONPATH=/usr/local/lib/python2.7/site-packages

########
# autojump
########
[[ -s /etc/profile.d/autojump.zsh ]] && . /etc/profile.d/autojump.zsh

autoload -U compinit && compinit
