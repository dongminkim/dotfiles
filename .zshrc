# .zshrc
# vim:foldmethod=marker

#zmodload zsh/zprof
#ZSH_DISABLE_COMPFIX="true"

# Basic 
export ZSH=$HOME/.oh-my-zsh
DEFAULT_USER="$USER"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Powerlevel10k theme {{{
    ZSH_THEME="powerlevel10k/powerlevel10k"
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
#}}}

# https://github.com/zsh-users/zsh-syntax-highlighting
# https://github.com/dongminkim/kk
plugins=(zsh-syntax-highlighting kk)

# User configuration {{{
    source $ZSH/oh-my-zsh.sh
    unsetopt autopushd
    source $HOME/._shrc "${(%):-%N}"
#}}}

alias l='\kk'
alias ll='\kk -A'
alias la='\kk -a'

# https://github.com/junegunn/fzf {{{
    export FZF_COMPLETION_TRIGGER=''
    bindkey '^T' fzf-completion
    bindkey '^I' $fzf_default_completion
#}}}

# https://github.com/changyuheng/zsh-interactive-cd {{{
    __zic_fzf_prog() {
        [ -n "$TMUX_PANE" ] && [ "${FZF_TMUX:-0}" != 0 ] && [ ${LINES:-40} -gt 15 ] \
            && echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
    }

    __zic_matched_subdir_list() {
        local dir length seg starts_with_dir
        if [[ "$1" == */ ]]; then
            dir="$1"
            if [[ "$dir" != / ]]; then
                dir="${dir: : -1}"
            fi
            length=$(echo -n "$dir" | wc -c)
            if [ "$dir" = "/" ]; then
                length=0
            fi
            find -L "$dir" -mindepth 1 -maxdepth 1 -type d 2>/dev/null \
                | cut -b $(( ${length} + 2 ))- | sed '/^$/d' | while read -r line; do
                if [[ "${line[1]}" == "." ]]; then
                    continue
                fi
                echo "$line"
            done
        else
            dir=$(dirname -- "$1")
            length=$(echo -n "$dir" | wc -c)
            if [ "$dir" = "/" ]; then
                length=0
            fi
            seg=$(basename -- "$1")
            starts_with_dir=$( \
                find -L "$dir" -mindepth 1 -maxdepth 1 -type d \
                2>/dev/null | cut -b $(( ${length} + 2 ))- | sed '/^$/d' \
                | while read -r line; do
                    if [[ "${seg[1]}" != "." && "${line[1]}" == "." ]]; then
                        continue
                    fi
                    if [[ "$line" == "$seg"* ]]; then
                        echo "$line"
                    fi
                done)
            if [ -n "$starts_with_dir" ]; then
                echo "$starts_with_dir"
            else
                find -L "$dir" -mindepth 1 -maxdepth 1 -type d \
                    2>/dev/null | cut -b $(( ${length} + 2 ))- | sed '/^$/d' \
                    | while read -r line; do
                    if [[ "${seg[1]}" != "." && "${line[1]}" == "." ]]; then
                        continue
                    fi
                    if [[ "$line" == *"$seg"* ]]; then
                        echo "$line"
                    fi
                done
            fi
        fi
    }

    _zic_list_generator() {
        __zic_matched_subdir_list "${(Q)@[-1]}" | sort
    }

    _zic_complete() {
        setopt localoptions nonomatch
        local l matches fzf tokens base

        l=$(_zic_list_generator $@)

        if [ -z "$l" ]; then
            zle ${__zic_default_completion:-expand-or-complete}
            return
        fi

        fzf=$(__zic_fzf_prog)

        if [ $(echo $l | wc -l) -eq 1 ]; then
            matches=${(q)l}
        else
            matches=$(echo $l \
                | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} \
                --reverse $FZF_DEFAULT_OPTS $FZF_COMPLETION_OPTS \
                --bind 'shift-tab:up,tab:down'" ${=fzf} \
                | while read -r item; do
                echo -n "${(q)item} "
            done)
        fi

        matches=${matches% }
        if [ -n "$matches" ]; then
            tokens=(${(z)LBUFFER})
            base="${(Q)@[-1]}"
            if [[ "$base" != */ ]]; then
                if [[ "$base" == */* ]]; then
                    base="$(dirname -- "$base")"
                    if [[ ${base[-1]} != / ]]; then
                        base="$base/"
                    fi
                else
                    base=""
                fi
            fi
            LBUFFER="${tokens[1]} "
            if [ -n "$base" ]; then
                base="${(q)base}"
                if [ "${tokens[2][1]}" = "~" ]; then
                    base="${base/#$HOME/~}"
                fi
                LBUFFER="${LBUFFER}${base}"
            fi
            LBUFFER="${LBUFFER}${matches}/"
        fi
        zle redisplay
        typeset -f zle-line-init >/dev/null && zle zle-line-init
    }

    zic-completion() {
        setopt localoptions noshwordsplit noksh_arrays noposixbuiltins
        local tokens cmd

        tokens=(${(z)LBUFFER})
        cmd=${tokens[1]}

        if [[ "$LBUFFER" =~ "^\ *cd$" ]]; then
            zle ${__zic_default_completion:-expand-or-complete}
        elif [ "$cmd" = cd ] || [ "$cmd" = pushd ]; then
            _zic_complete ${tokens[2,${#tokens}]/#\~/$HOME}
        else
            zle ${__zic_default_completion:-expand-or-complete}
        fi
    }

    [ -z "$__zic_default_completion" ] && {
        binding=$(bindkey '^I')
        # $binding[(s: :w)2]
        # The command substitution and following word splitting to determine the
        # default zle widget for ^I formerly only works if the IFS parameter contains
        # a space via $binding[(w)2]. Now it specifically splits at spaces, regardless
        # of IFS.
        [[ $binding =~ 'undefined-key' ]] || __zic_default_completion=$binding[(s: :w)2]
        unset binding
    }

    zle -N zic-completion
    bindkey '^I' zic-completion
#}}}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
