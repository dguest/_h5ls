# completion function for hdf 'h5ls'
_h5ls()
{
    local cur prev opts WORDS end
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="-h --help -d --data -r --recursive -S --simple"

    local TAIL_WD=$(( ${#COMP_WORDS[@]} - ${COMP_CWORD} - 1 ))
    if [[ $TAIL_WD > 0 ]]
    then
        local DO_OPTS=1
    elif [[ ${cur} == -* && $TAIL_WD == 0 ]]
    then
        local DO_OPTS=1
    fi


    if [[ ${DO_OPTS} ]]
    then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi

    # if we're pointing at an HDF5 file, the command we run depends on
    # whether we've already descended into it.
    #
    # This first case is just pointing at it: it just appends a slash
    # if one doesn't exist.
    #
    # The second assumes we've descended into the file. In that case
    # we have to strip off the last part of the path to feed it to
    # h5ls to get all possible matches.
    #
    local cmd=""
    local cmp
    local base
    if h5ls ${cur%/} >& /dev/null ; then
        cmp=${cur%/}/
        cmd="h5ls ${cmp}"
        base=${cur%/}
    elif h5ls ${cur%/*} >& /dev/null; then
        cmp=${cur}
        cmd="h5ls ${cur%/*}/"
        base=${cur%/*}
    fi
    if [[ $cmd ]]; then
        local WORDS=""
        for end in $(eval $cmd | awk '$2 == "Group" {print $1}' )
        do
            WORDS+=${base}/${end}/" "
        done
        for end in $(eval $cmd | awk '$2 == "Dataset" {print $1}' )
        do
            WORDS+=${base}/${end}" "
        done

        cmd="compgen -W \"${WORDS}\" -- $cmp"
        COMPREPLY=( $(eval $cmd) )
        return 0
    else
        COMPREPLY=( $(compgen -o plusdirs -f -- ${cur}) )
        return 0
    fi
}
complete -o filenames -o nospace -F _h5ls h5ls
