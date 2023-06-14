+++
title = "jh-misc layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:53:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-misc
{{< /hint >}}

<!--more-->


## Goals {#goals}

Quickurl, Games, Search, Finance, Wakatime, Telegram, Discord, Matrix, IRC,
Screenshot 등을 지원한다.


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
   (spacemacs-misc :packages (not dumb-jump)) ; devdocs, request
   ;; games
   search-engine
   quickurl

   openai

   (finance
    :variable
    ledger-post-amount-alignment-column 68)
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

(defconst jh-misc-packages
  '(
    activity-watch-mode

    frameshot
    gif-screencast
    (screenshot :location (recipe :fetcher github :repo "tecosaur/screenshot"
                                  :files ("*.el" "*.org")))

    wakatime-mode
    atomic-chrome
    elcord
    redacted

    telega

    ;; Terminal Mode
    corfu-terminal
    (term-keys :location (recipe :fetcher github :repo "junghan0611/term-keys"))
    (xclip :toggle (version< "29.0.50" emacs-version)) ;; Emacs 29
    ))
```


### <span class="org-todo todo TODO">TODO</span> ledger cape {#ledger-cape}

CAPE 로 연동해서 처리해야 한다. 뭐가 되었든간에 Spacemacs 베이스로
가져가는게 좋겠다. company 와 연동이 되니까 잘 쓰면 좋은 일이다.

```elisp
;; (defun finance/post-init-company ()
;;   (spacemacs|add-company-backends
;;     :backends company-capf
;;     :modes ledger-mode))
```


### Atomic-chrome {#atomic-chrome}

[Atomic Chrome](https://github.com/alpha22jp/atomic-chrome) is an extension that allows to edit browser text fields in Emacs.
Despite its name, it also works for Firefox with [GhostText](https://ghosttext.fregante.com/welcome/), which is what I use.

2023-05-11 엄청 편하다. 좋다.

```elisp
(defun jh-misc/init-atomic-chrome ()
  (use-package atomic-chrome
    :if (not (or my/remote-server my/is-termux))
    :defer 10
    :commands (atomic-chrome-start-server)
    :hook (after-init . atomic-chrome-start-server)
    ))
```


### Redacted {#redacted}



```elisp
(defun jh-misc/init-redacted ()
  (use-package redacted
    :defer (spacemacs/defer)
    :commands (redacted-mode))
  )
```


### Screencast `gif-screencast` {#screencast-gif-screencast}

Call \`gif-screencast' to start a recording.
A screenshot is taken for every user action.
Call \`gif-screencast-stop' (&lt;f9&gt; by default) to finish recording and create
the GIF result.

gif-screencast-program: scrot
gif-screencast-convert-program: convert (from the ImageMagick suite)
Optional: gif-screencast-optimize-program: Gifsicle

```text
sudo apt-get install scrot gifsicle
```

[Ambrevar / emacs-gif-screencast · GitLab](https://gitlab.com/ambrevar/emacs-gif-screencast)

```elisp
(defun jh-misc/init-gif-screencast ()
  (require 'gif-screencast))
```


### frameshot and screenshot {#frameshot-and-screenshot}



```elisp
(defun jh-misc/init-frameshot ()
  (use-package frameshot :ensure :defer 10)
  )

;; This makes it a breeze to take lovely screenshots.
(defun jh-misc/init-screenshot ()
  (use-package screenshot :ensure :defer 10)
  )
```


### TimeTracking `activity-watch-mode` {#timetracking-activity-watch-mode}

```elisp
(defun jh-misc/init-activity-watch-mode ()
  (use-package activity-watch-mode
    :defer (spacemacs/defer)
    :config
    (defun spacemacs/activitywatch-dashboard ()
      (interactive)
      (browse-url "http://localhost:5600"))
    (global-activity-watch-mode 1)
    ))
```


### Emacs with `kitty` terminal {#emacs-with-kitty-terminal}

[slimmer emacs with kitty](https://jao.io/blog/slimmer-emacs-with-kitty.html) 이 글을 보고 kitty 로 이맥스를 사용하고 싶었다.
한영 키가 매끄럽지 않아서 문제 였는데 해결을 했다.


#### corfu-terminal {#corfu-terminal}

```elisp
(defun jh-misc/init-corfu-terminal ()
  (use-package corfu-terminal
    :unless window-system
    :after corfu
    :config
    (unless (display-graphic-p) ; terminal
      (add-hook 'corfu-mode-hook 'corfu-terminal-mode)
      )
    ))
```


#### term-keys {#term-keys}

2023-03-13 드디어 동작한다. kitty 를 활용 할 수 있다. (잘 안쓰겠지만)

```elisp
(defun jh-misc/init-term-keys ()
  (use-package term-keys
    :unless window-system
    :ensure
    :config
    (unless (display-graphic-p)
      (term-keys-mode t))
    ))
```


#### xclip {#xclip}

```elisp
(defun jh-misc/init-xclip ()
  (use-package xclip
    :unless window-system
    :config
    (unless (display-graphic-p)
      (xclip-mode 1))))
```


### wakatime-mode {#wakatime-mode}

<span class="timestamp-wrapper"><span class="timestamp">[2023-04-29 Sat 18:38]</span></span>
이게 속편할 수 있다. 이맥스만 뽑아내면 된다면!

$ python3 -c "$(wget -q -O - <https://raw.githubusercontent.com/wakatime/vim-wakatime/master/scripts/install_cli.py>)"

```elisp
(defun jh-misc/init-wakatime-mode ()
  (use-package wakatime-mode
    :if (and (or
              (string= (system-name) "jhnuc")
              (string= (system-name) "junghan-laptop")
              )
             (not my/slow-ssh)
             (not my/remote-server))
    ;; :init
    ;; (add-hook 'prog-mode-hook 'wakatime-mode)
    ;; (add-hook 'text-mode-hook 'wakatime-mode)
    :config
    (advice-add 'wakatime-init :after (lambda () (setq wakatime-cli-path (expand-file-name "~/.wakatime/wakatime-cli"))))

    ;; wakatime-api-key  "your-api-key" in permachine.el
    (defun spacemacs/wakatime-dashboard ()
      (interactive)
      (browse-url "https://wakatime.com/dashboard"))
    (global-wakatime-mode)

    ))
```


### <kbd>telega</kbd> telegram client {#telega-telegram-client}



```elisp
(defun jh-misc/init-telega ()
  (use-package telega
    :commands telega
    :config
    (setf (alist-get 2 telega-avatar-factors-alist) '(0.45 . 0.1))
    (setq telega-chat-fill-column 60)
    )
  )

```


## Funcs {#funcs}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-

(defun magit-commit-generic-update ()
  (interactive)
  (magit-commit-create '("-m" "Updates")))

(with-eval-after-load 'transient
  (with-eval-after-load 'magit
    (transient-append-suffix 'magit-commit "c"
      '("g" "Commit with generic message" magit-commit-generic-update))))

(defun my/screenshot-svg ()
  "Save a screenshot of the current frame as an SVG image.
  Saves to a temp file and puts the filename in the kill ring."

  ;; Taken from here
  ;; https://www.reddit.com/r/emacs/comments/idz35e/emacs_27_can_take_svg_screenshots_of_itself/g2c2c6y/
  (interactive)
  (let* ((filename (make-temp-file "Emacs" nil ".svg"))
         (data (x-export-frames nil 'svg)))
    (with-temp-file filename
      (insert data))
    (kill-new filename)
    (message filename)))

(defun serve-current-buffer (&optional port)
  "Serve current buffer."
  (interactive)
  (ws-start
   (lambda (request)
     (with-slots (process headers) request
       (ws-response-header process 200 '("Content-type" . "text/html; charset=utf-8"))
       (process-send-string process
                            (let ((html-buffer (htmlize-buffer)))
                              (prog1 (with-current-buffer html-buffer (buffer-string))
                                (kill-buffer html-buffer))))))
   (or port 9010)))
```


## Keybindings {#keybindings}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-

(spacemacs/set-leader-keys "aW" 'spacemacs/wakatime-dashboard)
(spacemacs/set-leader-keys "aA" 'spacemacs/activitywatch-dashboard)

(spacemacs/set-leader-keys "Tr" 'redacted-mode)
```
