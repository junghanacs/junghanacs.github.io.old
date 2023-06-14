+++
title = "jh-reading layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:53:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-reading
{{< /hint >}}

<!--more-->


## Goals {#goals}

jh-reading


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
   (elfeed
    :variables
    elfeed-enable-goodies t
    rmh-elfeed-org-files (list "~/sync/org/elfeed/elfeed.org")
    ;; elfeed-db-directory "~/.spacemacs.d/.elfeed"
    elfeed-enable-web-interface nil
    elfeed-goodies/show-mode-padding 2
    elfeed-goodies/powerline-default-separator 'slant
    elfeed-goodies/feed-source-column-width 25
    elfeed-goodies/tag-column-width 30
    url-queue-timeout 30)

   epub

   ;; eaf

   (eww
    :packages (not texfrag)
    :variables
    shr-max-image-proportion 0.6
    ;; shr-image-animate nil          ; No GIFs, thank you!
    shr-width fill-column          ; check `prot-eww-readable'
    shr-max-width fill-column
    shr-use-fonts nil)

   ;; xkcd

   ;; fast, global-search and tag-based email system
   ;; (notmuch
   ;;  :variables
   ;;  notmuch-messages-deleted-tags '("+deleted" "-inbox" "-unread"))

   (pocket :variables
           pocket-reader-color-title t
           pocket-reader-color-site t
           pocket-reader-site-column-max-width 16)

   pdf

   (dash :variables
         dash-docs-docset-newpath "~/.local/share/Zeal/Zeal/docsets")

   speed-reading
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

(defconst jh-reading-packages
  '(
    ;; 재정의 패키지
    ;; eww

    ;; 새로 등록하는 패키지
    tldr ; read manual

    ;; consult-notmuch

    ;; emms
    ;; (empv :location (recipe :fetcher github
    ;;                         :repo "isamert/empv.el"))

    ebuku ; for buku bookmark

    ;; sicp      ; sicp info-mode
    wikinfo   ; wiki info-mode

    youtube-sub-extractor
    devdocs-browser ; using EWW
    consult-dash

    ;; mastodon ; ActivityPub
    elfeed-webkit
    elfeed-tube
    ;;      elfeed-tube-mpv

    ;; (youtube-dl :location (recipe :fetcher github :repo "skeeto/youtube-dl-emacs"))
    ))
```


### elfeed-tube {#elfeed-tube}

좋은 영어 유튜브를 보고 있을 때 문제는 끝까지 보는 것이다. 내용 파악이 제대로
안된다는 생각이 들면 아무리 좋은 것도 포기하게 된다. 물론 영어 자막을 켜놓거나
한글 번역으로 할 때도 있지만 별 도움이 안된다. 그래서 혹시 이맥스로 유튜브 영어
스크립트를 다운 받는 방법이 있나 찾아보았다. 일단 다운을 받으면, 잘 편집해서
영어 / 한글 세트 구성으로 스크립트를 만들 수 있기 때문이다. 그러면 내용 이해도
편하고 기록하기에도 유용하다. 완벽한 영어만 있거나, 허접한 한글 번역만 있는 것은
정답이 아니다. 영어와 한글이 같이 있어야 Guess 를 해가며 볼 수 있다. 위에 링크에
이맥스 코드가 있다. :-)

```elisp
(defun jh-reading/init-elfeed-tube ()
  (use-package elfeed-tube
    :after elfeed
    :demand t
    :config
    ;; (setq elfeed-tube-auto-save-p nil) ; default value
    (setq elfeed-tube-auto-save-p t)
    (setq elfeed-tube-auto-fetch-p t)  ; default value
    (setq elfeed-tube-captions-languages
          '("en" "english (auto generated)" "ko"))
    (elfeed-tube-setup)

    :bind (:map elfeed-show-mode-map
                ("F" . elfeed-tube-fetch)
                ([remap save-buffer] . elfeed-tube-save)
                :map elfeed-search-mode-map
                ("F" . elfeed-tube-fetch)
                ([remap save-buffer] . elfeed-tube-save)
                )
    )
  )

;; (use-package elfeed-tube-mpv
;;   :ensure t ;; or :straight t
;;   :bind (:map elfeed-show-mode-map
;;               ("C-c C-f" . elfeed-tube-mpv-follow-mode)
;;               ("C-c C-w" . elfeed-tube-mpv-where))
;;   )
```


### elfeed-webkit {#elfeed-webkit}

<span class="timestamp-wrapper"><span class="timestamp">[2023-06-02 Fri 06:00]</span></span>
[GitHub - fritzgrabo/elfeed-webkit: Emacs: Render elfeed e...](https://github.com/fritzgrabo/elfeed-webkit)

```elisp
(defun jh-reading/init-elfeed-webkit ()
  (use-package elfeed-webkit
    :ensure
    :demand
    :after elfeed
    :init
    (setq elfeed-webkit-auto-tags '(webkit comics))
    :config
    (elfeed-webkit-auto-enable-by-tag)
    :bind (:map elfeed-show-mode-map
                ("%" . elfeed-webkit-toggle)))
  )
```


### youtube-sub-extractor {#youtube-sub-extractor}

`yt-dlp` 를 활용한다. 먼저, 설치해줘야 한다.
키바인딩은 해보고 나서

여기서 일단 최신 바이너리를 설치하는게 좋겠다.
<https://github.com/yt-dlp/yt-dlp#installation>

```text
> ln -s yt-dlp_linux yt-dlp
> yt-dlp -U
Available version: stable@2023.03.04, Current version: stable@2023.03.04
Current Build Hash: 7494af600c4389d19961b44e406472bba7c54c28dc1f62bb72bdde7181708a9a
yt-dlp is up to date (stable@2023.03.04)
```

```elisp
(defun jh-reading/init-youtube-sub-extractor ()
  (use-package youtube-sub-extractor
    :defer t
    :commands (youtube-sub-extractor-extract-subs)
    :config
    ;; (map! :map youtube-sub-extractor-subtitles-mode-map
    ;;   :desc "copy timestamp URL" :n "RET" #'youtube-sub-extractor-copy-ts-link
    ;;   :desc "browse at timestamp" :n "C-c C-o" #'youtube-sub-extractor-browse-ts-link)
    (setq youtube-sub-extractor-timestamps 'left-margin)
    )
  )
```


### eBuku -- `buku` Bookmark {#ebuku-buku-bookmark}

evil-collection 덕분에 키 바인딩을 가져 간다.

```elisp
(defun jh-reading/init-ebuku ()
  (use-package ebuku
    :after evil-collection
    ))
```


### consult-dash {#consult-dash}

dash layer 에는 helm, ivy 설정만 들어 있다. consult 설정을 넣어 준다.

```elisp
(defun jh-reading/init-consult-dash ()
  (use-package consult-dash
    :defer t
    :bind ("M-s d" . consult-dash)
    :init (progn
            (spacemacs/declare-prefix "arz" "zeal/dash docs")
            (spacemacs/set-leader-keys
              "arzH" 'consult-dash))
    :config
    ;; Use the symbol at point as initial search term
    (consult-customize consult-dash :initial (thing-at-point 'symbol))
    ;;   (when (functionp 'consult-dash)
    ;; (setq-local consult-dash-docsets '("Python 2" "Python 3" "NumPy")))
    )
  )
```


### devdocs-browser {#devdocs-browser}

설정하고 테스트 해보자.

```elisp
(defun jh-reading/init-devdocs-browser ()
  (use-package devdocs-browser
    :defer t
    :config
    ;; (setq devdocs-browser-cache-directory "~/spacemacs/.cache/private/")
    (add-to-list 'devdocs-browser-major-mode-docs-alist
                 '(ruby-mode "ruby")
                 '(rjsx-mode ("react" "javascript")))
    )
  (spacemacs/set-leader-keys "ard" #'devdocs-browser-open))
```


### tldr {#tldr}

```elisp
(defun jh-reading/init-tldr ()
  (use-package tldr
    :defer t
    :config
    (spacemacs/set-leader-keys "h," 'tldr)
    :custom
    (tldr-enabled-categories '("common" "linux"))))
```


### wikinfo {#wikinfo}



```elisp
(defun jh-reading/init-wikinfo ()
  (use-package wikinfo :ensure :defer 10))
```
