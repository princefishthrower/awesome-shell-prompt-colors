# awesome-shell-prompt-colors

In this repository you'll find customizable bash and zsh scripts that can make your shell prompt look like this:

![A preview of what these scripts can do!](./src/img/preview.png)

Currently this repository contains only bash and zsh implementations, though more are welcome. The scripts are in `/src`.

For the impatient, I've copy-and-pasted what you'll find in `src/`:

# For bash

```bash
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

# Set the special bash variable PROMPT_COMMAND to our custom function
PROMPT_COMMAND=buildColorPrompt;
```

## Colors in bash implementation

The bash implementation is limited to a handful of colors: `black`, `white`, `red`, `green`, `yellow`, `blue`, `magenta`, `cyan`, `light gray`, `light red`, `light green`, `light yellow`, `light blue`, `light magenta`, and `light cyan`.

# For zsh

```bash
function buildColorPrompt() {
    
    # I always like showing what directory I am in
    directory=$(pwd)

    # Modify these to whatever you'd like!
    PROMPT_TEXT="youruser@yourmachine [$directory]"

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
}

# set the precmd() hook to our custom function
precmd() {
   buildColorPrompt;
}

```

The zsh implementation allows for it's full range of 256 supported colors. Other than that there are only a few tweaks from the bash implementation (for example array indexes in zsh start at 1. 🙄)

## Colors in zsh implementation

Here are some examples of various color schemes. All colors are referred to simply as an integer between 0 and 255, separated by commas:

```bash
# Rainbow (The color scheme used in example screenshot above!)
PROMPT_COLORS="196,214,220,82,75,93"

# Vaporwave (magenta / cyan shades)
PROMPT_COLORS="27,63,99,135,171,207"

# Sunset (orange / pink)
PROMPT_COLORS="214,215,216,202,203,204,205,206,207,217,218,219"

# Rasta green-red-yellow
PROMPT_COLORS="9,10,11"
```

For the full list of all 256 colors, check out https://jonasjacek.github.io/colors/

# Questions, Comments, Bugs, Features?

Feel free to create an issue for anything. I also gladly welcome pull requests or feature requests.