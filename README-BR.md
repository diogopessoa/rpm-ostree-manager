<p align="center">
  <img src="slogan-rom.png" alt="RPM-OSTree Manager Slogan" width="100%">
</p>

# RPM-OSTree Manager

[![Fedora Atomic](https://img.shields.io/badge/Fedora-Atomic-blue?logo=fedora&logoColor=white)](https://fedoraproject.org/)
[![Bazzite](https://img.shields.io/badge/Compatible-Bazzite-8a2be2)](https://github.com/ublue-os/bazzite)
[![Bluefin](https://img.shields.io/badge/Compatible-Bluefin-00a8e8?)](https://projectbluefin.io/)
[![Aurora](https://img.shields.io/badge/Compatible-Aurora-db6383?)](https://github.com/ublue-os/aurora)

# Tabela de Conteúdo
* [🇺🇸](https://github.com/diogopessoa/rpm-ostree-manager/blob/main/README.md) [🇧🇷](https://github.com/diogopessoa/rpm-ostree-manager/blob/main/README-BR.md
* [Tabela de Conteúdo](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#tabela-de-conteudo)
  - [Sobre e Funcionalidades](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#sobre-e-funcionalidades)
  - [Como instalar](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#como-instalar)
  - [Desinstalação](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#desinstalaçao)
  - [Créditos e Licença](https://github.com/diogopessoa/rpm-ostree-manager/?tab=readme-ov-file#creditos-e-licença)

## Sobre e Funcionalidades

Uma ferramenta CLI simples e intuitiva para instalar e gerenciar pacotes RPM locais e layered em sistemas Fedora Atomic (Silverblue, Kinoite, Bluefin, Bazzite, Aurora).

- **Instalar RPM Local:** Busca automática de RPM na pasta Downloads.
- **Remover RPM Local e Layered:** Listagem por ordem numérica dos pacotes instalados pelo usuário.
- **Rollback:** Reversão para o estado anterior do sistema.
- **Status:** Verifica pacotes layereds e pendentes.

## Como instalar

Execute o seguinte comando para instalar o RPM-OSTree Manager automaticamente:

```bash
curl -fsSL [https://raw.githubusercontent.com/diogopessoa/rpm-ostree-manager/main/install.sh](https://raw.githubusercontent.com/diogopessoa/rpm-ostree-manager/main/install.sh) | bash
```

**Tudo pronto!** Após a instalação concluída com sucesso, você já pode encontrar o **RPM-OSTree Manager** no seu menu de aplicativos ou digitar `rom` no terminal.

## Desinstalação

Se você quiser remover o RPM-OSTree Manager, execute o commando:

```bash
sudo rm /usr/local/bin/rom && rm ~/.local/share/applications/rpm-ostree-manager.desktop ~/.local/share/icons/rpm-ostree-manager.svg
```

## Créditos e Licença

* **MIT License:** Licenciado sob a [MIT License](https://github.com/diogopessoa/rpm-ostree-manager/blob/main/LICENSE).
* **Ícone:** O ícone utilizado faz parte do projeto [Kora Icons](https://github.com/bikass/kora), licenciado sob a GPL-3.0.


