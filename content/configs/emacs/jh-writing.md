+++
title = "jh-writing layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:51:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-writing
{{< /hint >}}

<!--more-->


## Goals {#goals}

-   spacemacs-language
-   translate


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
   (translate
    :variables gts-translate-list '(("en" "ko") ("ko" "en"))
    translate-enable-highlight t)

   ;; (typography :packages (typo)
   ;;             :variables typography-enable-typographic-editing nil)

   ;; asciidoc ; e.g. docs.cider.mx editing

   (markdown
    :packages (markdown-mode mmm-mode vmd-mode markdown-toc gh-md) ; smartparens
    ;; :variables markdown-live-preview-engine 'vmd
    ;; markdown-mmm-auto-modes '("c" "c++" "python" "scala" ("elisp" "emacs-lisp"))
    )

   ;; fountain ; screenwriting

   ;; restructuredtext ; ReStructuredText (ReST)

   ;; (latex :variables
   ;;        latex-enable-folding t
   ;;        latex-enable-auto-fill t)

   ;; (plantuml :variables
   ;;           plantuml-jar-path "/usr/share/plantuml/plantuml.jar"
   ;;           org-plantuml-jar-path "/usr/share/plantuml/plantuml.jar")

   ;; (languagetool :variables
   ;;               langtool-default-language "en-US"
   ;;               langtool-show-error-on-jump t
   ;;               langtool-java-classpath "/usr/share/languagetool:/usr/share/java/languagetool/*")
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

(defconst jh-writing-packages
  '(
    dictionary
    markdown-mode
    popwin

    ;; additional packages

    (guess-language :location (recipe
                               :fetcher github
                               :repo "junghan0611/guess-language.el"
                               :files ("*.el" "trigrams/*")))

    (txl :location (recipe :fetcher github :repo "junghan0611/txl.el"))
    ;; (deepl :location (recipe :fetcher github :repo "emacs-openai/deepl"))

    palimpsest

    ;; separedit ; Edit comment/string/docstring/code block in separate buffer with your favorite mode.
    ;; substitute
    ;; speed-type

    ;; selectric-mode

    ;; olivetti
    ;; logos

    google-translate ; from spacemacs-language
    org-translate

    sentex ; Regex-based sentence navigation rules

    ;; define-it
    ;; mw-thesaurus
    ;; sdcv
    ;; external-dict
    ;; lexic
    ;; define-word ; from spacemacs-language

    ;; (use-package reverso
    ;;   :straight (:host github :repo "SqrtMinusOne/reverso.el")

    ;; khoj

    ;; lingva ; tracking-free alternative front-end for Google translate
    ;; libretranslate API, a libre and self-hostable translation engine.
    ;; (libretrans :location
    ;;             (recipe
    ;;             :fetcher url
    ;;             :url "https://codeberg.org/martianh/libretrans.el/raw/branch/main/libretrans.el"))

    ))
```


### README :: `Superword-mode` {#readme-superword-mode}

sub-word, superword-mode, substring, string-inflaction, underscore 등 언더바
문제부터 해서 걸려있는 부분들이 많이 있다. evil-symbol-word-search 도 여기와
연관이 되어 있다. 알고 가야한다.
<span class="timestamp-wrapper"><span class="timestamp">[2023-02-26 Sun 11:45]</span></span>


### `translate` Layer {#translate-layer}

translate 레이어가 있다. 근데 디테일은 잡아줘야 한다.
All layer configurations can be done by setting layer variables in your dotfile.
No custom user config lines are necessary. For more details please see the
homepage of package [translate-mode](https://github.com/rayw000/translate-mode) and [go-translate](https://github.com/lorniu/go-translate/).


#### <span class="org-todo todo TODO">TODO</span> translate-mode {#translate-mode}

<span class="timestamp-wrapper"><span class="timestamp">[2023-01-17 Tue 16:32]</span></span>
쌍으로 보면서 번역하는 모드. 번역 모드. 번역을 구조적으로 쉽게 번역 작가 처럼


#### org-translate {#org-translate}

이 라이브러리에는 \`org-translate-mode' 마이너 모드가 포함되어 있습니다. Org
위에서 사용되어 번역 관련 기능을 제공합니다. 완벽한 CAT 도구가 아닙니다.
기본적으로 두 가지 작업을 수행합니다. 소스 텍스트와 소스 텍스트 간의 분할 대응을
관리합니다. 사용할 수 있는 용어집을 관리합니다. 자동 용어 번역, 이전 사용 표시
등 이건 하나의 파일에서 소스와 번역을 따로 관리 할 수 있다.

```elisp
(defun jh-writing/init-org-translate ()
  (require 'org-translate)
  (setq ogt-default-segmentation-strategy 'paragraph)
  )
```


### Sentex {#sentex}

<span class="timestamp-wrapper"><span class="timestamp">[2023-05-30 Tue 15:50]</span></span>
Checkout : OmegaT and Okapi
[martianh/sentex: Complex sentence-ending rules for Emacs ...](https://codeberg.org/martianh/sentex)

> This package uses breaking and non-breaking sentence-ending rules ported
> from OmegaT and Okapi Framework.
>
> It provides \`sentex-forward-sentence', \`sentex-backward-sentence', and
> \`sentex-kill-sentence'. They aim to act like the built-in functions, but to
> intelligently ignore things like "e.g.", "i.e.", or "Mr." as ends of sentences.
>
> Customize \`sentex-ruleset-framework' to select which framework to use.
> Call \`sentex-set-language-for-buffer', or set \`sentex-current-language'
> to choose what language's rules to use. Different frameworks support
> different languages, so if your language doesn't appear in the options, try
> using a different one.

설정을 해보고 일단 사용법을 연구하자.

```elisp
(defun jh-writing/init-sentex ()
  (use-package sentex :defer)
  )
```


### <span class="org-todo todo TODO">TODO</span> `typography` layer {#typography-layer}

typo 작가를 위한 패키지. 따옴표 인용부호 등 ;; 영어


### `Markdown` Layer {#markdown-layer}

마크다운이 이맥스의 메인은 아니지만, 설정은 꾸준히 챙겨야 한다.
물론 기본적인 설정은 마크다운 레이어를 참고하는 것이 먼저다. 여기는 스페이스맥스니까.

**Note:** Spacemacs already defines the variable `markdown-mmm-auto-modes` to a
bunch of languages. Consider opening a PR on the Spacemacs repository to add
new languages instead of overriding the variable in your dotfile.

```elisp
(defun jh-writing/post-init-markdown-mode ()
  (setq markdown-header-scaling t )
  (setq markdown-fontify-code-blocks-natively t)

  (define-key markdown-mode-map (kbd "C-n") 'markdown-next-visible-heading)
  (define-key markdown-mode-map (kbd "C-p") 'markdown-previous-visible-heading)
  (define-key markdown-mode-map (kbd "C-c C-o") 'markdown-follow-thing-at-point)

    ;;; Plain text (text-mode)
  (add-to-list 'auto-mode-alist '("\\(README\\|CHANGELOG\\|COPYING\\|LICENSE\\)\\'" . text-mode))
    ;;; Markdown (markdown-mode)
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

  (defun markdown-setup ()
    (interactive)
    ;; (flyspell-mode 1)
    (visual-line-mode 1)
    (auto-fill-mode 1))
  (add-hook 'markdown-mode-hook 'markdown-setup)
  )
```


### `Translator` {#translator}




#### <span class="org-todo todo TODO">TODO</span> google-translate {#google-translate}

<span class="timestamp-wrapper"><span class="timestamp">[2022-11-17 Thu 12:45]</span></span>
go-translate 와 함께 사용. skip-region-alist 스타일을 적용해야 한다.

(add-to-list 'ispell-skip-region-alist '(":\\\\(PROPERTIES\\\|LOGBOOK\\\):" . ":END:"))
(add-to-list 'ispell-skip-region-alist '("#\\\\+BEGIN_SRC" . "#\\\\+END_SRC"))
(add-to-list 'ispell-skip-region-alist '("#\\\\+BEGIN_EXAMPLE" . "#\\\\+END_EXAMPLE"))

[GitHub - atykhonov/google-translate: Emacs interface to Google Translate](https://github.com/atykhonov/google-translate)

```elisp
(defun jh-writing/init-google-translate ()
  (use-package google-translate
    ;; :commands (spacemacs/set-google-translate-languages)
    :init
    ;; fix search fail ',ttk'
    ;; (see https://github.com/atykhonov/google-translate/issues/52#issuecomment-727920888)
    (with-eval-after-load 'google-translate-tk
      (defun google-translate--search-tkk () "Search TKK." (list 430675 2721866130)))
    (progn
      (autoload 'google-translate-translate "google-translate-core-ui" "google-translate-translate" nil nil)
      (autoload 'popup-tip "popup" "popup-tip" nil nil)

      (defun google-translate-to-korean (&optional str)
        "Translate given string automatically without language selection prompt."
        (let ((lang (cond
                     ((string-match "[가-힣]" str)
                      "ko")
                     ((or (string-match "[ァ-ヶー]" str)
                          (string-match "[ぁ-んー]" str)
                          ;; (string-match "[亜-瑤]" str)
                          )
                      "ja")
                     ((string-match "[一-龥]" str)
                      "zh-CN")
                     (t
                      "en"))))
          (google-translate-translate lang
                                      (if (string= "ko" lang) "en" "ko")
                                      str)))

      (defun korean/popup-translation (&optional str)
        "Display Google translation in tooltip."
        (interactive)
        (let* ((str (cond ((stringp str) str)
                          (current-prefix-arg
                           (read-string "Google Translate: "))
                          ((use-region-p)
                           (buffer-substring (region-beginning) (region-end)))
                          (t
                           (save-excursion
                             (let (s)
                               (forward-char 1)
                               (backward-sentence)
                               (setq s (point))
                               (forward-sentence)
                               (buffer-substring s (point)))))))
               (translated-str (save-window-excursion
                                 (funcall 'google-translate-to-korean
                                          (replace-regexp-in-string "^\\s-+" str))
                                 (switch-to-buffer "*Google Translate*")
                                 (buffer-string))))
          (if (region-active-p)
              (run-at-time 0.1 nil 'deactivate-mark))
          (kill-buffer "*Google Translate*")
          (popup-tip translated-str
                     :point (point)
                     :around t
                     ;; :height 30
                     :scroll-bar t
                     :margin t)))

      (evil-leader/set-key "xgg" 'korean/popup-translation)

      (spacemacs/set-leader-keys
        "xgi" 'google-translate-paragraphs-insert
        "xgo" 'google-translate-paragraphs-overlay
        "xgQ" 'google-translate-query-translate-reverse
        "xgq" 'google-translate-query-translate
        "xgT" 'google-translate-at-point-reverse
        "xgt" 'google-translate-at-point)
      ;; (setq google-translate-enable-ido-completion nil)
      (setq google-translate-show-phonetic t)
      (setq google-translate-default-source-language "en"
            google-translate-default-target-language "ko")
      )
    )
  )
```


#### popwin for go-transpate {#popwin-for-go-transpate}

<span class="timestamp-wrapper"><span class="timestamp">[2023-03-12 Sun 09:28]</span></span>
버퍼 위치를 고정해 놓는 게 편할 듯하다.

```elisp
(defun jh-writing/pre-init-popwin ()
  (spacemacs|use-package-add-hook popwin
    :post-config
    (push '("*Go-Translate*" :dedicated t :position bottom :stick t :noselect t) popwin:special-display-config)))
```


### Dictionary {#dictionary}


#### dictionary server {#dictionary-server}

[Wordsmithing in Emacs - Mastering Emacs](https://www.masteringemacs.org/article/wordsmithing-in-emacs)
위에 정리가 잘되어 있다.
23/01/17--16:49 :: 내가 하려는 것은 로컬 사전 서버를 돌리는 일이다.
위의 글에 일부 내용이 있다.

> Running your own Dictionary Server
>
> Emacs’s dictionary lookup will, by default, communicate with a third-party
> server when you ask it to look up a word. I’d rather it didn’t, so I changed
> it. Here’s how I did this on Ubuntu:
>
> $ sudo apt-get install dictd dict dict-{wn,vera,jargon,gcide,foldoc}
> $ sudo systemctl enable dictd
>
> I had to manually enable the dictionary service daemon, as that is a requirement
> for this to work.
>
> To make Emacs use your local server instead of a remote one, customize
> dictionary-server to localhost:
>
> (setq dictionary-server "localhost")
>
> There’s a large range of dictionaries available in Ubuntu/Debian, and I only
> included the bare essentials above. Of note is gcide, which is a
> community-maintained version of Webster’s 1913 dictionary. All installed
> dictionaries are activated and made available to the dictionary server.
>
> DICT 는 RFC 2229 로 설명된 1997 년 DICT 개발 그룹에서 만든 사전 네트워크
> 프로토콜입니다. 목표는 웹스터 프로토콜을 능가하여 클라이언트가 균일한
> 인터페이스를 통해 다양한 사전에 액세스할 수 있도록 하는 것입니다

관련 설정을 추가하자면! 로컬 호스트를 하면 오프라인 사전을 사용한다는 말.
prot 설정에서 가져온다면 아래와 같다.
_home/junghan/sync/man/dotsamples/vanilla/prot-dotfiles/emacs_.emacs.d/prot-emacs-modules/prot-emacs-langs.el:146

```elisp
(defun jh-writing/init-dictionary ()
  (use-package dictionary
    :config
    (setq dictionary-server "localhost")
    ;; (setq dictionary-server "dict.org")
    (setq dictionary-default-popup-strategy "lev" ; read doc string
          dictionary-create-buttons nil
          dictionary-use-single-buffer t)))
```


#### <span class="org-todo todo TODO">TODO</span> 사전 패키지들 여기로 다시 옮길 것 {#사전-패키지들-여기로-다시-옮길-것}


### <span class="org-todo todo TODO">TODO</span> palimpseat {#palimpseat}

글쓰기를 위한 패키지. 지울 단락을 따로 보관해 둔다.
아주 귀한 패키지인데 아직 사용을 못하고 있네!

```elisp
(defun jh-writing/init-palimpsest ()
  (use-package palimpsest
    :defer t
    :after org
    :config
    ;; (add-hook 'text-mode-hook 'palimpsest-mode)
    (add-hook 'org-mode-hook 'palimpsest-mode)
    ;; Usage
    ;; M-x palimpsest-move-region-to-bottom
    ;; M-x palimpsest-move-region-to-top
    ;; M-x palimpsest-move-region-to-trash
    ;; Keyboard shortcuts are provided:

    ;; C-c C-r: Send selected text to bottom of buffer
    ;; C-c C-s: Send selected text to top of buffer
    ;; C-c C-q: Send selected text to trash file
    )
  )
```


### guess-language {#guess-language}

```elisp
(defun jh-writing/init-guess-language ()
  (use-package guess-language
    :demand
    :ensure
    :config
    (setq guess-language-langcodes
          '((en . ("en_US" "English" "🇬🇧" "English"))
            (ko . ("ko_KR" "Korean" "🇰🇷" "Korean"))))

    (setq guess-language-languages '(ko en))
    (setq guess-language-min-paragraph-length 35)
    )
  ;; (setq guess-language-trigrams-directory "/home/junghan/sync/emacs/guess-language/trigrams/")
  )

;; 여기에 flyspell 언어 바꿔서 해주면 좋겠다.
;; (defun my-custom-function (lang beginning end)
;;   (do-something))
;; (add-hook 'guess-language-after-detection-functions #'my-custom-function)
;; (add-hook 'org-mode-hook (lambda () (guess-language-mode 1)))
```


### <span class="org-todo todo TODO">TODO</span> txl : deepl rest api {#txl-deepl-rest-api}

[GitHub - tmalsburg/txl.el: Emacs extension providing dire...](https://github.com/tmalsburg/txl.el)
한글 API 처리 하려니까 잘 안되는구나. 조금 다른 방법을 찾아봐야 할 것 같다.
단, txl 코드를 참고 할 만 하다.

```elisp
(defun jh-writing/init-txl ()
  (require 'txl)
  (setq txl-languages '(EN-US . KO))

  ;; (setq txl-deepl-api-url "https://api-free.deepl.com/v2/translate") ; free

  ;; https://arca.live/b/alpaca/74925160
  ;; gtgkjh85@naver.com https://rapidapi.com/splintPRO/api/deepl-translator
  (setq txl-deepl-api-key "fba11761camshf62e55c2852de79p154e1bjsn570a0812878e")
  (setq txl-deepl-api-url "https://deepl-translator.p.rapidapi.com/translate")
  (global-set-key (kbd "C-c T .")   'txl-translate-region-or-paragraph)
  )
```
