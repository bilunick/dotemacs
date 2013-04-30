;; add exec path
(add-to-list 'exec-path "/usr/local/bin/")

; display line numbers in margin.
(global-linum-mode 1)
; display column numbers
(column-number-mode 1)

; don't blink the cursor
(blink-cursor-mode -1)

; highlight the current line
(add-to-list 'load-path "~/.emacs.d/highlight-current-line")
(require 'highlight-current-line)
(global-hl-line-mode t)
(setq highlight-current-line-globally t)
(setq highlight-current-line-high-faces nil)
(setq highlight-current-line-whole-line nil)
(setq hl-line-face (quote highlight))

; make sure transient mark mode is enabled (it should be by default,
; but just in case)
(transient-mark-mode t)

;; add fill column indicator
(add-to-list 'load-path "~/.emacs.d/fill-column-indicator")
(require 'fill-column-indicator)
(define-globalized-minor-mode
 global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)

;; set font size
(set-face-attribute 'default (selected-frame) :height 140)

;; set ido
(require 'ido)
(ido-mode t)

(require 'package)
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
;; Add MELPA repository
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; enable autocomplete
(add-hook 'python-mode-hook 'auto-complete-mode)

;; add jedi autocompletion
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

;; set solarized theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'solarized-light t)

;;; Hooks
(remove-hook 'python-mode-hook 'wisent-python-default-setup)
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'autopair-global-mode)

(add-hook 'after-init-hook
          (lambda ()
            (add-hook 'prog-mode-hook 'flycheck-mode)))

;; always start emacs in fullscreen
(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
)
(toggle-fullscreen)
