# USAGE
#
# In your .zprofile, copy and paste this function in, then add it to your precmd hook like so:
# precmd() {
#    buildColorPrompt;
# }
#
function buildColorPrompt() {
    
    # I always like showing what directory I am in - store that value in this 'directory' variable
    directory=$(pwd)

    # Modify these to whatever you'd like!
    PROMPT_TEXT="awesome-shell-prompt-colors@awesome-machine [$directory]"

    # Comma seperated colors - as many or as few as you'd like
    PROMPT_COLORS="15"

    # This will be the color of everything in the input part of the prompt (here set to 15 = white)
    PROMPT_INPUT_COLOR="15"
    
    # split PROMPT_COLORS into array
    colors_array=("${(@s/,/)PROMPT_COLORS}") # @ modifier

    # break PROMPT_TEXT into character array
    letters=()
    for (( i=1 ; i < ${#PROMPT_TEXT}+1 ; i++ )) {
        letters[$i]=${PROMPT_TEXT:$i-1:1}
    }

    # build prompt with colors
    color_index=1
    ps1=""
    for (( i=1 ; i < ${#letters[@]}+1 ; i++ )) {
        # Determine color in this giant case statement
        color="${colors_array[color_index]}"

        # add to ps1 var - color, then letter, then the end formatter
        ps1+="%F{$color}${letters[$i]}"

        # reset color index if we are at the end of the color array, otherwise increment it
        if (( $color_index == ${#colors_array[@]} ))
        then
            color_index=1
        else
            ((color_index=color_index+1))
        fi
    }

    # end color formating
    ps1+="%F{$PROMPT_INPUT_COLOR} %# "

    # Finally: set the PROMPT variable
    PROMPT=$ps1
    # echo $ps1
}