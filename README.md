# Doom Emacs

<p align="left">
  <img src="https://raw.githubusercontent.com/RomeoCavazza/nixos-config/refs/heads/main/docs/assets/logo/emacs.png" alt="Emacs" width="26" />
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/nixos/nixos-original.svg" alt="NixOS" width="26" />
  <img src="https://raw.githubusercontent.com/RomeoCavazza/nixos-config/refs/heads/main/docs/assets/logo/ollama.png" alt="Ollama" width="26" />
</p>

Linux/NixOS-oriented Doom Emacs configuration.
This repository is the `$DOOMDIR`: Doom itself lives in `~/.emacs.d`, while
this repo carries module selection, user settings, and extra packages.

The profile is tuned for modal editing, fast project navigation, Org research,
LSP-backed development, Magit, vterm, and local AI through Ollama.

**This config is maintained as part of
[`nixos-config`](https://github.com/RomeoCavazza/nixos-config), where it is mounted at
`/etc/nixos/config/doom`.**

## Visual Guide

![Leader bindings](assets/panel.png)

| Entry | Preview |
| --- | --- |
| **Dashboard** | ![Dashboard](assets/dashboard.png) |
| **Edit File** | ![Edit File](assets/edit-file.png) |
| **Search File** | ![Search File](assets/search-file.png) |
| **Search Word** | ![Search Word](assets/search-word.png) |
| **Assistant** | ![Assistant](assets/assistant.png) |

## Setup

```bash
# Install Doom Emacs if it is not already present
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d

# Clone this configuration as DOOMDIR
git clone https://github.com/RomeoCavazza/emacs-config ~/.config/doom

# Install and synchronize Doom
~/.emacs.d/bin/doom install
~/.emacs.d/bin/doom sync
```

On `nixos-config`, the NixOS module starts the Emacs daemon and installs the system
dependencies needed by this profile:

```nix
imports = [
  ./modules/emacs.nix
];
```

## Files

| Path | Role |
| --- | --- |
| [`init.el`](init.el) | Doom module selection: UI, completion, tools, languages |
| [`config.el`](config.el) | Identity, fonts, theme, Org, GPTel/Ollama, custom binds |
| [`packages.el`](packages.el) | Extra packages outside Doom modules |
| [`assets/`](assets/) | README preview images |

## Features

- Completion stack via Doom's `(corfu +orderless)` and `vertico`.
- Doom dashboard, `doom-one` theme, modeline, popups, workspaces, and zen mode.
- Vim-style editing everywhere via `(evil +everywhere)`.
- New-file skeletons via `file-templates`, snippets, folding, multiple cursors,
  smartparens, and format-on-save.
- Dired, undo history, version-control integration, and Git gutters.
- Fast terminal integration through `vterm`.
- Syntax checking with Flycheck and spell checking with Flyspell.
- REPL/eval overlays, lookup/documentation helpers, LSP, Magit, PDF tools,
  Tree-sitter, and Docker integration.
- Language coverage for Emacs Lisp, Markdown, Nix, Org, shell, Python, Rust,
  C/C++, LaTeX, YAML, and JSON.
- Org mode with `+roam`, `+dragndrop`, and `+present` for notes, research, and
  lightweight presentations.
- Local AI chat via [gptel](https://github.com/karthink/gptel) and Ollama on
  `localhost:11434`.
- Mermaid support for Org blocks through `ob-mermaid`.

## Key Entries

| Binding | Action |
| --- | --- |
| `SPC f f` | Find or create a file |
| `SPC b b` | Switch buffer |
| `SPC g g` | Open Magit status |
| `SPC p p` | Switch project |
| `SPC t z` | Toggle zen mode |
| `SPC o c` | Open GPTel AI chat |
| `SPC o m` | Open GPTel menu |
| `SPC o s` | Send GPTel prompt |

## Local AI

GPTel is configured to use Ollama with streaming enabled:

```elisp
(setq! gptel-model 'mistral
       gptel-backend (gptel-make-ollama "Ollama"
                       :host "localhost:11434"
                       :stream t
                       :models '(mistral llama3 gemma:2b)))
```

Recommended local models:

```bash
ollama pull mistral
ollama pull llama3
ollama pull gemma:2b
```

## NixOS Integration

The companion module in `nixos-config` enables `emacs-pgtk` as a user daemon and
installs the native dependencies this config expects:

- `ripgrep` and `fd` for project search.
- `clang`, `cmake`, `gnumake`, `libtool`, and `sqlite` for vterm and
  Tree-sitter builds.
- `nil` and `bash-language-server` for baseline LSP support.
- `pandoc`, `graphviz`, and a medium TeX Live scheme for Org publishing,
  diagrams, and LaTeX workflows.
