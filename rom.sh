#!/usr/bin/env bash

# ==============================================================================
# PROJECT: RPM-OSTree Manager
# AUTHOR: Diogo Pessoa (https://github.com/diogopessoa/rpm-ostree-manager/)
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
    echo -e "0) Exit"
    echo -ne "\nOption: "
}

install_rpm() {
    echo -e "\n--- ${BLUE}Install Local RPM${NC} ---"
    cd "$DOWNLOADS_DIR" || return
    
    # List .rpm files and store in an array
    mapfile -t files < <(ls *.rpm 2>/dev/null)
    
    if [ ${#files[@]} -eq 0 ]; then
        echo -e "${RED}No .rpm files found in $DOWNLOADS_DIR${NC}"
        echo "Tip: You can also drag and drop an RPM file here from any folder."
    else
        echo "Select a number OR drag and drop an RPM file here:"
        for i in "${!files[@]}"; do
            echo -e "$((i+1))) ${GREEN}${files[$i]}${NC}"
        done
        echo "0) Cancel"
    fi
    
    echo -ne "\nEnter number or drop file: "
    read -rp "" input
    input=$(echo "$input" | tr -d "'\"")

    if [[ -z "$input" ]]; then
        : # Do nothing, will trigger the Return prompt
    elif [[ "$input" == "0" ]]; then
        return
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
    
    read -p "Press Enter to Return..."
}

remove_rpm() {
    echo -e "\n--- ${RED}Remove Layered / Local RPM${NC} ---"
    echo "Searching for packages..."

    # Searches all possible keys store packages
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

        read -rp "Enter number: " num
        if [[ -z "$num" ]]; then
            :
        elif [[ "$num" -gt 0 && "$num" -le ${#pkg_list[@]} ]]; then
            selected_pkg="${pkg_list[$((num-1))]}"
            # Clean package name (remove version if present)
            pkg_clean=$(echo "$selected_pkg" | sed 's/-[0-9].*//')
            sudo rpm-ostree uninstall "$pkg_clean"
            echo -e "${GREEN}Removal scheduled! Please reboot the system.${NC}"
        elif [[ "$num" == "0" ]]; then
            return
        else
            echo -e "${RED}Invalid selection!${NC}"
        fi
    fi
    read -p "Press Enter to Return..."
}

rollback() {
    echo -e "\n--- ${GREEN}System Rollback${NC} ---"
    read -p "Do you want to revert to the previous state? (y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        sudo rpm-ostree rollback
    fi
    read -p "Press Enter to Return..."
}

# --- Main Loop ---
while true; do
    show_menu
    read -r opt
    case "$opt" in
        1) install_rpm ;;
        2) remove_rpm ;;
        3) rollback ;;
        4) clear; rpm-ostree status; echo ""; read -p "Press Enter to Return..." ;;
        0)
            clear
            echo
            echo -e "   Follow for updates:"
            echo -e "   github.com/diogopessoa/rpm-ostree-manager"
            echo -e "${BLUE}---------------------------------------------${NC}"
            exit 0 
            ;;
        *)
            echo -e "${RED}Invalid option!${NC}"
            read -p "Press Enter to Return..."
            ;;
    esac
done
