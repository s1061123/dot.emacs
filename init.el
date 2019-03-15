(setenv "LANG" "ja_JP.UTF-8")

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(setq ps-multibyte-buffer 'non-latin-printer)
(require 'ps-mule)
(defalias 'ps-mule-header-string-charsets 'ignore)


(menu-bar-mode 0)
(tool-bar-mode 0)
(setq visible-bell 't)
(setq display-time-24hr-format 't)
(display-time-mode)
(prefer-coding-system 'utf-8-unix)
;(set-language-environment "Japanese")           ; 日本語環境設定
(setq x-super-keysym 'meta)

(let ((default-directory (expand-file-name "~/.emacs.d/lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))


(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

(use-package howm
  :ensure t
  :config
  ;;(setq howm-directory (expand-file-name "~/howm"))
  (setq howm-menu-lang 'en)
  ;;(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.md")
  ;;(setq howm-menu-file "menu.md")
  (define-key global-map (kbd "C-c ,,") 'howm-menu))

;; tidal for stack
;;(use-package tidal
;;  :ensure t
;;  :config
;;  (setq tidal-interpreter "/usr/bin/stack")
;;  (setq tidal-interpreter-arguments
;;	(list "repl"
;;            "--ghci-options=-XOverloadedStrings"
;;            )))

(use-package elscreen
  :ensure t
  :config
  (setq elscreen-prefix-key (kbd "C-]"))
  (elscreen-start)
  (setq elscreen-display-tab nil)
;;; タブの先頭に[X]を表示しない
  (setq elscreen-tab-display-kill-screen nil)
;;; header-lineの先頭に[<->]を表示しない
  (setq elscreen-tab-display-control nil)
;;; バッファ名・モード名からタブに表示させる内容を決定する(デフォルト設定)
  (setq elscreen-buffer-to-nickname-alist
        '(("^dired-mode$" .
           (lambda ()
             (format "Dired(%s)" dired-directory)))
          ("^Info-mode$" .
           (lambda ()
             (format "Info(%s)" (file-name-nondirectory Info-current-file))))
          ("^mew-draft-mode$" .
           (lambda ()
             (format "Mew(%s)" (buffer-name (current-buffer)))))
          ("^mew-" . "Mew")
          ("^irchat-" . "IRChat")
          ("^liece-" . "Liece")
          ("^lookup-" . "Lookup")))
  (setq elscreen-mode-to-nickname-alist
        '(("[Ss]hell" . "shell")
          ("compilation" . "compile")
          ("-telnet" . "telnet")
          ("dict" . "OnlineDict")
          ("*WL:Message*" . "Wanderlust")))
  (use-package elscreen-wl)
  )

;; company
(use-package company
    :init
    (setq company-selection-wrap-around t)
    :bind
    (:map company-active-map
        ("M-n" . nil)
        ("M-p" . nil)
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
        ("C-h" . nil))
    :config
    (setq company-tooltip-limit 20) ; bigger popup window
    (setq company-idle-delay .3)
    (setq company-minimum-prefix-length 3)
    (setq company-echo-delay 0)     ; remove annoying blinking
    (setq company-begin-commands '(self-insert-command))
    )
(global-company-mode)

;; With use-package:
(use-package company-box
  :hook (company-mode . company-box-mode))

(require 'sclang)

;; skk
(global-set-key (kbd "C-x C-j") 'skk-mode)
;(setq skk-large-jisyo "/usr/share/skk/SKK-JISYO.L.unannotated")
(setq skk-large-jisyo "/home/tohayash/dic/SKK-JISYO.L.unannotated")

;; for lookup
(define-key ctl-x-map "l" 'lookup)
(define-key ctl-x-map "y" 'lookup-region)
(define-key ctl-x-map "\C-y" 'lookup-pattern)
(global-set-key "\C-cw" 'lookup-pattern)

;; lookup2
(load "lookup-autoloads")
(setq lookup-search-agents
      '(
	(ndeb "~/dic" :coding sjis-dos :alias "dics")
;;	(ndeb "c:/tom/dic/dic/eijiro" :coding sjis-dos :alias "dics")
;;	(ndeb "c:/tom/dic/dic/waeijiro" :coding sjis-dos :alias "dics")
	(ndspell)
	))

;;実際に横幅が 1:2 になるのは、12pt, 13.5pt, 15pt など、1.5の倍数なので、
;;それに合わせるのがおすすめ。
;(add-to-list 'default-frame-alist '(font . "ricty-13.5"))
(set-face-attribute 'default nil :family "Ricty" :height 240)
(set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Ricty"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (markdown-mode dockerfile-mode company-box tidal w3m sclang-snippets sclang-extensions howm elscreen ddskk wanderlust go-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;(set-frame-size (selected-frame) 60 20)
(set-frame-size (selected-frame) 100 40)
(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(width . 110))
(server-start)
