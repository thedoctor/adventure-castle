;;;;---------------------------------------------------------------------------
;; .emacs configuration file
;; author: Matt Smith
;; tested on: GNU Emacs 23.1.1 (x86_64-redhat-linux-gnu, GTK+ Version 2.18.9)
;;
;; packages used:
;;   revive (session management)
;;   buffer-move (shoving around frames)
;;   windmove (switching between frames; buffer-move dependency)
;;   ido (buffer/file selection)
;;   stripes (alternating background colors.
;;
;; about:
;;   This config file solves some of my big problems with emacs, mostly having
;;   to do with frames.
;;
;; last mod: 2012-08-21
;;;;---------------------------------------------------------------------------
;; This is the directory where we keep plugins.
(add-to-list 'load-path "~/.emacs.d/elisp/")
(add-to-list 'load-path "~/.emacs.d/elpa/")

;;;;---------------------------------------------------------------------------
;; SECTION: MODES
;;;;---------------------------------------------------------------------------

;; Markdown Mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; PHP Mode
(autoload 'php-mode "php-mode" "Major mode for PHP." t)

;; JSON Mode
(autoload 'json-mode "json-mode" "Major mode for JSON." t)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

;; JS2 Mode
(autoload 'js2-mode "js2-mode" "Alternate major mode for JavaScript." t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; SCSS Mode
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; CoffeeScript Mode
(autoload 'coffee-mode "coffee-mode" "Major mode for CoffeeScript." t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))

(setq-default auto-mode-alist
  (append '(("\.css.php$" . css-mode)
            ("\.php$" . php-mode)
            ("\.module$" . php-mode)
            ("\.inc$" . php-mode)
            (".pythonrc" . python-mode)
            ("Rakefile" . ruby-mode))
          ;;("\.ctp$" . web-mode))
          auto-mode-alist))


;;;;---------------------------------------------------------------------------
;; SECTION: PREFERENCES
;;;;---------------------------------------------------------------------------

(setq-default tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(setq-default indent-tabs-mode nil)

;; Follow symlinks
(setq-default vc-follow-symlinks t)

;; Turn on syntax hightlighting.
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode 1)        ; GNU Emacs
  (setq font-lock-auto-fontify t))   ; XEmacs

;; Delete trailing whitespace on save.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Show me dem line-numbers
(setq linum-format "%d ")
(add-hook 'after-change-major-mode-hook 'linum-mode)

(global-set-key (kbd "ESC <up>") 'scroll-down)
(global-set-key (kbd "ESC <down>") 'scroll-up)
(global-set-key (kbd "<C-tab>") 'indent-region)

;;;;---------------------------------------------------------------------------
;; SECTION: Plugins
;;;;---------------------------------------------------------------------------

;; Revive - lets you maintain your open buffers and frame configuration.
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe Emacs" t)
;; C-x 5 save
(define-key ctl-x-map "5" 'save-current-configuration)
;; C-x 1 load
(define-key ctl-x-map "1" 'resume)
;; C-x . forget
(define-key ctl-x-map "." 'wipe)

;; Windmove - for switching between frames -- easier than C-x o.
(require 'windmove)
(global-set-key (kbd "ESC 8")    'windmove-up)
(global-set-key (kbd "ESC 5")  'windmove-down)
(global-set-key (kbd "ESC 4")  'windmove-left)
(global-set-key (kbd "ESC 6") 'windmove-right)

;; Buffer-move - for swapping buffers between frames. Numpad is great for this.
(require 'buffer-move)
(global-set-key (kbd "C-x <kp-8>")    'buf-move-up)
(global-set-key (kbd "C-x <kp-5>")  'buf-move-down)
(global-set-key (kbd "C-x <kp-4>")  'buf-move-left)
(global-set-key (kbd "C-x <kp-6>") 'buf-move-right)

;; Resizing windows - not a plugin, but related.
(global-set-key (kbd "ESC i")              'enlarge-window)
(global-set-key (kbd "ESC k")               'shrink-window)
(global-set-key (kbd "ESC j")  'shrink-window-horizontally)
(global-set-key (kbd "ESC l") 'enlarge-window-horizontally)

;; DoReMi - Incrementally perform action with arrow keys
;; (require 'doremi)
;; TODO (doremi)

;; IDO - interactive do, basically auto-completion for switching buffers and finding files. Replaces main C-x f and C-x b.
(require 'ido)
(ido-mode t)

;; Stripes - sets the background color of every even line. In this case, it's set to #141414 -- change in stripes.el
(require 'stripes)
;;(add-hook 'after-change-major-mode-hook 'turn-on-stripes-mode)

;; Column-marker - let's highlight column 80 so we know where to trim lines. Love me dat PEP
(require 'column-marker)
(add-hook 'after-change-major-mode-hook (lambda () (interactive) (column-marker-2 80)))
(add-hook 'after-change-major-mode-hook 'column-number-mode)

;; Highlight-chars - Customizable regex highlighting.
(require 'highlight-chars)
;; Highlight tabs - we almost always want spaces.
(add-hook 'after-change-major-mode-hook 'hc-highlight-tabs)
;; Highlight trailing whitespace.
(add-hook 'after-change-major-mode-hook 'hc-highlight-trailing-whitespace)
