<p align="center">
  <img src="slogan-rom.png" alt="RPM-OSTree Manager Slogan" width="100%">
</p>

[![Fedora Atomic](https://img.shields.io/badge/Fedora-Atomic-blue?logo=fedora&logoColor=white)](https://fedoraproject.org/)
[![Bazzite](https://img.shields.io/badge/Compatible-Bazzite-8a2be2)](https://github.com/ublue-os/bazzite)
[![Bluefin](https://img.shields.io/badge/Compatible-Bluefin-00a8e8?)](https://projectbluefin.io/)
[![Aurora](https://img.shields.io/badge/Compatible-Aurora-db6383?)](https://github.com/ublue-os/aurora)

# Tabela de Conteúdo
[🇺🇸 English](https://github.com/diogopessoa/rpm-ostree-manager/blob/main/README.md) [🇧🇷 Português](https://github.com/diogopessoa/rpm-ostree-manager/blob/main/README-BR.md)
* [Tabela de Conteúdo](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#tabela-de-conteudo)
  - [Sobre e Funcionalidades](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#sobre-e-funcionalidades)
  - [Funcionalidades](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#funcionalidades)
  - [Menu Principal](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#menu-principal)
  - [Demonstração de Uso](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#demonstraçao-de-uso)
  - [Destino dos Arquivos](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#destino-dos-arquivos)
  - [Como instalar](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#como-instalar)
  - [Desinstalação](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#desinstalaçao)
  - [Créditos e Licença](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#creditos-e-licença)

## Sobre

RPM-OSTree Manager é uma ferramenta CLI simples e intuitiva para instalar e gerenciar pacotes RPM locais e layered em sistemas Fedora Atomic (Silverblue, Kinoite, Bluefin, Bazzite, Aurora).

>Devido à base imutável dos sistemas atômicos, as camadas devem ser usadas apenas como último recurso. Priorize sempre a instalação de pacotes nesta ordem: Flatpak, containers e, por último, camadas (rpm-ostree).

## Funcionalidades

- **📦 Instalar RPM Local:** Busca automaticamente arquivos RPM na pasta **Downloads**, ou você pode **arrastar** um RPM diretamente para a janela do programa para instalá-lo de qualquer local.
- **🗑️ Remover RPMs Locais e em Camadas:** Lista os pacotes instalados pelo usuário numericamente para facilitar a desinstalação.

- **↩️ Reverter:** Reverte rapidamente o sistema para um estado previamente selecionado.

- **📌 Fixar/Desafixar Implantação:** Fixe uma implantação estável para evitar que seja removida durante as atualizações. Ela permanecerá na entrada do GRUB até que você a desafixe.

- **☑️ Status:** Verifica pacotes em camadas, implantações pendentes e versionamento ativo do sistema.

>💡 Informações:
Uma implantação é a imagem completa do sistema (base + pacotes em camadas) listada no status do rpm-ostree, identificada por um índice (exemplo: 0). Fixá-la impede a remoção automática.
  
## Menu Principal
![main_menu](screenshots/main_menu_v2.png)

## Demonstração de Uso

<video src="https://github.com/user-attachments/assets/70e30d2d-cc4a-4772-8974-a99d58d4aaa8" width="100%" controls title="RPM-OSTree Manager Demo">
  Your browser does not support the video tag.
</video>

Esta demonstração é apenas uma parte das funcionalidades disponíveis.

## Destino dos Arquivos

Este mapa mostra onde cada arquivo é colocado no seu sistema após a execução do instalador:

```text
Caminho de destino

├── /usr/local/bin/rom                                  # Principal executável (from rom.sh)
├── ~/.local/share/icons/rpm-ostree-manager.svg         # Ícone (from icon.svg)
└── ~/.local/share/applications/rpm-ostree-manager.desktop # Atalho no menu de aplicativos

```

## Como instalar

Execute o seguinte comando para instalar o RPM-OSTree Manager automaticamente:

```bash
curl -fsSL https://raw.githubusercontent.com/diogopessoa/rpm-ostree-manager/main/install.sh | bash
```

**Tudo pronto!** Após a instalação concluída com sucesso, você já pode encontrar o **RPM-OSTree Manager** no seu menu de aplicativos ou digitar `rom` no terminal.

## Desinstalação

Se você quiser remover o RPM-OSTree Manager, execute o commando:

```bash
sudo rm /usr/local/bin/rom && rm ~/.local/share/applications/rpm-ostree-manager.desktop ~/.local/share/icons/rpm-ostree-manager.svg && echo "RPM-OSTree Manager has been successfully uninstalled."
```

## Créditos e Licença

* **MIT License:** Licenciado sob a [MIT License](https://github.com/diogopessoa/rpm-ostree-manager/blob/main/LICENSE).
* **Ícone:** Faz parte do projeto [Kora Icons](https://github.com/bikass/kora), licenciado sob a GPL-3.0.


