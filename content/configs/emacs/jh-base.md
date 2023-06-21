+++
title = "jh-base layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-21T10:26:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-base
{{< /hint >}}

<!--more-->


## Goals {#goals}

-   spacemacs-defaults layers
-   TIPS
    -   [X] [Configure Vanilla Emacs in 10 Minutes - YouTube](https://youtu.be/eRHLGWajcTk)

대단한 배포판과 패키지를 찾지만 최신 이맥스 버전에서 제공하는 패키지들에
중요한 핵심은 다 들어 있다. 오히려 유명한 패키지는 최신 이맥스와
중복되는 기능들로 인해 호불호가 커지고 있다. 아래 레이어에서 제공하는
기능들은 기본으로 설치되는 것들이다. 키바인딩이 제대로 되어 있는지를
떠나서 활용을 잘 해야 한다. 기본적인 것들인데 설명이 없어서 놓치기 쉽다.
각 영역에서 세부 설정은 다루게 될 것이다.

-   2023-04-30
    base 만 넣으면 빌트인 + 최소 구성으로 동작하는거다. 완전 빌트인은 아니다.
    왜냐? Spacemacs 에서 구성하는 default 의 확장버전이기 때문이다. 오히려
    잘 됬다. bootstrap 에서 evil 등을 넣으니까 말이다. 문제는 여기에
    org 모드가 없는데 좀 그렇긴 하다만. ui 도 없고. base 를
    당장 만드는게 의미가 없겠다. 노가다만 크다.


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
   spacemacs-defaults
   helpful
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

;;;; Package Lists

(defconst jh-base-packages
  '(
    ;; electric
    ;; paren

;;;;; spacemacs-bootstrap
    which-key

    helpful
    time-stamp

;;;;; spacemacs-defaults

    recentf
    bookmark
    abbrev
    dabbrev
    dired
    ;; dired-x
    savehist
    ;; saveplace

    ;; tar-mode

    ;; archive-mode
    ;; conf-mode
    ;; cus-edit
    ;; display-line-numbers
    ;; electric-indent-mode
    ;; easypg
    ;; ediff
    ;; eldoc
    ;; help-fns+
    ;; hi-lock
    ;; image-mode
    ;; imenu
    ;; occur-mode
    ;; package-menu
    ;; page-break-lines
    ;; process-menu
    ;; quickrun
    ;; subword
    ;; uniquify
    ;; url
    ;; visual-line-mode
    ;; whitespace
    ;; winner
    ;; zone

;;;;; Additional built-in packages
    calendar
    tramp
    proced
    man

;;;;; Additional packages
    sideline

    ;; gc-buffers ; too aggressive
    ;; (explain-pause-mode :location (recipe :fetcher github :repo "lastquestion/explain-pause-mode"))
    ))
```


### Helpful {#helpful}

<span class="timestamp-wrapper"><span class="timestamp">[2023-05-22 Mon 06:26]</span></span>
shackle 과 연동하는 시나리오에 튜닝 필요

```elisp

;;;; Helpful

;; tshu/lisp/editor-misc.el
(defun jh-base/post-init-helpful ()
  (setq helpful-max-buffers 3)

  (defun helpful-reuse-window (buffer-or-name)
    "Switch to helpful BUFFER-OR-NAME.

The logic is simple, if we are currently in the helpful buffer,
reuse it's window, otherwise create new one."
    (if (eq major-mode 'helpful-mode)
        (pop-to-buffer-same-window buffer-or-name)
      (pop-to-buffer buffer-or-name)))

  (setq helpful-switch-buffer-function #'helpful-reuse-window)

  (with-eval-after-load 'ibuffer
    (add-to-list 'ibuffer-help-buffer-modes 'helpful-mode))

  )
```


### Which-key {#which-key}

Spacemacs 기본은 which-key-setup-side-window-bottom 이다.
minibuffer 와 통합한다는 것은 무슨 이점이 있을까?
<span class="timestamp-wrapper"><span class="timestamp">[2023-03-25 Sat 15:51]</span></span>

```elisp
;;;; Which-key

(defun jh-base/post-init-which-key ()
  (setq which-key-idle-delay 0.4)
  (setq which-key-ellipsis "..")

  ;; (setq which-key-sort-order 'which-key-key-order) ;; default
  ;; same as default, except single characters are sorted alphabetically
  (setq which-key-sort-order 'which-key-key-order-alpha) ; minemacs
  ;; same as default, except all prefix keys are grouped together at the end
  ;; (setq which-key-sort-order 'which-key-prefix-then-key-order) ; Spacemacs default

  (setq which-key-min-display-lines 6)
  (setq which-key-max-description-length 36) ; spacemacs 32

  ;; Allow a key binding to be modified by multiple rules in
  ;; `which-key-replacement-alist'
  ;; (setq
  ;;  which-key-replacement-alist
  ;;  (append
  ;;   which-key-replacement-alist
  ;;   (list
  ;;    '(("\\`g z" . "\\`evil-\\(?:mc\\|multiedit\\)-\\(.*\\)")    . (nil . "⌶·\\1"))
  ;;    '(("\\`g c" . "\\`evilnc-\\(.*\\)")                         . (nil . "#·\\1"))
  ;;    '(("\\`g" . "\\`[Ii]nfo[-:]?\\(?:a-\\)?\\(.*\\)")           . (nil . "ɩ·\\1"))
  ;;    ;; '(("\\`SPC TAB" . "\\`tabspaces-\\(.*\\)")                  . (nil . "⭾·\\1"))
  ;;    '(("\\`SPC p" . "\\`\\+?\\(?:consult-\\)?project-\\(.*\\)") . (nil . "🅟·\\1"))
  ;;    '(("" . "\\`evil[-:]?\\(?:a-\\)?\\(.*\\)")                  . (nil . "ɛ·\\1")))))

  (add-to-list 'which-key-replacement-alist '(("TAB" . nil) . ("↹" . nil)))
  (add-to-list 'which-key-replacement-alist '(("RET" . nil) . ("⏎" . nil)))
  (add-to-list 'which-key-replacement-alist '(("DEL" . nil) . ("⇤" . nil)))
  (add-to-list 'which-key-replacement-alist '(("SPC" . nil) . ("␣" . nil)))
  )
```


### Recentf {#recentf}



```elisp
;;;; Recentf

(defun jh-base/pre-init-recentf ()
  (spacemacs|use-package-add-hook recentf
    ;; :pre-init
    ;; (message "JH pre-init-recentf")
    ;; :post-init
    ;; (message "JH post-init-recentf")
    ;; :pre-config
    ;; (message "JH pre-config-recentf")
    :post-config
    ;; (message "JH post-config-recentf")
    ;; (setq recentf-save-file (concat dotspacemacs-directory "var/recentf"))
    (setq recentf-max-saved-items 200) ; default 20
    ;; (add-hook 'after-init-hook 'recentf-mode)
    (recentf-mode +1)
    ))
```


### Dired {#dired}



```elisp
;;;; Dired

;; https://systemcrafters.cc/emacs-from-scratch/effortless-file-management-with-dired/
(defun jh-base/post-init-dired ()
  ;; -al ; spacemacs
  ;; Make sure to use the long name of flags when exists
  ;; eg. use "--almost-all" instead of "-A"
  ;; Otherwise some commands won't work properly
  ;; tshu :: dired-listing-switches "-aBhl --group-directories-first"
  ;; (setq dired-listing-switches
  ;;       "-l --almost-all --human-readable --time-style=long-iso --group-directories-first --no-group")
  ;; (setq dired-listing-switches
  ;;       "-h -g -u --time-style=long-iso --group-directories-first -o")

  (setq dired-auto-revert-buffer t)
  ;; (setq dired-hide-details-hide-symlink-targets t)
  ;; (setq dired-kill-when-opening-new-dired-buffer t)

  ;; from prot
  ;; (setq dired-make-directory-clickable t) ; Emacs 29.1
  ;; (setq dired-free-space nil) ; Emacs 29.1
  ;; (setq dired-guess-shell-alist-user ; those are the suggestions for ! and & in Dired
  ;;       '(("\\.\\(png\\|jpe?g\\|tiff\\)" "feh" "xdg-open")
  ;;         ("\\.\\(mp[34]\\|m4a\\|ogg\\|flac\\|webm\\|mkv\\)" "mpv" "xdg-open")
  ;;         (".*" "xdg-open")))

  ;; Mouse support
  ;; (setq mouse-drag-copy-region t) ; default nil
  ;; (setq dired-mouse-drag-files t) ; Emacs 29.1

  ;; (setq dired-recursive-copies 'always)
  ;; (setq dired-recursive-deletes 'always)
  ;; (setq dired-create-destination-dirs 'always)

  ;; (add-hook 'dired-mode-hook
  ;;           (lambda ()
  ;;             (setq truncate-lines t)
  ;;             (visual-line-mode nil)))

  (when my/is-termux
    (add-hook 'dired-mode-hook #'dired-hide-details-mode))
  ;; (add-hook 'dired-mode-hook #'dired-hide-details-mode)

  (defun my/dired-home ()
    "Open dired at $HOME"
    (interactive)
    (dired (expand-file-name "~")))

  (spacemacs/set-leader-keys "od" 'my/dired-home)

  (defun my/dired-open-this-subdir ()
    (interactive)
    (dired (dired-current-directory)))

  (defun my/dired-kill-all-subdirs ()
    (interactive)
    (let ((dir dired-directory))
      (kill-buffer (current-buffer))
      (dired dir)))

  (spacemacs/declare-prefix-for-mode 'dired-mode "ms" "subdir")
  (spacemacs/set-leader-keys-for-major-mode 'dired-mode
    "ss" 'dired-maybe-insert-subdir
    "ss" 'dired-maybe-insert-subdir
    "sl" 'dired-maybe-insert-subdir
    "sq" 'dired-kill-subdir
    "sk" 'dired-prev-subdir
    "sj" 'dired-next-subdir
    "sS" 'my/dired-open-this-subdir
    "sQ" 'my/dired-kill-all-subdirs
    )

  (spacemacs/set-leader-keys-for-major-mode 'dired-mode
    "h" 'dired-hide-details-mode
    "o" 'dired-omit-mode)

  ;; The search next/previous commands are different because of the
  ;; `evil-search-module' values: vim = evil-search, hybrid = isearch

  ;; wdired is a mode that allows you to rename files and directories by editing the
  ;; =dired= buffer itself.
  (require 'wdired)

  (setq wdired-allow-to-change-permissions t)
  (setq wdired-create-parent-directories t)
  (evil-define-key 'normal wdired-mode-map (kbd "^") 'evil-first-non-blank)
  (evil-define-key 'normal dired-mode-map
    (kbd "C-c C-e") 'wdired-change-to-wdired-mode
    (kbd "h") 'dired-up-directory
    (kbd "l") 'dired-find-file)
  )
```


### Simple `Bookmark` {#simple-bookmark}

```elisp
;;;; Bookmark

(defun jh-base/post-init-bookmark ()
  (setq bookmark-default-file (concat dotspacemacs-directory "var/bookmarks"))
  (setq bookmark-use-annotations nil)
  (setq bookmark-automatically-show-annotations t)
  (setq bookmark-set-fringe-mark t)  ; Emacs 28
  (add-hook 'bookmark-bmenu-mode-hook #'hl-line-mode)
  )
```


### Savehist {#savehist}



```elisp
;;;; Savehist

(defun jh-base/pre-init-savehist ()
  (spacemacs|use-package-add-hook savehist
    :post-init
    ;; 기본이 100, 스페이스맥스 1000
    (setq history-delete-duplicates t) ; default nil
    (setq history-length 500)

    (add-to-list 'savehist-additional-variables 'corfu-history)
    ;; (corfu-history evil-jumps-history projectile-project-command-history mark-ring global-mark-ring search-ring regexp-search-ring extended-command-history kill-ring)
    )
  )
```


### `dabbrev` dynamic word completion {#dabbrev-dynamic-word-completion}

<span class="timestamp-wrapper"><span class="timestamp">[2023-02-13 Mon 02:50]</span></span>
이것은 버퍼 내부의 동적/임의 텍스트 완성에 대한 Emacs 의 고유한 접근 방식입니다:
"동적 약어" 또는 `dabbrev`. 이 메커니즘은 적절한 일치 항목을 찾기 위해 지점
이전의 모든 텍스트를 읽는 방식으로 작동합니다. 다른 시나리오에 따라 포워드 및
다른 버퍼를 살펴봐야 하는지 여부가 결정됩니다. 본질적으로 Dabbrev 는 이미 가지고
있는 것을 다시 입력하는 데 도움이 됩니다.

`dabbrev-expand=를 사용하여 해당 지점에서 텍스트를 완성하려고 시도합니다. 반복
호출은 후보를 순환합니다. 피드백은 제공되지 않으며, kill-ring에서 끌어오기가
작동하는 것과 거의 동일합니다(Emacs28의 경우 =yank-pop` on `M-y=는 이전 명령이
=yank` on =C-y=가 아닌 경우 완성을 사용함). 마지막 성공적인 =dabbrev-expand=와
일치하는 구를 완성하려면 빈 공간을 제공하고 명령을 다시 호출해야 합니다. 이것은
N 단어에 대해 다음 단어와 일치합니다.

반면 =dabbrev-completion=은 미니버퍼 상호 작용 및 패턴 일치 스타일의 이점을
얻습니다(완성 프레임워크 및 추가). Corfu 의 도움으로 완료 후보가 지점 근처의 팝업
창에 표시됩니다(버퍼 내 완료를 위한 Corfu).

=dabbrev-abbrev-char-regexp=는 일반 단어와 기호(예: 하이픈으로 구분된 단어)
모두와 일치하도록 구성됩니다. 이것은 코드와 일반 언어에 똑같이 적합합니다.

`dabbrev-abbrev-skip-leading-regexp=는 =$`, `*`, `/`, `=`, `~`, `' 중 하나로
시작하는 단어와 기호도 확장하도록 지시됩니다. =. 이 정규식은 나중에 확장될 수
있지만 알려진 단어/기호 앞에 특수 문자가 있는 컨텍스트에서 완성을 수행할 수
있도록 하는 것이 아이디어입니다. 예를 들어, 이 문서의 =org-mode` 버전에서 모든
인라인 코드는 등호 사이에 배치되어야 합니다. 이제 ===를 입력한 다음 문자를
입력하면 해당 입력을 기반으로 텍스트를 확장할 수 있습니다.

```elisp
;;;; Dabbrev : Dynamic Word Completion

(defun jh-base/init-dabbrev ()
  (use-package dabbrev
    :demand
    :init
    ;; (setq dabbrev-abbrev-char-regexp "\\sw\\|\\s_") ; prot
    (setq dabbrev-abbrev-char-regexp "[A-Za-z-_]") ; tshu
    (setq dabbrev-ignored-buffer-regexps '("\\.\\(?:pdf\\|jpe?g\\|png\\)\\'"))
    (setq dabbrev-abbrev-skip-leading-regexp "[$*/=~']")
    :config
    (let ((map global-map))
      (define-key map (kbd "M-/") #'dabbrev-expand)
      (define-key map (kbd "C-M-/") #'dabbrev-completion)))
  )
```


### `abbrev` abbreviations {#abbrev-abbreviations}

23/01/03--17:43 :: 아주 잘 동작하는데 사용법이 좀 더 연구가 필요하다.

-   M-/
-   abbrev-mode
    C-x a -
    C-x a i l
    C-x a i g
    (setq-default abbrev-mode t)
    (read-abbrev-file "~/.abbrev_defs")
    (setq save-abbrevs t)
-   edit-abbrevs
-   list-abbrevs
-   kill-all-abbrevs

<!--listend-->

```elisp
;;;; Abbrev : Abbreviations

(defun jh-base/post-init-abbrev ()
  (setq abbrev-file-name (concat dotspacemacs-directory "var/abbrev_defs"))

  (read-abbrev-file abbrev-file-name)
  (setq save-abbrevs t)
  (setq-default abbrev-mode t)
  )
```


### Sideline {#sideline}

<span class="timestamp-wrapper"><span class="timestamp">[2023-04-27 Thu 17:19]</span></span>
[GitHub - emacs-sideline/sideline: Show information on the...](https://github.com/emacs-sideline/sideline)

```elisp
;;;; Sideline

(defun jh-base/init-sideline ()
  (use-package sideline
    :ensure
    :init
    ;; (setq sideline-delay 1.0) ; 0.5
    (setq sideline-backends-skip-current-line t  ; don't display on current line
          sideline-order-left 'down              ; or 'up
          sideline-order-right 'up               ; or 'down
          sideline-format-left "%s   "           ; format for left aligment
          sideline-format-right "   %s"          ; format for right aligment
          sideline-priority 100                  ; overlays' priority
          sideline-display-backend-name t)      ; display the backend na
    ;; :config
    ;; (global-sideline-mode 1)
    )
  )

;; Customization Tips
;; (setq sideline-backends-left '(sideline-flycheck)
;;   sideline-backends-right '(sideline-lsp)))
;; (setq sideline-backends-right '((sideline-lsp      . up)
;;                              (sideline-flycheck . down))))
```


### TRAMP {#tramp}

TRAMP 를 경험 해봐야 한다.

```elisp
;;;; Tramp

(defun jh-base/init-tramp ()
  (use-package tramp
    :defer
    :init
    ;; :commands tramp-file-local-name
    ;; Set default connection mode to SSH
    (setq tramp-default-method "ssh")

    (setq remote-file-name-inhibit-cache 60 ; default 10
          tramp-verbose 1 ; default 3
          vc-handled-backends '(SVN Git))

    :config
    (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
    (defun my/show-server-edit-buffer (buffer)
      ;; TODO: Set a transient keymap to close with 'C-c C-c'
      (split-window-vertically -15)
      (other-window 1)
      (set-buffer buffer))
    ;; (setq server-window #'my/show-server-edit-buffer)
    )
  )
```


### Tools for manual pages (manpages) {#tools-for-manual-pages--manpages}



```elisp
;;;; Man

(defun jh-base/init-man ()
  (use-package man
    :defer 10
    :after evil
    :config
    (setq Man-notify-method 'pushy) ; does not obey `display-buffer-alist'
    (let ((map Man-mode-map))
      (define-key map (kbd "i") #'Man-goto-section)
      (define-key map (kbd "g") #'Man-update-manpage))

    (evil-define-key '(motion normal visual) Man-mode-map
      "M-n" 'Man-next-section
      "M-p" 'Man-previous-section
      "]]" 'Man-next-section
      "[[" 'Man-previous-section
      "gs" 'Man-goto-section
      ">"  'Man-follow-manual-reference)
    )
  )
```


### Calendar {#calendar}

```elisp
;;;; Calendar

(defun jh-base/init-calendar ()
  (use-package calendar
    :ensure t
    :config
    ;; (setq org-agenda-start-on-weekday nil)
    (setq calendar-date-style 'iso ;; YYYY/MM/DD
          calendar-mark-holidays-flag t
          calendar-week-start-day 1 ;; 0 Sunday, 1 Monday
          calendar-mark-diary-entries-flag nil
          calendar-latitude 37.26
          calendar-longitude 127.01
          calendar-location-name "Suwon, KR"
          calendar-time-display-form
          '(24-hours ":" minutes
                     (if time-zone " (") time-zone (if time-zone ")")))
    )
  )
```


### Proced (process monitor, similar to 'top') {#proced--process-monitor-similar-to-top}



```elisp
;;;; Proced

(defun jh-base/init-proced ()
  (use-package proced
    :defer 10
    :init
    (setq proced-auto-update-flag t)
    (setq proced-enable-color-flag t) ; Emacs 29
    (setq proced-auto-update-interval 5)
    (setq proced-descend t)
    (setq proced-filter 'user))
  )
```


### Time-stamp {#time-stamp}



```elisp
;;;; Time-Stamp

(defun jh-base/init-time-stamp ()
  (require 'time-stamp)
  (add-hook 'write-file-functions 'time-stamp) ; update when saving
  )
```


## Funcs {#funcs}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
```


### Helper Functions {#helper-functions}

Many people configure their emacs with the help of macros such as `use-package`.
I prefer to keep my init lower-level and simple. I have written some simple
functions that will make configuration less repetitive.

Using my own functions for the things I want or need keeps my overall package
load smaller.

`vanilla/trevdev-dotfiles/config.org:232`

Create a mode for mapping high priority keybinds early on.

```elisp
;;; Helper Functions

(defun td/bind-keys (conses &optional mode-map)
  "Bind several keybinds using a list of `CONSES'.
  Binds will be global unless the optional `MODE-MAP' is specified."
  (dolist (combo conses)
    (if (or (consp mode-map) (keymapp mode-map))
        (define-key mode-map (kbd (car combo)) (cdr combo))
      (if mode-map (warn "Optional %s `MODE-MAP' was invalid: %s" (type-of mode-map) mode-map))
      (global-set-key (kbd (car combo)) (cdr combo)))))

(defun td/add-hooks (modes func)
  "Set several hooks from a list of `CONSES'.
  Adds '-hook' onto the end of the symbols for brevity."
  (dolist (mode modes)
    (add-hook (intern (concat (symbol-name mode) "-hook")) func)))

(defun td/auto-mode (modes)
  "Add the `MODES' to the `auto-mode-alist'."
  (dolist (mode modes)
    (add-to-list 'auto-mode-alist mode)))

(defun td/filter-nil (seq)
  "Filter out nil items from sequence `SEQ'."
  (seq-filter #'(lambda (item) item) seq))

(defun td/is-file-buffer (buffer)
  "Test if a buffer belongs to a file on the system. Returns non-nil if it does."
  (let ((file (buffer-file-name buffer)))
    (when file
      (file-exists-p file))))
```


### Extra Functions {#extra-functions}

helper loader skeeto/youtube-dl-emacs

```elisp
;;; Extra Functions

(defun describe-last-function ()
  (interactive)
  (describe-function last-command))

  ;;; expose
(defun expose (function &rest args)
  "Return an interactive version of FUNCTION, 'exposing' it to the user."
  (lambda ()
    (interactive)
    (apply function args)))

  ;;; what-face
(defun what-face (pos)
  "Show the name of face under point."
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))


;; /home/junghan/sync/man/dotsamples/korean/injae-dotfiles/module/+util.el
                                        ; text random
(defun randomize-region (beg end)
  (interactive "r")
  (if (> beg end)
      (let (mid) (setq mid end end beg beg mid)))
  (save-excursion
    ;; put beg at the start of a line and end and the end of one --
    ;; the largest possible region which fits this criteria
    (goto-char beg)
    (or (bolp) (forward-line 1))
    (setq beg (point))
    (goto-char end)
    ;; the test for bolp is for those times when end is on an empty
    ;; line; it is probably not the case that the line should be
    ;; included in the reversal; it isn't difficult to add it
    ;; afterward.
    (or (and (eolp) (not (bolp)))
        (progn (forward-line -1) (end-of-line)))
    (setq end (point-marker))
    (let ((strs (shuffle-list
                 (split-string (buffer-substring-no-properties beg end)
                               "\n"))))
      (delete-region beg end)
      (dolist (str strs)
        (insert (concat str "\n"))))))

(defun shuffle-list (list)
  "Randomly permute the elements of LIST.
  All permutations equally likely."
  (let ((i 0) j temp
        (len (length list)))
    (while (< i len)
      (setq j (+ i (random (- len i))))
      (setq temp (nth i list))
      (setcar (nthcdr i list) (nth j list))
      (setcar (nthcdr j list) temp)
      (setq i (1+ i))))
  list)

(defun new-buffer-save (name buffer-major-mode)
  (interactive)
  (let ((buffer (generate-new-buffer name)))
    (switch-to-buffer buffer)
    (set-buffer-major-mode buffer)
    (funcall buffer-major-mode)
    (setq buffer-offer-save t))
  )

(defun new-buffer (name buffer-major-mode)
  (let ((buffer (generate-new-buffer name)))
    (switch-to-buffer buffer)
    (set-buffer-major-mode buffer)
    (funcall buffer-major-mode))
  )

(defun new-no-name-buffer ()
  (interactive)
  (new-buffer "untitled" 'text-mode)
  )

  ;;; System
;; (defun numcores ()
;;   "Return the number of logical processors on this system."
;;   (or
;;    ;; Linux
;;    (when (file-exists-p "/proc/cpuinfo")
;;      (with-temp-buffer
;;        (insert-file-contents "/proc/cpuinfo")
;;        (how-many "^processor[[:space:]]+:")))
;;    ;; Windows
;;    (let ((number-of-processors (getenv "NUMBER_OF_PROCESSORS")))
;;      (when number-of-processors
;;        (string-to-number number-of-processors)))
;;    ;; BSD+OSX
;;    (with-temp-buffer
;;      (ignore-errors
;;        (when (zerop (call-process "sysctl" nil t nil "-n" "hw.ncpu"))
;;          (string-to-number (buffer-string)))))
;;    ;; Default
;;    1))

  ;;; measure-time
;; (defmacro measure-time (&rest body)
;;   "Measure and return the running time of the code block."
;;   (declare (indent defun))
;;   ;; Fresh garbage collection before making any measurements.
;;   (garbage-collect)
;;   (let ((start (make-symbol "start")))
;;     `(let ((,start (float-time)))
;;        ,@body
;;        (- (float-time) ,start))))

  ;;; random
;; (defun insert-random (n)
;;   "Insert a random number between 0 and the prefix argument."
;;   (interactive "P")
;;   (insert (number-to-string (random n))))
;; ;; (global-set-key (kbd "C-c r") 'insert-random)

;; (cl-defun insert-random-hex (&optional (size 64))
;;   "Insert a random, SIZE-bit number as hexadecimal."
;;   (interactive)
;;   (let ((string (make-string (/ size 4) 0))
;;         (digits "0123456789abcdef"))
;;     (dotimes (i (/ size 4))
;;       (setf (aref string i) (aref digits (cl-random 16))))
;;     (insert string)))

;; (defun eval-and-replace (value)
;;   "Evaluate the sexp at point and replace it with its value."
;;   (interactive (list (eval-last-sexp nil)))
;;   (kill-sexp -1)
;;   (insert (format "%S" value)))

  ;;; Dictionary lookup
;; (defun lookup-word (word)
;;   (interactive (list (thing-at-point 'word)))
;;   (browse-url (format "http://en.wiktionary.org/wiki/%s" word)))
;; (global-set-key (kbd "M-#") 'lookup-word)

  ;;; Quick switch to scratch buffers
;; (defmacro scratch-key (key buffer-name mode)
;;   `(global-set-key ,key (lambda ()
;;                           (interactive)
;;                           (switch-to-buffer ,buffer-name)
;;                           (unless (eq major-mode ',mode)
;;                             (,mode)))))

;; (declare-function js2-mode nil)
;; (declare-function clojure-mode nil)
;; (scratch-key (kbd "C-c s") "*scratch*"    emacs-lisp-mode)
;; (scratch-key (kbd "C-c j") "*javascript*" js2-mode)
;; (scratch-key (kbd "C-c x") "*css*"        css-mode)
;; (scratch-key (kbd "C-c h") "*html*"       html-mode)

;; ID: 72dc0a9e-c41c-31f8-c8f5-d9db8482de1e
;; (defun find-all-files (dir)
;;   "Open all files and sub-directories below the given directory."
;;   (interactive "DBase directory: ")
;;   (let* ((list (directory-files dir t "^[^.]"))
;;          (files (cl-remove-if 'file-directory-p list))
;;          (dirs (cl-remove-if-not 'file-directory-p list)))
;;     (dolist (file files)
;;       (find-file-noselect file))
;;     (dolist (dir dirs)
;;       (find-file-noselect dir)
;;       (find-all-files dir))))

  ;;; Process menu killing
;; (define-key process-menu-mode-map (kbd "k") #'process-menu-kill)
;; (defun process-menu-kill ()
;;   "Kill selected process in the process menu buffer."
;;   (interactive)
;;   (let ((process (get-text-property (point) 'tabulated-list-id)))
;;     (when (processp process) (delete-process process))
;;     (run-at-time 0.1 nil (lambda ()
;;                            (let ((n (line-number-at-pos)))
;;                              (revert-buffer)
;;                              (forward-line (1- n)))))))

  ;;; Help mode assistance
;; (defun push-first-button ()
;;   "Find and push the first button in this buffer, intended for `help-mode'."
;;   (interactive)
;;   (cl-block :find-button
;;     (goto-char (point-min))
;;     (while (< (point) (point-max))
;;       (if (get-text-property (point) 'button)
;;           (cl-return-from :find-button (push-button))
;;         (forward-char)))))

  ;;; Tabs
;; (defun toggle-tab-width ()
;;   (interactive)
;;   (let* ((loop [8 4 2])
;;          (match (or (cl-position tab-width loop) -1)))
;;     (setf tab-width (aref loop (mod (1+ match) (length loop))))))
;; (global-set-key (kbd "C-h t") #'toggle-tab-width)
```


### Open user-files {#open-user-files}

```elisp
;;; Open user-files

(defun my/open-fortune-quotes ()
  (interactive )
  (find-file "~/sync/obsd/fortunes/quotes-ko.md"))
(defun my/open-dotsamples-readme ()
  (interactive )
  (find-file "~/sync/man/dotsamples/README.org"))
(defun my/open-dotspacemacs-org ()
  (interactive)
  (find-file (concat dotspacemacs-directory "dot-org/spacemacs.org")))
(defun my/open-tempel-templates ()
  (interactive)
  (find-file (concat dotspacemacs-directory "tempel-templates.eld")))
(defun my/open-hunspell-personal ()
  (interactive)
  (find-file (concat dotspacemacs-directory ".hunspell_ko_personal")))
(defun my/open-elfeed-list ()
  (interactive)
  (find-file "~/sync/org/elfeed/elfeed.org"))
(defun my/open-dict-ko-mydata ()
  (interactive)
  (find-file (concat dotspacemacs-directory "dict-ko-mydata.yaml")))
(defun my/open-abbrev-defs ()
  (interactive)
  (find-file "~/spacemacs/.cache/abbrev_defs"))
(defun my/open-dotworkflow-org ()
  (interactive)
  (find-file (concat dotspacemacs-directory "lisp/my-org-workflow.org")))
(defun my/open-csaroid-list ()
  (interactive)
  (find-file "~/sync/org/csaoid/"))
```


### Terminal Mode Hook {#terminal-mode-hook}

[doomemacs/doomemacs#5167 Scrolling for touch devices - En...](https://github.com/doomemacs/doomemacs/issues/5167)

```elisp
;;; Terminal mode hook

;; turn off =show-smartparens-global-mode=
;; turn off =global-page-break-lines-mode=
;; scrolling for touch devices enable the function mouse-wheel-mode
(defun jh-base/enable-terminal-mode ()
  (message "[LOG] jh-base/enable-terminal-mode")
  (show-smartparens-global-mode -1)
  (global-page-break-lines-mode -1)

  ;; I have successfully used the following configuration in Spacemacs on termux
  ;; (Android) to be able to scroll vertically with screen gestures (swipe up /
  ;; down) :
  (load "mwheel")
  (mwheel-install)
  (mouse-wheel-mode 1)
  (setq mouse-wheel-progressive-speed nil)
  (setq redisplay-dont-pause t)
  (setq mouse-wheel-scroll-amount
        '(1 ((shift) . 1)
            ((control) . nil)))
  )

(unless (display-graphic-p)
  ;; (add-hook 'spacemacs-post-user-config-hook
  (add-hook 'after-init-hook #'jh-base/enable-terminal-mode))
```


## Configs {#configs}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
```


### <span class="org-todo todo TODO">TODO</span> Parens Stuff (built-in) {#parens-stuff--built-in}

[GitHub - AmaiKinono/puni: Structured editing (soft deleti...](https://github.com/AmaiKinono/puni)

```elisp
;;; Paren and Electric-pair

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Matching.html
;; 괄호, 구분자(delimiter) 쌍 강조
(with-eval-after-load 'paren
  ;; 괄호만 강조
  ;; (setq show-paren-style 'parenthesis) ; default
  ;; 괄호 강조를 즉시 보여준다
  ;; (setq show-paren-delay 0) ; 0.125
  ;; 괄호 입력 후 내용 입력시 괄호를 강조
  (setq show-paren-when-point-inside-paren t)
  (setq show-paren-when-point-in-periphery t)
  ;; 괄호 강조를 즉시 보여준다
  (setq show-paren-delay 0) ; 0.125
  ;; (show-paren-mode)
  )

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Matching.html
;; 괄호, 구분자(delimiter) 자동 쌍 맞추기
(setq electric-pair-pairs '((?\{ . ?\})
                            (?\( . ?\))
                            (?\[ . ?\])
                            (?\" . ?\")))

;; tab으로 electic pair 밖으로 나올 수 있게 한다
;; https://www.reddit.com/r/emacs/comments/3n1j4x/anyway_to_tab_out_of_parentheses/
;; (progn
;;   (defun smart-tab-jump-out-or-indent (&optional arg)
;;     (interactive "P")
;;     (let ((closings (mapcar #'cdr electric-pair-pairs))
;;           (after (char-after)))
;;       (if (member after closings)
;;           (forward-char 1)
;;         (indent-for-tab-command arg))))
;;   (global-set-key [remap indent-for-tab-command] 'smart-tab-jump-out-or-indent)
;;   )
```
