#!/usr/bin/env bash

# ==============================================================================
# PROJECT: RPM-OSTree Manager
# AUTHOR: Diogo Pessoa (https://github.com/diogopessoa/rpm-ostree-manager/)
# VERSION: 0.1.2
# ==============================================================================

# --- Terminal Check (Force open in Ptyxis if launched from Menu) ---
if [[ ! -t 0 ]]; then
    if command -v ptyxis &> /dev/null; then
        ptyxis -- bash -c "$0; echo; echo 'Press any key to exit...'; read -n1"
    else
        gnome-terminal -- bash -c "$0; echo; echo 'Press any key to exit...'; read -n1"
    fi
    exit
fi

# --- Settings and Colors ---
REAL_USER=${SUDO_USER:-$USER}
USER_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)
DOWNLOADS_DIR="$USER_HOME/Downloads"
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

# --- Helper Function: Get Input with ESC Support ---
get_input() {
    local prompt=$1
    echo -ne "$prompt"
    
    # Reads only 1 character silently
    read -rsn1 key
    
    # Se for ESC (\e ou \033)
    if [[ "$key" == $'\e' ]]; then
        echo "" 
        return 1
    fi

    # If it's not ESC, it reads the rest of what was typed
    read -r rest
    echo "$key$rest"
    return 0
}

show_menu() {
    clear
    echo -e "${BLUE}╭────────────────────────────────────╮${NC}"
    echo -e "${GREEN}          ${BOLD}RPM-OSTree Manager${NC}"
    echo -e "${BLUE}╰────────────────────────────────────╯${NC}\n"
    echo -e "Welcome!"
    echo -e "\nChoose an option:"
    echo -e "1) ${BLUE}Install${NC} Local RPM (Downloads)"
    echo -e "2) ${RED}Remove${NC} Layered/Local RPM"
    echo -e "3) ${GREEN}Rollback:${NC} revert the system"
    echo -e "4) Check Status"
    echo -e "0) Exit (or press ESC)"
    echo -e "\n${NC}──────────────────────────────────────"
    echo -ne "  ${BLUE}ESC${NC} = Return/Exit    ${BLUE}ENTER${NC} = Confirm\n\nOption: "
}

install_rpm() {
    echo -e "\n--- ${BLUE}Install Local RPM${NC} ---"
    cd "$DOWNLOADS_DIR" || return
    
    mapfile -t files < <(ls *.rpm 2>/dev/null)
    
    if [ ${#files[@]} -eq 0 ]; then
        echo -e "${RED}No .rpm files found in $DOWNLOADS_DIR${NC}"
        echo "Tip: You can also drag and drop an RPM file here."
    else
        echo "Select a number OR drag and drop an RPM file here:"
        for i in "${!files[@]}"; do
            echo -e "$((i+1))) ${GREEN}${files[$i]}${NC}"
        done
        echo "0) Cancel"
    fi
    
    input=$(get_input "\nEnter number or drop file (ESC to return): ")
    if [[ $? -eq 1 || "$input" == "0" ]]; then return; fi

    input=$(echo "$input" | tr -d "'\"")

    if [[ -z "$input" ]]; then
        :
    elif [[ "$input" =~ ^[0-9]+$ ]] && [[ "$input" -le ${#files[@]} ]]; then
        selected_file="${files[$((input-1))]}"
        sudo rpm-ostree install "$selected_file"
        echo -e "${GREEN}Scheduled! Reboot to apply changes.${NC}"
    elif [[ -f "$input" && "$input" == *.rpm ]]; then
        sudo rpm-ostree install "$input"
        echo -e "${GREEN}Scheduled! Reboot to apply changes.${NC}"
    else
        echo -e "${RED}Invalid selection or file!${NC}"
    fi
    
    echo -e "\n${BLUE}Press ESC to Return...${NC}"
    read -rsn1 -p ""
}

remove_rpm() {
    echo -e "\n--- ${RED}Remove Layered / Local RPM${NC} ---"
    echo "Searching for packages..."

    packages=$(rpm-ostree status --json | jq -r '.deployments[] | select(.booted == true) | 
        (.packages // []) + 
        (."local-packages" // []) + 
        (.local_packages // []) + 
        (."requested-local-packages" // []) | unique | .[]' 2>/dev/null)

    if [ -z "$packages" ]; then
        echo -e "${RED}No layered packages found.${NC}"
    else
        mapfile -t pkg_list < <(echo "$packages")
        echo "Select the package to remove:"
        for i in "${!pkg_list[@]}"; do
            echo -e "$((i+1))) ${RED}${pkg_list[$i]}${NC}"
        done
        echo "0) Cancel"

        num=$(get_input "\nEnter number (ESC to return): ")
        if [[ $? -eq 1 || "$num" == "0" ]]; then return; fi

        if [[ -z "$num" ]]; then
            :
        elif [[ "$num" =~ ^[0-9]+$ ]] && [[ "$num" -le ${#pkg_list[@]} ]]; then
            selected_pkg="${pkg_list[$((num-1))]}"
            pkg_clean=$(echo "$selected_pkg" | sed 's/-[0-9].*//')
            sudo rpm-ostree uninstall "$pkg_clean"
            echo -e "${GREEN}Removal scheduled! Please reboot.${NC}"
        else
            echo -e "${RED}Invalid selection!${NC}"
        fi
    fi
    echo -e "\n${BLUE}Press ESC to Return...${NC}"
    read -rsn1 -p ""
}

rollback() {
    echo -e "\n--- ${GREEN}System Rollback${NC} ---"
    echo -ne "Do you want to revert to the previous state? (y/N): "
    read -r confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        sudo rpm-ostree rollback
    fi
    echo -e "\n${BLUE}Press ESC to Return...${NC}"
    read -rsn1 -p ""
}

# --- Main Loop ---
while true; do
    show_menu
    
    # Capture the main menu option
    read -rsn1 opt
    case "$opt" in
        1) install_rpm ;;
        2) remove_rpm ;;
        3) rollback ;;
        4) 
            clear
            rpm-ostree status
            echo -e "\n${BLUE}Press ESC to Return...${NC}"
            read -rsn1
            ;;
        0|$'\e') # Exit with 0 or ESC
            clear
            echo -e "\n   Thank you for using ROM Manager!"
            echo -e "   Star this project at:"
            echo -e "   github.com/diogopessoa/rpm-ostree-manager"
            echo -e "${BLUE}---------------------------------------------${NC}"
            exit 0 
            ;;
        *)
            if [[ -n "$opt" && "$opt" != $'\e' ]]; then
                echo -e "${RED}Invalid option!${NC}"
                sleep 1
            fi
            ;;
    esac
done
