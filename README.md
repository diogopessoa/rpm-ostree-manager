<p align="center">
  <img src="slogan-rom.png" alt="RPM-OSTree Manager Slogan" width="100%">
</p>

[![Fedora Atomic](https://img.shields.io/badge/Fedora-Atomic-blue?logo=fedora&logoColor=white)](https://fedoraproject.org/)
[![Bazzite](https://img.shields.io/badge/Compatible-Bazzite-8a2be2)](https://github.com/ublue-os/bazzite)
[![Bluefin](https://img.shields.io/badge/Compatible-Bluefin-00a8e8?)](https://projectbluefin.io/)
[![Aurora](https://img.shields.io/badge/Compatible-Aurora-db6383?)](https://github.com/ublue-os/aurora)

# Table of Contents
[🇺🇸 English](https://github.com/diogopessoa/rpm-ostree-manager/blob/main/README.md) [🇧🇷 Português](https://github.com/diogopessoa/rpm-ostree-manager/blob/main/README-BR.md) 
* [Table of Contents](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#table-of-contents)
  - [About and Features](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#about-features)
  - [Screenshots](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#screenshots)
  - [File Destination](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#file-destination)
  - [Installation](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#installation)
  - [Uninstallation](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#uninstallation)
  - [Credits and License](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#credits-and-license)


## About and Features

RPM-OSTree Manager is a simple and intuitive CLI tool to install and manage local and layered RPM packages on Fedora Atomic systems (Silverblue, Kinoite, Bluefin, Bazzite, Aurora).

- **Install Local RPM:** Automatically scans for RPM files in the Downloads folder or accepts manual paths.
- **Remove Local and Layered RPMs:** Lists user-installed packages numerically for easy selection.
- **Rollback:** Quickly revert the system to its previous state. 
- **Pin/Unpin Deployment:** Pin a stable deployment. It will remain in the GRUB entry until you remove it.
- **Status:** Check for layered packages and pending deployments.

### UX

- **Intuitive CLI Navigation:** Easy-to-use numbered menus.
- **Smart Drag & Drop Support:** Install RPMs from any folder by simply dragging the file into the terminal.
  
### Main Menu
![main_menu](screenshots/main_menu_v2.png)

## Demo

<video src="https://github.com/user-attachments/assets/70e30d2d-cc4a-4772-8974-a99d58d4aaa8" width="100%" controls title="RPM-OSTree Manager Demo">
  Your browser does not support the video tag.
</video>

This demonstration shows only a portion of the features in action.

## File Destination

This map shows where each file is placed on your system after running the installer:



```
Destination Path

├── /usr/local/bin/rom                                  # Main executable (from rom.sh)
├── ~/.local/share/icons/rpm-ostree-manager.svg         # Icon file (from icon.svg)
└── ~/.local/share/applications/rpm-ostree-manager.desktop # Application Menu shortcut

```

## Installation

Run the following command to install RPM-OSTree Manager automatically:

```bash
curl -fsSL https://raw.githubusercontent.com/diogopessoa/rpm-ostree-manager/main/install.sh | bash
```

**All done!** Once the installation is successful, you can find **RPM-OSTree Manager** in your application menu or simply type `rom` in your terminal.

## Uninstallation

If you want to uninstall RPM-OSTree Manager, run the command:

```bash
sudo rm /usr/local/bin/rom && rm ~/.local/share/applications/rpm-ostree-manager.desktop ~/.local/share/icons/rpm-ostree-manager.svg && echo "RPM-OSTree Manager has been successfully uninstalled."
```

## Credits and License

* **MIT License:** Licensed under the [MIT License](https://github.com/diogopessoa/rpm-ostree-manager/blob/main/LICENSE).
* **Icon:** The icon used is part of the [Kora Icons](https://github.com/bikass/kora) project, licensed under GPL-3.0.



