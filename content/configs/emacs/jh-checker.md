+++
title = "jh-checker layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:51:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-checker
{{< /hint >}}

<!--more-->


## Goals {#goals}

프로그래밍 언어와 인간 언어 둘다 검사기가 필요하다.

-   syntax : flycheck and flymake
-   spell : jinx, spell-fu
-   style : 1) en/ko, 2) elisp/binary/lsp-mode


## Layer {#layer}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
;;
;; Copyright (c) 2012-2023 Sylvain Benner & Contributors
;;
;; Author: Junghan Kim <junghanacs@gmail.com>
;; URL: https://github.com/junghanacs
;;
;; This file is not part of GNU Emacs.
;;
;; License: GPLv3

;;; Commentary:

;;; Code:

(configuration-layer/declare-layer-dependencies
 '(
   ;; Spell as you type with Flyspell package,
   ;; requires external command - ispell, hunspell, aspell
   ;; SPC S menu, SPC S s to check current word
   ;; (spell-checking
   ;;  ;; flyspell flyspell-correct
   ;;  :packages (not auto-dictionary flyspell-popup flyspell-correct-popup)
   ;;  :variables
   ;;  enable-flyspell-auto-completion nil
   ;;  spell-checking-enable-auto-dictionary nil
   ;;  spell-checking-enable-by-default nil)

   ;; flycheck :: use flycheck-posframe
   (syntax-checking
    :packages (flycheck) ; flycheck-pos-tip
    :variables
    syntax-checking-enable-by-default t ; t - enable to prog-mode
    syntax-checking-enable-tooltips nil ; default t
    ;; syntax-checking-use-standard-error-navigation t ; default nil
    )

   ))
```


## Packages {#packages}


### Packages {#packages}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
;;
;; Copyright (c) 2012-2023 Sylvain Benner & Contributors
;;
;; Author: Junghan Kim <junghanacs@gmail.com>
;; URL: https://github.com/junghanacs
;;
;; This file is not part of GNU Emacs.
;;
;; License: GPLv3

;;; Commentary:

;;; Code:

(defconst jh-checker-packages
  '(
    flymake
    flycheck

;;;; 1) Syntax
    flycheck-posframe
    consult-flycheck
    ;; flycheck-eglot ; or flymake

;;;; 2) Spell
    (jinx :location (recipe :fetcher github :repo "minad/jinx"
                            :files ("*.*")))
    spell-fu
    ;; wcheck-mode ; with enchant2 for english

;;;; 3) Style
    ;; 1. linters
    ;; flycheck-grammarly
    ;; flycheck-vale

    ;; 2. languagetool
    ;; languagetool
    ;; flycheck-languagetool
    ;; lsp-ltex
    ;; (lsp-ltex :location (recipe :fetcher github :repo "emacs-languagetool/lsp-ltex"))

    ;; 3. grammarly
    ))
```


### Syntax checker {#syntax-checker}


#### flycheck {#flycheck}

```elisp
(defun jh-checker/post-init-flycheck ()
  ;; Default value is (save idle-change new-line mode-enabled)
  (setq flycheck-check-syntax-automatically
        '(save idle-buffer-switch mode-enabled))

  ;; (global-set-key (kbd "<f2>") 'flycheck-previous-error)
  ;; (global-set-key (kbd "<f3>") 'flycheck-next-error)
  ;; (global-set-key (kbd "M-p") 'flycheck-previous-error)
  ;; (global-set-key (kbd "M-n") 'flycheck-next-error)

  ;; (define-key flycheck-mode-map (kbd "M-n") 'flycheck-next-error)
  ;; (define-key flycheck-mode-map (kbd "M-p") 'flycheck-previous-error)
  (evil-define-key '(normal) flycheck-mode-map (kbd "M-n") 'flycheck-next-error)
  (evil-define-key '(normal) flycheck-mode-map (kbd "M-p") 'flycheck-previous-error)

  ;;/ahyatt-dotfiles/.emacs.d/init.el:569
  (setq flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (setq-default flycheck-highlighting-mode 'lines) ; 'symbols

  ;; Wait before complaining so we don't step on useful help messages.
  (setq-default flycheck-idle-change-delay 3) ; default 0.5
  ;; If flycheck idle change delay is too short, then it overwrites the helpful
  ;; messages about how to call elisp functions, etc.
  ;; (setq flycheck-idle-change-delay 15))

  ;; Define fringe indicator / warning levels
  (define-fringe-bitmap 'flycheck-fringe-bitmap-ball
    (vector #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00011100
            #b00111110
            #b00111110
            #b00111110
            #b00011100
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000))
  (flycheck-define-error-level 'error
    :severity 2
    :overlay-category 'flycheck-error-overlay
    :fringe-bitmap 'flycheck-fringe-bitmap-ball
    :fringe-face 'flycheck-fringe-error)
  (flycheck-define-error-level 'warning
    :severity 1
    :overlay-category 'flycheck-warning-overlay
    :fringe-bitmap 'flycheck-fringe-bitmap-ball
    :fringe-face 'flycheck-fringe-warning)
  (flycheck-define-error-level 'info
    :severity 0
    :overlay-category 'flycheck-info-overlay
    :fringe-bitmap 'flycheck-fringe-bitmap-ball
    :fringe-face 'flycheck-fringe-info)
  )
```


#### flycheck-posframe {#flycheck-posframe}

이게 궁합이 잘 맞는다.

```elisp
(defun jh-checker/init-flycheck-posframe ()
  (use-package flycheck-posframe
    :after flycheck
    :ensure
    :config
    (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode)
    (setq flycheck-posframe-position 'window-bottom-left-corner)

    ;; (flycheck-posframe-configure-pretty-defaults) ; default face
    (setq flycheck-posframe-warning-prefix "💡 ")
    (setq flycheck-posframe-error-prefix "⛔ ")
    (set-face-attribute 'flycheck-posframe-warning-face nil :inherit 'warning)
    (set-face-attribute 'flycheck-posframe-error-face nil :inherit 'error)
    ;; (setq flycheck-posframe-border-use-error-face t)
    ;; (setq flycheck-posframe-border-width 1)
    ))
```


#### consult-flycheck {#consult-flycheck}

```elisp
(defun jh-checker/init-consult-flycheck ()
  (use-package consult-flycheck
    :after flycheck
    :defer
    :bind (:map flycheck-command-map
                ("!" . consult-flycheck))
    ;; If flycheck idle change delay is too short, then it overwrites the helpful
    ;; messages about how to call elisp functions, etc.
    :config (setq flycheck-idle-change-delay 15)
    (global-set-key (kbd "M-g l") 'consult-flycheck)
    )
  )
```


#### flymake {#flymake}

```elisp
(defun jh-checker/init-flymake ()
  (use-package flymake
    :defer 10
    :bind (("M-g D"   . flymake-show-buffer-diagnostics)
           ("M-g C-d" . flymake-show-project-diagnostics)
           ("M-g C-n" . flymake-goto-next-error)
           ("M-g C-p" . flymake-goto-prev-error)
           :repeat-map flymake-repeatmap
           ("p" . flymake-goto-prev-error)
           ("n" . flymake-goto-next-error)
           :map flymake-diagnostics-buffer-mode-map
           ("?" . flymake-show-diagnostic-here)
           :map flymake-project-diagnostics-mode-map
           ("?" . flymake-show-diagnostic-here))
    ;; :hook (prog-mode . (lambda () (flymake-mode t)))
    :config
    (defun flymake-show-diagnostic-here (pos &optional other-window)
      "Show the full diagnostic of this error.
Used to see multiline flymake errors"
      (interactive (list (point) t))
      (let* ((id (or (tabulated-list-get-id pos)
                     (user-error "Nothing at point")))
             (text (flymake-diagnostic-text (plist-get id :diagnostic))))
        (message text)))
    (remove-hook 'flymake-diagnostic-functions #'flymake-proc-legacy-flymake))
  )
```


### Spell checker {#spell-checker}

김아더 WordNet 안뇽 Helle


#### `jinx` for Korean {#jinx-for-korean}

jinx 한글 커버

```elisp
(defun jh-checker/init-jinx ()
  (use-package jinx
    :ensure
    :init
    (spacemacs/declare-prefix "S"  "spelling")
    (spacemacs/set-leader-keys "Sj" 'jinx-correct) ; ko
    (spacemacs/set-leader-keys "SJ" 'jinx-mode) ; ko
    :config
    (setq jinx-languages "ko")
    (setq jinx-delay 0.5) ; default 0.2

    ;; (dolist (hook '(text-mode-hook conf-mode-hook)) ; prog-mode-hook
    ;;   (add-hook hook #'jinx-mode))

    (add-hook 'org-mode-hook #'jinx-mode)

    ;; 한글만 검사하면 된다.
    (setq jinx-exclude-regexps
          '((t "[A-Za-z]" "[']")))

    ;; 아래는 기본인데 일단 해보면서 보자.
    ;; "[A-Z]+\\>"         ;; Uppercase words
    ;; "\\w*?[0-9]\\w*\\>" ;; Words with numbers, hex codes
    ;; "[a-z]+://\\S-+"    ;; URI
    ;; "<?[-+_.~a-zA-Z][-+_.~:a-zA-Z0-9]*@[-.a-zA-Z0-9]+>?" ;; Email
    ;; "\\(?:Local Variables\\|End\\):\\s-*$" ;; Local variable indicator
    ;; "jinx-\\(?:languages\\|local-words\\):\\s-+.*$")) ;; Local variables

    ;; M-$점 앞의 철자가 틀린 단어에 대한 수정을 트리거합니다.
    ;; C-u M-$전체 버퍼에 대한 수정을 트리거합니다.
    (keymap-global-set "M-$" #'jinx-correct)
    ;; (keymap-global-set "C-;" #'jinx-correct)
    (keymap-global-set "C-M-$" #'jinx-languages)
    ;; (keymap-global-set "<remap> <ispell-word>" #'jinx-correct)
    ;; (define-key jinx-misspelled-map (kbd "C-;") 'jinx-correct)
    ))
```


#### `spell-fu` for English {#spell-fu-for-english}

영어는 빠른 스펠푸로

```elisp
(defun jh-checker/init-spell-fu ()
  (use-package spell-fu
    :defer
    :init
    (+spell-fu-register-dictionaries "en")
    ;; (require 'ispell)
    ;; (setq ispell-dictionary "en_US")
    ;; (setq ispell-program-name "aspell")
    ;; (setq ispell-personal-dictionary "~/.aspell_en_personal")
    :config
    (spacemacs/set-leader-keys "Sf" '+spell-fu-correct)
    (spacemacs/set-leader-keys "Sa" 'spell-fu-word-add)
    (spacemacs/set-leader-keys "SF" 'spell-fu-mode)

    ;; replace ispell-word
    (define-key evil-normal-state-map "z=" '+spell-fu-correct)
    (define-key evil-visual-state-map "z=" '+spell-fu-correct)
    ;; (keymap-global-set "M-$" #'jinx-correct) TODO find new bindings

    (setq spell-fu-idle-delay 1) ; default 0.25

    (defcustom +spell-excluded-faces-alist
      '((markdown-mode
         . (markdown-code-face
            markdown-html-attr-name-face
            markdown-html-attr-value-face
            markdown-html-tag-name-face
            markdown-inline-code-face
            markdown-link-face
            markdown-markup-face
            markdown-plain-url-face
            markdown-reference-face
            markdown-url-face))
        (org-mode
         . (org-block
            org-block-begin-line
            org-block-end-line
            org-cite
            org-cite-key
            org-level-1
            org-level-2
            org-level-3
            org-level-4
            org-level-5
            org-code
            org-date
            org-footnote
            org-formula
            org-inline-src-block
            org-latex-and-related
            org-link
            org-meta-line
            org-property-value
            org-ref-cite-face
            org-special-keyword
            org-tag
            org-todo
            org-todo-keyword-done
            org-todo-keyword-habt
            org-todo-keyword-kill
            org-todo-keyword-outd
            org-todo-keyword-todo
            org-todo-keyword-wait
            org-verbatim))
        (latex-mode
         . (font-latex-math-face
            font-latex-sedate-face
            font-lock-function-name-face
            font-lock-keyword-face
            font-lock-variable-name-face)))
      "Faces in certain major modes that spell-fu will not spellcheck."
      :group 'spell-fu
      :type '(repeat (cons symbol (repeat face))))

    (add-hook
     'spell-fu-mode-hook
     (defun +spell-fu--init-excluded-faces-h ()
       "Set `spell-fu-faces-exclude' according to `+spell-excluded-faces-alist'."
       (when-let (excluded (cdr (cl-find-if #'derived-mode-p +spell-excluded-faces-alist :key #'car)))
         (setq-local spell-fu-faces-exclude excluded)))))

  ;; spell-fu for english
  ;; (spell-fu-global-mode)
  (dolist (hook '(org-mode-hook markdown-mode-hook prog-mode-hook)) ; conf-mode-hook
    (add-hook hook #'spell-fu-mode))
  )
```


## Funcs {#funcs}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
```


### spell-fu functions {#spell-fu-functions}

```elisp
;; Adapted from Doom Emacs
(defun +spell-fu--correct (replace poss word orig-pt start end)
  "Correct word with spell-fu."
  (cond ((eq replace 'ignore)
         (goto-char orig-pt)
         nil)
        ((eq replace 'save)
         (goto-char orig-pt)
         (ispell-send-string (concat "*" word "\n"))
         (ispell-send-string "#\n")
         (setq ispell-pdict-modified-p '(t)))
        ((or (eq replace 'buffer) (eq replace 'session))
         (ispell-send-string (concat "@" word "\n"))
         (add-to-list 'ispell-buffer-session-localwords word)
         (or ispell-buffer-local-name ; session localwords might conflict
             (setq ispell-buffer-local-name (buffer-name)))
         (if (null ispell-pdict-modified-p)
             (setq ispell-pdict-modified-p
                   (list ispell-pdict-modified-p)))
         (goto-char orig-pt)
         (if (eq replace 'buffer)
             (ispell-add-per-file-word-list word)))
        (replace
         (let ((new-word (if (atom replace)
                             replace
                           (car replace)))
               (orig-pt (+ (- (length word) (- end start))
                           orig-pt)))
           (unless (equal new-word (car poss))
             (delete-region start end)
             (goto-char start)
             (insert new-word))))
        ((goto-char orig-pt)
         nil)))

;; Adapted from Doom Emacs
;;;###autoload
(defun +spell-fu-correct ()
  "Correct spelling of word at point."
  (interactive)
  ;; spell-fu fails to initialize correctly if it can't find aspell or a similar
  ;; program. We want to signal the error, not tell the user that every word is
  ;; spelled correctly.
  (unless (or (and ispell-really-aspell ispell-program-name)
              (executable-find "aspell"))
    (user-error "Aspell is required for spell checking"))

  (ispell-set-spellchecker-params)
  (save-current-buffer
    (ispell-accept-buffer-local-defs))
  (if (not (featurep 'vertico))
      (call-interactively #'ispell-word)
    (cl-destructuring-bind (start . end)
        (or (bounds-of-thing-at-point 'word)
            (user-error "No word at point"))
      (let ((word (thing-at-point 'word t))
            (orig-pt (point))
            poss ispell-filter)
        (ispell-send-string "%\n")
        (ispell-send-string (concat "^" word "\n"))
        (while (progn (accept-process-output ispell-process)
                      (not (string= "" (car ispell-filter)))))
        ;; Remove leading empty element
        (setq ispell-filter (cdr ispell-filter))
        ;; ispell process should return something after word is sent. Tag word as
        ;; valid (i.e., skip) otherwise
        (unless ispell-filter
          (setq ispell-filter '(*)))
        (when (consp ispell-filter)
          (setq poss (ispell-parse-output (car ispell-filter))))
        (cond
         ((or (eq poss t) (stringp poss))
          ;; don't correct word
          (message "%s is correct" (funcall ispell-format-word-function word))
          t)
         ((null poss)
          ;; ispell error
          (error "Ispell: error in Ispell process"))
         (t
          ;; The word is incorrect, we have to propose a replacement.
          (setq res (completing-read (format "Corrections for %S: " word) (nth 2 poss)))
          (unless res (setq res (cons 'break word)))
          (cond
           ((stringp res)
            (+spell-fu--correct res poss word orig-pt start end))
           ((let ((cmd (car res))
                  (wrd (cdr res)))
              (unless (or (eq cmd 'skip)
                          (eq cmd 'break)
                          (eq cmd 'stop))
                (+spell-fu--correct cmd poss wrd orig-pt start end)
                (unless (string-equal wrd word)
                  (+spell-fu--correct wrd poss word orig-pt start end))))))
          (ispell-pdict-save t)))))))

(defun +spell-fu--add-dictionary (lang)
  "Add `LANG` to spell-fu multi-dict, with a personal dictionary."
  ;; Add the dictionary
  (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary lang))
  (let ((personal-dict-file (expand-file-name (format "personal-aspell.%s.pws" lang) spell-fu-directory)))
    ;; Create an empty personal dictionary if it doesn't exists
    (unless (file-exists-p personal-dict-file) (write-region "" nil personal-dict-file))
    ;; Add the personal dictionary
    (spell-fu-dictionary-add (spell-fu-get-personal-dictionary (format "%s-personal" lang) personal-dict-file))))

;;;###autoload
(defmacro +spell-fu-register-dictionaries (&rest langs)
  "Register dictionaries for `LANGS` to spell-fu's multi-dict."
  (let* ((fn-name (intern (format "+spell-fu--multi-langs-%s-h" (string-join langs "-"))))
         (closure `(defun ,fn-name ())))
    (dolist (lang langs)
      (add-to-list 'closure `(+spell-fu--add-dictionary ,lang) t))
    (append '(add-hook (quote spell-fu-mode-hook)) (list closure))))
```
