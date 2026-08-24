;;; config.el -*- lexical-binding: t; -*-
;; Ported from nvim/lua/plugins/{keymaps,astrocore,astrolsp,treesitter,colorscheme,none-ls}.lua

;; ─── astrocore: options ────────────────────────────────────────────
(setq user-full-name "xiao8")

;; colorscheme.lua: astrodark -> doom-one
(setq doom-theme 'doom-one)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 13)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font")
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 18))

;; astrocore.options.opt: relativenumber, number, wrap=false, signcolumn=yes
(setq display-line-numbers-type 'relative)
(setq-default fill-column 100)

;; ─── astrolsp.lua ──────────────────────────────────────────────────
(after! lsp-mode
  ;; features: codelens, inlay_hints, semantic_tokens
  (setq lsp-lens-enable t
        lsp-inlay-hint-enable t
        lsp-signature-auto-activate t
        lsp-headerline-breadcrumb-enable t)
  ;; astrolsp.config.gopls: staticcheck, gofumpt, usePlaceholders, hints, codelenses
  (lsp-register-custom-settings
   '(("gopls" . (("staticcheck" . t)
                 ("gofumpt" . t)
                 ("usePlaceholders" . t)
                 ("completeUnimported" . t)
                 ("hints" . (("assignVariableTypes" . t)
                             ("compositeLiteralFields" . t)
                             ("constantValues" . t)
                             ("functionTypeParameters" . t)
                             ("parameterNames" . t)
                             ("rangeVariableTypes" . t)))
                 ("codelenses" . (("generate" . t)
                                  ("regenerate_cgo" . t)
                                  ("run_govulncheck" . t)
                                  ("test" . t)
                                  ("tidy" . t)
                                  ("upgrade_dependency" . t)
                                  ("vendor" . t)))))))
  ;; astrolsp.config.tailwindcss filetypes
  (add-to-list 'lsp-language-id-configuration '(web-mode . "tailwindcss")))

;; ─── none-ls.lua formatters ────────────────────────────────────────
;; Doom's (format +onsave) already wires prettier/shfmt/stylua via apheleia.
;; none-ls.formatting.goimports/gofumpt for go:
(after! go-mode
  (setq gofmt-command "goimports"))

;; ─── treesitter.lua ensure_installed ───────────────────────────────
;; handled by Doom's :tools tree-sitter + :lang modules; auto-install on by default.

;; ═══════════════════════════════════════════════════════════════════
;; keymaps.lua
;; ═══════════════════════════════════════════════════════════════════

;; M-w / M-a / M-s / M-d : window navigation (up/left/down/right)
(map! :n "M-w" #'windmove-up
      :n "M-a" #'windmove-left
      :n "M-s" #'windmove-down
      :n "M-d" #'windmove-right)

;; S-j / S-k : jump 10 lines down / up
(map! :n "J" (cmd! (evil-next-visual-line 10))
      :n "K" (cmd! (evil-previous-visual-line 10)))

;; H / L : line start (^) / line end ($)
(map! :n "H" #'evil-first-non-blank
      :n "L" #'evil-end-of-line
      :v "H" #'evil-first-non-blank
      :v "L" #'evil-end-of-line)

;; d / c / x / D / C : delete/change without yank (black-hole register "_)
(evil-define-operator my/evil-delete-no-yank (beg end type register yank-handler)
  (evil-delete beg end type ?_ yank-handler))
(evil-define-operator my/evil-change-no-yank (beg end type register yank-handler)
  (evil-change beg end type ?_ yank-handler))
(defun my/delete-char-no-yank (&optional count)
  (interactive "p")
  (evil-delete-char (or count 1) ?_))
(defun my/delete-to-eol-no-yank ()
  (interactive)
  (evil-delete (point) (line-end-position) 'inclusive ?_))
(defun my/change-to-eol-no-yank ()
  (interactive)
  (evil-change (point) (line-end-position) 'inclusive ?_))
(map! :n "d" #'my/evil-delete-no-yank
      :n "c" #'my/evil-change-no-yank
      :n "x" #'my/delete-char-no-yank
      :n "D" #'my/delete-to-eol-no-yank
      :n "C" #'my/change-to-eol-no-yank
      :v "d" #'my/evil-delete-no-yank
      :v "c" #'my/evil-change-no-yank
      :v "x" #'my/delete-char-no-yank
      :v "D" #'my/delete-to-eol-no-yank
      :v "C" #'my/change-to-eol-no-yank)

;; visual: C-j / C-k move selection down / up ; C-l / C-h indent / dedent
(after! drag-stuff
  (map! :v "C-j" #'drag-stuff-down
        :v "C-k" #'drag-stuff-up))
(map! :v "C-l" #'evil-shift-right
      :v "C-h" #'evil-shift-left)

;; insert: C-h / C-j / C-k / C-l : left / down / up / right
(map! :i "C-h" #'left-char
      :i "C-j" #'next-line
      :i "C-k" #'previous-line
      :i "C-l" #'right-char)

;; astrolsp mappings: S-f hover (normal), C-f signature help (insert)
(after! lsp-mode
  (map! :map lsp-mode-map
        :n "S-f" #'lsp-describe-thing-at-point
        :i "C-f" #'lsp-signature))
