
# .zshrc 性能分析
zmodload zsh/datetime
setopt PROMPT_SUBST
PS4='+$EPOCHREALTIME %N:%i> '

logfile=$(mktemp zsh_profile.7Pw1Ny0G)
echo "Logging to $logfile"
exec 3>&2 2>$logfile

setopt XTRACE
# .zshrc 性能分析

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Path to your oh-my-zsh installation.

export ZSH=/Users/henry/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(autojump colored-man-pages extract git gitfast kubectl sublime web-search zsh-autosuggestions zsh-syntax-highlighting)

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME//.rvm/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/bin:$HOME/.npm-global/bin:$HOME/.composer/vendor/bin:$HOME/.symfony/bin:/snap/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# >  History config
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

unset GEM_HOME
#[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
. /usr/share/autojump/autojump.sh

# export DYLD_LIBRARY_PATH=/usr/local/opt/mysql/lib:$DYLD_LIBRARY_PATH
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"

#ENV parameters for golang
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GOROOT=/usr/local/go
# export GOROOT=/usr/local/Cellar/go/1.14.1/libexec
export GO111MODULE=auto
export GOPROXY=direct
export GOPROXY=https://goproxy.io
# export GOPRIVATE="*.garena.com"
export PATH=$GOBIN:$PATH:$GOROOT/bin
# export PATH=$PATH::~/.mix:/usr/local/share/dotnet:/usr/local/opt/postgresql@10/bin:$HOME/.cargo/bin

#Java ENV
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_171.jdk/Contents/Home
PATH=$PATH:$JAVA_HOME/bin

export MAVEN_HOME=/usr/local/apache-maven-3.6.3
export PATH=${MAVEN_HOME}/bin:$PATH

export GRADLE_HOME=/opt/gradle/gradle-6.4.1
export PATH=$PATH:${GRADLE_HOME}/bin

#Env configuration for anaconda
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/henry/anaconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/henry/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/henry/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/henry/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
export PATH="$HOME/anaconda3/bin:$PATH"

## flutter
export PATH="$PATH:/opt/flutter/bin"
export ENABLE_FLUTTER_DESKTOP=true
export FLUTTER_STORAGE_BASE_URL="https://mirrors.tuna.tsinghua.edu.cn/flutter"
export PUB_HOSTED_URL="https://mirrors.tuna.tsinghua.edu.cn/dart-pub"

export ANDROID_HOME="/home/henry/Android/Sdk"
export PATH=${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(thefuck --alias)"

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

_COLUMNS=$(tput cols)
_MESSAGE=" FBI Warining "
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")

echo " "
echo -e "${spaces}\033[41;37;5m FBI WARNING \033[0m"
echo " "
_COLUMNS=$(tput cols)
_MESSAGE="Ferderal Law provides severe civil and criminal penalties for"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${_MESSAGE}"

_COLUMNS=$(tput cols)
_MESSAGE="the unauthorized reproduction, distribution, or exhibition of"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${_MESSAGE}"

_COLUMNS=$(tput cols)
_MESSAGE="copyrighted motion pictures (Title 17, United States Code,"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${_MESSAGE}"

_COLUMNS=$(tput cols)
_MESSAGE="Sections 501 and 508). The Federal Bureau of Investigation"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${_MESSAGE}"

_COLUMNS=$(tput cols)
_MESSAGE="investigates allegations of criminal copyright infringement"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${_MESSAGE}"

_COLUMNS=$(tput cols)
_MESSAGE="(Title 17, United States Code, Section 506)."
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${_MESSAGE}"
echo " "

# Load zsh-syntax-highlighting.
source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Load zsh-autosuggestions.
source ~/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-git/prompt.sh
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

# Enable autosuggestions automatically.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

function homestead() {
    (cd ~/container/Homestead && vagrant $*)
}

export PATH="$HOME/go/tools:$PATH"
export MICRO_REGISTRY=consul
export PATH="$HOME/program/etcd-v3.4.9-linux-amd64:$PATH"

if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

sukka_lazyload_add_command() {
    eval "$1() { \
        unfunction $1 \
        _sukka_lazyload__command_$1 \
        $1 \$@ \
    }"
}

sukka_lazyload_add_completion() {
    local comp_
    eval "${comp_name}() { \
        compdef -d $1; \
        _sukka_lazyload_completion_$1; \
    }"
    compdef $comp_name $1
}

sukka_lazyload__command_pyenv() {

  eval "$(command pyenv init -)"
}
_sukka_lazyload__compfunc_pyenv() {

  source "$(brew --prefix pyenv)/completions/pyenv.zsh"
}

sukka_lazyload_add_command pyenv
sukka_lazyload_add_completion pyenv

_sukka_lazyload__command_fuck() {

  eval $(thefuck --alias)
}

sukka_lazyload_add_command fuck

_sukka_lazyload__completion_hexo() {

  eval $(hexo --completion=zsh)
}

sukka_lazyload_add_completion hexo

lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}


source ~/.zplug/init.zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh

zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
# Defers the loading of a package
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:3

zplug "woefe/wbase.zsh"

# Prohibit updates to a plugin by using the "frozen:" tag
zplug "k4rthik/git-cal", as:command, frozen:1
# Support oh-my-zsh plugins and the like
zplug "plugins/git",   from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "woefe/git-prompt.zsh", use:"{git-prompt.zsh,examples/wprompt.zsh}"
zplug "plugins/git-open",   from:oh-my-zsh
# Support checking out a specific branch/tag/commit of a plugin
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", at:4c23cb60

zplug "junegunn/fzf", use:"shell/*.zsh"
# Grab binaries from GitHub Releases
# and rename using the "rename-to:" tag
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*linux*amd64*"
zplug "sharkdp/fd", from:gh-r, as:command, rename-to:fd, use:"*x86_64-unknown-linux-gnu.tar.gz"

# Can manage a plugin as a command And accept glob patterns (e.g., brace, wildcard, ...)
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"
# Can manage everything e.g., other person´s zshrc
zplug "tcnksm/docker-alias", use:zshrc

zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
# Also supports prezto plugins
zplug "modules/osx", from:prezto, if:"[[ $OSTYPE == *darwin* ]]"
zplug "modules/prompt", from:prezto
# Set zstyle before zplug load
zstyle ´:prezto:module:prompt´ theme ´sorin´
zplug "themes/duellj", from:oh-my-zsh, as:theme
zplug "powerlevel9k/powerlevel9k", as:theme, depth:1
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/osx",   from:oh-my-zsh
zplug "plugins/vscode",   from:oh-my-zsh
zplug "plugins/z",   from:oh-my-zsh
zplug "plugins/d",   from:oh-my-zsh
zplug "plugins/extract",   from:oh-my-zsh

zplug "plugins/cp",   from:oh-my-zsh
zplug "plugins/web-search",   from:oh-my-zsh
zplug "plugins/rand-quote", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "voronkovich/gitignore.plugin.zsh"

# Run a command after a plugin is installed/updated
zplug "tj/n", hook-build:"make install"

# Install if "if:" tag returns true
zplug "hchbaw/opp.zsh", if:"(( ${ZSH_VERSION%%.*} < 5 ))"

# Can manage gist file just like other plugins
zplug "b4b4r07/79ee61f7c140c63d2786", \
   as:command, \
   from:gist, \
   use:get_last_pane_path.sh

# Support bitbucket
zplug "b4b4r07/hello_bitbucket", \
   as:command, \
   from:bitbucket, \
   hook-build:"chmod 755 *.sh", \
   use:"*.sh"

# Support Gitlab
zplug "willemmali-sh/chegit", \
   as:command, \
   from:gitlab

# Group dependencies, emoji-cli depends on jq in this example
zplug "stedolan/jq", \
   as:command, \
   from:gh-r \
   rename-to:jq, \
   on:"b4b4r07/emoji-cli"

# Can manage local plugins
zplug "~/.zsh", from:local

# Load theme file
#zplug "themes/robbyrussell", from:oh-my-zsh, as:theme
#zplug ´dracula/zsh´, as:theme

# > Key binds 键盘绑定
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey ';' autosuggest-accept

# > 主题 powerlevel9k
ZSH_THEME="powerlevel9k/powerlevel9k"
# > 配置主题
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=( os_icon ssh dir  dir_writable  newline  vcs  )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)

# Then, source plugins and add commands to $PATH
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# > zplug 安装
zplug load


# .zshrc 性能分析
unsetopt XTRACE
exec 2>&3 3>&-
# .zshrc 性能分析
