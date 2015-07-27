;;; tim-python-mode.el --- Emacs Tim: python-mode.el configuration
;;
;;

;;; Commentary:

;;
;;

;;; Code:

(message "===> Tim.WU: loading %s" load-file-name)

;;; ---- C-j to easily switch between the two modes:

(require 'shell)
(require 'term)
(defun term-switch-to-shell-mode ()
  (interactive)
  (if (equal major-mode 'term-mode)
      (progn
        (shell-mode)
        (set-process-filter  (get-buffer-process (current-buffer)) 'comint-output-filter )
        (local-set-key (kbd "C-j") 'term-switch-to-shell-mode)
        (compilation-shell-minor-mode 1)
        (comint-send-input)
      )
    (progn
        (compilation-shell-minor-mode -1)
        (font-lock-mode -1)
        (set-process-filter  (get-buffer-process (current-buffer)) 'term-emulate-terminal)
        (term-mode)
        (term-char-mode)
        (term-send-raw-string (kbd "C-l"))
        )))
(define-key term-raw-map (kbd "C-j") 'term-switch-to-shell-mode)
;;(define-key term-raw-map [tab] nil)
;;(define-key term-raw-map (kbd "TAB") nil)

;;; ---- python-mode
(prelude-require-package 'python-mode)
(require 'python-mode)

(defun python-add-breakpoint ()
  "Add a break point"
  (interactive)
  (newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))
(define-key python-mode-map (kbd "C-c C-b") 'python-add-breakpoint)

(defun python-interactive ()
  "Enter the interactive Python environment"
  (interactive)
  (progn
    (insert "!import code; code.interact(local=vars())")
    (move-end-of-line 1)
    (comint-send-input)))
(global-set-key (kbd "C-c M-i") 'python-interactive)

;; set `M-x py-shell RET` to ipython
(custom-set-variables
    '(py-force-py-shell-name-p t)
    '(py-shell-name "ipython"))

;;;


(define-key python-mode-map (kbd "C-M-y") 'complete-at-point)

;;; ---- isend-mode
(prelude-require-package 'isend-mode)
(require 'isend-mode)
(setq isend-skip-empty-lines nil)
(setq isend-strip-empty-lines nil)
(setq isend-delete-indentation t)
(setq isend-end-with-empty-line t)  ;; `M-x isend-associate RET BUFFER_NAME` then `C-RET` to send sentence to ipython


;;; ---- enable turn-on-pdbtrack since anaconda blocks it by default.
(add-hook 'python-mode-hook (lambda ()
                              (progn
                                (message "==> Tim.WU: python-mode-hook: enable turn-on-pdbtrack")
                                (turn-on-pdbtrack))))

(provide 'tim-python-mode)
;;; tim-python-mode ends here

;;; ----
(prelude-require-package 'highlight-indentation)
(require 'highlight-indentation)

;;; --- realgud
(prelude-require-package 'realgud)
(require 'realgud)  ;; M-x realgud-track-mode in *shell* & run $trepan2 xxx.py

;;; ---- jedi  -- no need, anaconda will invoke/install jedi
;;(prelude-require-package 'jedi)
;;(require 'jedi)

;;; ---- auto-completion  -- doesn't work
;;(prelude-require-package 'shell-command)
;;(require 'shell-command) 
;;(shell-command-completion-mode)

;;; ---- bash-completion  -- doesn't work
(prelude-require-package 'bash-completion)
;;(require 'bash-completion)
;;;(bash-completion-setup)
;;(autoload 'bash-completion-dynamic-complete 
;;  "bash-completion"
;;  "BASH completion hook")
;;(add-hook 'shell-dynamic-complete-functions
;;  'bash-completion-dynamic-complete)

;;; ---- xpdb
;; Let python-mode know about xpdb and generator expressions.
;;(setq py-pdbtrack-input-prompt "\n[(&amp class="comment">;amp;amp;lt;]*x?pdb[&amp;amp;amp;gt;)]+ "
;;      py-pdbtrack-stack-entry-regexp
;;      (concat "^&amp class="comment">;amp;amp;gt; \\(.*\\)(\\([0-9]+\\))"
;;	      "\\([?a-zA-Z0-9_]+\\|&amp class="comment">;amp;amp;lt;genexpr&amp;amp;amp;gt;\\)()"))

