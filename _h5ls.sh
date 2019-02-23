# bash completion function for hdf 'h5ls'
_h5ls()
{
    local cur prev opts WORDS end
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="-h --help -d --data -r --recursive -S --simple"

    local TAIL_WD=$(( ${#COMP_WORDS[@]} - ${COMP_CWORD} - 1 ))
    if [[ $TAIL_WD > 0 ]]; then
        local DO_OPTS=1
    elif [[ ${cur} == -* && $TAIL_WD == 0 ]]; then
        local DO_OPTS=1
    fi


    if [[ ${DO_OPTS} ]]; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    elif [[ $cur == *.h5/* && ! -d ${cur%.h5/*}.h5 ]] || \
         [[ $cur == *.hdf5/* && ! -d ${cur%.hdf5/*}.hdf5 ]] || \
         [[ $cur == *.hd5/* && ! -d ${cur%.hdf5/*}.hd5 ]]; then
        WORDS=""
        local cmd="h5ls ${cur%/*}/"
        for end in $(eval $cmd | awk '$2 == "Group" {print $1}' )
        do
            WORDS+=${cur%/*}/${end}/" "
        done
        for end in $(eval $cmd | awk '$2 == "Dataset" {print $1}' )
        do
            WORDS+=${cur%/*}/${end}" "
        done

        cmd="compgen -W \"${WORDS}\" -- $cur"
        COMPREPLY=( $(eval $cmd) )
    else
        COMPREPLY=( $(compgen -o plusdirs -f -X "!*.h*5" -- ${cur}) )
    fi
    return 0
}
complete -o filenames -o nospace -F _h5ls h5ls
