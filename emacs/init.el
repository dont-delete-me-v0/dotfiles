;;; init.el --- Doom Emacs configuration -*- lexical-binding: t; -*-
;; Ported from AstroNvim v6 (nvim/lua/lazy_setup.lua + community.lua).
;; Modules below mirror the AstroCommunity packs and plugin list.

(doom! :input
       ;; layout              ; auie,ctsrnm is the superior home row
       bidi

       :completion
       company               ; blink.cmp
       vertico               ; telescope/fzf equivalent

       :ui
       doom                  ; astroui: astrotheme look
       dashboard             ; alpha (snacks dashboard)
       doom-quit
       hl-todo
       indent-guides         ; indent-blankline
       modeline             ; lualine / doom-modeline
       nav-flash
       ophints
       (popup +defaults)
       tabs                 ; bufferline / tabby
       treemacs             ; nvim-tree
       unicode
       vc-gutter            ; gitsigns
       window-select        ; M-w/a/s/d window nav lives on top of this
       workspaces           ; tab emulation

       :editor
       (evil +everywhere)   ; the whole reason we're here
       file-templates
       fold                 ; nvim-ufo
       (format +onsave)     ; none-ls format_on_save
       multiple-cursors
       rotate-text
       snippets             ; LuaSnip -> yasnippet

       :emacs
       dired
       electric             ; autopairs-ish (smartparens in :config)
       ibuffer
       undo
       vc

       :term
       eshell

       :checkers
       syntax              ; nvim-lspconfig diagnostics
       (spell +flyspell)
       ;; grammar            ; requires languagetool

       :tools
       (eval +overlay)
       lookup              ; K / go-to-definition
       lsp                 ; astrolsp + lspconfig
       magit               ; gitsigns / lazygit (far stronger)
       make
       rgb
       tree-sitter         ; nvim-treesitter

       :os
       (:if IS-MAC macos)
       tty

       :lang
       data                ; toml + extra
       emacs-lisp          ; native
       go                  ; gopls, goimports, gofumpt, golangci-lint, delve
       json                ; jsonls
       javascript          ; ts_ls / eslint (js)
       markdown            ; markdown ft
       ;; org
       sh                  ; bashls, shfmt
       typescript          ; ts_ls, eslint (ts/tsx)
       web                 ; html, css, emmet, tailwindcss lsp
       yaml                ; yamlls
       lua                 ; lua_ls

       :config
       (default +bindings +smartparens))
