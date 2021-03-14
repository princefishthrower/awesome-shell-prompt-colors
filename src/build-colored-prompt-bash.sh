# USAGE
#
# In your .bash_profile, copy and paste this function in, then set it as your PROMPT_COMMAND
#
# PROMPT_COMMAND=buildColorPrompt;
#
function buildColorPrompt() {
    
    # I always like showing what directory I am in (special character "\w" in PS1) - store the equivalent in this 'directory' variable
    directory=$(pwd)

    # Modify these to whatever you'd like!
    PROMPT_TEXT="awesome-shell-prompt-colors@awesome-machine [$directory] "

    # Colors seperated by comma - acceptable values are: 
    # black, white, red, green, yellow, blue, magenta, cyan, light gray, light red, light green, light yellow, light blue, light magenta, light cyan 
    PROMPT_COLORS="red,white,blue"

    # Colors! 
    BLACK="\e[30m"
    WHITE="\e[97m"
    RED="\e[31m"
    GREEN="\e[32m"
    YELLOW="\e[33m"
    BLUE="\e[34m"
    MAGENTA="\e[35m"
    CYAN="\e[36m"
    LIGHT_GRAY="\e[37m"
    DARK_GRAY="\e[90m"
    LIGHT_RED="\e[91m"
    LIGHT_GREEN="\e[92m"
    LIGHT_YELLOW="\e[93m"
    LIGHT_BLUE="\e[94m"
    LIGHT_MAGENTA="\e[95m"
    LIGHT_CYAN="\e[96m"

    # End formatting string
    END_FORMATTING="\[\e[0m\]"
    
    # split PROMPT_COLORS into array
    count=0
    IFS=','
    for x in $PROMPT_COLORS
    do
        colors_array[$count]=$x
        ((count=count+1))
    done
    unset IFS

    # break PROMPT_TEXT into character array
    letters=()
    for (( i=0 ; i < ${#PROMPT_TEXT} ; i++ )) {
        letters[$i]=${PROMPT_TEXT:$i:1}
    }

    # build prompt with colors
    color_index=0
    ps1='\['
    for (( i=0 ; i < ${#letters[@]} ; i++ )) {
        # Determine color in this giant case statement
        color="${colors_array[color_index]}"
        case $color in
            "black")
                COLOR=$BLACK
                ;;
            "red")
                COLOR=$RED
                ;;
            "green")
                COLOR=$GREEN
                ;;
            "yellow")
                COLOR=$YELLOW
                ;;
            "blue")
                COLOR=$BLUE
                ;;
            "magenta")
                COLOR=$MAGENTA
                ;;
            "cyan")
                COLOR=$CYAN
                ;;
            "light gray")
                COLOR=$LIGHT_GRAY
                ;;
            "dark gray")
                COLOR=$DARK_GRAY
                ;;
            "light red")
                COLOR=$LIGHT_RED
                ;;
            "light green")
                COLOR=$LIGHT_GREEN
                ;;
            "light yellow")
                COLOR=$LIGHT_YELLOW
                ;; 
            "light blue")
                COLOR=$LIGHT_BLUE
                ;;
            "light magenta")
                COLOR=$LIGHT_MAGENTA
                ;;
            "light cyan")
                COLOR=$LIGHT_CYAN
                ;;
            "white")
                COLOR=$WHITE
                ;;
            *)
                COLOR=$WHITE
                ;;
        esac 

        # add to ps1 var - color, then letter, then the end formatter
        ps1+=$COLOR"${letters[$i]}"

        # reset color index if we are at the end of the color array, otherwise increment it
        if (( $color_index == ${#colors_array[@]} - 1 ))
        then
            color_index=0
        else
            ((color_index=color_index+1))
        fi
    }
    ps1+="$END_FORMATTING\]"

    # Finally: set the PS1 variable
    PS1=$ps1
}