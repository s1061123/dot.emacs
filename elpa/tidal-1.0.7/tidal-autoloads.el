;;; tidal-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "tidal" "tidal.el" (0 0 0 0))
;;; Generated autoloads from tidal.el

(autoload 'literate-tidal-mode "tidal" "\
Major mode for interacting with an inferior haskell process.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.ltidal$" . literate-tidal-mode))

(autoload 'tidal-mode "tidal" "\
Major mode for interacting with an inferior haskell process.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.tidal$" . tidal-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "tidal" '("turn-on-tidal-keybindings" "tidal-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; tidal-autoloads.el ends here
