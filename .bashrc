# .bashrc
# vim:foldmethod=marker

if [ "$PS1" ]; then
    # Escape Sequences {{{
        function escape_sequence_256color { #{{{
            SEQ=''
            while getopts ":BUNf:b:" opt; do
                case $opt in
                    N ) SEQ="${SEQ}\033[0m" ;;              #NORMAL
                    B ) SEQ="${SEQ}\033[1m" ;;              #BOLD
                    U ) SEQ="${SEQ}\033[4m" ;;              #UNDERLINE
                    f ) SEQ="${SEQ}\033[38;5;${OPTARG}m" ;; #FOREGROUND
                    b ) SEQ="${SEQ}\033[48;5;${OPTARG}m" ;; #BACKGROUND
                esac
            done
            echo $SEQ
        } #}}}
        function escape_sequence_16color { #{{{
            SEQ='\033['
            while getopts ":BUNf:b:" opt; do
                case $opt in
                    N ) SEQ="${SEQ}0;" ;;          #NORMAL
                    B ) SEQ="${SEQ}1;" ;;          #BOLD
                    U ) SEQ="${SEQ}4;" ;;          #UNDERLINE
                    f ) SEQ="${SEQ}3${OPTARG};" ;; #FOREGROUND
                    b ) SEQ="${SEQ}4${OPTARG};" ;; #BACKGROUND
                esac
            done
            SEQ="${SEQ}m"
            SEQ="${SEQ/;m/m}"
            echo $SEQ
        } #}}}
        function escape_sequence { #{{{
            if [[ "$TERM" =~ -256color(-.*)? ]]; then
                escape_sequence_256color "$@"
            else
                escape_sequence_16color "$@"
            fi
        } #}}}
    #}}}

    # Prompt String {{{
        function set_pr_addon { #{{{
            local _PR_ADD_ON=""
            local GIT_BRANCH=$(git branch --no-color 2> /dev/null | egrep "^\*" | cut -c3-)
            if [ -n "$GIT_BRANCH" ]; then
                local GIT_ORIGIN=$(basename $(git remote show -n origin | egrep 'Fetch URL' | cut -c14- | sed -e '/.*:/s///') .git)
                local GIT_TRACK=$(git rev-parse --revs-only --symbolic-full-name @{u} 2> /dev/null | grep -v '@{u}')
                CR0=$(escape_sequence -N)
                CR1=$(escape_sequence -f $1)
                CR2=$(escape_sequence -B -f $2)
                CR3=$(escape_sequence -N -f $2)
                if [ -n "$GIT_TRACK" ]; then
                    GIT_REMOTE="${GIT_TRACK##refs/remotes/}"
                    GIT_TRACK="${CR1}::${CR3}${GIT_REMOTE%/*}/${CR2}${GIT_REMOTE##*/}"
                fi
                _PR_ADD_ON="${_PR_ADD_ON}${CR1}Git${CR0}[${CR2}${GIT_ORIGIN}${CR0}][${CR2}${GIT_BRANCH}${GIT_TRACK}${CR0}] "
            fi
            export PR_ADD_ON="$_PR_ADD_ON"
        } #}}}
        function set_prompt { #{{{
            # current date
            local PS1_DATE='\D{%F %T}'
            if [ $BASH_VERSINFO -lt 3 ]; then
                PS1_DATE='$PS1_DATE'
                export PROMPT_COMMAND='PS1_DATE=$(date +"%F %T");'$PROMPT_COMMAND
            fi

            # escapes and character codes
            local E_PRE='\033[' E_SUF='m' E_NL='\012'

            # color codes
            local CC_BLACK_16=0 CC_RED_16=1 CC_GREEN_16=2 CC_YELLOW_16=3 CC_BLUE_16=4 CC_MAGENTA_16=5 CC_CYAN_16=6 CC_GRAY_16=7
            local CC_GRAY_D_18=$CC_BLACK_16 CC_GRAY_L_16=$CC_GRAY_16 CC_WHITE_16=$CC_GRAY_16 CC_PINK_16=$CC_MAGENTA_16 CC_VIOLET_16=$CC_MAGENTA_16 CC_ORANGE_16=$CC_YELLOW_16
            local CC_GRASS_16=$CC_GREEN_16 CC_GRASS_S_16=$CC_GREEN_16

            local CC_BLACK_256=0 CC_RED_256=124 CC_GREEN_256=64 CC_YELLOW_256=136 CC_BLUE_256=63 CC_MAGENTA_256=125 CC_CYAN_256=37 CC_GRAY_256=250
            local CC_GRAY_D_256=244 CC_GRAY_L_256=255 CC_WHITE_256=15 CC_PINK_256=213 CC_VIOLET_256=55 CC_ORANGE_256=130
            local CC_GRASS_256=58 CC_GRASS_S_256=22

            if [[ "$TERM" =~ -256color(-.*)? ]]; then
                local CC_COLORS=256
            else
                local CC_COLORS=16
            fi

            # choose colors for $PR_HOST
            local PROMPT_COLORS_ENV_FILE="$HOME/.env/.prompt_colors.host..${HOSTNAME}"
            local CV_USER_FG=BLACK
            local CV_USER_BG=GRAY_L
            local CV_HOST_FG=BLACK
            local CV_HOST_BG=GRAY
            if [ -f "$PROMPT_COLORS_ENV_FILE" ]; then
                . "$PROMPT_COLORS_ENV_FILE"
            fi
            if $( echo "$CV_HOST_FG" | grep -q '[^[:digit:]]' ); then eval "CV_HOST_FG=\$CC_$( echo "${CV_HOST_FG}" | tr '[:lower:]' '[:upper:]' )_${CC_COLORS}"; fi
            if $( echo "$CV_HOST_BG" | grep -q '[^[:digit:]]' ); then eval "CV_HOST_BG=\$CC_$( echo "${CV_HOST_BG}" | tr '[:lower:]' '[:upper:]' )_${CC_COLORS}"; fi
            if $( echo "$CV_USER_FG" | grep -q '[^[:digit:]]' ); then eval "CV_USER_FG=\$CC_$( echo "${CV_USER_FG}" | tr '[:lower:]' '[:upper:]' )_${CC_COLORS}"; fi
            if $( echo "$CV_USER_BG" | grep -q '[^[:digit:]]' ); then eval "CV_USER_BG=\$CC_$( echo "${CV_USER_BG}" | tr '[:lower:]' '[:upper:]' )_${CC_COLORS}"; fi
            eval "local CV_PATH_FG=\$CC_ORANGE_${CC_COLORS}"
            eval "local CV_DATE_FG=\$CC_GRAY_${CC_COLORS}"
            eval "local CV_NUMBER_FG=\$CC_YELLOW_${CC_COLORS}"
            eval "local CV_GIT_FG1=\$CC_GRAY_D_${CC_COLORS}"
            eval "local CV_GIT_FG2=\$CC_GRASS_${CC_COLORS}"

            # partial prompts
            local PR_USER="$( escape_sequence -N -f $CV_USER_FG -b $CV_USER_BG )\\u$( escape_sequence -N )@"
            local PR_HOST="$( escape_sequence -N -f $CV_HOST_FG -b $CV_HOST_BG )\\h$( escape_sequence -N )"
            local PR_PATH="$( escape_sequence -f $CV_PATH_FG )\\w$( escape_sequence -N )"
            local PR_DATE="$( escape_sequence -f $CV_DATE_FG )$PS1_DATE$( escape_sequence -N )"
            local PR_NUMBER="$( escape_sequence -f $CV_NUMBER_FG )#\\#$( escape_sequence -N )"
            local PR_DOLLAR="$E_NL\$ "

            # set prompt
            export PS1=${PR_USER}${PR_HOST}' '$PR_PATH' '"\$(echo -ne \"\$PR_ADD_ON\")"$PR_DATE' '$PR_NUMBER' '$PR_DOLLAR
            case "$TERM" in
                xterm*  )    export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; set_pr_addon '$CV_GIT_FG1' '$CV_GIT_FG2'; echo -ne "\007"' ;;
                screen* )    export PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; set_pr_addon '$CV_GIT_FG1' '$CV_GIT_FG2'; echo -ne "\033\\"' ;;
                *       )    ;;
            esac
        } #}}}
    #}}}

    # bash environments
        export BASH_ENV=$HOME/.bashrc

    # prompt
        set_prompt

    # check the terminal size when bash regains control
        shopt -s checkwinsize

    # enable history appending instead of overwriting
        shopt -s histappend

    # User configuration
        source $HOME/._shrc "$BASH_SOURCE"
fi

