;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; --- Identity ---
(setq user-full-name "Romeo Cavazza"
      user-mail-address "ton.email@exemple.com")

;; --- Appearance ---
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))

(setq doom-theme 'doom-one)

(setq display-line-numbers-type 'relative)

;; --- Org ---
(setq org-directory "~/org/")

;; --- AI ---
(use-package! gptel
  :config
  (setq! gptel-model 'mistral
         gptel-backend (gptel-make-ollama "Ollama"
                         :host "localhost:11434"
                         :stream t
                         :models '(mistral llama3 gemma:2b))))

(map! :leader
      (:prefix ("o" . "open")
       :desc "Open AI Chat" "c" #'gptel
       :desc "Send AI Prompt" "s" #'gptel-send
       :desc "AI Prompt Menu" "m" #'gptel-menu))

;; --- Performance ---
(setq lsp-idle-delay 0.500)
