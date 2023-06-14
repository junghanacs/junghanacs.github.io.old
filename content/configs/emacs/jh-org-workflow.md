+++
title = "jh-org-workflow"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:53:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
노랑님의 워크플로우 기반 커스텀
{{< /hint >}}

<!--more-->


## GUIDE {#guide}

노랑님의 체계를 거의 따라갑니다. 키바인딩도 왠만하면 변경하지 않습니다.
노랑님 시스템에 익숙해 지고 나서, 최근 이맥스의 흐름을 반영하고자 합니다.

{{< hint info >}}
아래는 노랑님의 글을 대충 번역한 것이다. 읽어 보고 한글로 이해 안되면 원문을
보고 수정한다. 이해되는 수준이라면 번역이 별로여도 손대지 않는다. 손대기
시작하면 나의 문장으로 다시 써야 하는데 시간이 오래 걸리는 일이다.
{{< /hint >}}


## Packages <span class="tag"><span class="donotmove">donotmove</span></span> {#packages}

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

(defconst jh-org-workflow-packages
  '(
    org
    ))
```


## <kbd>START</kbd> `post-init-org` <span class="tag"><span class="donotmove">donotmove</span></span> {#start-post-init-org}

-   Basic syntax
-   Hotkeys for creating headlines and moving them
-   Basic formatting
-   Links (`org-insert-link`, `org-open-at-point`)
-   Tables
-   Bulleted lists, checkboxes (`s-M-RET` to make new check item)
-   Source blocks
-   Inline code
-   Tasks (`C-c C-t`, `org-todo`)
-   Indentation 이슈 (2023-04-16)
    org-indent-mode 를 사용하면 adapt-indentation 은 자동 비활성화
    startup-indent 를 켜면 org-indent-mode 활성화
    org-modern, org-modern-indent-mode 는 터미널 모드에서 src block 문제
    즉, Simple is Best. org-indent-mode 만 org-mode-hook 으로 추가!
-   Evil Collection
    [tab] 'org-cycle
    [S-tab] 'org-shifttab
    "{" 'org-backward-paragraph
    "}" 'org-forward-paragraph
    "(" 'org-backward-sentence
    ")" 'org-forward-sentence

<!--listend-->

```elisp
;;;; 'post-init-org' Load org-workflow

(defun jh-org-workflow/post-init-org ()
```


## Getting Started {#getting-started}

4 장에서 설정 관련 핵심 철학이 나온다. 파일 구성이다.


### My day goes generally like this: {#my-day-goes-generally-like-this}

-   Punch in (this starts the clock on the default task)
-   Look at the agenda and make a mental note of anything important to deal with today
-   Read email and news
    -   create notes, and tasks for things that need responses with org-capture
-   Check refile tasks and respond to emails
-   Look at my agenda and work on important tasks for today
    -   Clock it in
    -   Work on it until it is DONE or it gets interrupted
-   Work on tasks
-   Make journal entries (C-c c j) for interruptions
-   Punch out for lunch and punch back in after lunch
-   work on more tasks
-   Refile tasks to empty the list
    -   Tag tasks to be refiled with m collecting all tasks for the same target
    -   Bulk refile the tasks to the target location with B r
    -   Repeat (or refile individually with C-c C-w) until all refile tasks are gone
-   Mark habits done today as DONE
-   Punch out at the end of the work day


### Keybinding Tables {#keybinding-tables}

```text
노랑님 바인딩 예
```

I have the following custom key bindings set up for my emacs (sorted by frequency).

| Key     | For                                             | Used       |
|---------|-------------------------------------------------|------------|
| F12     | Agenda (1 key less than C-c a)                  | Very Often |
| C-c b   | Switch to org file                              | Very Often |
| F11     | Goto currently clocked item                     | Very Often |
| C-c c   | Capture a task                                  | Very Often |
| C-F11   | Clock in a task (show menu with prefix)         | Often      |
| f9 g    | Gnus - I check mail regularly                   | Often      |
| f5      | Show todo items for this subtree                | Often      |
| S-f5    | Widen                                           | Often      |
| f9 b    | Quick access to bbdb data                       | Often      |
| f9 c    | Calendar access                                 | Often      |
| C-S-f12 | Save buffers and publish current project        | Often      |
| C-c l   | Store a link for retrieval with C-c C-l         | Often      |
| f8      | Go to next org file in org-agenda-files         | Sometimes  |
| f9 r    | Boxquote selected region                        | Sometimes  |
| f9 t    | Insert inactive timestamp                       | Sometimes  |
| f9 v    | Toggle visible mode (for showing/editing links) | Sometimes  |
| C-f9    | Previous buffer                                 | Sometimes  |
| C-f10   | Next buffer                                     | Sometimes  |
| C-x n r | Narrow to region                                | Sometimes  |
| f9 f    | Boxquote insert a file                          | Sometimes  |
| f9 i    | Info manual                                     | Sometimes  |
| f9 I    | Punch Clock In                                  | Sometimes  |
| f9 O    | Punch Clock Out                                 | Sometimes  |
| f9 o    | Switch to org scratch buffer                    | Sometimes  |
| f9 s    | Switch to scratch buffer                        | Sometimes  |
| f9 h    | Hide other tasks                                | Rare       |
| f7      | Toggle line truncation/wrap                     | Rare       |
| f9 T    | Toggle insert inactive timestamp                | Rare       |
| C-c a   | Enter Agenda (minimal emacs testing)            | Rare       |


### Keybinding Codes {#keybinding-codes}

| Key         | For                           | Used       |
|-------------|-------------------------------|------------|
| C-n/p       | org-next/prev-visible-heading | Very Often |
| M-n/p       | org-next/prev-link            | Very Often |
| C-c %/&amp; | org-mark-ring-push/goto       | Very Often |
| C-c @       | org-mark-subtree              |            |
| M-hjkl      | org-meta hjkl                 | Very Often |

```elisp
;; from DW
(evil-define-key '(normal insert visual) org-mode-map (kbd "C-n")
  'org-next-visible-heading)
(evil-define-key '(normal insert visual) org-mode-map (kbd "C-p")
  'org-previous-visible-heading)

;; =C-c %= org-mark-ring-push, =C-c &= org-mark-ring-goto
;; =C-c @= org-mark-subtree
;; https://orgmode.org/manual/Handling-Links.html
;; (define-key org-mode-map (kbd "C-M-n") 'org-next-link)
;; (define-key org-mode-map (kbd "C-M-p") 'org-previous-link)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c i") 'org-insert-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c \\") 'org-tags-sparse-tree)

;; The following setting is different from the document so that you
;; can override the document org-agenda-files by setting your
;; org-agenda-files in the variable org-user-agenda-files
;; (if (boundp 'org-user-agenda-files)
;;     (setq org-agenda-files org-user-agenda-files)
;;   (setq org-agenda-files (quote ("~/sync/org/workflow"))))

;; (if (boundp 'org-user-agenda-diary-file)
;;     (setq org-agenda-diary-file org-user-agenda-diary-file)
;;   (setq org-agenda-diary-file "~/org/diary.org"))

;; (setq org-agenda-files (list "~/sync/org/workflow/")))
;; (setq org-agenda-files (quote ("~/sync/org/calendar"
;;                                "~/sync/org/workflow"))))

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

;; unset old key
(global-unset-key (kbd "<f4>"))
(global-unset-key (kbd "<f5>"))
(global-unset-key (kbd "<f9>"))

;; JUNGHAN
(global-set-key (kbd "<f4>") 'org-toggle-link-display)
(global-set-key (kbd "<f5>") 'org-toggle-inline-images)

;; Custom Key Bindings
;; (global-set-key (kbd "<f12>") 'org-agenda)
;; (global-set-key (kbd "<f5>") 'bh/org-todo)
;; (global-set-key (kbd "<S-f5>") 'bh/widen)
;; (global-set-key (kbd "<f7>") 'bh/set-truncate-lines)
;; (global-set-key (kbd "<f8>") 'org-cycle-agenda-files)

(global-set-key (kbd "<f9> <f9>") 'bh/show-org-agenda)
(global-set-key (kbd "<f9> c") 'calendar)
;; (global-set-key (kbd "<f9> f") 'logos-focus-mode)
;; (global-set-key (kbd "<f9> f") 'boxquote-insert-file)
;; (global-set-key (kbd "<f9> g") 'gnus)
(global-set-key (kbd "<f9> h") 'bh/hide-other)
(global-set-key (kbd "<f9> n") 'bh/toggle-next-task-display)
(global-set-key (kbd "<f9> I") 'bh/punch-in)
(global-set-key (kbd "<f9> O") 'bh/punch-out)
(global-set-key (kbd "<f9> o") 'bh/make-org-scratch)
;; (global-set-key (kbd "<f9> r") 'boxquote-region)
(global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)
(global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)
(global-set-key (kbd "<f9> T") 'bh/toggle-insert-inactive-timestamp)
(global-set-key (kbd "<f9> v") 'visible-mode)
(global-set-key (kbd "<f9> i") 'org-clock-in)
(global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)
(global-set-key (kbd "C-x n r") 'narrow-to-region)

(global-set-key (kbd "C-<f9>") 'previous-buffer)
(global-set-key (kbd "C-<f10>") 'next-buffer)

(global-set-key (kbd "<f11>") 'org-clock-goto)
;; (global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)

(defun bh/hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading 'invisible-ok)
    (hide-other)
    (org-cycle)
    (org-cycle)
    (org-cycle)))

(defun bh/set-truncate-lines ()
  "Toggle value of truncate-lines and refresh window display."
  (interactive)
  (setq truncate-lines (not truncate-lines))
  ;; now refresh window display (an idiom from simple.el):
  (save-excursion
    (set-window-start (selected-window)
                      (window-start (selected-window)))))

(defun bh/make-org-scratch ()
  (interactive)
  (find-file "/tmp/publish/scratch.org")
  (gnus-make-directory "/tmp/publish"))

(defun bh/switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))
```


### <kbd>Junghanacs</kbd> Keybinding {#junghanacs-keybinding}

```elisp
;; (setq ob-async-no-async-languages-alist '("gnuplot")) ; "mermaid"

;; 자주 쓰는 키 바인딩
(evil-define-key '(normal insert visual) org-mode-map (kbd "C-c H") 'org-insert-heading)
(evil-define-key '(normal insert visual) org-mode-map (kbd "C-c S") 'org-insert-subheading)

;; insert 모드에서 방향키로 쓰도록 세팅한다. evil-xxx-line 대신
;; 이맥스 기본 이동으로 세팅 했다.
;; (evil-define-key '(insert) org-mode-map (kbd "C-h") 'left-char)
;; (evil-define-key '(insert) org-mode-map (kbd "C-l") 'right-char)
;; (evil-define-key '(insert) org-mode-map (kbd "C-j") 'next-line)
;; (evil-define-key '(insert) org-mode-map (kbd "C-k") 'previous-line)

;; 이상하게 기존 키 바인딩이 안지워진다. 이건 나중에 다시 하자.
;; (define-key org-mode-map (kbd "M-h") nil)

;; (define-key org-mode-map (kbd "M-l>") nil)
;; (keymap-unset-key [M-h] "evil-mode")
;; (keymap-unset-key [M-l] "evil-mode")
;; (evil-define-key '(insert) org-mode-map (kbd "M-h") 'delete-backward-char)
;; (evil-define-key '(insert) org-mode-map (kbd "M-l") 'delete-forward-char)

;; 복사한 링크는 아래의 방법으로 넣는다. 깔끔해서 좋다.
;; org-cliplink 는 insert 니까 i를 바인딩한다. org-insert-link를 따른다.
(evil-define-key '(normal insert visual) org-mode-map (kbd "C-c M-i") 'org-cliplink)
;; (define-key map (kbd "C-c M-i") 'org-cliplink)

;; M-RET 마이너모드 커맨드 , 와 같음

;; ordered/unordered list 를 입력 할 때 편함.
;; 체크박스가 있는 경우 M-S-RET org-insert-todo-heading 을 활용.
(evil-define-key '(normal insert visual) org-mode-map (kbd "C-M-<return>") 'org-insert-item)

;; 문단을 한 라인으로 합쳐 준다. 구글 번역기 돌릴 때 매우 유용.
;; (evil-define-key '(normal insert visual) org-mode-map (kbd "C-M-q") 'unfill-paragraph)

;; org-timer 도 어젠다에 넣어주고 싶은데?!
;; clock-in 은 되는데 헤딩이 어젠다에 없는거면 소용 없다.
;; 내 생각엔 신경쓰지말고 완료 상태 만드는거에 집중하자.
;; (defun my/org-timer-set-hook ()
;;   ;; 일단 90분으로 고정
;;   (shell-command-to-string "~/.local/bin/set-timer.sh 90min")
;;   ;; (org-clock-in)
;;   )

;; (defun my/org-timer-stop-hook ()
;;   (shell-command-to-string "~/.local/bin/reset-timer.sh")
;;   ;; (org-clock-out)
;;   )

;; (defun my/org-timer-done-hook ()
;;   (shell-command-to-string "~/.local/bin/reset-timer.sh")
;;   ;; (org-clock-out)
;;   )

;; (add-hook 'org-timer-set-hook 'my/org-timer-set-hook)
;; (add-hook 'org-timer-done-hook 'my/org-timer-done-hook)
;; (add-hook 'org-timer-stop-hook 'my/org-timer-stop-hook)

;; my org pomodoro 실행 함수를 만들고, 거기서 셋팅하면 된다.
;; 이맥스 클라이언트로 동작시킬 필요가 없다.
;; (defun my/org-pomodoro()
;;   "my/org-pomodoro start w/ clock-in or stop"
;;   (interactive)
;;   (shell-command-to-string "~/.local/bin/set-timer.sh 25min")
;;   (org-pomodoro)
;;   )
;; (defun my/org-pomodoro-killed ()
;;   "my org-pomodoro-killed with i3-bar."
;;   (interactive)
;;   (shell-command-to-string "~/.local/bin/reset-timer.sh")
;;   (org-pomodoro-killed)
;;   )
;; (defun my/org-pomodoro-finished ()
;;   "my org-pomodoro-finished with i3-bar."
;;   (interactive)
;;   (shell-command-to-string "~/.local/bin/reset-timer.sh")
;;   (org-pomodoro-finished)
;;   )
;; (let ((map global-map))
;;   (define-key map (kbd "C-c j p p") 'my/org-pomodoro)
;;   (define-key map (kbd "C-c j p k") 'my/org-pomodoro-killed)
;;   (define-key map (kbd "C-c j p f") 'my/org-pomodoro-finished)
;;   )

;; /ahyatt-dotfiles/.emacs.d/emacs.org:214
;; TEMPORARY, seems like this isn't getting autoloaded correctly.
(require 'org-duration)
(require 'org-element)

(setq org-pomodoro-length 25)
(setq org-pomodoro-short-break-length 5)
(setq org-pomodoro-long-break-length 20)
;; A pomodoro group is for a day, so after 8 hours of no activity, that's a group.
(setq org-pomodoro-expiry-time (* 60 8))

(defun ash/org-pomodoro-til-meeting ()
  "Run a pomodoro until the next 30 minute boundary."
  (interactive)
  (let ((org-pomodoro-length (mod (- 30 (cadr (decode-time (current-time)))) 30)))
    (org-pomodoro)))

;; I org-clock-in, P org-pomodoro
(add-hook 'org-agenda-mode-hook
          #'(lambda () (org-defkey org-agenda-mode-map (kbd "C-c I") 'org-pomodoro))
          'append)

(setq org-pomodoro-manual-break t) ; manualy break my focus time
(setq org-pomodoro-format "⌛ %s")
(setq org-pomodoro-short-break-format "😽 %s"
      org-pomodoro-long-break-format "🎼 %s")
(setq org-pomodoro-start-sound "~/.spacemacs.d/sounds/focus_bell.wav")
(setq org-pomodoro-short-break-sound "~/.spacemacs.d/sounds/three_beeps.wav")
(setq org-pomodoro-long-break-sound "~/.spacemacs.d/sounds/three_beeps.wav")
(setq org-pomodoro-finished-sound "~/.spacemacs.d/sounds/meditation_bell.wav")
(setq org-pomodoro-audio-player "/usr/bin/aplay")

;; emacs built-in org-timer
(setq org-clock-sound "~/.spacemacs.d/sounds/meditation_bell.wav")

(defun my/play-meditation-bell()
  "Play meditation-bell"
  (interactive)
  (call-process-shell-command "~/.local/bin/play-meditation-bell.sh" nil 0) ; async
  )

(defun my/play-meditation-bell-short()
  "Play meditation-bell-short (focus)"
  (interactive)
  (call-process-shell-command "~/.local/bin/play-meditation-bell-short.sh" nil 0)
  )

(global-set-key (kbd "C-c j m") 'my/play-meditation-bell)

(add-hook 'org-clock-in-hook 'my/play-meditation-bell 'append)
;; (add-hook 'org-clock-out-hook 'my/play-meditation-bell 'append)
;; (add-hook 'org-clock-goto-hook 'my/play-meditation-bell 'append)
;; (add-hook 'org-clock-cancel-hook 'my/play-meditation-bell 'append)
;; (add-hook 'org-capture-mode-hook 'my/play-meditation-bell 'append)
```


## Tasks and States {#tasks-and-states}

재미있는 부분이다. 본 문서에 보면 상태 다이어그램을 보여준다. 따라가자.
아래와 같은 더미 엔트리를 사용해서 개별 파일의 상태를 관리한다. 이는 글로벌
투두 메커니즘에 영향을 주지 않기에 효과적이다.

키워드는 기존에 내가 사용하던 로그시크 호환과는 약간 다르다. 그리고 NEXT 를
굉장히 효과적으로 관리한다. 전체 그림과 함께 사용해 보아야 한다.

태스트의 상태도를 그림으로 보여주는데 이미지 여기에 추가하자.
![](/imgs/20221115-1428-task-state.png)

그리고 상태가 트리거 되면 태그가 붙는다.

```text
The triggers break down to the following rules:
Moving a task to CANCELLED adds a CANCELLED tag
Moving a task to WAITING adds a WAITING tag
Moving a task to HOLD adds WAITING and HOLD tags
Moving a task to a done state removes WAITING and HOLD tags
Moving a task to TODO removes WAITING, CANCELLED, and HOLD tags
Moving a task to NEXT removes WAITING, CANCELLED, and HOLD tags
Moving a task to DONE removes WAITING, CANCELLED, and HOLD tags
```

```elisp
;; keys mentioned in brackets are hot-keys for the States
;; ! indicates insert timestamp
;; @ indicates insert note
;; / indicates entering the state
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "OFF(o)" "CANCELLED(c@/!)" "PHONE(p)" "MEETING(m)")
              (sequence ; from doom-emacs
               "[ ](T)"   ; A task that needs doing
               "[-](N)"   ; Task is in progress
               "[?](W)"   ; Task is being held up or paused
               "|"
               "[X](D)")  ; Task was completed
              )))

(defface my/org-bold-todo
  '((t :inherit (bold org-todo)))
  "Face for bold TODO-type Org keywords.")

(defface my/org-bold-done
  '((t :inherit (bold org-done)))
  "Face for bold DONE-type Org keywords.")

(defface my/org-bold-shadow
  '((t :inherit (bold shadow)))
  "Face for bold and `shadow' Org keywords.")

(defface my/org-todo-special
  '((t :inherit (font-lock-keyword-face bold org-todo)))
  "Face for special TODO-type Org keywords.")

(setq org-todo-keyword-faces
      '(
        ("TODO" . my/org-bold-todo)
        ;; ("FIXME" . my/org-bold-todo)
        ("[ ]" . my/org-bold-todo)

        ("DONE" . my/org-bold-done)
        ;; ("FIXED" . my/org-bold-done)
        ("[X]" . my/org-bold-done)
        ("CANCELLED" . my/org-bold-done)

        ("NEXT" . my/org-todo-special)
        ("READ" . my/org-todo-special)
        ("[-]" . my/org-todo-special)
        ("MEETING" . my/org-todo-special)
        ("PHONE" . my/org-todo-special)

        ("WAITING" . my/org-bold-shadow)
        ("HOLD" . my/org-bold-shadow)
        ("[?]" . my/org-bold-shadow)
        ("OFF" . my/org-bold-shadow)
        )
      )

;; from doom-emacs
(setq org-eldoc-breadcrumb-separator " → ")
(setq org-priority-faces
      '((?A . error)
        (?B . warning)
        (?C . success)))

;; (setq org-use-fast-todo-selection t) ; default auto
;; (setq org-use-fast-tag-selection t) ; default auto

;; Shift 거슬리는 것을 막아주는 아주 요긴한 설정이다.
(setq org-treat-S-cursor-todo-selection-as-state-change nil)

;; FIXME org tage state manager
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("OFF" ("OFF" . t)) ; added
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD") ("OFF"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD") ("OFF"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD") ("OFF"))
              )))
```


## Adding New Tasks Quickly with `org-capture-templates` {#adding-new-tasks-quickly-with-org-capture-templates}

내가 쓰던 캡처는 일단 잊어라. 일단 리파일에 집중하고 처리 프로세스를 강화하자.
동작은 다 확인했다. 잘 된다.

The `%a` verb expands to a link to where one was when they called `org-capture`.
This might, for example, be another file or an email.

`%a` 동작을 명시하면 =org-capture=를 호출했을 때 있었던 위치에 대한 링크로 확장됩니다. 예를
들어 다른 파일이나 이메일일 수 있습니다.

```elisp
;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol

(setq org-capture-templates
      (quote
       (
        ;; ("t" "todo" entry (file "~/sync/org/workflow/inbox.org")
        ;;  "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
        ;; ("s" "slipbox" entry (file "~/sync/org/workflow/inbox.org")
        ;;  "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
        ;; ("s" "Memo on Slipbox" entry (file+olp "~/sync/org/workflow/inbox.org" "Slipbox")
        ;;  "* %u %? " :prepend t) ; 타임스템프
        ;; ("l" "Link on Slipbox" entry (file+headline "~/sync/org/workflow/inbox.org" "Slipbox")
        ;;  "* %a %^g\n %?\n %T\n %i")

        ;; ("f" "Fleeting note" entry  (file "~/sync/org/workflow/inbox.org")
        ;;  "* TODO %^{Note title}\nContext: %U\n%a\n%?" :empty-lines-before 1 )

        ("f" "Fleeting note (/w Clock)" entry (file+headline "~/sync/org/workflow/inbox.org" "Slipbox")
         "* TODO %^{Note title}\nContext: %U\n%a\n%?" :clock-in t :clock-resume t)
        ;; "* %?\n%U\n%a\n" :clock-in t :clock-resume t)

        ;; ("p" "org-protocol" entry (file "~/sync/org/workflow/inbox.org")
        ;;  "* TODO Review %c\n%U\n" :immediate-finish t)
        ;; ("m" "meeting" entry (file "~/sync/org/workflow/inbox.org")
        ;;  "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
        ;; ("p" "phone call" entry (file "~/sync/org/workflow/refile.org")
        ;;  "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
        ;; ("r" "respond" entry (file "~/sync/org/workflow/refile.org")
        ;;  "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)

        ;; habit
        ;; ("h" "habit" entry (file "~/sync/org/workflow/refile.org")
        ;;  "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")

        ;; 22/11/21--10:43 :: add for awk org-drill
        ;; ("A" "Awk drill question" entry
        ;;  (file+headline "~/sync/org/git/learn-awk/awk.org" "Drills")
        ;;  "\n\n** %^{Question title}                           :awk:drill:\n\n   %^{Question body} \n\n*** Answer \n\n    #+BEGIN_SRC awk :results output code :in-file ./text-files/%^{text file}\n      %^{awk program}\n    #+END_SRC")
        )
       )
      )
;; 이런 디테일이 중요하더라. 지저분하게 만들지 않도록 하는 팁들.
;; Remove empty LOGBOOK drawers on clock out
(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at (point))))
(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)
```


## Refiling Tasks {#Refiling}

> `Refiling tasks` 는 쉽습니다. 캡처 모드를 사용하여 내 refile.org 파일에서
> 많은 새 작업을 수집한 후, 해당하는 조직 파일 및 주제로 이동해야 합니다.
> 내 모든 활성 조직 파일은 내 `org-agenda-files` 에 설정하며 어젠다에서
> 볼 수 있습니다.
>
> 최대 일주일 동안 refile.org 에서 캡처 작업을 수집합니다.
> 이것들은 이제 내 블록 안건에서 매일 눈에 띄고 보통 낮에 다시 정리합니다.
> 그리고 나는 refile 작업 목록을 비워 두는 것을 좋아합니다.

22/11/17--13:31 :: ido 가 켜지면 compleseus 레이어와 충돌이 난다.
그러느니 안쓰는게 더 현명하다.
아래에 보면 노랑님은 IDO 를 사용해서 리파일 타겟을 선택한다. 내 설정에서는
IDO 를 사용하지 않기 때문에 간단한 방법으로 수정한다.
22/12/03--16:41 :: 리파일 설정이 안되 있어서 불편해서 다시 왔다. 변경하자.


### <span class="org-todo todo TODO">TODO</span> 7.1 Refile Setup {#7-dot-1-refile-setup}



리파일 설정 관련 원문을 먼저 남긴다.

> 조직에서 작업을 다시 정리하려면 작업을 다시 정리할 위치를 알려줘야 합니다.
> 내 설정에서 나는 =org-agenda-files=의 모든 파일을 허용하고 현재 파일은 유효한
> refile 대상 목록에 기여합니다.
>
> 나는 최근 IDO 를 사용하여 타겟 파일/헤딩을 직접 완성하고 있습니다.
> 이전 완료보다 더 빠른 것으로 나타났습니다. 처음에는 IDO 가 마음에 들지 않았지만
> 설명서를 다시 검토하고 대상 검색을 제한하는 `C-SPC=에 대해 배운 후 IDO가 이전의
> 단계별 설정보다 훨씬 낫다는 것을 알았습니다. 이제 무언가를 다시 파일화하고 싶을
> 때 =C-c C-w=를 수행하여 다시 파일 프로세스를 시작한 다음 일치하는 대상을 얻기
> 위해 무언가를 입력한 다음 =C-SPC` 일치 항목을 현재 목록으로 제한한 다음 다른
> 텍스트로 계속 검색합니다. 내가 필요한 대상을 찾기 위해. `C-j` 또한 현재 완료를
> 최종 대상으로 선택합니다. 나는 이것을 많이 좋아한다. 여러 하위 트리 또는
> 프로젝트에서 동일한 제목을 가질 수 있도록 대상에 전체 개요 경로를 표시하고 다시
> 정리하는 동안 구분할 수 있습니다.
>
> 이제 `DONE` 상태 작업을 유효한 재파일
> 대상으로 제외합니다. 이렇게 하면 refile 대상 목록을 적당한 크기로 유지하는 데
> 도움이 됩니다.
>
> `System Maintenance` 아래의 `norang.org` 파일에 작업을 다시 정리하려면 작업에
> 커서를 놓고 =C-c C-w=를 누르고 =nor C-SPC sys RET=를 입력하면 완료됩니다. IDO
> 완성으로 대상을 쉽게 찾을 수 있습니다.

```elisp
(setq org-refile-targets (quote ((nil :maxlevel . 1)
                                 (org-agenda-files :maxlevel . 1))))
;; org-refile-targets '((nil :maxlevel . 4)
;;                      (org-agenda-files :maxlevel . 3))

;; Use full outline paths for refile targets - we file directly with IDO
;; (setq org-refile-use-outline-path (quote file))
;; (setq org-refile-use-outline-path t) ; default nil

;; Save Org buffers after refiling!
;; 리파일 후 저장하도록 해야 싱크 문제가 안생긴다.
(advice-add 'org-refile :after 'org-save-all-org-buffers)

(setq org-outline-path-complete-in-steps nil) ; default t

;; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

;; Exclude DONE state tasks from refile targets
;; (defun bh/verify-refile-target ()
;;   "Exclude todo keywords with a done state from refile targets"
;;   (not (member (nth 2 (org-heading-components)) org-done-keywords)))
;; (setq org-refile-target-verify-function 'bh/verify-refile-target)

(global-set-key (kbd "C-c r") 'org-refile-hydra/body)

(defun fk/org-refile-fixed-location (file headline)
  "Refile headline without selecting from refile-targets."
  (let ((pos (save-window-excursion
               (find-file file)
               (org-find-exact-headline-in-buffer headline))))
    (org-refile nil nil (list headline file nil pos))))

(defun fk/org-refile-fixed-location-with-closed-timestamp (file headline)
  "Refile headline without selecting from refile-targets. Add
      \"CLOSED\" timestamp info."
  (add-hook 'org-after-refile-insert-hook (lambda () (org-add-planning-info 'closed (org-current-effective-time))) -100)
  (fk/org-refile-fixed-location file headline)
  (remove-hook 'org-after-refile-insert-hook (lambda () (org-add-planning-info 'closed (org-current-effective-time)))))

(defun fk/org-refile-done ()
  (interactive)
  (fk/org-refile-fixed-location-with-closed-timestamp "archive.org" "Done"))

(defun fk/org-refile-trash ()
  (interactive)
  (fk/org-refile-fixed-location-with-closed-timestamp "archive.org" "Trash"))
(defhydra org-refile-hydra
  (:color red :hint nil)
  "
  ^Move^                 ^Todo^             ^IAM^            ^Archive^
  ----------------------------------------------------------------------
  _n_: Next              _p_: Project     _E_: Emacs         _d_: Done
  _p_: Previous          _e_: Emacs       _P_: Presentation  _x_: Trash
  ^^                     _w_: Work        _T_: Tech          _s_: Schedule
  _1_: Low Priority      _h_: Personal    _H_: Home          ^^
  _2_: Medium Priority   _f_: Family      _W_: Watch         ^^
  _3_: High Priority     ^^               _R_: Read          ^^
  ^^                     ^^               _O_: Other         ^^
  _c_: Set Time Effort   ^^                                  ^^
  _a_: Set Tags          ^^                                  ^^


  "
  ;; Move
  ("n" next-line)
  ("p" previous-line)
  ("1" (lambda () (interactive) (org-priority ?C)))
  ("2" (lambda () (interactive) (org-priority ?B)))
  ("3" (lambda () (interactive) (org-priority ?A)))
  ("c" org-set-effort)
  ("a" org-set-tags-command)
  ;; Todo
  ("p" (lambda () (interactive) (fk/org-refile-fixed-location "project.org" "TODOS")))
  ("e" (lambda () (interactive) (fk/org-refile-fixed-location "Emacs.org" "TODOS")))
  ("w" (lambda () (interactive) (fk/org-refile-fixed-location "Junghanacs.org" "TODOS")))
  ("h" (lambda () (interactive) (fk/org-refile-fixed-location "personal.org" "TODOS")))
  ("f" (lambda () (interactive) (fk/org-refile-fixed-location "family.org" "TODOS")))
  ;; IAM
  ("E" (lambda () (interactive) (fk/org-refile-fixed-location "IAM.org" "Emacs")))
  ("P" (lambda () (interactive) (fk/org-refile-fixed-location "IAM.org" "Presentation")))
  ("T" (lambda () (interactive) (fk/org-refile-fixed-location "IAM.org" "Tech")))
  ("H" (lambda () (interactive) (fk/org-refile-fixed-location "IAM.org" "Home")))
  ("W" (lambda () (interactive) (fk/org-refile-fixed-location "IAM.org" "Watch")))
  ("R" (lambda () (interactive) (fk/org-refile-fixed-location "IAM.org" "Read")))
  ("O" (lambda () (interactive) (fk/org-refile-fixed-location "IAM.org" "Other")))
  ;; Archive
  ("d" fk/org-refile-done)
  ("x" fk/org-refile-trash)
  ("s" (lambda () (interactive) (fk/org-refile-fixed-location "archive.org" "Schedule")))
  ;; General
  ("M" org-refile "Refile manually")
  ("S" save-buffer "Save buffer")
  ("q" nil "Quit" :color blue))
```


### 7.2 Refiling Tasks {#7-dot-2-refiling-tasks}

Tasks to refile are in their own section of the block agenda. To find tasks to
refile I run my agenda view with `F12 SPC` and scroll down to second section of
the block agenda: `Tasks to Refile`. This view shows all tasks (even ones marked
in a `done` state).

다시 제출할 작업은 블록 안건의 자체 섹션에 있습니다. 다시 정리할 작업을 찾기
위해 `F12 SPC=를 사용하여 내 안건 보기를 실행하고 블록 안건의 두 번째 섹션인
=Refile할 작업=으로 스크롤합니다. 이 보기에는 모든 작업이 표시됩니다(=done`
상태로 표시된 작업도 포함).

Bulk refiling in the agenda works very well for multiple tasks going to the same
place. Just mark the tasks with `m` and then `B r` to refile all of them to a
new location. Occasionally I'll also refile tasks as subtasks of the current
clocking task using `C-2 C-c C-w` from the `refile.org` file.

의제에서 대량 재작성은 동일한 장소로 이동하는 여러 작업에 매우 적합합니다.
작업을 `m=으로 표시한 다음 =B r=로 표시하여 모든 작업을 새 위치로 다시
정리하십시오. 때때로 저는 =refile.org` 파일에서 =C-2 C-c C-w=를 사용하여 현재
클럭 작업의 하위 작업으로 작업을 다시 정리합니다.

Refiling all of my tasks tends to take less than a minute so I normally do this
a couple of times a day.

내 모든 작업을 다시 작성하는 데 1 분도 채 걸리지 않는 경향이 있으므로 보통 하루에
두 번 이 작업을 수행합니다.


### 7.3 Refiling Notes {#7-dot-3-refiling-notes}

I keep a `* Notes` headline in most of my org-mode files. Notes have a `NOTE`
tag which is created by the capture template for notes. This allows finding
notes across multiple files easily using the agenda search functions.

나는 대부분의 조직 모드 파일에 `* Notes` 헤드라인을 유지합니다. 메모에는 메모에
대한 캡처 템플릿에 의해 생성된 `NOTE` 태그가 있습니다. 이를 통해 안건 검색
기능을 사용하여 여러 파일에서 메모를 쉽게 찾을 수 있습니다.

Notes created by capture tasks go first to `refile.org` and are later refiled to
the appropriate project file. Some notes that are project related get filed to
the appropriate project instead of under the catchall `* NOTES` task. Generally
these types of notes are specific to the project and not generally useful -- so
removing them from the notes list when the project is archived makes sense.

캡처 작업으로 작성된 메모는 먼저 `refile.org=로 이동하고 나중에 적절한 프로젝트
파일로 다시 정리됩니다. 프로젝트와 관련된 일부 메모는 catchall =* NOTES` 작업
대신 적절한 프로젝트에 보관됩니다. 일반적으로 이러한 유형의 메모는 프로젝트에
따라 다르며 일반적으로 유용하지 않습니다. 따라서 프로젝트가 보관될 때 메모
목록에서 메모를 제거하는 것이 좋습니다.


### 7.4 Refiling Phone Calls and Meetings {#7-dot-4-refiling-phone-calls-and-meetings}

Phone calls and meetings are handled using capture mode. I time my calls and
meetings using the capture mode template settings to clock in and out the
capture task while the phone call or meeting is in progress.

전화 통화 및 회의는 캡처 모드를 사용하여 처리됩니다. 전화 통화 또는 회의가
진행되는 동안 캡처 모드 템플릿 설정을 사용하여 통화 및 회의 시간을 정하여 캡처
작업을 시작 및 종료합니다.

Phone call and meeting tasks collect in `refile.org` and are later refiled to
the appropriate location. Some phone calls are billable and we want these
tracked in the appropriate category. I refile my phone call and meeting tasks
under the appropriate project so time tracking and reports are as accurate as
possible.
전화 통화 및 회의 작업은 =refile.org=에 수집되고 나중에 적절한 위치에
다시 정리됩니다. 일부 전화 통화는 청구 가능하며 적절한 카테고리에서 추적하기를
원합니다. 시간 추적 및 보고서가 최대한 정확하도록 적절한 프로젝트에서 전화 통화
및 회의 작업을 다시 정리합니다.


## Custom agenda views {#custom-agenda-views}

여기서 보여주는 바대로 움직이자고 워크플로우가 존재한다.
슈퍼어젠다가 있던 뭐던 간에 워크플로우가 있어야 된다.


### Overview {#overview}

블락 어젠다 뷰에 나의 영혼을 맡긴다. 여기에는 나의 하루의 모든 것을 담았다.
노랑님이 작성한 시점은 09 년도다. 문서를 보면 나의 느린 Eee PC 를 고려했다는
이야기가 나온다. 서브 노트북으로 사용하신 것 같은데 나도 써봤다. 어젠다에서
다루게 결국 실시간 텍스트 파싱인데 처참한 싱글 스레드 성능으로 답이 없을게다.
지금이라고 천지가 개벽했나? 아니다. 조금 더 유연해졌을 뿐이다.

노랑님은 일전에 커스텀 뷰에 많은 필터 함수를 만들어서 사용했었다. 그러나
오그 모드가 개선되면서 많은 기능이 포함 되었다. 아마도 지금 시점에서는
커스텀 함수 없이도 노랑님의 워크플로우가 가능할 것 같다. 나중에 내가 할
숙제이다. -- 오그 모드 분석과 super-agenda 파악 해 볼 것

-   READ 관련 참고 코드
    -   알파파파님 슈퍼 어젠다 <https://github.com/alphapapa/org-super-agenda>
        다 커버할 수 있을 것 같은데, 손대려면 일이 크다.
    -   베당님 워크플로우 <https://github.com/vedang/org-mode-crate>
        본 문서로 검색하면 자료가 꽤 나온다. 이맥서들이 한번씩 거쳐갔을 문서니까
        대부분 올드해서 관심이 안간다. 베당님은 나와 똑같은 짓을 하고 있었다.
        업뎃을 계속하고 있으니 보자. 뭘 튜닝을 한 것인가?

        많이 내려놨구나. 최신 오그모드를 반영해서 좋다. 특히, 뒤쪽에
        퍼블리시 파트는 역시 날려버리는게 옳다. 본질에 집중했다.

        여기서 옮겨 올 부분도 있다. 다 넣을게 아니라 빼야 된다.

;; A big thanks to Bernt Hansen for providing an awesome guide to
;; beginners so that we can harness the power of org-mode. Almost all of the
;; customization here, and my complete day-to-day workflow,
;; is based on his document about org-mode which can be
;; found here: <http://doc.norang.ca/org-mode.html>

```text
Custom agenda views are used for:
- Single block agenda shows the following
  + overview of today
  + Finding tasks to be refiled
  + Finding stuck projects
  + Finding NEXT tasks to work on
  + Show all related tasks
  + Reviewing projects
  + Finding tasks waiting on something
  + Findings tasks to be archived
- Finding notes
- Viewing habits
```

노랑님의 블록 어젠다의 기능은 위와 같다.


### `Code Block` {#code-block}

어젠다 관련하여 옮기고 튜닝하는 코드

```elisp
;; ex) 2022-09-19 (월)
(setq org-agenda-format-date "%Y-%m-%d (%a)")

;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
;; t :: block saparator turns off
(setq org-agenda-compact-blocks nil)

(advice-add 'org-agenda-exit :after #'org-save-all-org-buffers)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              ("h" "Habits" tags-todo "STYLE=\"habit\""
               ((org-agenda-overriding-header "Habits")
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              ;; Review JH
              ("r" "Agenda review"
               ((agenda "" ((org-agenda-span 7)))
                (stuck "")
                (todo "NEXT")
                (todo "TODO")
                (todo "HOLD"))
               ((org-agenda-archives-mode t)
                (org-agenda-compact-blocks nil)
                (org-agenda-show-all-dates nil)))
              (" " "Agenda"
               ((agenda "" nil)
                (tags "REFILE"
                      ((org-agenda-overriding-header "Tasks to Refile")
                       (org-tags-match-list-sublevels nil)))
                (tags-todo "-CANCELLED/!"
                           ((org-agenda-overriding-header "Stuck Projects")
                            (org-agenda-skip-function 'bh/skip-non-stuck-projects)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-HOLD-CANCELLED/!"
                           ((org-agenda-overriding-header "Projects")
                            (org-agenda-skip-function 'bh/skip-non-projects)
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-CANCELLED/!NEXT"
                           ((org-agenda-overriding-header (concat "Project Next Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                           ((org-agenda-overriding-header (concat "Project Subtasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-non-project-tasks)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                           ((org-agenda-overriding-header (concat "Standalone Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-project-tasks)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-CANCELLED+WAITING|HOLD/!"
                           ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-non-tasks)
                            (org-tags-match-list-sublevels nil)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
                (tags "-REFILE/DONE"
                      ((org-agenda-overriding-header "Tasks to Archive")
                       (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                       (org-tags-match-list-sublevels nil))))
               nil))))

(defun bh/org-auto-exclude-function (tag)
  "Automatic task exclusion in the agenda with / RET"
  (and (cond
        ((string= tag "hold")
         t)
        ((string= tag "farm")
         t))
       (concat "-" tag)))
(setq org-agenda-auto-exclude-function 'bh/org-auto-exclude-function)
```


### Setup :: Views {#setup-views}

노랑님의 블록 어젠다는 기본 뷰와 프로젝트 뷰가 있다.
기본 커스텀 뷰로 들어가면, 위에 언급한 모든 내용을 쭉 보여준다.
프로젝트 뷰는 `P` 를 입력하면 보인다. (몰랐다...) 프로젝트 관련 태스크를
집중하여 보여준다.

노랑님은 어젠다에서 탑다운으로 일을 하는 편이라고 한다. 그냥 보여주는게
아니라 데드라인, 스케줄 등으로 정렬 된 것이다. 물론 커스텀 가능하다.
필터링을 하거나.

그래서 노랑님의 My day goes generally like this: 가 나온 것이다. 맨 위에
아마 넣었을 텐데 너무 위대하니 또 넣자. 보고 또 보고 해보면서 익히고
나에게 맞춰야 한다.

```text
My day goes generally like this:

- Punch in (this starts the clock on the default task)
- Look at the agenda and make a mental note of anything important to deal with today
- Read email and news
  - create notes, and tasks for things that need responses with org-capture
- Check refile tasks and respond to emails
- Look at my agenda and work on important tasks for today
  - Clock it in
  - Work on it until it is =DONE= or it gets interrupted
- Work on tasks
- Make journal entries (=C-c c j=) for interruptions
- Punch out for lunch and punch back in after lunch
- work on more tasks
- Refile tasks to empty the list
  - Tag tasks to be refiled with =m= collecting all tasks for the same target
  - Bulk refile the tasks to the target location with =B r=
  - Repeat (or refile individually with =C-c C-w=) until all refile tasks are gone
- Mark habits done today as DONE
- Punch out at the end of the work day
```


### What do I work on next? {#what-do-i-work-on-next}



데일리 어젠다 뷰에서 오늘이나 이전에 예정된 태스크로 시작하라.
그 다음엔 `Next Tasks` 목록을 뒤져서 다음 할 일을 찾는다. 나는
작업 중인 프로젝트들을 시작할 때 '오늘'로 스케줄을 설정하는 편이다.
이렇게 설정하면 어젠다를 열 때 마다 계속 상기시켜 주니까.

그리고, 나는 대개 오늘 어젠다에 1-2 개 프로젝트만 스케줄을 설정하고,
중요하지 않게 되었거나 오늘 관심이 가질 필요 없는 일정은 스케줄에서 제거한다.

작업할 새 작업을 찾을 때 일반적으로 =F12 SPC=를 눌러 블록 안건을 얻고 다음
순서를 따릅니다.

-   Pick something off today's agenda
    -   deadline for today (do this first - it's not late yet)
    -   deadline in the past (it's already late)
    -   a scheduled task for today (it's supposed to be done today)
    -   a scheduled task that is still on the agenda
    -   deadline that is coming up soon
-   pick a NEXT task
-   If you run out of items to work on look for a NEXT task in the current context
    pick a task from the Tasks list of the current project.


#### Why keep it all on the `NEXT` list? {#why-keep-it-all-on-the-next-list}



나는 더 GTD 한 스타일로 방법을 바꿨다. 이제 `NEXT` 목록을 적극 사용합니다.
중단된 프로젝트는 `NEXT` 작업을 표시하거나, 생성해야 하기 때문에 `NEXT`
키워드가 있는 프로젝트만 태스크를 어젠다에 표기 한다.

`NEXT` 태스크는 1) _지금_ 작업이 가능한 상태인 녀석들이며, 2) 일부
프로젝트에서는 _논리적_ 다음 순서 또는 단계를 의미하기도 한다.

나는 많은 일을 하고 시간을 측정하고 싶지만 실제로 시작/끝나지 않는 일에 대해
특별한 키워드 `ONGOING=을 사용했습니다. 나는 시간을 기록하고 싶은 것을 쉽게 찾기
위해 끌어올 수 있는 =ONGOING` 작업에 대한 특별한 의제 보기를 가지고 있었습니다.

그 이후로 나는 `ONGOING` todo 키워드를 사용하지 않게 되었습니다. `NEXT` 작업을
표시하는 안건 보기를 사용하면 시간을 정할 항목을 쉽게 선택할 수 있습니다. 그리고
작업을 찾을 때 `ONGOING` 목록을 봐야 하는지 아니면 `NEXT` 목록을 봐야 하는지
기억할 필요가 없습니다. 출근합니다. `NEXT` 목록은 기본적으로 '현재
상태'(프로젝트를 진행시키는 모든 작업)입니다. 가능한 한 빨리 작업할 항목을 찾고
실제로 작업을 수행하고 싶습니다. 시간을 기록해야 하는 작업을 찾기 위해 조직
파일을 뒤지는 데 시간을 낭비하지 않습니다.

`NEXT` 목록에서 작업을 삭제하려면 작업을 `TODO` 상태로 되돌리기만 하면 됩니다.


### Reading email, newsgroups, and cohnversation on IRC {#reading-email-newsgroups-and-cohnversation-on-irc}



When reading email, newsgroups, and conversations on IRC I just let
the default task (normally `** Organization`) clock the time I spend on
these tasks.  To read email I go to Gnus and read everything in my
inboxes.  If there are emails that require a response I use
org-capture to create a new task with a heading of 'Respond to &lt;user&gt;'
for each one.  This automatically links to the email in the task and
makes it easy to find later.  Some emails are quick to respond to and
some take research and a significant amount of time to complete.  I
clock each one in it's own task just in case I need that clocked time
later.  The capture template for Repond To tasks is now scheduled for
today so I can refile the task to the appropriate org file without
losing the task for a week.

Next, I go to my newly created tasks to be refiled from the block
agenda with `F12 a` and clock in an email task and deal with it.
Repeat this until all of the 'Respond to &lt;user&gt;' tasks are marked
`DONE`.

I read email and newgroups in Gnus so I don't separate clocked time
for quickly looking at things.  If an article has a useful piece of
information I want to remember I create a note for it with `C-c c n`
and enter the topic and file it.  This takes practically no time at
all and I know the note is safely filed for later retrieval.  The time
I spend in the capture buffer is clocked with that capture note.


### Filtering {#filtering}

<span class="timestamp-wrapper"><span class="timestamp">[2022-11-17 Thu 05:38]</span></span>
너무 많은 작업, 너무 적은 시간. 주어진 시간에 수백 개의 작업이 있습니다(현재
373 개). 보고 싶은 것들이 너무 많아서 부담스러울 수 있습니다. 이것은 의제
필터링이 하루를 절약하는 곳입니다.

오전 11 시 53 분이고 점심 시간 직전에 작업 모드에 있습니다. 지금은 업무와 관련
없는 작업을 보고 싶지 않습니다. 나도 점심시간 직전에 큰 프로젝트를 하고 싶지
않아... 그래서 목록에서 떼어낼 수 있는 작은 작업을 찾아야 한다.

어떻게 해야 할까요? 블록 아젠다에서 NEXT 작업 목록을 가져온 다음 필터링을 통해
범위를 좁힙니다. 작업은 예상 노력에 따라 NEXT 안건 보기에서 정렬되므로 짧은
작업이 먼저 표시됩니다. 맨 위에서 시작하여 아래로 작업하면 됩니다. 표시되는 안건
작업을 =/ + 1=을 사용하여 10 분 이하의 예상 작업으로 제한할 수 있으며 점심 식사를
위해 출발하기 전에 남은 시간에 맞는 작업을 선택할 수 있습니다.


### Automatically removing context based task with `/ RET` {#automatically-removing-context-based-task-with-ret}

<span class="timestamp-wrapper"><span class="timestamp">[2022-11-17 Thu 14:07]</span></span>
=/ RET=를 사용하여 컨텍스트 기반 작업을 자동으로 제거

=/ RET=는 정말 유용합니다. 이 멋진 기능은 John Wiegley 에 의해 조직 모드에
추가되었습니다. 사용자가 제공한 기능을 기반으로 필터링하여 작업을 자동으로
제거합니다.

직장에서는 관리자가 할당한 프로젝트가 있습니다. 때때로 우선 순위가 변경되고
프로젝트가 미래의 어느 시점으로 지연됩니다. 즉, 이 작업을 즉시 중단해야 합니다.
프로젝트 작업을 `HOLD=로 설정하고 다른 작업을 합니다. =/ RET` 필터는 `HOLD` 작업
및 하위 작업을 제거합니다(태그 상속으로 인해).

집에는 `farm` 태그가 붙은 몇 가지 작업이 있습니다. 물리적으로 가족 농장에 있을
때 이러한 작업을 수행해야 하기 때문입니다. 자주 방문하지 않기 때문에 시스템의
자동 제외 태그 목록에 `farm=을 추가했습니다. 물리적으로 그곳에 있을 때 =/ TAB
farm RET=을 사용하여 =farm` 작업으로 항상 명시적으로 필터링할 수 있습니다.

=/ RET=이 위의 설명을 기반으로 작업을 필터링할 수 있도록
다음과 같은 설정이 있습니다. bh/org-auto-exclude-function 이 이 역할을 합니다.


## Time Clocking {#time-clocking}

어메이징한 것이 뭐냐? 시간 기록 관리 아니겠는가? 여기 코드만 딸랑 넣어 놨는데
원래 문서에는 장대한 설명이 있다. 그걸 알아야/해봐야 의미가 있다. 아니면 다 필요
없는 코드다.

시퀀스가 있다. 그걸 생각하고 써야 하는데, 그래서 키 바인딩도 그대로 가는 것이다.
왜? 문서에서 키바인딩만 나와 있는데 헷갈리니까 그냥 따라하는거다.


### 원문 요약 :: punch-in, punch-out {#원문-요약-punch-in-punch-out}

인정합니다. 오그 모드의 =타임 클락킹=은 가히 환상적입니다.
나는 일에 모든 것들을 클락킹 합니다. 오그 모드는 이 과정을 정말 쉽게
만들어 줍니다. 나는 부족한 것 보다 과하게라도 시간 기록을 하는 걸 선호합니다.
그러기에 쉽게 할 수 있어야 합니다.

기록하는 것은 지난 날을 회상하는 것도 가능하겠지만, 내가 어디에 시간을
많이 쓰고 있는지라든가 중요한 프로젝트에 얼마나 리소스를 투입하고 있는지
알게 해준다. 이는 무언가를 하는데 있어서 얼마나 시간이 필요한지 예측하는데
도움이 된다. 기록 할수록 나의 시간 감각, 측정 능력이 개선 된다.

여기서 나는 펀치 인/아웃이라는 개념을 활용한다. 일을 시작 할 때 인, 점심
먹을 때 아웃, 돌아와서 인, 집에 갈때 아웃. 펀치 인을 하는 동안 모든 시간이
기록 된다.

펀치 인을 하면 =기본 태스크=로 시간이 할당 된다. 특정 태스크에 클락 인을 하고
끝내면 다시 기본 태스크로 시간이 할당 된다. 이렇게 해야 시간을 잃지 않을 수
있다.

My clocking setup basically works like this:

-   Punch in (start the clock)

This clocks in a predefined task by org-id that is the default task
to clock in whenever the clock normally stops

-   Clock in tasks normally, and let moving to a DONE state clock out

clocking out automatically clocks time on a parent task or
moves back to the predefined default task if no parent exists.

-   Continue clocking whatever tasks you work on
-   Punch out (stop the clock)


#### 워크 시퀀스 예제 {#워크-시퀀스-예제}



```org
* TODO Project A
** NEXT TASK 1
** TODO TASK 2
** TODO TASK 3
* Tasks
** TODO Some miscellaneous task
```

위를 보면 프로젝트 A 에 1, 2, 3 태스크가 있다. 1 에 다음이 있는 것으로
1 을 해야 한다. 그리고 태스트들의 하위로 소소한 태스크가 하나 할 일로
남겨져 있다. 이에 대해서 다음 시퀀스로 진행을 한다. 이게 오늘 할 일인가?
아무튼... &gt;&gt; 일을 쪼개는 것도 참 중요하다!

1) F9-I
: punch-in

2) F12-SPC
: org-agenda 의 custom-view 보기
    여기서 'TODO Some miscellaneous task'를 다음에 처리하려고 한다.
    `I=를 입력하여 =clock-in` 하자. `SPC ?` 로 키맵을 보면 그렇게
    매핑되어 있다. 따로 해줄 필요 없다. 아니면 `Alt+SPC` 눌러서 트랜지언트
    맵을 보고 호출해도 된다. 이건 스맥스에서 만들어 놓은 것이다.
    아무튼, 클락인이 되면 모드라인에 표기가 된다. 그리고 해당 태스크는
    TODO -&gt; NEXT 로 상태가 변경 된다. NEXT 가 마치 DOING 같네.


3) `F11=로 현재 태스크로 이동 후, =C-c C-t d` 완료 상태로 변경
    모드라인에 시간은 흐르고 파일은 이래 저래 작업하고 있을 것이다.
    그렇다면, 현재 클락인된 태스크로 이동하는 가장 빠른 방법은 F11 이다.
    키바인딩에 매핑해 놓았다. 그러면 해당 위치로 이동한다. 완료로 바꿔야지?

    완료로 바꾸는 방법은 위에 씌여 있는 이맥스다운 방법과 =t=를 입력하여
    바꾸는 방법이 있다. 그리고 쉬프트와 방향키로 바꾸는 방법이 있다.
    관련 설정을 꺼놨는데도 이게 여전히 먹힌다. 신중하게 상태 변경을 하는게 좋다.
    태그 밎 타임 로깅이 바뀌기 때문에 지저분해진다. 꼬이는 거다.
    나는 가장 불편한 방법으로 쓰련다.

    완료하고 나면, 다시 기본 클럭으로 돌아간다. 훌륭하다.
    아 근대 어젠다 구성이 별로네. 시간 단위 정보를 보여주는게
    거의 없다. --&gt; 캡처로 할 일 만들었다. 캡처하고 나니까 다시 기본 클락
    으로 복귀. 훌륭하구만.


4) 이제 프로젝트 A 의 1 번 태스크를 클락인 하자.
    `I` 누르면 클락인이다. 너무 쉽게 되니까 조심스럽네. 그렇다면
    다 했다고 치고 완료해보라. `F11`, `C-c C-t d` 이다. 키바인딩 구리다.
    내 키보드는 F 키도 없는데. 그래도 안 바꾼다. 밀고 가자. 완료하고 나면,
    클락은 프로젝트 A 로 이동한다. 보자. 뭘 해야 하나?

    아 잠시만, 태스트 1 은 처음 상태가 NEXT 였다. 클락인해도 그대로다.
    태스크 2 를 클락인 했다. 상태는 NEXT 로 변경되고 모드라인데 작업 시간이
    표기 된다. 완료 하자.


5) 잠시만, 현재 클락은 어디에 있는가? 프로젝트 A 다.
    지금 상황에서 태스트 3 을 끝내면 클락은 다시 기본으로 돌아간다.
    근데 이게 프로젝트인데, 한 자리에서 다 끝낼 수가 있나?

    다른 태스크를 보자. 어젠다에서 뒤져보자. 리파일에 있는 그냥 테스트
    TODO 를 클락인 했다. "테스트로 생성합니다."라는 태스크다. 이건 아마
    완료하면 기본 클락으로 돌아갈 것이다. 프로젝트가 아니기 때문이다.

    프로젝트는 따로 구분하는 메커니즘은 두지 않는다고 했다. 문서에 보면
    서브 테스크가 있는 것은 프로젝트라고 한다. Stuck Project 가 아래
    GTD 에서 다룬다. 그리고 커스텀 어젠다에서도 표기를 강하게(?) 해준다.

    이게 뭐냐? 스턱 프로젝트는 서브 태스크 중에 NEXT 가 없는 케이스에 해당
    한다. 처음에는 뭔가 싶었는데... NEXT 가 없다는 것은 현재 작업 중이거나
    다음에 할 태스크라고 명시해 놓은게 없다는 말이다. 납득이 완전 된다.
    클락인하면 NEXT 로 바뀌니까 NEXT 는 작업 중인 태스크도 된다. 그러다가
    퇴근하면 NEXT 상태로 클락아웃 된 것이다. 이게 아니여도 다음에
    작업하기 위해서 NEXT 로 지정해 놓을 수도 있을 것이다. (NEXT 로 바꾸는 것
    자체는 아무런 사이드 효과가 없다.)

    뭐든 간에 TODO 만 있다는 것은 목표만 나열한 것과도 같다. 내가
    잘하는 짓이다. TODO 가 산더미이고 완료되는게 없는 상태. 스턱된거다.


6) 장난 아니다. 내용도 엄청 많은데. 실습해가면서 해봐야 한다. 이거
    빡시다.


### Clocking in {#clocking-in}


#### Setting a default clock task {#setting-a-default-clock-task}

내 todo.org 파일에는 기본 `** Organization` 작업이 있는데, 이 작업은 기타 시계
시간을 설정하는 경향이 있습니다. 이것이 =F9-I=로 근무일을 시작할 때 시작하는
작업입니다. 조직 파일을 재구성하고, 이메일을 읽고, 받은 편지함을 비우고, 특정
프로젝트와 관련되지 않은 다른 계획 작업을 수행하는 동안 이 작업에 시간을 할애할
것입니다. 이 조직 작업에서 기본 작업으로 모든 시계를 펀치 인합니다.


#### Using the `clock history` to clock in old tasks {#using-the-clock-history-to-clock-in-old-tasks}

시계 기록을 사용하여 이전 작업 기록

시계 기록을 사용하여 시간을 기록한 이전 작업에서 시계를 다시 시작하거나 이전에
시간을 기록한 작업으로 바로 이동할 수 있습니다.

나는 이것을 주로 뭔가에 의해 중단된 것을 기록하는 데 사용합니다.

다음 시나리오를 고려하십시오.

-   You are working on and clocking `Task A` (Organization)
-   You get interrupted and switch to `Task B` (Document my use of org-mode)
-   You complete `Task B` (Document my use of org-mode)
-   Now you want to go back to `Task A` (Organization) again to continue

This is easy to deal with.

1.  Clock in `Task A`, work on it
2.  Go to `Task B` (or create a new task) and clock it in
3.  When you are finished with `Task B` hit `C-u C-c C-x C-i i`

이렇게 하면 다음과 같은 시계 이력 선택 창이 표시되고 중단된 `[i]` 항목이
선택됩니다.

**Clock history selection buffer for C-u C-c C-x C-i**
아. org-journal-mode 라는게 있다. 그리고 지금은 아. org-capture-mode 겠구나.
아무튼 교육 프로그램에서 이맥스를 데일리로 써야 하는게 급선무라면
일단 기록을 해야 한다. 가장 좋은 것은 내가 쓰는 것 처럼 시간 입력에 따라서
뭔가를 쓰는 것이다. 그게 많거나 적거나 중요하지 않고 그냥 쓰는 것이다.

쓰다가 괜찮으면 캡처로 할 일을 만들어서 배치하고, 아니면 그냥 적어 놓고 끝.
다시 보지는 않기 마련인데. 그게 참 아쉬운 부분이긴 하겠다.

다행히 org-journal-mode 의 장점은 검색에 있다. 스트링 검색을 지원하기 때문에
주, 월, 년 단위로 디테일하게 조절해 가면서 지난 기록의 텍스트를 검색할 수 있다.
그러다가 걸리면 보면 되겠지. 아니면 언제 뭐 했나 궁금하기도 할 것이고.

아직 검토는 못했지만, 정해진 포멧으로 작성기 때문에 무엇이든 검색할 수 있다.
예를 들어, 지난 3 개월간 평일 오전에 주로 뭘 하는가 보려면
지난 3 개월, 오전 12 시까지의 기록을 버퍼에 뽑아 주면 된다. 그러면 보고나서
필요하면 별도로 저장할수도 있고 여기에서 더 가공을 하고 싶다면 embark 로
버퍼로 뽑고 거기서 추가적인 필터를 하면 될 것이다. 모든 데이터는 텍스트이고
날짜, 시간 정보가 있기 때문에 가공할 수 있다. 텍스트 모아봐야 공간을
차지 할 것도 없다. 검색 할 때마가 텍스트 파싱이 필요하기에 시간이 걸리는 일이
겠지만 그래서 더 자유롭기도 한 것이다. 그리고 정해진 양식이 있기에 복잡도는
크지 않다.

그래서 초보자들이 이맥스 편집, 라이프 매니징, 워크 플로우, 캡처 등을 차분하게
익숙해지려면 저널을 쓰기를 권하고 싶다. 아니 권해야 한다. 텍스트 편집에 익숙해
져야지 그 외에 일도 가능하다. 나도 텍스트 편집 자체에는 별 기능을 이용하는게
없다. 아예 없나? 싶다. 더 빠르게 뭘 하겠다는 생각도 없다. 입력하는 것 뿐이다.
앞에 글을 지우지도 않는다. 앞으로만 나아 간다.

```text
Default Task
[d] norang          Organization                          <-- Task B
The task interrupted by starting the last one
[i] norang          Organization                          <-- Task B
Current Clocking Task
[c] org             NEXT Document my use of org-mode      <-- Task A
Recent Tasks
[1] org             NEXT Document my use of org-mode      <-- Task A
[2] norang          Organization                          <-- Task B
...
[Z] org             DONE Fix default section links        <-- 35 clock task entries ago
```


### Clock Everything - Capture new entry {#clock-everything-capture-new-entry}

모든 것을 기록하려면 모든 것에 대한 작업이 필요합니다. 계획된 프로젝트에는
괜찮지만 중단은 필연적으로 발생하며 해당 중단에 소비한 시간을 기록할 장소가
필요합니다.

이를 처리하기 위해 우리는 우리가 하려는 일을 기록하기 위해 새로운 캡처 작업을
만듭니다. 워크플로는 다음과 같습니다.

-   You are clocking some task and an interruption occurs
-   Create a quick capture task journal entry `C-c c j`
-   Type the heading
-   go do that thing (eat lunch, whatever)
-   file it `C-c C-c`, this restores the clock back to the previous clocking task
-   clock something else in or continue with the current clocking task

이것은 조직 파일 레이아웃에서 이 작업이 실제로 속한 위치와 같은 세부 정보를
무시하고 작업을 완료할 수 있음을 의미합니다. 작업을 다시 정리하는 것이 편리할 때
나중에 그룹에서 여러 작업을 다시 정리하면 장기적으로 시간이 절약됩니다.

커피 브레이크와 같이 흥미롭지 않은 일회성 작업인 경우 diary.org 날짜 트리로
이동하는 캡처 저널 항목을 만듭니다. 실제로 추적하고 완료로 표시하고 일부
프로젝트에 적용해야 하는 작업인 경우 refile.org 에 파일로 저장하는
대신 캡처 작업을 만듭니다.


### Finding tasks to clock in {#finding-tasks-to-clock-in}

<kbd>clock history가 뭔지 모르겠네. 9.2에도 나오는 이야긴데</kbd>

To find a task to work on I use one of the following options
(generally listed most frequently used first)

-   Use the clock history C-u C-c C-x C-i
    Go back to something I was clocking that is not finished
-   Pick something off today's block agenda
    `SCHEDULED` or `DEADLINE` items that need to be done soon
-   Pick something off the `NEXT` tasks agenda view
    Work on some unfinished task to move to completion
-   Pick something off the other task list
-   Use an agenda view with filtering to pick something to work on

Punching in on the task you select will restrict the agenda view to that project
so you can focus on just that thing for some period of time.


### Editing clock entries {#editing-clock-entries}

<kbd>로그 모드에 엔트리 나오는게 없는데 어떻게 하는 거야?</kbd>

때로는 시계 항목을 편집하여 현실을 반영해야 합니다. 일주일에 2~3 개 항목에 대해 이 작업을 수행합니다.

때때로 나는 내 컴퓨터에서 떨어져 있기 때문에 제 시간에 작업을 기록할 수 없습니다. 이 경우 이전 클럭 작업이 계속 실행 중이며 잘못된 두 작업의 시간을 계산합니다.

시간을 기록한 다음 컴퓨터로 돌아가서 올바른 작업을 기록하고 시작 시간과 종료 시간을 편집하여 시계 기록을 수정합니다.

항목에 대한 시계 라인을 빠르게 방문하려면 의제 로그 모드를 사용하십시오. `F12 a l` 오늘의 모든 클럭 라인을 보여줍니다. 적절한 클럭 라인으로 빠르게 이동하기 위해 이것을 사용합니다. F11 은 현재 시계가 있는 작업으로 이동하지만 의제 로그 모드는 이전 시계 항목을 찾고 방문하는 데 더 좋습니다.

=F12 a l=을 사용하여 로그 모드에서 의제를 열고 기록된 시계 시간만 표시합니다. 편집해야 하는 클럭 라인으로 커서를 이동하고 =TAB=을 누르면 됩니다.

시계 항목을 편집하려면 편집하려는 날짜 부분에 커서를 놓고(마우스가 아닌 키보드를 사용하십시오. 마우스로 타임스탬프를 클릭하면 해당 날짜의 의제로 돌아가기 때문입니다) `S를 누르십시오. -<위쪽 화살표>` 또는 `S-<아래쪽 화살표>` 키를 눌러 시간을 변경합니다.

다음 설정은 시간 편집에서 불연속적인 분 간격을 사용하도록 합니다(반올림 없음).
(setq org-time-stamp-rounding-minutes (quote (1 1)))

이동 화살표 조합으로 시간을 편집하면 시계 라인의 총계도 업데이트되므로 매우
편리합니다.

I always check that I haven't created task overlaps when fixing time clock
entries by viewing them with log mode on in the agenda. There is a new view in
the agenda for this -- just hit `v c` in the daily agenda and clock gaps and
overlaps are identified.

저는 항상 안건에서 로그 모드를 켜고 시계 항목을 확인하여 시간 기록 항목을 수정할
때 작업 중복을 생성하지 않았는지 확인합니다. 이에 대한 의제에 새로운 보기가
있습니다. 일일 의제에서 =v c=를 누르기만 하면 시간 간격과 중복이 식별됩니다.

내 시계 항목이 가능한 한 정확하기를 원합니다.
다음 설정은 1 분의 클럭킹 간격을 보여줍니다.

```text
(setq org-agenda-clock-consistency-checks
      (quote (:max-duration "4:00"
                            :min-duration 0
                            :max-gap 0
                            :gap-ok-around ("4:00"))))
```

뽀모도로나 기타 활용하는 패키지들을 언급한다. 왜?!
스맥스에 있는 나의 코드도 여기에 밀어 넣어야 하는데 어디에 넣으려고?!


### Code Block {#code-block}

```elisp

;; (setq org-clock-idle-time 10)
;; (setq org-clock-reminder-timer (run-with-timer
;;                                 t (* org-clock-idle-time 60)
;;                                 (lambda ()
;;                                   (unless (org-clocking-p)
;;                                     (alert "Do you forget to clock-in?"
;;                                            :title "Org Clock")))))

;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)
;; (org-clock-auto-clockout-insinuate) ; off
;; Show lot of clocking history so it's easy to pick items off the C-F11 list
(setq org-clock-history-length 23)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

(setq bh/keep-clock-running nil)

(defun bh/clock-in-to-next (kw)
  "Switch a task from TODO to NEXT when clocking in.
  Skips capture tasks, projects, and subprojects.
  Switch projects and subprojects from NEXT back to TODO"
  (when (not (and (boundp 'org-capture-mode) org-capture-mode))
    (cond
     ((and (member (org-get-todo-state) (list "TODO"))
           (bh/is-task-p))
      "NEXT")
     ((and (member (org-get-todo-state) (list "NEXT"))
           (bh/is-project-p))
      "TODO"))))

;; Change tasks to NEXT when clocking in
(setq org-clock-in-switch-to-state 'bh/clock-in-to-next)

(defun bh/find-project-task ()
  "Move point to the parent (project) task if any"
  (save-restriction
    (widen)
    (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
      (while (org-up-heading-safe)
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq parent-task (point))))
      (goto-char parent-task)
      parent-task)))

(defun bh/punch-in (arg)
  "Start continuous clocking and set the default task to the
  selected task.  If no task is selected set the Organization task
  as the default task."
  (interactive "p")
  (setq bh/keep-clock-running t)
  (if (equal major-mode 'org-agenda-mode)
      ;; We're in the agenda
      (let* ((marker (org-get-at-bol 'org-hd-marker))
             (tags (org-with-point-at marker (org-get-tags-at))))
        (if (and (eq arg 4) tags)
            (org-agenda-clock-in '(16))
          (bh/clock-in-organization-task-as-default)))
    ;; We are not in the agenda
    (save-restriction
      (widen)
      ;; Find the tags on the current task
      (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
          (org-clock-in '(16))
        (bh/clock-in-organization-task-as-default)))))

(defun bh/punch-out ()
  (interactive)
  (setq bh/keep-clock-running nil)
  (when (org-clock-is-active)
    (org-clock-out))
  (org-agenda-remove-restriction-lock))

(defun bh/clock-in-default-task ()
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in))))

(defun bh/clock-in-parent-task ()
  "Move point to the parent (project) task if any and clock in"
  (let ((parent-task))
    (save-excursion
      (save-restriction
        (widen)
        (while (and (not parent-task) (org-up-heading-safe))
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq parent-task (point))))
        (if parent-task
            (org-with-point-at parent-task
              (org-clock-in))
          (when bh/keep-clock-running
            (bh/clock-in-default-task)))))))

(defvar bh/organization-task-id "eb155a82-92b2-4f25-a3c6-0304591af2f9")

(defun bh/clock-in-organization-task-as-default ()
  (interactive)
  (org-with-point-at (org-id-find bh/organization-task-id 'marker)
    (org-clock-in '(16))))

(defun bh/clock-out-maybe ()
  (when (and bh/keep-clock-running
             (not org-clock-clocking-in)
             (marker-buffer org-clock-default-task)
             (not org-clock-resolving-clocks-due-to-idleness))
    (bh/clock-in-parent-task)))

(add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)

;; (require 'org-id) ; delete compile error on emacs-29
(defun bh/clock-in-task-by-id (id)
  "Clock in a task by id"
  (org-with-point-at (org-id-find id 'marker)
    (org-clock-in nil)))

(defun bh/clock-in-last-task (arg)
  "Clock in the interrupted task if there is one
  Skip the default task and get the next one.
  A prefix arg forces clock in of the default task."
  (interactive "p")
  (let ((clock-in-to-task
         (cond
          ((eq arg 4) org-clock-default-task)
          ((and (org-clock-is-active)
                (equal org-clock-default-task (cadr org-clock-history)))
           (caddr org-clock-history))
          ((org-clock-is-active) (cadr org-clock-history))
          ((equal org-clock-default-task (car org-clock-history)) (cadr org-clock-history))
          (t (car org-clock-history)))))
    (widen)
    (org-with-point-at clock-in-to-task
      (org-clock-in nil))))

(setq org-time-stamp-rounding-minutes (quote (1 1)))

(setq org-agenda-clock-consistency-checks
      (quote (:max-duration "4:00"
                            :min-duration 0
                            :max-gap 0
                            :gap-ok-around ("4:00"))))
```


## Time reporting and tracking {#time-reporting-and-tracking}

고객사 요청에 따라서 작업한 시간 내역을 공유한다면 이 기능 없이
어떻게 가능하겠는가?! 나의 생산성을 검토할 수 있기에 메타 인지에
도움이 된다.

노랑님의 구성은 10 년 전 오그 모드 버전이다. 10 년 동안 오그 모드가
얼마나 변했겠는가? 더 정교해 졌으리라 믿는데. 사용법을 모른다. 인포 문서봐라!


### Code Block {#code-block}

9 의 연장선에서 그림을 그리는 코드다. 이게 끝이 아니다.
시간 기록은 나도 열심히 해왔다. 근데 그게 뭐?
의미 있는 정보로 활용한 적은 없다. 그저 기록하고 있다라고
나를 압박하는 것일 뿐.

사회가 개인화 되고 개인의 역량에 대한 가치로 비용을 정산해야 하는
미래에는 대충 몇시간 했어요 돈 줘요 이렇게는 투명하지 않다.

시간 리포트를 같이 제출해야 할 것이다. 이게 얼마나 투명하게 할지는 깃헙에
이 데이터를 기록하게 하면 될 것이다. 아무튼 책상에 앉아 있을 때는 기록을 하자.

```elisp
;; Sometimes I change tasks I'm clocking quickly
;;  - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Agenda clock report parameters
(setq org-agenda-clockreport-parameter-plist
      (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80)))

;; from DW
;; (setq org-columns-default-format
;;      "%20CATEGORY(Category) %65ITEM(Task) %TODO %6Effort(Estim){:} %6CLOCKSUM(Clock) %TAGS")

;; from org-mode-crate
;; (setq org-columns-default-format
;;      "%50ITEM(Task) %5Effort(Effort){:} %5CLOCKSUM %3PRIORITY %20DEADLINE %20SCHEDULED %2  0TIMESTAMP %TODO %CATEGORY(Category) %TAGS")

;; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")

;; global Effort estimate values
;; global STYLE property values for completion
(setq org-global-properties
      (quote
       (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 8:00")
        ("STYLE_ALL" . "habit"))))

;; Agenda log mode items to display (closed clock : default)
;; 이전 이맥스는 state가 기본이었다. 지금은 시간 기준으로 표기한다.
;; closed    Show entries that have been closed on that day.
;; clock     Show entries that have received clocked time on that day.
;; state     Show all logged state changes.
(setq org-agenda-log-mode-items '(closed clock state))
(setq org-agenda-log-mode-add-notes nil)

;; sort 관련 기능을 확인해보고 정의한 함수들이 필요 없으면 빼면 된다.
(setq org-agenda-sort-notime-is-late t) ; Org 9.4
(setq org-agenda-sort-noeffort-is-high t) ; Org 9.4
```


### Billing clients based on clocked time {#billing-clients-based-on-clocked-time}

월초에 저는 지난 달에 수행한 작업에 대해 고객사들에 송장을 발행한다.
그 전에 여기에서 청구 할 금액에 대한 시간 데이터의 정확성을 검토한다.

수집된 시간의 청구 과정은 다음 단계로 진행 된다.

1.  Verify that the clock data is complete and correct
2.  Use `clock reports` to summarize time spent
3.  Create an invoice based on the clock data
4.  Archive complete tasks so they are out of the way.
    See `Archiving` for more details.


#### Verify that the clock data is complete and correct {#verify-that-the-clock-data-is-complete-and-correct}

시계 데이터가 완전하고 올바른지 확인하십시오.

작업을 자주 변경하기 때문에(때로는 1 분에 한 번 이상) 다음 설정을
사용하여 지속 시간이 0 인 시계 항목을 제거합니다.

(setq org-clock-out-remove-zero-time-clocks t)

이 설정은 내 시계 로그 항목을 깔끔하게 유지합니다. 시계 보고서에 들어
갈만한 항목만 유지합니다.

시계 시간에 대한 인보이스를 발행하기 전에 시간 데이터가 정확한지
확인하는 것이 중요합니다. 끝나지 않은 항목(즉, 종료 시간이 없음)이
있는 시계 시간이 있는 경우 시계 날짜의 공백이며
시계 보고서를 생성할 때 작업에 소요된 시간이 0 으로 계산됩니다.
0 으로 세는 것은 잘못된 것입니다.

종료가 제대로 안 된 항목을 확인하기 위해
어젠다에서 시계 검사를
사용합니다 (어젠다에서 `v c`). 이는 시계 데이터의 간격과 겹침을 보여줍니다.

To check the last month's clock data I use `F12 a v m b v c` which shows a full month in the agenda, moves to the previous month, and shows the clocked times only. It's important to remove any agenda restriction locks and filters when checking the logs for gaps and overlaps.

지난 달의 시계 데이터를 확인하기 위해 나는 =F12 a v m b vc=를 사용하여 안건에서 한 달 전체를 표시하고 이전 달로 이동하며 시계 시간만 표시합니다. 간격 및 겹침에 대한 로그를 확인할 때 의제 제한 잠금 및 필터를 제거하는 것이 중요합니다.

어젠다에 clocked-time 만 표시되므로 항목에 종료 시간이 누락되었는지
확인하기 위해 목록을 빠르게 스캔할 수 있습니다. 항목이 닫히지 않은 경우
해당 시간 주변의 다른 시계 정보를 기반으로 시계 항목을 수동으로
수정할 수 있습니다.

&gt;&gt; 실제 위에 동작되나?


#### Using clock reports to summarize time spent {#using-clock-reports-to-summarize-time-spent}

시계 보고서를 사용하여 소요 시간 요약 클라이언트에 대한
청구 가능 시간은 별도의 오그 파일에 보관됩니다.

`XYZ.org=의 작업에 소요된 시간 보고서를 받으려면 =XYZ.org` 파일을
방문하고 =F12 &lt; a v m b R=을 사용하여 지난 달의 일정 시계 보고서를
실행하기만 하면 됩니다. 이것은 의제를 이 하나의 파일로 제한하고
전체 월의 의제를 표시하고 지난 달로 이동하며 시계 보고서를 생성합니다.

My agenda org clock report settings show 5 levels of detail with links to the tasks. I like wider reports than the default compact setting so I override the `:narrow` value.

내 의제 조직 시계 보고서 설정에는 태스크에 대한 링크와 함께 다섯 가지의
세부 수준이 표시됩니다. 저는 조밀한 기본 설정보다 더 넓은 보고서를
선호하므로 `:narrow` 값을 재정의합니다.

setq org-agenda-clockreport-parameter-plist ...
; (:link t :maxlevel 2) 이맥스 기본 값
; (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80))) 설정 값

나는 각 프로젝트 조직 파일에 월별 시계 보고서 동적 블록을 가지고 있었고
청구 주기가 끝날 때 수동으로 업데이트했습니다. 저는 이것을 고객의 프로젝트에
소요된 시간에 대해 비용을 청구하는 기준으로 사용했습니다.
한 달에 두 개 이상의 파일이 있는 경우 동적 블록을 업데이트하는 것이
상당히 지루하다는 것을 알았습니다.

이후 ~어젠다에 관련 기능~이 추가된 직후 내장된 시계 보고서 기능을
사용하도록 전환했습니다. 저는 이게 훨씬 편합니다.
데이터는 일반적으로 다른 사람이 소비하는 것이 아니므로 의제 시계 보고서
형식이 제 사용 사례에 적합합니다.


### Task Estimates and column view {#task-estimates-and-column-view}

작업을 완료하는 데 걸리는 시간을 추정하는 것은 마스터하기 어려운 기술입니다.
조직 모드는 이러한 추정 과정을 쉽게 훈련하게 하며, 완료 하는데까지의
실제 소요 시간을 기록할 수 있다.
반복적인 연습과 노력을 통해서 예측 능력이 향상되게 될 것이다.


#### Creating a task estimate with `column mode` {#creating-a-task-estimate-with-column-mode}

`properties` 및 =column view=를 사용하여 프로젝트 추정을 수행합니다.
다음 헤드라인을 사용하여 열 보기를 전역적으로 설정했습니다.

<kbd>(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")</kbd>

이렇게 하면 열 보기에 예상 작업 노력과 시계 시간이 나란히 표시되어
프로젝트 추정을 검토하는 데 좋습니다.

=Effort=라는 속성은 주어진 작업을 완료하는 데 걸리는 예상 시간을
기록합니다. 내가 사용하는 예상 시간은 다음 중 하나입니다.

-   10 minutes, 30 minutes, 1 hour ~ 8 hours

이들은 전역 속성 =Effort_ALL=의 =열 모드=에서 쉽게 사용할 수 있도록 저장됩니다.
(setq org-global-properties ...

작업 또는 하위 트리에 대한 추정치를 생성하려면 =C-c C-x C-c=로 열
모드를 시작하고 =c=로 트리를 축소합니다. 여기에는 작업 이름, 예상 작업량
및 시계 시간이 열로 표시된 헤드라인 위에 오버레이된 테이블이 표시됩니다.

작업의 `Effort` 열에 있는 커서를 사용하여 빠른 키 `1` ~ =9=를
사용하여 예상 노력 값을 쉽게 설정할 수 있습니다. 노력 값을 설정한 후
=q=로 =column mode=를 종료합니다.

22/11/19--17:23 :: 실제로 잘 됩니다.

-   `C-c C-x C-c` org-colums
    스맥스에 메이저모드 키로 매핑이 안되 있네요.
    해당 열에 가서 1-9 입력하면 시간 입력이 됩니다.
-   `, E` or `M-RET E` org-set-effort
    스맥스 메이저모드 키로 입력하는게 편해서 E 로 내가 매핑함.


#### Saving your estimate {#saving-your-estimate}

&gt;&gt; 아래 실제 해본 다음에 적어 놓음. 키바인딩 다름.

클라이언트 측에 시간/비용 견적을 제공해야 하는 고정 비용의 작업이라면,
프로젝트를 완료하기 위해서 사전에 전달한 예상 추정 치를
저장해 놓는 것이 유용할 것이다.

추정 프로젝트 하위 트리의 맨 위에 동적 시계 보고서 테이블을 만들어 원래 추정치를
저장합니다. =C-c C-x i RET=를 입력하면 예상 값과 현재까지의 시계 시간이 포함된
시계 테이블 보고서가 삽입됩니다.

```org
Original Estimate
#+BEGIN: columnview :hlines 1 :id local
| Task                        | Estimated Effort | CLOCKSUM |
|-----------------------------+------------------+----------|
| ** TODO Project to estimate |             5:40 |          |
| *** TODO Step 1             |             0:10 |          |
| *** TODO Step 2             |             0:10 |          |
| *** TODO Step 3             |             5:10 |          |
| **** TODO Step 3.1          |             2:00 |          |
| **** TODO Step 3.2          |             3:00 |          |
| **** TODO Step 3.3          |             0:10 |          |
| *** TODO Step 4             |             0:10 |          |
#+END:
```

나는 일반적으로 `#+에서 =C-c C-c=를 눌러 실수로 테이블을 업데이트하지 않도록
클라이언트에 추정치를 제공한 후 원래 테이블에서 =#+BEGIN:` 및 `#+END:` 행을
삭제합니다.

원래 추정 데이터를 저장하면 원래 추정 데이터를 잃지 않고 프로젝트에서 작업하면서
프로젝트 작업을 하위 작업으로 세분화할 수 있습니다.

22/11/19--17:29 :: 실제 해본 뒤에 적음

org-dynamic-block-insert-dblock
함수를 호출하면 cloumnview, clocktable 둘중에 선택을 하라한다.
맞춰서 하면 아래와 같은 정보를 확인할 수 있다.
org-clock-report

```text
1) 글로벌 cloumnview
| Task                           | Effort | CLOCKSUM |
|--------------------------------+--------+----------|
| Programming Clojure Reviews    |        |          |
|--------------------------------+--------+----------|
| Sample                         |   3:30 |          |
| SP: Sample Project to estimate |   3:30 |          |
| SP: Step 1                     |   1:00 |          |
| SP: Step 2                     |   0:30 |          |
| SP: Step 3                     |   1:30 |          |
| SP: Step 3.1                   |   0:30 |          |
| SP: Step 3.2                   |   0:30 |          |
| SP: Step 3.3                   |   0:30 |          |
| SP: Step 4                     |   0:30 |          |

2) 로컬 cloumnview
| Task                           | Effort | CLOCKSUM |
|--------------------------------+--------+----------|
| SP: Sample Project to estimate |   3:30 |          |
| SP: Step 1                     |   1:00 |          |
| SP: Step 2                     |   0:30 |          |
| SP: Step 3                     |   1:30 |          |
| SP: Step 3.1                   |   0:30 |          |
| SP: Step 3.2                   |   0:30 |          |
| SP: Step 3.3                   |   0:30 |          |
| SP: Step 4                     |   0:30 |          |

3) clocktable
| Headline     | Time   |
|--------------+--------|
| *Total time* | *0:00* |
```


#### Reviewing your estimate {#reviewing-your-estimate}

=Column view=는 견적을 검토하는 데 유용합니다. 여기에는 프로젝트의 예상 시간 값과 총 시계 시간이 나란히 표시됩니다.

=C-c C-x i RET=를 사용하여 동적 시계 테이블을 생성하는 것은 다른 응용 프로그램에서 사용할 수 있도록 해야 하는 경우 이 프로젝트 검토를 저장하는 좋은 방법입니다.

=C-c C-x C-d=는 또한 현재 org 파일에 대한 빠른 시간 요약을 제공합니다.


### Providing progress reports to others {#providing-progress-reports-to-others}

&gt; 어젠다뷰에서 이전 시간으로 가면서 R 을 눌러서 보고서를 뽑아 내고 이를
텍스트 파일로 만들어서 전달하면 된다.

누군가 내가 최근에 한 일에 대한 세부 정보를 원할 때,
나는 내가 완료한 작업과 기간 동안의 시계 보고서(clock report) 와 더불어
상태 변경 사항이 포함된 로그 보고서(log report)를 어젠다에서 간단하게 생성합니다.

`R` org-agenda-clock-report-mode

다음 설정은 의제에서 종료된 작업 및 상태 변경을 보여줍니다. 의제 시계
보고서('R')와 결합하여 필요한 모든 세부 정보를 신속하게 생성할 수 있습니다.

(setq org-agenda-log-mode-items (quote (closed state)))

보고서를 생성하기 위해
적절한 시간 프레임(오늘, 어제, 이번 주 또는 지난주)에 대한 의제를 가져오고
키 시퀀스 =l R=를 눌러 로그 보고서(클록킹 데이터 라인 없음) 및 시간 보고서를
뒤에 추가합니다.

그런 다음 결과 유용한 형식으로 내보내 다른 사람에게 제공하기만 하면
됩니다. =C-x C-w /tmp/agenda.html RET=는 HTML 로 내보내고
=C-x C-w /tmp/agenda.txt RET=는 일반 텍스트로 내보냅니다.
다른 형식도 있지만 저는 이 두 가지를 가장 많이 사용합니다.

이 내보내기를 태그 필터 및 =C-u R=과 결합하면 사람들이 관심을 갖는 태그로 보고서를 제한할 수 있습니다.


### `NEW` org-clock-mode-line {#new-org-clock-mode-line}



```elisp
;; current  Only the time in the current instance of the clock
;; today    All time clocked into this task today
;; repeat   All time clocked into this task since last repeat
;; all      All time ever recorded for this task
;; auto     Automatically, either all, or repeat for repeating tasks
(setq org-clock-mode-line-entry t)
(setq org-clock-mode-line-line-total 'auto)
```


## Tags {#tags}

나도 태그를 좀 신경써서 구성했는데, 여기에 일단 맞춘다.
태그의 역할을 한정지어서 바라보면 안된다.

상속태그는 일단 기본으로 보이게 한다. 태그 시스템은 상당히 점진적으로
개선할 부분이다.


### Intro {#intro}

태그의 역할을 참으로 다양하다.

Tasks can have any number of arbitrary tags. Tags are used for:

filtering todo lists and agenda views
providing context for tasks
tagging notes
tagging phone calls
tagging meetings
tagging tasks to be refiled
tagging tasks in a WAITING state because a parent task is WAITING
tagging cancelled tasks because a parent task is CANCELLED
preventing export of some subtrees when publishing


### `Code Block` {#code-block}

```elisp
;; FILETAGS로 상속받은 태그는 어젠다에서 숨긴다. 상속 태그
;; (setq org-agenda-show-inherited-tags nil)

(setq org-auto-align-tags nil) ; default
;; 태그 위치를 좌측으로 당겨야 버티컬 창 여러개에서 한 줄로 표현할 수 있다.
(setq org-tags-column 0) ; default -77

;; Allow setting single tags without the menu
;; (setq org-fast-tag-selection-single-key (quote expert))
;; (setq org-fast-tag-selection-single-key nil)
(setq org-fast-tag-selection-single-key t)

(setq org-tags-match-list-sublevels 'intented) ; t
(setq org-tags-exclude-from-inheritance '("Project")) ; nil

;; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ("@errand" . ?e)
                            ("@office" . ?o)
                            ("@home" . ?h)
                            ("@farm" . ?f) ; Example
                            (:endgroup)
                            ("HOLD" . ?h)
                            ("Project" . ?p) ; Project
                            ("NOTE" . ?n)
                            ("CANCELLED" . ?c)
                            ("FLAGGED" . ??))))

;; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)
```


## Handling Notes {#HandlingNotes}

메모는 하루 동안 접하게 되는 지식의 작은 보석입니다. 그들은 할 일이 없다는 점을
제외하고는 작업과 같습니다 (지식의 보석을 배우고 암기하는 것 제외). 불행히도
기억할 보석이 너무 많아서 생각만 해도 머리가 터질 지경입니다.

org-mode to the rescue! :: 구원자여!
종종 Gnus 에서 org-mode 및 git 메일링 목록을 읽는 동안 멋진 기능이나 기억하고
싶은 것을 찾게 됩니다. 메모를 작성하려면 메모 캡처 템플릿 =C-c c n=을 사용하고
메모 제목을 입력하고 =C-c C-c=를 입력하여 저장합니다. 할 수 있는 유일한 다른
작업은 (나중에) 적절한 프로젝트 파일로 다시 파일화하는 것입니다.

메모를 찾기 위해 의제보기가 있습니다. 메모는 적절한 프로젝트 파일 및 작업으로
다시 정리됩니다. 그것이 속한 특정 작업이 없으면 catchall `* Notes` 작업으로
이동합니다. 나는 일반적으로 모든 프로젝트 파일에 포괄적인 메모 작업을 가지고
있습니다. 메모는 캡처 템플릿에 의해 이미 적용된 `NOTE` 태그로 생성되므로
어디에서나 메모를 다시 정리할 수 있습니다. 노트가 내 의제에 기여하는 프로젝트
파일(예: org-agenda-files)에 있는 한 키 조합 =F12 N=을 눌러 내 노트 의제 보기로
쉽게 노트를 다시 찾을 수 있습니다. 표준 의제 태그 필터링을 사용하여 노트의 의제
보기를 자유롭게 제한할 수 있습니다.

의미 있는 헤드라인이 있는 짧은 노트는 =F12 N=을 사용하여 필요할 때 다시 찾는
방법 외에는 실제로 아무것도 기억할 필요가 없기 때문에
기술적인 세부 사항을 기억할 수 있는 매우 좋은 방법입니다.

프로젝트와 관련이 있고 일반적으로 유용하지 않은 메모는 프로젝트와 함께 보관하고
프로젝트가 제거될 때 의제에서 제거할 수 있습니다.

그래서 내 조직 노트는 org.org 에 들어가고 내 깃 관련 노트는 `* Notes` 아래에 있는
git.org 에 들어갑니다. 나는 그것들을 영원히 찾을 수 있을 것이다. 프로젝트와 함께
기억하고 싶은 일부 작업프로젝트 세부 사항에 대한 메모는 적절한 작업 조직 모드
파일 아래의 프로젝트 작업에 보관되며 결국 프로젝트가 완료되고 보관되면 의제에서
제거됩니다.


## GTD {#gtd}

GTD 에서 다루는 프로젝트 관리를 보자.


### Overviews {#overviews}



I'm using a new lazy project definition to mark tasks as projects. This requires
zero effort from me. Any task with a subtask using a todo keyword is a project.
Period.

작업을 프로젝트로 표시하기 위해 새로운 지연 프로젝트 정의를 사용하고 있습니다.
이것은 나의 노력이 전혀 필요하지 않습니다. todo 키워드를 사용하는 하위 작업이
있는 모든 작업은 프로젝트입니다. 기간.

Projects are 'stuck' if they have no subtask with a `NEXT` todo keyword task
defined.

`NEXT` todo 키워드 작업이 정의된 하위 작업이 없으면 프로젝트가 '중단'됩니다.

The org-mode stuck projects agenda view lists projects that have no `NEXT` task
defined. Stuck projects show up on my block agenda and I tend to assign a `NEXT`
task so the list remains empty. This helps to keep projects moving forward.

조직 모드 고정 프로젝트 안건 보기에는 `NEXT` 작업이 정의되지 않은 프로젝트가
나열됩니다. 중단된 프로젝트가 내 블록 안건에 표시되고 `NEXT` 작업을 할당하여
목록이 비어 있도록 하는 경향이 있습니다. 이는 프로젝트를 계속 진행하는 데 도움이
됩니다.

I disable the default org-mode stuck projects agenda view with the following
setting.

다음 설정으로 기본 조직 모드 고정 프로젝트 의제 보기를 비활성화합니다.

This prevents org-mode from trying to show incorrect data if I select the
default stuck project view with `F12 #` from the agenda menu. My customized
stuck projects view is part of my block agenda displayed with `F12 SPC`.

이렇게 하면 의사 일정 메뉴에서 =F12 #=를 사용하여 기본 고정 프로젝트 보기를
선택하는 경우 조직 모드가 잘못된 데이터를 표시하려고 시도하는 것을 방지할 수
있습니다. 내 사용자 지정 중단된 프로젝트 보기는 =F12 SPC=로 표시되는 내 블록
안건의 일부입니다.

Projects can have subprojects - and these subprojects can also be stuck. Any
project that is stuck shows up on the stuck projects list so I can indicate or
create a `NEXT` task to move that project forward.

프로젝트에는 하위 프로젝트가 있을 수 있으며 이러한 하위 프로젝트도 중단될 수
있습니다. 중단된 모든 프로젝트는 중단된 프로젝트 목록에 표시되므로 `NEXT` 작업을
표시하거나 생성하여 해당 프로젝트를 진행할 수 있습니다.

In the following example `Stuck Project A` is stuck because it has no subtask
which is `NEXT`. `Project C` is not stuck because it has `NEXT` tasks `SubTask
G` and `Task I`. `Stuck Sub Project D` is stuck because `SubTask E` is not
`NEXT` and there are no other tasks available in this project.

다음 예에서 `Stuck Project A=는 =NEXT=인 하위 작업이 없기 때문에 중단되었습니다.
=프로젝트 C=는 =NEXT` 작업 `하위 작업 G` 및 =작업 I=이 있기 때문에 중단되지
않습니다. =Stuck Sub Project D=는 =SubTask E=가 =NEXT=가 아니고 이 프로젝트에
사용 가능한 다른 작업이 없기 때문에 중단되었습니다.

All of the stuck projects and subprojects show up in the stuck projects list and
that is my indication to assign or create `NEXT` tasks until the stuck projects
list is empty. Occasionally some subtask is `WAITING` for something and the
project is stuck until that condition is satisfied. In this case I leave it on
the stuck project list and just work on something else. This stuck project
'bugs' me regularly when I see it on the block agenda and this prompts me to
follow up on the thing that I'm waiting for.

중단된 모든 프로젝트 및 하위 프로젝트가 중단된 프로젝트 목록에 표시되며 이는
중단된 프로젝트 목록이 비워질 때까지 `NEXT` 작업을 할당하거나 생성하라는
표시입니다. 때때로 일부 하위 작업이 무언가에 대해 =WAITING=이고 해당 조건이
충족될 때까지 프로젝트가 중단됩니다. 이 경우에는 중단된 프로젝트 목록에 그대로
두고 다른 작업을 수행합니다. 이 정체된 프로젝트는 블록 의제에서 볼 때 정기적으로
저를 '버그'로 만들고 이것은 제가 기다리고 있는 것에 대한 후속 조치를 취하도록
유도합니다.


### `Code Block` {#code-block}



```elisp
(setq org-agenda-span 'day)

;; /home/junghan/.emacs.tshu/lisp/lang-org.el
;; 노랑님은 이걸 사용하지 않고 직접 서브 시스템을 만들었다.
(setq org-stuck-projects (quote ("" nil nil "")))

(defun bh/is-project-p ()
  "Any task with a todo keyword subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task has-subtask))))

(defun bh/is-project-subtree-p ()
  "Any task with a todo keyword that is in a project subtree.
  Callers of this function already widen the buffer view."
  (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
                              (point))))
    (save-excursion
      (bh/find-project-task)
      (if (equal (point) task)
          nil
        t))))

(defun bh/is-task-p ()
  "Any task with a todo keyword and no subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task (not has-subtask)))))

(defun bh/is-subproject-p ()
  "Any task which is a subtask of another project"
  (let ((is-subproject)
        (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
    (save-excursion
      (while (and (not is-subproject) (org-up-heading-safe))
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq is-subproject t))))
    (and is-a-task is-subproject)))

(defun bh/list-sublevels-for-projects-indented ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
    This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels 'indented)
    (setq org-tags-match-list-sublevels nil))
  nil)

(defun bh/list-sublevels-for-projects ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
    This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels t)
    (setq org-tags-match-list-sublevels nil))
  nil)

(defvar bh/hide-scheduled-and-waiting-next-tasks t)

(defun bh/toggle-next-task-display ()
  (interactive)
  (setq bh/hide-scheduled-and-waiting-next-tasks (not bh/hide-scheduled-and-waiting-next-tasks))
  (when  (equal major-mode 'org-agenda-mode)
    (org-agenda-redo))
  (message "%s WAITING and SCHEDULED NEXT Tasks" (if bh/hide-scheduled-and-waiting-next-tasks "Hide" "Show")))

(defun bh/skip-stuck-projects ()
  "Skip trees that are not stuck projects"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (bh/is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                nil
              next-headline)) ; a stuck project, has subtasks but no next task
        nil))))

(defun bh/skip-non-stuck-projects ()
  "Skip trees that are not stuck projects"
  ;; (bh/list-sublevels-for-projects-indented)
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (bh/is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                next-headline
              nil)) ; a stuck project, has subtasks but no next task
        next-headline))))

(defun bh/skip-non-projects ()
  "Skip trees that are not projects"
  ;; (bh/list-sublevels-for-projects-indented)
  (if (save-excursion (bh/skip-non-stuck-projects))
      (save-restriction
        (widen)
        (let ((subtree-end (save-excursion (org-end-of-subtree t))))
          (cond
           ((bh/is-project-p)
            nil)
           ((and (bh/is-project-subtree-p) (not (bh/is-task-p)))
            nil)
           (t
            subtree-end))))
    (save-excursion (org-end-of-subtree t))))

(defun bh/skip-project-trees-and-habits ()
  "Skip trees that are projects"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-projects-and-habits-and-single-tasks ()
  "Skip trees that are projects, tasks that are habits, single non-project tasks"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((org-is-habit-p)
        next-headline)
       ((and bh/hide-scheduled-and-waiting-next-tasks
             (member "WAITING" (org-get-tags-at)))
        next-headline)
       ((bh/is-project-p)
        next-headline)
       ((and (bh/is-task-p) (not (bh/is-project-subtree-p)))
        next-headline)
       (t
        nil)))))

(defun bh/skip-project-tasks-maybe ()
  "Show tasks related to the current restriction.
  When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
  When not restricted, skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
           (next-headline (save-excursion (or (outline-next-heading) (point-max))))
           (limit-to-project (marker-buffer org-agenda-restrict-begin)))
      (cond
       ((bh/is-project-p)
        next-headline)
       ((org-is-habit-p)
        subtree-end)
       ((and (not limit-to-project)
             (bh/is-project-subtree-p))
        subtree-end)
       ((and limit-to-project
             (bh/is-project-subtree-p)
             (member (org-get-todo-state) (list "NEXT")))
        subtree-end)
       (t
        nil)))))

(defun bh/skip-project-tasks ()
  "Show non-project tasks.
  Skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       ((bh/is-project-subtree-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-non-project-tasks ()
  "Show project tasks.
  Skip project and sub-project tasks, habits, and loose non-project tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
           (next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((bh/is-project-p)
        next-headline)
       ((org-is-habit-p)
        subtree-end)
       ((and (bh/is-project-subtree-p)
             (member (org-get-todo-state) (list "NEXT")))
        subtree-end)
       ((not (bh/is-project-subtree-p))
        subtree-end)
       (t
        nil)))))

(defun bh/skip-projects-and-habits ()
  "Skip trees that are projects and tasks that are habits"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-non-subprojects ()
  "Skip trees that are not projects"
  (let ((next-headline (save-excursion (outline-next-heading))))
    (if (bh/is-subproject-p)
        nil
      next-headline)))
```


## Archiving {#archiving}

이건 아직 해보지도 않았네. 해볼거야. 아래 설정 잘 되어 있구나.

```elisp
(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archived Tasks")

(defun bh/skip-non-archivable-tasks ()
  "Skip trees that are not available for archiving"
  (save-restriction
    (widen)
    ;; Consider only tasks with done todo headings as archivable candidates
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max))))
          (subtree-end (save-excursion (org-end-of-subtree t))))
      (if (member (org-get-todo-state) org-todo-keywords-1)
          (if (member (org-get-todo-state) org-done-keywords)
              (let* ((daynr (string-to-number (format-time-string "%d" (current-time))))
                     (a-month-ago (* 60 60 24 (+ daynr 1)))
                     (last-month (format-time-string "%Y-%m-" (time-subtract (current-time) (seconds-to-time a-month-ago))))
                     (this-month (format-time-string "%Y-%m-" (current-time)))
                     (subtree-is-current (save-excursion
                                           (forward-line 1)
                                           (and (< (point) subtree-end)
                                                (re-search-forward (concat last-month "\\|" this-month) subtree-end t)))))
                (if subtree-is-current
                    subtree-end ; Has a date in this month or last month, skip it
                  nil))  ; available to archive
            (or subtree-end (point-max)))
        next-headline))))
```


## Publishing and Exporting {#publishing-and-exporting}


### Org-babel :: `Clojure with BB` {#org-babel-clojure-with-bb}

Babashka 로 설정했다. 코드는 아래 참고.

Add support for running Org-mode Clojure source blocks with [Babashka](https://github.com/borkdude/babashka):
[Add support for running clojure blocks in org-mode via babashka · 5f9dbe53ce ...](https://git.jeremydormitzer.com/jdormit/dotfiles/commit/5f9dbe53cea2b37fc89cc49f858f98387da99576)

```elisp
(require 'ob-clojure)
;; (require 'cider)
(with-eval-after-load 'ob-clojure
  (defcustom org-babel-clojure-backend nil
    "Backend used to evaluate Clojure code blocks."
    :group 'org-babel
    :type '(choice
            (const :tag "inf-clojure" inf-clojure)
            (const :tag "cider" cider)
            (const :tag "slime" slime)
            (const :tag "bb" bb)
            (const :tag "Not configured yet" nil)))

  (defun elisp->clj (in)
    (cond
     ((listp in) (concat "[" (s-join " " (mapcar #'elisp->clj in)) "]"))
     (t (format "%s" in))))

  (defun ob-clojure-eval-with-bb (expanded params)
    "Evaluate EXPANDED code block with PARAMS using babashka."
    (unless (executable-find "bb")
      (user-error "Babashka not installed"))
    (let* ((stdin (let ((stdin (cdr (assq :stdin params))))
                    (when stdin
                      (elisp->clj
                       (org-babel-ref-resolve stdin)))))
           (input (cdr (assq :input params)))
           (file (make-temp-file "ob-clojure-bb" nil nil expanded))
           (command (concat (when stdin (format "echo %s | " (shell-quote-argument stdin)))
                            (format "bb %s -f %s"
                                    (cond
                                     ((equal input "edn") "")
                                     ((equal input "text") "-i")
                                     (t ""))
                                    (shell-quote-argument file))))
           (result (shell-command-to-string command)))
      (s-trim result)))

  (defun org-babel-execute:clojure (body params)
    "Execute a block of Clojure code with Babel."
    (unless org-babel-clojure-backend
      (user-error "You need to customize org-babel-clojure-backend"))
    (let* ((expanded (org-babel-expand-body:clojure body params))
           (result-params (cdr (assq :result-params params)))
           result)
      (setq result
            (cond
             ((eq org-babel-clojure-backend 'inf-clojure)
              (ob-clojure-eval-with-inf-clojure expanded params))
             ((eq org-babel-clojure-backend 'cider)
              (ob-clojure-eval-with-cider expanded params))
             ((eq org-babel-clojure-backend 'slime)
              (ob-clojure-eval-with-slime expanded params))
             ((eq org-babel-clojure-backend 'bb)
              (ob-clojure-eval-with-bb expanded params))))
      (org-babel-result-cond result-params
        result
        (condition-case nil (org-babel-script-escape result)
          (error result)))))

  ;; bb
  (customize-set-variable 'org-babel-clojure-backend 'bb))

(add-hook 'org-mode-hook (lambda () (require 'ob-clojure)))
```


### Org-babel Setup {#org-babel-setup}

```elisp
(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)

;; 대문자가 좋다 uppercase better
;; (setq org-babel-uppercase-example-markers t) ; default nil

(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))

(setq org-startup-with-inline-images t)
(setq org-image-actual-width (min (/ (display-pixel-width) 3) 640))
;; (setq org-image-actual-width 400)

(setq plantuml-jar-path "/usr/share/plantuml/plantuml.jar"
      org-plantuml-jar-path "/usr/share/plantuml/plantuml.jar")
(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")

(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (shell . t)
         (awk . t)
         (ditaa . t)
         (sed . t)
         (python . t)
         (gnuplot . t)
         (clojure . t)
         (ruby . t)
         (js . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         )))

(setq org-confirm-babel-evaluate nil)
(setq org-edit-src-persistent-message nil)
(setq org-src-fontify-natively t)
(setq org-edit-src-content-indentation 0)

;; from +org-init-babel-h doom-emacs
(setq org-src-preserve-indentation t  ; use native major-mode indentation
      org-src-tab-acts-natively t     ; we do this ourselves
      ;; You don't need my permission (just be careful, mkay?)
      org-link-elisp-confirm-function nil
      ;; Our :lang common-lisp module uses sly, so...
      org-babel-lisp-eval-fn #'sly-eval)

;; I prefer C-c C-c over C-c ' (more consistent)
(define-key org-src-mode-map (kbd "C-c C-c") #'org-edit-src-exit)
```


## Productivity Tools {#productivity-tools}


### Focus on Current Work {#focus-on-current-work}

22/11/19--12:29 :: 필요해서 다시 넣는다. 다른데서 호출하더라.
일단 팔로우 모드를 기본으로 키맵으로 수정했다. 일부로 호출하지 않는 이상
사용하지는 않을 것이긴 하나 매우 유용한 기능임은 확실하다.
그리고 이미 기능이 바인딩 되어 있으므로 파악을 해야 오작동을 안한다.


#### Narrowing to a subtree with `bh/org-todo` {#narrowing-to-a-subtree-with-bh-org-todo}

`f5` 및 =S-f5=는 아래에 정의된 것처럼 emacs 버퍼를 좁히고 넓히는 기능을 바인딩합니다.

이제 다음을 사용합니다.

-   T (tasks) for C-c / t on the current buffer
-   N (narrow) narrows to this task subtree
-   U (up) narrows to the immediate parent task subtree without moving
-   P (project) narrows to the parent project subtree without moving
-   F (file) narrows to the current file or file of the existing restriction

의제는 조직 버퍼를 계속 넓혀서 우리가 하고 있는 일에 집중할 수 있는 편리한
방법을 제공합니다. 이렇게 하면 보기를 이 작업 하위 트리로 제한하여 조직 파일의
다른 모든 세부 정보를 일시적으로 쉽게 숨길 수 있습니다. 완료되지 않은 작업만
표시되도록 작업이 접히고 강조 표시됩니다.

`f5=(또는 =T` 속도 키)를 많이 눌렀습니다. 이것은 기본적으로
`org-narrow-to-subtree` 및 `C-c / t` 조합을 수행하여 버퍼를 축소된 상태로
둡니다. `S-f5=(또는 =U`, `W`, =F=와 같은 다른 확장 속도 키)를 사용하여 일반
보기로 다시 확대합니다.

다음 헤드라인을 강제로 표시하는 다음 설정도 있습니다.
(setq org-show-entry-below (quote ((default))))

이렇게 하면 접힌 트리 상태로 작업할 때 너무 많은 헤드라인이 함께 접히는 것을
방지할 수 있습니다.

```elisp

;; 키바인딩 파트에서 이미 했다.
(defun bh/org-todo (arg)
  (interactive "p")
  (if (equal arg 4)
      (save-restriction
        (bh/narrow-to-org-subtree)
        (org-show-todo-tree nil))
    (bh/narrow-to-org-subtree)
    (org-show-todo-tree nil)))

(defun bh/widen ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (progn
        (org-agenda-remove-restriction-lock)
        (when org-agenda-sticky
          (org-agenda-redo)))
    (widen)))

(add-hook 'org-agenda-mode-hook
          #'(lambda () (org-defkey org-agenda-mode-map "W" (lambda () (interactive) (setq bh/hide-scheduled-and-waiting-next-tasks t) (bh/widen))))
          'append)

;; 18.2.2-3 절에 필요한 함수.
;; (defun bh/restrict-to-file-or-follow (arg)
;;   "Set agenda restriction to 'file or with argument invoke follow mode.
;; I don't use follow mode very often but I restrict to file all the time
;; so change the default 'F' binding in the agenda to allow both"
;;   (interactive "p")
;;   (if (equal arg 4)
;;       (org-agenda-follow-mode)
;;     (widen)
;;     (bh/set-agenda-restriction-lock 4)
;;     (org-agenda-redo)
;;     (beginning-of-buffer)))

;; (add-hook 'org-agenda-mode-hook
;;           #'(lambda () (org-defkey org-agenda-mode-map "F" 'bh/restrict-to-file-or-follow))
;;          'append)

(defun bh/narrow-to-org-subtree ()
  (widen)
  (org-narrow-to-subtree)
  (save-restriction
    (org-agenda-set-restriction-lock)))

(defun bh/narrow-to-subtree ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (progn
        (org-with-point-at (org-get-at-bol 'org-hd-marker)
          (bh/narrow-to-org-subtree))
        (when org-agenda-sticky
          (org-agenda-redo)))
    (bh/narrow-to-org-subtree)))

(add-hook 'org-agenda-mode-hook
          #'(lambda () (org-defkey org-agenda-mode-map "N" 'bh/narrow-to-subtree))
          'append)

(defun bh/narrow-up-one-org-level ()
  (widen)
  (save-excursion
    (outline-up-heading 1 'invisible-ok)
    (bh/narrow-to-org-subtree)))

(defun bh/get-pom-from-agenda-restriction-or-point ()
  (or (and (marker-position org-agenda-restrict-begin) org-agenda-restrict-begin)
      (org-get-at-bol 'org-hd-marker)
      (and (equal major-mode 'org-mode) (point))
      org-clock-marker))

(defun bh/narrow-up-one-level ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (progn
        (org-with-point-at (bh/get-pom-from-agenda-restriction-or-point)
          (bh/narrow-up-one-org-level))
        (org-agenda-redo))
    (bh/narrow-up-one-org-level)))

(add-hook 'org-agenda-mode-hook
          #'(lambda () (org-defkey org-agenda-mode-map "U" 'bh/narrow-up-one-level))
          'append)

(defun bh/narrow-to-org-project ()
  (widen)
  (save-excursion
    (bh/find-project-task)
    (bh/narrow-to-org-subtree)))

(defun bh/narrow-to-project ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (progn
        (org-with-point-at (bh/get-pom-from-agenda-restriction-or-point)
          (bh/narrow-to-org-project)
          (save-excursion
            (bh/find-project-task)
            (org-agenda-set-restriction-lock)))
        (org-agenda-redo)
        (beginning-of-buffer))
    (bh/narrow-to-org-project)
    (save-restriction
      (org-agenda-set-restriction-lock))))

(add-hook 'org-agenda-mode-hook
          #'(lambda () (org-defkey org-agenda-mode-map "P" 'bh/narrow-to-project))
          'append)

(defvar bh/project-list nil)

(defun bh/view-next-project ()
  (interactive)
  (let (num-project-left current-project)
    (unless (marker-position org-agenda-restrict-begin)
      (goto-char (point-min))
                                        ; Clear all of the existing markers on the list
      (while bh/project-list
        (set-marker (pop bh/project-list) nil))
      (re-search-forward "Tasks to Refile")
      (forward-visible-line 1))

                                        ; Build a new project marker list
    (unless bh/project-list
      (while (< (point) (point-max))
        (while (and (< (point) (point-max))
                    (or (not (org-get-at-bol 'org-hd-marker))
                        (org-with-point-at (org-get-at-bol 'org-hd-marker)
                          (or (not (bh/is-project-p))
                              (bh/is-project-subtree-p)))))
          (forward-visible-line 1))
        (when (< (point) (point-max))
          (add-to-list 'bh/project-list (copy-marker (org-get-at-bol 'org-hd-marker)) 'append))
        (forward-visible-line 1)))

                                        ; Pop off the first marker on the list and display
    (setq current-project (pop bh/project-list))
    (when current-project
      (org-with-point-at current-project
        (setq bh/hide-scheduled-and-waiting-next-tasks nil)
        (bh/narrow-to-project))
                                        ; Remove the marker
      (setq current-project nil)
      (org-agenda-redo)
      (beginning-of-buffer)
      (setq num-projects-left (length bh/project-list))
      (if (> num-projects-left 0)
          (message "%s projects left to view" num-projects-left)
        (beginning-of-buffer)
        (setq bh/hide-scheduled-and-waiting-next-tasks t)
        (error "All projects viewed.")))))

(add-hook 'org-agenda-mode-hook
          #'(lambda () (org-defkey org-agenda-mode-map "V" 'bh/view-next-project))
          'append)

(setq org-show-entry-below (quote ((default))))
```


### Tuning the Agenda Views {#tuning-the-agenda-views}

다양한 사용자 정의는 일정 보기가 작업 세부 정보를 표시하는 방식에
영향을 미칩니다. 이 섹션에서는 내 작업 과정에서 사용하는
각 사용자 정의를 보여줍니다.


#### Highlight the current agenda line {#highlight-the-current-agenda-line}

내 `.emacs` 파일의 다음 코드는 현재 의제 행을 강조 표시합니다. 이렇게 하면
의제에서 발행된 명령에 의해 어떤 작업이 영향을 받을지 명확해집니다. 더 이상
실수로 잘못된 작업을 수행하지 마세요!

```elisp
;; 18.3.1 Highlight the current agenda line
;; Always hilight the current agenda line
(add-hook 'org-agenda-mode-hook
          #'(lambda () (hl-line-mode 1))
          'append)
;; custom-set-faces 에 아래 추가
;;  '(org-mode-line-clock ((t (:background "grey75" :foreground "red" :box (:line-width -1 :style released-button)))) t)
```


#### Use the Diary for Holidays and Appointments {#use-the-diary-for-holidays-and-appointments}

<span class="timestamp-wrapper"><span class="timestamp">[2022-11-20 Sun 12:03]</span></span>
22/12/21--14:49 :: agenda-diary-file 사용.
캡처도 마찬가지긴 한데. 일단 이런 방식으로 써보는 것도 좋다. 하루가
일생아니겠는가?

저는 emacs Diary 를 아무 용도로 사용하지 않지만 일정에서 휴일을 보는 것을
좋아합니다. 이렇게 하면 일하지 않아도 되는 날을 계획하는 데 도움이 됩니다.

```elisp
  ;;; 18.3.3 Use the Diary for Holidays and Appointments
(setq org-agenda-include-diary nil)
;; (setq org-agenda-diary-file "~/sync/org/workflow/log.org") ; move to jh-org.org
```

다이어리 파일은 캡처 모드 'appointment' 템플릿에서 생성된 `date-tree` 항목을
유지합니다. 나는 인터럽트 중에도 시간을 기록하고 싶은 기타 작업에도
이것을 사용합니다.

`~/diary` 파일을 더 이상 사용하지 않습니다. 그것은 Emacs 를 만족시키기 위해
길이가 0 인 파일로 존재합니다. 대신 조직 모드의 다이어리 함수를 사용합니다.
emacs 아젠다에 `i=가 있는 항목을 삽입하면
=~/sync/org/workflow/diary.org` 파일에 날짜 항목이 생성됩니다.

다음과 같이 내 `todo.org` 파일에 있는 달력의 공휴일을 포함합니다.

```org
#+FILETAGS: Personal
* Appointments
:PROPERTIES:
:CATEGORY: Appt
:ARCHIVE:  %s_archive::* Appointments
:END:
** Holidays
:PROPERTIES:
:Category: Holiday
:END:
%%(org-calendar-holiday)
** Some other Appointment
...
```

제목의 모든 시간 문자열이 의제에 표시되도록 다음 설정을 사용합니다.
&gt; 22/11/21--17:23 :: 기본 값은 nil 인데. 일단 두자.

```elisp
  ;;; 18.3.3 Use the Diary for Holidays and Appointments
(setq org-agenda-insert-diary-extract-time t) ; nil
```


#### Searches include archive files {#searches-include-archive-files}

I keep a single archive file for each of my org-mode project files.
This allows me to search the current file and the archive when I need
to dig up old information from the archives.

I don't need this often but it sure is handy on the occasions that
I do need it.

```elisp
  ;;; 18.3.4 Searches include archive files
;; Include agenda archive files when searching for things
(setq org-agenda-text-search-extra-files (quote (agenda-archives)))
```


#### Agenda view tweaks {#agenda-view-tweaks}

The following agenda customizations control

-   display of repeating tasks
-   display of empty dates on the agenda
-   task sort order
-   start the agenda weekly view with Sunday
-   display of the grid
-   habits at the bottom

I use a custom sorting function so that my daily agenda lists tasks in
order of importance.  Tasks on the daily agenda are listed in the
following order:

1.  tasks with times at the top so they are hard to miss
2.  entries for today (active timestamp headlines that are not scheduled or deadline tasks)
3.  deadlines due today
4.  late deadline tasks
5.  scheduled items for today
6.  pending deadlines (due soon)
7.  late scheduled items
8.  habits

The lisp for this isn't particularly pretty but it works.

```elisp
          ;;; 18.3.5 Agenda view tweaks
;; Show all future entries for repeating tasks
(setq org-agenda-repeating-timestamp-show-all t)

;; Show all agenda dates - even if they are empty
(setq org-agenda-show-all-dates t)

;; Sorting order for tasks on the agenda
(setq org-agenda-sorting-strategy
      (quote ((agenda habit-down time-up user-defined-up effort-up category-keep)
              (todo category-up effort-up)
              (tags category-up effort-up)
              (search category-up))))

;; Start the weekly agenda on Monday
(setq org-agenda-start-on-weekday 1)

(setq org-agenda-block-separator ?─) ; not '-'
(setq org-agenda-start-with-log-mode t)

;; daily         if the agenda shows a single day
;; weekly        if the agenda shows an entire week
;; today         show grid on current date, independent of daily/weekly display
;; require-timed show grid only if at least one item has a time specification
;; remove-match  skip grid times already present in an entry

;; (quote ((daily today remove-match) ; norang
;; (quote ((daily today require-timed) ; default
(setq org-agenda-time-grid
      (quote ((daily today today) ; junghan
              (400 600 800 1000 1200 1400 1600 1800 2000 2200 2400)
              "......" "----------------")))

;; Display tags farther right : default auto
;; 어젠다는 한 줄에 태그 까지 나타내자
(setq org-agenda-tags-column -80) ; org-tags-column 값 참고

;; Agenda sorting functions
(setq org-agenda-cmp-user-defined 'bh/agenda-sort)

(defun bh/agenda-sort (a b)
  "Sorting strategy for agenda items.
                Late deadlines first, then scheduled, then non-late deadlines"
  (let (result num-a num-b)
    (cond
     ;; time specific items are already sorted first by org-agenda-sorting-strategy

     ;; non-deadline and non-scheduled items next
     ((bh/agenda-sort-test 'bh/is-not-scheduled-or-deadline a b))

     ;; deadlines for today next
     ((bh/agenda-sort-test 'bh/is-due-deadline a b))

     ;; late deadlines next
     ((bh/agenda-sort-test-num 'bh/is-late-deadline '> a b))

     ;; scheduled items for today next
     ((bh/agenda-sort-test 'bh/is-scheduled-today a b))

     ;; late scheduled items next
     ((bh/agenda-sort-test-num 'bh/is-scheduled-late '> a b))

     ;; pending deadlines last
     ((bh/agenda-sort-test-num 'bh/is-pending-deadline '< a b))

     ;; finally default to unsorted
     (t (setq result nil)))
    result))

(defmacro bh/agenda-sort-test (fn a b)
  "Test for agenda sort"
  `(cond
    ;; if both match leave them unsorted
    ((and (apply ,fn (list ,a))
          (apply ,fn (list ,b)))
     (setq result nil))
    ;; if a matches put a first
    ((apply ,fn (list ,a))
     (setq result -1))
    ;; otherwise if b matches put b first
    ((apply ,fn (list ,b))
     (setq result 1))
    ;; if none match leave them unsorted
    (t nil)))

(defmacro bh/agenda-sort-test-num (fn compfn a b)
  `(cond
    ((apply ,fn (list ,a))
     (setq num-a (string-to-number (match-string 1 ,a)))
     (if (apply ,fn (list ,b))
         (progn
           (setq num-b (string-to-number (match-string 1 ,b)))
           (setq result (if (apply ,compfn (list num-a num-b))
                            -1
                          1)))
       (setq result -1)))
    ((apply ,fn (list ,b))
     (setq result 1))
    (t nil)))

(defun bh/is-not-scheduled-or-deadline (date-str)
  (and (not (bh/is-deadline date-str))
       (not (bh/is-scheduled date-str))))

(defun bh/is-due-deadline (date-str)
  (string-match "Deadline:" date-str))

(defun bh/is-late-deadline (date-str)
  (string-match "\\([0-9]*\\) d\. ago:" date-str))

(defun bh/is-pending-deadline (date-str)
  (string-match "In \\([^-]*\\)d\.:" date-str))

(defun bh/is-deadline (date-str)
  (or (bh/is-due-deadline date-str)
      (bh/is-late-deadline date-str)
      (bh/is-pending-deadline date-str)))

(defun bh/is-scheduled (date-str)
  (or (bh/is-scheduled-today date-str)
      (bh/is-scheduled-late date-str)))

(defun bh/is-scheduled-today (date-str)
  (string-match "Scheduled:" date-str))

(defun bh/is-scheduled-late (date-str)
  (string-match "Sched\.\\(.*\\)x:" date-str))
```


#### Sticky Agendas {#sticky-agendas}

<span class="timestamp-wrapper"><span class="timestamp">[2022-11-21 Mon 17:25]</span></span>
22/11/21--17:27 :: org-sticky-header 랑 다른 것이다.
23/01/09--14:01 :: OFF
2023-02-09 :: ON 다시 활성화
2023-03-23 :: OFF -- calendar 시나리오랑 겹치나 좀 거슬리네
2023-04-26 :: ON 다시 활성화

Sticky agendas allow you to have more than one agenda view created
simultaneously. You can quickly switch to the view without incurring an agenda
rebuild by invoking the agenda custom command key that normally generates the
agenda. If it already exists it will display the existing view. `g` forces
regeneration of the agenda view.

I normally have two views displayed (`F12 a` for the daily/weekly
agenda and `F12 SPC` for my project management view)

```elisp
;; Use 't' sticky agenda's so they persist
(setq org-agenda-sticky t) ; default nil
```


### Checklist handling {#checklist-handling}

리셋 체크 박스 t 보이지? 그거해서 넣으라고.

```text
.* TODO Invoicing and Archive Tasks [0/7]
  DEADLINE: <2009-07-01 Wed +1m -0d>
  :PROPERTIES:
  :RESET_CHECK_BOXES: t
  :END:

  - [ ] Do task 1
  - [ ] Do task 2
  ...
  - [ ] Do task 7
```


### Handling blocked tasks {#handling-blocked-tasks}

블락된 태스크는 완료가 안된 서브 태스크를 가진 태스크를 의미 한다.
어젠다에서 이러한 블락된 태스크는 그레이 폰트로 보인다.
아래의 설정은 서브 태스크가 완료가 아니면 부모 태스크가 완료 될 수 없게 한다.

```elisp
;; 18.6 Handling blocked tasks
(setq org-enforce-todo-dependencies t)
```

아래 설정을 꼭 봐야 한다. 프로퍼티로 NOBLOCKING, ORDERED 를 보여준다.
노블로킹은 위 설정의 예외를 가능케 한다. ORDERED 는 서브 태스크가
순서대로 완료하게 한다. 훌륭하다.

```text
.* TODO New Repeating Task
  SCHEDULED: <2009-06-16 Tue +1w>
  :PROPERTIES:
  :NOBLOCKING: t
  :END:
  ...
.** TODO Subtask

.* TODO Some Task
  :PROPERTIES:
  :ORDERED: t
  :END:
.** TODO Step 1
.** TODO Step 2
.** TODO Step 3
```


### Org Task structure and presentation {#org-task-structure-and-presentation}

여러 세팅이 있는데, 어짜피 넘어야 할 세팅이다.

```elisp
;; 18.7.1 Controlling display of leading stars on headlines
;; Hide ~*~, ~~~ and ~/~ in org text.
;; org-indent-mode 사용하면 org-hide-leading-starts 자동 on
;; Org styling, hide markup etc. = / ~
(setq org-hide-emphasis-markers t) ; work with org-appear
(setq org-hide-leading-stars t) ;; on
(setq org-hide-block-startup nil)
(setq org-hide-macro-markers nil)

;; 18.7.2 org-indent mode
;; startup-indent 하면 org-indent-mode 켜진다.
;; use manually -- #+STARTUP: indent or #+STARTUP: noindent
;; org-indent-mode 를 사용하면 adapt-indentation은 자동 off
;; Turn off all org auto indentation completely
;; this optiosn work with 'org-modern-indent package'
(setq org-startup-indented t) ; default nil

;; Turn off manual indentation completely,
;; AKA when you suddenly press TAB or =
(setq org-adapt-indentation nil) ; default nil

;; 18.7.3 blank lines are evil : 아닌데?!
(setq org-cycle-separator-lines 0)
;; (setq org-cycle-separator-lines 1) ; default 2
;; (setq org-blank-before-new-entry (quote ((heading . auto) ; (heading . auto) :: default
;;                                          (plain-list-item . auto))))

;; 18.7.4 adding new tasks quickly without disturbing the current task content
;; t 로 설정하면, 컨텐츠 뒤에 헤딩이 붙는다.
;; Respect Content When Inserting Heading
;; Also see https://www.n16f.net/blog/org-mode-headline-tips/.
(setq org-insert-heading-respect-content nil) ; default nil

;; 18.7.5 notes at the top
;; 리버스 순서가 익숙하다.
(setq org-reverse-note-order t) ; default nil

;; 18.7.7 editing and special key handling
;; (setq org-special-ctrl-a/e t) ; default nil
;; (setq org-special-ctrl-k t) ; default nil
;; (setq org-yank-adjusted-subtrees t) ; default nil

```


### 18.8 - 18.32 {#18-dot-8-18-dot-32}

```elisp
;; 18.8 Attachments
;; (setq org-id-method (quote uuidgen))

;; 18.9 Deadlines and Agenda visibility
(setq org-deadline-warning-days 10) ; default 14

;; 18.10 exporting tables to csv
(setq org-table-export-default-format "orgtbl-to-csv")

;; 18.11 minimize emacs frames
;; (setq org-link-frame-setup (quote (
;;                                    ;; (vm . vm-visit-folder)
;;                                    (gnus . org-gnus-no-new-news)
;;                                    (file . find-file))))

;; 18.12 Loggin stuff
(setq org-log-reschedule (quote note)) ; 왜 스케줄 바꾸었는가?
(setq org-log-redeadline (quote note))
(setq org-log-done (quote time))
(setq org-log-into-drawer t)
(setq org-log-state-notes-insert-after-drawers nil)

;; 18.13 limiting time spent on tasks

;; 18.14 habit tracking
;; (setq org-modules (quote (
;;                           ;; org-bbdb
;;                           org-bibtex
;;                           ;; org-crypt
;;                           org-gnus
;;                           org-id
;;                           org-info
;;                           ;; org-jsinfo
;;                           org-habit
;;                           org-inlinetask
;;                           org-irc
;;                           ;; org-mew
;;                           ;;org-mhe
;;                           org-protocol
;;                           ;; org-rmail
;;                           org-eww
;;                           ;; org-wl
;;                           ;; org-w3m
;;                           )))
;; (require 'org-checklist) ; delete compile error on emacs-29
(require 'org-habit)
(setq org-habit-graph-column 50)
(setq org-habit-preceding-days 9)
(run-at-time "06:00" 86400 #'(lambda () (setq org-habit-show-habits t)))

;; more export backend support
;; (require 'ox-md)
;; (require 'ox-taskjuggler)
;; (add-to-list 'org-export-backends 'taskjuggler)

;; 18.16 auto revert mode
;; 다른데서 세팅했음
;;  (global-auto-revert-mode t)

;; 18.17 Encryption
;; (require 'org-crypt)
;;                                       ; Encrypt all entries before saving
;; (org-crypt-use-before-save-magic)
;; (setq org-tags-exclude-from-inheritance (quote ("crypt")))
;;                                       ; GPG key to use for encryption
;; (setq org-crypt-key "F0B66B40")
;; (setq org-crypt-disable-auto-save nil)

(defun bh/show-org-agenda ()
  (interactive)
  (if org-agenda-sticky
      (switch-to-buffer "*Org Agenda( )*")
    (switch-to-buffer "*Org Agenda*"))
  (delete-other-windows))

;; 18.19 org-protocol
(require 'org-protocol)
;; 18.20 require a final newline when saving files
(setq require-final-newline t) ;; default t

;; 18.21 insert inactive timestamps and exclude from export
(defvar bh/insert-inactive-timestamp t)
(defun bh/toggle-insert-inactive-timestamp ()
  (interactive)
  (setq bh/insert-inactive-timestamp (not bh/insert-inactive-timestamp))
  (message "Heading timestamps are %s" (if bh/insert-inactive-timestamp "ON" "OFF")))

(defun bh/insert-inactive-timestamp ()
  (interactive)
  (org-insert-time-stamp nil t t nil nil nil))

(defun bh/insert-heading-inactive-timestamp ()
  (save-excursion
    (when bh/insert-inactive-timestamp
      (org-return)
      (org-cycle)
      (bh/insert-inactive-timestamp))))

(add-hook 'org-insert-heading-hook 'bh/insert-heading-inactive-timestamp 'append)
(setq org-export-with-timestamps nil)

;; 18.22 return follow links
(setq org-return-follows-link t) ; 2023-06-08 't'

;; 18.23 highlight clock when running overtime
;; custom-face -- '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button)))) t)

;; 18.24 Meeting notes
(defun bh/prepare-meeting-notes ()
  "Prepare meeting notes for email
               Take selected region and convert tabs to spaces, mark TODOs with leading >>>, and copy to kill ring for pasting"
  (interactive)
  (let (prefix)
    (save-excursion
      (save-restriction
        (narrow-to-region (region-beginning) (region-end))
        (untabify (point-min) (point-max))
        (goto-char (point-min))
        (while (re-search-forward "^\\( *-\\\) \\(TODO\\|DONE\\): " (point-max) t)
          (replace-match (concat (make-string (length (match-string 1)) ?>) " " (match-string 2) ": ")))
        (goto-char (point-min))
        (kill-ring-save (point-min) (point-max))))))

;; 18.25 remove highlights after changes
(setq org-remove-highlights-with-change t) ; default t

;; 18.27 prefer future dates or not?
;; (setq org-read-date-prefer-future 'time) ; default t

;; 18.28 automatically change list bullets
;; 23-03-25 7:06 AM Trun on
(setq org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+") ("1." . "a.")))

;; 18.29 remove indentation on agenda tags views
(setq org-tags-match-list-sublevels t) ; default t

;; 18.31 agenda persistent filters
(setq org-agenda-persistent-filter t)

;; 18.xx allow alphabetical bullets
(setq org-list-allow-alphabetical t) ; have a. A. a) A) list bullets
```


### 18.33 - 18.42 {#18-dot-33-18-dot-42}

```elisp
;; 18.33 mail links open compose-mail
;; (setq org-link-mailto-program (quote (compose-mail "%a" "%s")))

;; 18.35 use smex for M-x ido-completion
;; 뭔지 모르겠고 안쓰련다.
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d"))
;; (require 'smex)
;; (smex-initialize)

;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "C-x x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; 18.36 use emacs bookmarks for fast navigation
;; 검토해보라. 이거 아니여도 이미 잘 되어있는지
;; (global-set-key (kbd "<C-f6>") '(lambda () (interactive) (bookmark-set "SAVED")))
;; (global-set-key (kbd "<f6>") '(lambda () (interactive) (bookmark-jump "SAVED")))

;; 18.37 using org-mime to email
;;    (require 'org-mime)

;; 18.38 remove multiple state change log details from the agenda
;; 뭐라는거냐?
(setq org-agenda-skip-additional-timestamps-same-entry t)

;; 18.39 drop old style references in tables
(setq org-table-use-standard-references (quote from))

  ;;; 18.40 use system settings for file-application selection
;; (setq org-file-apps (quote ((auto-mode . emacs)
;;                             ("\\.mm\\'" . system)
;;                             ("\\.x?html?\\'" . system)
;;                             ("\\.pdf\\'" . system))))
;; to get org-ref and org-pdftools to use pdf-tools to open up a pdf link
;; (add-to-list 'org-file-apps '("\\.pdf\\'" . EMACS))

  ;;; 18.41 use the current window for the agenda
;; current-window    Show agenda in the current window, keeping all other windows.
;; other-window      Use switch-to-buffer-other-window to display agenda.
;; only-window       Show agenda, deleting all other windows.
;; reorganize-frame  Show only two windows on the current frame, the current
;;                   window and the agenda.
;; other-frame       Use switch-to-buffer-other-frame to display agenda.
;;                   Also, when exiting the agenda, kill that frame.
;; other-tab         Use switch-to-buffer-other-tab to display the
;;                   agenda, making use of the tab-bar-mode introduced
;;                   in Emacs version 27.1.  Also, kill that tab when
;;                   exiting the agenda view.
(setq org-agenda-window-setup 'current-window)

;; Show src buffer in popup, and don't monopolize the frame
(setq org-src-window-setup 'other-window)

  ;;; 18.42 delete ids when cloning
(setq org-clone-delete-id t)
```


### 18.43 -  18.47 {#18-dot-43-18-dot-47}

```elisp
;; 18.43 cycling plain lists
(setq org-cycle-include-plain-lists t)

;; 18.44 showing source block syntax hiighlighting
;; 22/10/11--22:18 :: headline 설정 좋다.
;; fontify가 정확히 무엇인가? 테마가 하는대로 따라가는 것이 좋은 듯.
(setq org-fontify-todo-headline nil)
(setq org-fontify-done-headline nil)
;; (setq org-fontify-whole-block-delimiter-line nil) ; for modus-themes
(setq org-fontify-quote-and-verse-blocks t)

;; 18.46 NEXT is for tasks not projects
;; 이건 따로 챙겨주라.
(defun bh/mark-next-parent-tasks-todo ()
  "Visit each parent task and change NEXT states to TODO"
  (let ((mystate (or (and (fboundp 'org-state)
                          state)
                     (nth 2 (org-heading-components)))))
    (when mystate
      (save-excursion
        (while (org-up-heading-safe)
          (when (member (nth 2 (org-heading-components)) (list "NEXT"))
            (org-todo "TODO")))))))

(add-hook 'org-after-todo-state-change-hook 'bh/mark-next-parent-tasks-todo 'append)
(add-hook 'org-clock-in-hook 'bh/mark-next-parent-tasks-todo 'append)

;; 18.47 startup in foled view
;; fold / overview  - collapse everything, show only level 1 headlines
;; content          - show only headlines
;; nofold / showall - expand all headlines except the ones with :archive:
;;                    tag and property drawers
;; showeverything   - same as above but without exceptions
(setq org-startup-folded 'content)
```


### 18.49 Diable keys {#18-dot-49-diable-keys}

```elisp
;; Disable keys in org-mode
;;    C-c [
;;    C-c ]
;;    C-c ;
;;    C-c C-x C-q  cancelling the clock (we never want this)
(add-hook 'org-mode-hook
          #'(lambda ()
              ;; Undefine C-c [ and C-c ] since this breaks my
              ;; org-agenda files when directories are include It
              ;; expands the files in the directories individually
              (org-defkey org-mode-map "\C-c[" 'undefined)
              (org-defkey org-mode-map "\C-c]" 'undefined)
              (org-defkey org-mode-map "\C-c;" 'undefined)
              (org-defkey org-mode-map "\C-c\C-x\C-q" 'undefined))
          'append)
```


## <kbd>Junghanacs</kbd> Customization {#junghanacs-customization}


### `NEW` Turn-off shift-select-mode {#new-turn-off-shift-select-mode}



```elisp
;; 코지를 보면 이맥서는 사용하지 않는다고 적어 놨더군. 따라간다.
(setq org-support-shift-select nil)
(setq shift-select-mode nil)
```


### `NEW` org-pretty-entities {#new-org-pretty-entities}



```elisp
;; 왜 minemacs 는 org-pretty 설정을 둘다 t 로 했을까?  org-pretty-entities 가
;; 설정되면 abc_def 에서 def가 아래로 기어 들어간다.
(setq org-pretty-entities nil) ; very important
;; orgmode 익스포트 할 때, underscore가 subscripts 변환 방지
;; http://ohyecloudy.com/emacsian/2019/01/12/org-export-with-sub-superscripts/
(setq org-pretty-entities-include-sub-superscripts nil)

  ;;; Replace two consecutive hyphens with the em-dash
;; Unicode Character “☐” (U+2610) Todo
;; Unicode Character “◩” (U+25E9) Doing / Next
;; Unicode Character “☒” (U+2612) Done
;; Unicode Character “▣” (U+25A3) Held
;; and customize org-mode's checkboxes with unicode symbols
(add-hook
 'org-mode-hook
 (lambda ()
   "Beautify Org em-dash and checkbox Symbol"
   (push '("--" . "—") prettify-symbols-alist)
   (push '("[ ]" . "☐") prettify-symbols-alist) ; A task that needs doing
   (push '("[-]" . "◩") prettify-symbols-alist) ; Task is in progress
   (push '("[X]" . "☒") prettify-symbols-alist) ; Task was completed
   (push '("[?]" . "▣") prettify-symbols-alist) ; Task is being held up or paused
   (prettify-symbols-mode)))
```


### `NEW` org-ellipsis, imenu-depth, capture-bookmark {#new-org-ellipsis-imenu-depth-capture-bookmark}



```elisp
;; Search on https://www.compart.com/en/unicode/U+25BF
;; Unicode Character “◉” (U+25C9)
;; Unicode Character “▾” (U+25BE)
(setq org-ellipsis " ▾")
(setq org-imenu-depth 4) ; default 2
(setq org-capture-bookmark nil)
```


### `NEW` org-element-cache {#new-org-element-cache}



```elisp
  ;;; Disable 'org-element-cache'
;; The new org-data element provides properties from top-level property drawer,
;; buffer-global category, and :path property containing file path for file Org buffers.
(setq org-element-use-cache nil) ; default t
;; Element cache persists across Emacs sessions
(setq org-element-cache-persistent nil) ; default t
```


### `NEW` org-mouse-1-follows-link {#new-org-mouse-1-follows-link}



```elisp
;; nil 이면 C-c C-o 으로 접근한다.
(setq org-mouse-1-follows-link t)
```


### Org-mode `HOOK` {#org-mode-hook}

모아둬야 쓰기 쉽다.

```elisp
;; The Hooks! Might be faster to set this as separate hooks instead of one big function

;; Make ~SPC ,~ work, reference:
;; https://stackoverflow.com/a/24173780
;; (setcar (nthcdr 2 org-emphasis-regexp-components) " \t\n")
(add-hook 'org-mode-hook (lambda ()
                           (setq-local org-emphasis-alist
                                       '(("*" bold)
                                         ("/" italic)
                                         ("_" underline)
                                         ("=" org-verbatim verbatim)
                                         ("~" org-kbd)
                                         ("+"
                                          (:strike-through t))))
                           ))

(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'auto-fill-mode)

;; 2023-04-16 re-enable
(add-hook 'org-mode-hook 'org-indent-mode)

(add-hook 'org-capture-mode-hook #'evil-insert-state)
(add-hook 'org-capture-after-finalize-hook #'evil-normal-state)
```


### Tunning and Overide {#tunning-and-overide}

Spacemacs 와 workflow 일부 수정.

-   Spacemacs configuration
-   Korean/Hangul configuration
-   My custom options
-   Test options

<!--listend-->

```elisp
;; orgid 파일의 위치 설정
;; (setq org-id-locations-file (concat dotspacemacs-directory ".orgid"))

;; (setq org-directory "~/sync/org/")
;; (setq org-note-directory (concat org-directory "roam/")
;;       org-inbox-file (concat org-directory "workflow/refile.org") ; inbox.org
;;       org-log-file (concat org-directory "log.org")
;;       org-project-file (concat org-directory "workflow/Project.org")
;;       org-default-notes-file org-inbox-file)

;; 22/10/12--15:49 :: 멀티 바이트 강조
;; https://github.com/clockoon/my-emacs-setting/blob/master/config.org
;; org-mode는 기본적으로 강조문(굵게, 이탤릭 등)을 하나의 단어에
;; 대해서만 적용하도록 하고 있습니다. 예컨대 *이렇게*는 굵게 글씨를
;; 쓸 수 없습니다. 조사가 들어가는 한중일 언어에 쓰기에는 부적절한
;; 정책입니다. 따라서 강조문자 양 옆에 (알파벳이 아닌) 멀티바이트
;; 문자가 오더라도 작동하도록 설정을 변경합니다(물론 이는 완전한
;; 해결책은 아니며, 더 합리적인 방법에 대해서는 고민이 필요합니다.
(setcar org-emphasis-regexp-components
        " \t('\"{[:multibyte:]")
(setcar (nthcdr 1 org-emphasis-regexp-components)
        "[:multibyte:]- \t.,:!?;'\")}\\")
(org-set-emph-re 'org-emphasis-regexp-components
                 org-emphasis-regexp-components)


;; remove spacemac's hook
(remove-hook 'org-mode-hook 'dotspacemacs//prettify-spacemacs-docs)
(remove-hook 'org-capture-mode-hook 'spacemacs//org-capture-start)

(advice-add 'org-refile :after 'org-save-all-org-buffers)
(advice-add 'org-archive :after 'org-save-all-org-buffers)
(add-hook 'org-capture-after-finalize-hook 'org-save-all-org-buffers)

  ;;; Disable org-appear for terminal-mode
;; 'always' means that elements are toggled every time they are under the cursor.
;; 'manual' means that toggling starts on call to org-appear-manual-start
;; 'on-change' means that elements are toggled only when the buffer is modified
;; or when the element under the cursor is clicked with a mouse.
;; (setq org-appear-trigger 'on-change) ; 'manual
;; (setq org-appear-autolinks nil)
```


## <kbd>END</kbd>  `post-init-org` <span class="tag"><span class="donotmove">donotmove</span></span> {#end-post-init-org}

```elisp
)
```
