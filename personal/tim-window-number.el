;;; tim-window-number.el --- Emacs Tim: python-mode.el configuration
;;
;;

;;; Commentary:

;;
;;

;;; Code:

(message "===> Tim.WU: loading %s" load-file-name)


;; http://tapoueh.org/emacs/switch-window.html
(prelude-require-package 'switch-window)
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

;; move window
(prelude-require-package 'window-numbering)
(require 'window-numbering)
(custom-set-faces '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold)))))
(window-numbering-mode 1)

;; buffer-move.el
(prelude-require-package 'buffer-move)
(require 'buffer-move)
(global-set-key (kbd "C-c C-o C-i")     'buf-move-up)
(global-set-key (kbd "C-c C-o C-n")   'buf-move-down)
(global-set-key (kbd "C-c C-o C-j")   'buf-move-left)
(global-set-key (kbd "C-c C-o C-l")  'buf-move-right)


(provide 'tim-window-number)
;;; tim-window-number ends here
