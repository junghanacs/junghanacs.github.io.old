+++
title = "Dot-Spacemacs"
author = ["Junghan Kim"]
date = 2023-05-17
publishDate = 2023-05-17
lastmod = 2023-07-06
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
Spacemacs 닷 파일. 정리가 필요하다. 정리는 주석 삭제부터. noexport 를 적절히 사용
{{< /hint >}}

<!--more-->

> Currently tailored for GNU Emacs 29+
> 29.1 릴리즈가 되니까 거기에 집중한다.


## Prerequisites {#prerequisites}


### Spacemacs <kbd>init.el</kbd> {#spacemacs-init-dot-el}

This file is loaded before the initialization of emacs begins. It is sometimes
helpful to pre-configure stuff in here. **Note:** The <kbd>:PROPERTIES:</kbd> drawer in this
section flags org-babel to make sure that the <kbd>.emacs.d/</kbd> directory exists using
the `:mkdirp yes` argument.

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
;; This file was generated using literate programming.
;; Please see the spacemacs.org file.

;;; Load paths
;; optimize: force "lisp"" and "site-lisp" at the head to reduce the startup time.
;; (add-to-list 'load-path (concat dotspacemacs-directory "lisp"))
(dolist (dir '("site-lisp" "lisp"))
  (push (expand-file-name dir dotspacemacs-directory) load-path))

;; Emacs version 29 added a new frame parameter for "true" transparency, which
;; means that only the blackground is transparent while the text is not.
;; started to use new #emacs 29 alpha-background frame-parameters. It only works on
;; gnu/#linux at the moment and look beautiful :

(if (eq system-type 'gnu/linux)
    (setq default-frame-alist (push '(alpha-background . 94) default-frame-alist))
  (setq default-frame-alist (push '(alpha . (95 90)) default-frame-alist)))

(setq emacs-major-version-string (format "%s" emacs-major-version))

;; only for window-system
;; (setq default-frame-alist (push '(internal-border-width . 5) default-frame-alist))
;; (setq default-frame-alist (push '(right-divider-width . 20) default-frame-alist))
;; (setq default-frame-alist (push '(scroll-bar-with . 12) default-frame-alist))

;;; Load 'Spacemacs'
(load-file (concat dotspacemacs-directory "spacemacs.el"))

;;; Show 'Startup-Time'
(defun display-startup-echo-area-message ()
  "Display startup message."
  (message (concat "Startup time: " (emacs-init-time))))

;;; init.el ends here
```


### Custom Settings <kbd>emacs-custom.el</kbd> {#custom-settings-emacs-custom-dot-el}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-

;; This file is where Emacs writes custom variables.
;; Spacemacs will copy its content to your dotfile automatically in the
;; function `dotspacemacs/emacs-custom-settings'.
;; Do not alter this file, use Emacs customize interface instead.

;;; Custom-set-variables

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '(
     (org-cite-export-processors
      (t csl "~/org/roam/ieee.csl"))
     (eval add-hook 'after-save-hook
           (lambda nil
             (org-babel-tangle))
           nil t))))

;;; Custom-set-faces

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(translate-paragraph-highlight ((t (:extend t :background "red"))))
 '(spell-fu-incorrect-face ((t (:underline (:color "dark violet" :style wave :position nil)))))
 '(pocket-reader-archived ((t (:weight semi-light))))
 '(pocket-reader-unread ((t (:underline t :weight normal))))
 '(wcheck-default-face ((t (:foreground "HotPink1" :underline (:color foreground-color :style wave :position nil)))))
 '(sideline-blame ((t (:foreground "#7a88cf" :background unspecified :height 1.0 :italic t))))
 )
;;; emacs-custom.el ends here
```


### Dotfile Headers <kbd>spacemacs.el</kbd> {#dotfile-headers-spacemacs-dot-el}

This generates the top of the init file, which will set up the lexical scope and describe to Emacs what the file does.

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
;;
;; This program is free software: you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free Software
;; Foundation, either version 3 of the License, or (at your option) any later
;; version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;; FITNESS FOR A PARTICULAR PURPOSE.
;;
;; See the GNU General Public License for more details. You should have received
;; a copy of the GNU General Public License along with this program. If not, see
;; <https://www.gnu.org/licenses/>.
;;
;;  ____
;; / ___| _ __   __ _  ___ ___ _ __ ___   __ _  ___ ___
;; \___ \| '_ \ / _` |/ __/ _ \ '_ ` _ \ / _` |/ __/ __|
;;  ___) | |_) | (_| | (_|  __/ | | | | | (_| | (__\__ \
;; |____/| .__/ \__,_|\___\___|_| |_| |_|\__,_|\___|___/
;;       |_|
;;
;; This program was generated using literate programming.
;;
```


### Reproducible information {#reproducible-information}

This configuration is continuingly being improved. I build my own Emacs from
source in order to take advantage of some experimental features. There are also
`(packages! ...)` calls to external Emacs packages that are unpinned to any
specific version. As such, there might be incompabilities if one blindly copies
codes from this configurations. Although I'll try to document which features are
based on developing softwares and are likely to be changed in the future, it is
inevitable that some bits of information are going to fall through the cracks.

In this section, I reiterate the relevant info about the version of the software
I'm using here, in case someone finds this infomation useful. Here's my current
build of Emacs:

```emacs-lisp
(emacs-version)
```

```text
GNU Emacs 29.0.90 (build 1, x86_64-pc-linux-gnu, GTK+ Version 3.24.33, cairo version 1.16.0)
 of 2023-04-19
```

```text
GNU Emacs 29.0.90 (build 2, x86_64-pc-linux-gnu, GTK+ Version 3.24.33, cairo version 1.16.0)
 of 2023-04-16
```

```text
GNU Emacs 29.0.60 (build 2, x86_64-pc-linux-gnu, GTK+ Version 3.24.33, cairo version 1.16.0)
 of 2023-02-23
```

This Emacs is built with the following configuration options:

```emacs-lisp
system-configuration-options
```

```text
--with-native-compilation --with-json --without-pop --with-gnutls --without-mailutils --with-sqlite3 --with-rsvg --with-png --with-jpeg --with-tiff --with-imagemagick --with-tree-sitter=ifavailable --with-cairo --with-lcms2 --with-modules --with-xwidgets --with-x-toolkit=gtk3 '--program-transform-name=s/^ctags$/ctags.emacs/' 'CFLAGS=-O2 -pipe -mtune=native -march=native -fomit-frame-pointer'
```

```text
--with-native-compilation --with-json --without-pop --with-gnutls --without-mailutils --with-sqlite3 --with-tree-sitter=ifavailable --with-cairo --with-lcms2 --with-modules --with-xwidgets --with-x-toolkit=gtk3 '--program-transform-name=s/^ctags$/ctags.emacs/' 'CFLAGS=-O2 -pipe -mtune=native -march=native -fomit-frame-pointer'
```


## `Base` Configuration and `Layer` Declaration {#base-configuration-and-layer-declaration}

Configuration Layers declaration. You should not put any user code in this
function besides modifying the variable values.


### `START` dotspacemacs/layers () {#start-dotspacemacs-layers}

```elisp
;;; Spacemacs Layer
(defun dotspacemacs/layers ()
```


### `Base` Configurations {#base-configurations}

```elisp
;;;;  'Base' Configurations

(setq-default
 ;; Base distribution to use. This is a layer contained in the directory
 ;; `+distribution'. For now available distributions are `spacemacs-base'
 ;; or `spacemacs'. (default 'spacemacs)
 dotspacemacs-distribution 'spacemacs-base
 ;; 명시적으로 아래 정의한 패키지만 사용한다.
 ;; Lazy installation of layers (i.e. layers are installed only when a file
 ;; with a supported type is opened). Possible values are `all', `unused'
 ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
 ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
 ;; lazy install any layer that support lazy installation even the layers
 ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
 ;; installation feature and you have to explicitly list a layer in the
 ;; variable `dotspacemacs-configuration-layers' to install it.
 ;; (default 'unused)
 dotspacemacs-enable-lazy-installation nil
 ;; dotspacemacs-enable-lazy-installation 'unused
 dotspacemacs-ask-for-lazy-installation t
 dotspacemacs-configuration-layer-path '("~/.spacemacs.d/layers/") ; add private layer here!
 ;; 기본 스니펫 폴더 설정
 dotspacemacs-directory-snippets-dir '(concat doctspacemacs-directory "snippets"))
```


### `Extra` Package Options <span class="tag"><span class="extra">extra</span></span> {#extra-package-options}

-   "Frozen Packages" is list of packages that you do not want to be updated
-   "Excluded Packages" is list of packages that will not be installed or loaded
-   'Install packages': Defines the behaviour of Spacemacs when installing packages.
    -   'used-only': installs only explicitly used packages and uninstall any
        unused packages as well as their unused dependencies.
    -   \`used-but-keep-unused': installs only the used packages but won't
        uninstall them if they become unused.
    -   \`all' installs **all** packages supported by Spacemacs and never uninstall
        them. (default is \`used-only')

<!--listend-->

```elisp
;;;; 'Extra' Package Options

(setq-default
 dotspacemacs-frozen-packages '()
 dotspacemacs-excluded-packages '(
                                  web-beautify
                                  prettier-js
                                  company
                                  org-superstar
                                  emoji-cheat-sheet-plus ; dependent helm
                                  tern
                                  fancy-battery
                                  fish-mode
                                  valign
                                  undo-tree
                                  volatile-highlights
                                  )
 dotspacemacs-install-packages 'used-only
 )
```


### `Layer` Declarations <span class="tag"><span class="declaration">declaration</span></span> {#layer-declarations}

Declarations of layers which spacemacs should install. When layers are called
there are different options for how this should be done.
[Spacemacs layers list](https://develop.spacemacs.org/layers/LAYERS.html#completion)

```elisp
;;;; 'Layer' Declarations

;; Default Layer Configurations
;; List of configuration layers to load.
(setq-default
 dotspacemacs-configuration-layers
 '(
   jh-base
   jh-completion
   jh-visual
   jh-workspace
   jh-editing
   jh-navigation
   jh-writing
   jh-checker
   jh-project
   jh-utility
   jh-coding
   jh-org
   jh-org-workflow
   jh-pkm
   jh-misc
   jh-reading
   ))

;; Load custom-layer-filename
(let ((custom-layer-filename (concat dotspacemacs-directory "layers/load-" emacs-major-version-string ".el")))
  (when (file-exists-p custom-layer-filename)
    (load-file custom-layer-filename)))
```


### `Additional` Packages <span class="tag"><span class="addition">addition</span></span> {#additional-packages}

List of additional packages that will be installed without being wrapped in a
layer. If you need some configuration for these packages, then consider creating
a layer. You can also put the configuration in \`dotspacemacs/user-config'.

여기 안넣고 아래에 use-package 하게되면, 다시켤 때 마다 지우고 설치하게
된다. 그러니 여기 넣어라. 순서만 잘 맞춰주면 된다.

여기에 상당히 구성이 잘 되어 있으니까 위에 양식을 일부 사용해서
분류를 하자. 그렇게 되면 현재 Spacemacs 와 내 구성의 차이와 개선 및
단점을 볼 수 있다. 더불어 다양한 언어를 활용 할 수도 있기 때문에
상황에 맞게 활용 할 수 있다. 각자의 노하우를 합쳐가면 좋지 않겠는가?!

```elisp
;;;; 'Additional' Packages

(load-file (concat dotspacemacs-directory "additional-packages.el"))
```


### `END` dotspacemacs/layers {#end-dotspacemacs-layers}

```elisp
;;;; END

) ; defun dotspacemacs/layers
```


## `Spacemacs` Configuration {#spacemacs-configuration}


### `START` dotspacemacs/init {#start-dotspacemacs-init}

```elisp
;;; Spacemacs Configuration

(defun dotspacemacs/init ()
```


### Start and several functions {#start-and-several-functions}

Initialization function. This function is called at the very startup of
Spacemacs initialization before layers configuration. You should not put any
user code in there besides modifying the variable values.

```elisp
;;;; Start and several functions

;; This setq-default sexp is an exhaustive list of all the supported
;; spacemacs settings.
(setq-default
 ;; If non-nil then enable support for the portable dumper. You'll need to
 ;; compile Emacs 27 from source following the instructions in file
 ;; EXPERIMENTAL.org at to root of the git repository.
 ;;
 ;; WARNING: pdumper does not work with Native Compilation, so it's disabled
 ;; regardless of the following setting when native compilation is in effect.
 ;;
 ;; (default nil)
 dotspacemacs-enable-emacs-pdumper nil

 ;; Name of executable file pointing to emacs 27+. This executable must be
 ;; in your PATH.
 ;; (default "emacs")
 dotspacemacs-emacs-pdumper-executable-file "emacs"

 ;; Name of the Spacemacs dump file. This is the file will be created by the
 ;; portable dumper in the cache directory under dumps sub-directory.
 ;; To load it when starting Emacs add the parameter `--dump-file'
 ;; when invoking Emacs 27.1 executable on the command line, for instance:
 ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
 ;; (default (format "spacemacs-%s.pdmp" emacs-version))
 dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

 ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
 ;; possible. Set it to nil if you have no way to use HTTPS in your
 ;; environment, otherwise it is strongly recommended to let it set to t.
 ;; This variable has no effect if Emacs is launched with the parameter
 ;; `--insecure' which forces the value of this variable to nil.
 ;; (default t)
 dotspacemacs-elpa-https t

 ;; Maximum allowed time in seconds to contact an ELPA repository.
 ;; (default 5)
 dotspacemacs-elpa-timeout 15

 ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
 ;; This is an advanced option and should not be changed unless you suspect
 ;; performance issues due to garbage collection operations.
 ;; (default '(100000000 0.1))
 dotspacemacs-gc-cons '(100000000 0.1)
 ;; dotspacemacs-gc-cons '(256000000 0.1)
 ;; dotspacemacs-gc-cons '(512000000 0.3)

 ;; Set `read-process-output-max' when startup finishes.
 ;; This defines how much data is read from a foreign process.
 ;; Setting this >= 1 MB should increase performance for lsp servers
 ;; in emacs 27.
 ;; (default (* 1024 1024))
 dotspacemacs-read-process-output-max (* 1024 1024)

 ;; If non-nil then Spacelpa repository is the primary source to install
 ;; a locked version of packages. If nil then Spacemacs will install the
 ;; latest version of packages from MELPA. Spacelpa is currently in
 ;; experimental state please use only for testing purposes.
 ;; (default nil)
 dotspacemacs-use-spacelpa nil

 ;; If non-nil then verify the signature for downloaded Spacelpa archives.
 ;; (default t)
 dotspacemacs-verify-spacelpa-archives t

 ;; If non-nil then spacemacs will check for updates at startup
 ;; when the current branch is not `develop'. Note that checking for
 ;; new versions works via git commands, thus it calls GitHub services
 ;; whenever you start Emacs. (default nil)
 dotspacemacs-check-for-update nil

 ;; If non-nil, a form that evaluates to a package directory. For example, to
 ;; use different package directories for different Emacs versions, set this
 ;; to `emacs-version'. (default 'emacs-version)
 dotspacemacs-elpa-subdirectory 'emacs-version

 ;; One of `vim', `emacs' or `hybrid'.
 ;; `hybrid' is like `vim' except that `insert state' is replaced by the
 ;; `hybrid state' with `emacs' key bindings. The value can also be a list
 ;; with `:variables' keyword (similar to layers). Check the editing styles
 ;; section of the documentation for details on available variables.
 ;; (default 'vim)
 dotspacemacs-editing-style 'vim
 ;; dotspacemacs-editing-style
 ;; '(vim :variables
 ;;       vim-style-visual-feedback nil
 ;;       vim-style-remap-Y-to-y$ nil
 ;;       vim-style-retain-visual-state-on-shift t
 ;;       vim-style-visual-line-move-text nil
 ;;       vim-style-ex-substitute-global nil)

 ;; If non-nil show the version string in the Spacemacs buffer. It will
 ;; appear as (spacemacs version)@(emacs version)
 ;; (default t)
 dotspacemacs-startup-buffer-show-version t

 ;; Specify the startup banner. Default value is `official', it displays
 ;; the official spacemacs logo. An integer value is the index of text
 ;; banner, `random' chooses a random text banner in `core/banners'
 ;; directory. A string value must be a path to an image format supported
 ;; by your Emacs build.
 ;; If the value is nil then no banner is displayed. (default 'official)
 dotspacemacs-startup-banner 100 ; 'random
 ;; dotspacemacs-startup-banner (concat
 ;;                              dotspacemacs-directory "splash/spacemacs1.svg")

 ;; Scale factor controls the scaling (size) of the startup banner. Default
 ;; value is `auto' for scaling the logo automatically to fit all buffer
 ;; contents, to a maximum of the full image height and a minimum of 3 line
 ;; heights. If set to a number (int or float) it is used as a constant
 ;; scaling factor for the default logo size.
 dotspacemacs-startup-banner-scale 'auto

 ;; List of items to show in startup buffer or an association list of
 ;; the form `(list-type . list-size)`. If nil then it is disabled.
 ;; Possible values for list-type are:
 ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
 ;; List sizes may be nil, in which case
 ;; `spacemacs-buffer-startup-lists-length' takes effect.
 ;; The exceptional case is `recents-by-project', where list-type must be a
 ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
 ;; number is the project limit and the second the limit on the recent files
 ;; within a project.
 ;; dotspacemacs-startup-lists '(
 ;;                              ;; (projects . 5) ; projectile
 ;;                              ;; (agenda . 5) ; slowzy
 ;;                              (bookmarks . 5)
 ;;                              (recents . 5)
 ;;                              )
 dotspacemacs-startup-lists nil

 ;; True if the home buffer should respond to resize events. (default t)
 dotspacemacs-startup-buffer-responsive t

 ;; Show numbers before the startup list lines. (default t)
 dotspacemacs-show-startup-list-numbers t

 ;; The minimum delay in seconds between number key presses. (default 0.4)
 dotspacemacs-startup-buffer-multi-digit-delay 0.4

 ;; If non-nil, show file icons for entries and headings on Spacemacs home buffer.
 ;; This has no effect in terminal or if "all-the-icons" package or the font
 ;; is not installed. (default nil)
 dotspacemacs-startup-buffer-show-icons nil

 ;; Default major mode for a new empty buffer. Possible values are mode
 ;; names such as `text-mode'; and `nil' to use Fundamental mode.
 dotspacemacs-new-empty-buffer-major-mode 'org-mode

 ;; Default major mode of the scratch buffer (default `text-mode')
 dotspacemacs-scratch-mode 'emacs-lisp-mode

 ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
 ;; *scratch* buffer will be saved and restored automatically.
 dotspacemacs-scratch-buffer-persistent t

 ;; If non-nil, `kill-buffer' on *scratch* buffer
 ;; will bury it instead of killing.
 dotspacemacs-scratch-buffer-unkillable t

 ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
 dotspacemacs-initial-scratch-message ";; Welcome to Junghanacs!"
```


### Configuration {#configuration}

```elisp
;;;; Configuration

dotspacemacs-themes (let ((hr (nth 2 (decode-time))))
                      (if (or (< hr 7) (< 20 hr))           ; between 8 PM and 7 AM
                          '(spacemacs-dark spacemacs-light) ; load dark theme first
                        '(spacemacs-light spacemacs-dark)))
;; dotspacemacs-themes '(modus-operandi modus-vivendi)

dotspacemacs-mode-line-theme '(spacemacs :separator nil :separator-scale 1.5)

;; Default font or prioritized list of fonts. The `:size' can be specified as
;; a non-negative integer (pixel size), or a floating-point (point size).
;; Point size is recommended, because it's device independent. (default 10.0)
dotspacemacs-default-font '("Sarasa Term K Nerd Font"
                            :size 13.5 ; 13.5, 15.0
                            :width normal
                            :weight regular)

;; If non-nil the cursor color matches the state color in GUI Emacs.
dotspacemacs-colorize-cursor-according-to-state t

dotspacemacs-leader-key "SPC"

;; The key used for Emacs commands `M-x' (after pressing on the leader key).
dotspacemacs-emacs-command-key "SPC"

;; The key used for Vim Ex commands (default ":")
dotspacemacs-ex-command-key ":"

;; The leader key accessible in `emacs state' and `insert state'
;; (default "M-m")
dotspacemacs-emacs-leader-key "M-m"

;; Major mode leader key is a shortcut key which is the equivalent of
;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
dotspacemacs-major-mode-leader-key ","

;; Major mode leader key accessible in `emacs state' and `insert state'.
;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
;; Thus M-RET should work as leader key in both GUI and terminal modes.
;; C-M-m also should work in terminal mode, but not in GUI mode.
dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

;; These variables control whether separate commands are bound in the GUI to
;; the key pairs `C-i', `TAB' and `C-m', `RET'.
;; Setting it to a non-nil value, allows for separate commands under `C-i'
;; and TAB or `C-m' and `RET'.
;; In the terminal, these pairs are generally indistinguishable, so this only
;; works in the GUI. (default nil)
dotspacemacs-distinguish-gui-tab nil ; t if evil-better-jumper layer

;; Name of the default layout (default "Default")
dotspacemacs-default-layout-name "Default"

;; If non-nil the default layout name is displayed in the mode-line.
;; (default nil)
dotspacemacs-display-default-layout t

;; If non-nil then the last auto saved layouts are resumed automatically upon
;; start. (default nil)
dotspacemacs-auto-resume-layouts nil

;; If non-nil, auto-generate layout name when creating new layouts. Only has
;; effect when using the "jump to layout by number" commands. (default nil)
dotspacemacs-auto-generate-layout-names nil

;; Size (in MB) above which spacemacs will prompt to open the large file
;; literally to avoid performance issues. Opening a file literally means that
;; no major mode or minor modes are active. (default is 1)
dotspacemacs-large-file-size 5

;; Location where to auto-save files. Possible values are `original' to
;; auto-save the file in-place, `cache' to auto-save the file to another
;; file stored in the cache directory and `nil' to disable auto-saving.
;; (default 'cache)
dotspacemacs-auto-save-file-location 'cache

;; Maximum number of rollback slots to keep in the cache. (default 5)
dotspacemacs-max-rollback-slots 5

;; If non-nil, the paste transient-state is enabled. While enabled, after you
;; paste something, pressing `C-j' and `C-k' several times cycles through the
;; elements in the `kill-ring'. (default nil)
dotspacemacs-enable-paste-transient-state t

;; Which-key delay in seconds. The which-key buffer is the popup listing
;; the commands bound to the current keystroke sequence. (default 0.4)
dotspacemacs-which-key-delay 0.4

;; Which-key frame position. Possible values are `right', `bottom' and
;; `right-then-bottom'. right-then-bottom tries to display the frame to the
;; right; if there is insufficient space it displays it at the bottom.
;; (default 'bottom)
dotspacemacs-which-key-position 'bottom

;; Control where `switch-to-buffer' displays the buffer. If nil,
;; `switch-to-buffer' displays the buffer in the current window even if
;; another same-purpose window is available. If non-nil, `switch-to-buffer'
;; displays the buffer in a same-purpose window even if the buffer can be
;; displayed in the current window. (default nil)
dotspacemacs-switch-to-buffer-prefers-purpose t

;; If non-nil a progress bar is displayed when spacemacs is loading. This
;; may increase the boot time on some systems and emacs builds, set it to
;; nil to boost the loading time. (default t)
dotspacemacs-loading-progress-bar t

;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
dotspacemacs-fullscreen-at-startup nil

;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
;; Use to disable fullscreen animations in OSX. (default nil)
dotspacemacs-fullscreen-use-non-native nil

;; If non-nil the frame is maximized when Emacs starts up.
;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
dotspacemacs-maximized-at-startup nil

;; If non-nil the frame is undecorated when Emacs starts up. Combine this
;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
;; borderless fullscreen. (default nil)
dotspacemacs-undecorated-at-startup nil

;; A value from the range (0..100), in increasing opacity, which describes
;; the transparency level of a frame when it's active or selected.
;; Transparency can be toggled through `toggle-transparency'. (default 90)
dotspacemacs-active-transparency 90

;; A value from the range (0..100), in increasing opacity, which describes
;; the transparency level of a frame when it's inactive or deselected.
;; Transparency can be toggled through `toggle-transparency'. (default 90)
dotspacemacs-inactive-transparency 90

;; If non-nil show the titles of transient states. (default t)
dotspacemacs-show-transient-state-title t

;; If non-nil show the color guide hint for transient state keys. (default t)
dotspacemacs-show-transient-state-color-guide t

;; If non-nil unicode symbols are displayed in the mode line.
;; If you use Emacs as a daemon and wants unicode characters only in GUI set
;; the value to quoted `display-graphic-p'. (default t)
dotspacemacs-mode-line-unicode-symbols nil

;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
;; scrolling overrides the default behavior of Emacs which recenters point
;; when it reaches the top or bottom of the screen. (default t)
dotspacemacs-smooth-scrolling t

;; Show the scroll bar while scrolling. The auto hide time can be configured
;; by setting this variable to a number. (default t)
dotspacemacs-scroll-bar-while-scrolling nil

;; Control line numbers activation.
;; If set to `t', `relative' or `visual' then line numbers are enabled in all
;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
;; numbers are relative. If set to `visual', line numbers are also relative,
;; but only visual lines are counted. For example, folded lines will not be
;; counted and wrapped lines are counted as multiple lines.
;; This variable can also be set to a property list for finer control:
;; When used in a plist, `visual' takes precedence over `relative'.
;; dotspacemacs-line-numbers '(:relative t
;;                                       ;; :visual t
;;                                       :disabled-for-modes dired-mode
;;                                       ;; text-mode ; for performance issue
;;                                       doc-view-mode
;;                                       pdf-view-mode
;;                                       :size-limit-kb 1000)
dotspacemacs-line-numbers t

;; Code folding method. Possible values are `evil', `origami' and `vimish'.
;; (default 'evil)
dotspacemacs-folding-method 'evil

;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
;; `smartparens-strict-mode' will be enabled in programming modes.
;; (default nil)
dotspacemacs-smartparens-strict-mode nil ; use 'puni'

;; If non-nil smartparens-mode will be enabled in programming modes.
;; (default t)
dotspacemacs-activate-smartparens-mode nil ; use 'puni'

;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
;; over any automatically added closing parenthesis, bracket, quote, etc...
;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
dotspacemacs-smart-closing-parenthesis nil ; use 'electric-pair-mode'

;; Select a scope to highlight delimiters. Possible values are `any',
;; `current', `all' or `nil'. Default is `all' (highlight any scope and
;; emphasis the current one). (default 'all)
dotspacemacs-highlight-delimiters 'all

;; If non-nil, start an Emacs server if one is not already running.
;; (default nil)
dotspacemacs-enable-server t

;; Set the emacs server socket location.
;; If nil, uses whatever the Emacs default is, otherwise a directory path
;; like \"~/.emacs.d/server\". It has no effect if
;; `dotspacemacs-enable-server' is nil.
;; (default nil)
dotspacemacs-server-socket-dir "~/.cache/"

;; If non-nil, advise quit functions to keep server open when quitting.
;; (default nil)
dotspacemacs-persistent-server nil

;; List of search tool executable names. Spacemacs uses the first installed
;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
;; (default '("rg" "ag" "pt" "ack" "grep"))
dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

;; Format specification for setting the frame title.
;; %a - the `abbreviated-file-name', or `buffer-name'
;; %t - `projectile-project-name'
;; %I - `invocation-name'
;; %S - `system-name'
;; %U - contents of $USER
;; %b - buffer name
;; %f - visited file name
;; %F - frame name
;; %s - process status
;; %p - percent of buffer above top of window, or Top, Bot or All
;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
;; %m - mode name
;; %n - Narrow if appropriate
;; %z - mnemonics of buffer, terminal, and keyboard coding systems
;; %Z - like %z, but including the end-of-line format
;; If nil then Spacemacs uses default `frame-title-format' to avoid
;; performance issues, instead of calculating the frame title by
;; `spacemacs/title-prepare' all the time.
;; (default "%I@%S")
;; dotspacemacs-frame-title-format "%f"
dotspacemacs-frame-title-format nil

;; Format specification for setting the icon title format
;; (default nil - same as frame-title-format)
dotspacemacs-icon-title-format nil

;; Color highlight trailing whitespace in all prog-mode and text-mode derived
;; modes such as c++-mode, python-mode, emacs-lisp, html-mode, rst-mode etc.
;; (default t)
dotspacemacs-show-trailing-whitespace t

;; Delete whitespace while saving buffer. Possible values are `all'
;; to aggressively delete empty line and long sequences of whitespace,
;; `trailing' to delete only the whitespace at end of lines, `changed' to
;; delete only whitespace for changed lines or `nil' to disable cleanup.
;; (default nil)
;; dotspacemacs-whitespace-cleanup 'trailing
dotspacemacs-whitespace-cleanup 'all

;; If non-nil activate `clean-aindent-mode' which tries to correct
;; virtual indentation of simple modes. This can interfere with mode specific
;; indent handling like has been reported for `go-mode'.
;; If it does deactivate it here.
;; (default t)
dotspacemacs-use-clean-aindent-mode t

;; Accept SPC as y for prompts if non-nil. (default nil)
dotspacemacs-use-SPC-as-y nil

;; If non-nil shift your number row to match the entered keyboard layout
;; (only in insert state). Currently supported keyboard layouts are:
;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
;; New layouts can be added in `spacemacs-editing' layer.
;; (default nil)
dotspacemacs-swap-number-row nil

;; Either nil or a number of seconds. If non-nil zone out after the specified
;; number of seconds. (default nil)
dotspacemacs-zone-out-when-idle nil

;; Run `spacemacs/prettify-org-buffer' when
;; visiting README.org files of Spacemacs.
;; (default nil)
dotspacemacs-pretty-docs nil

;; If nil the home buffer shows the full path of agenda items
;; and todos. If non-nil only the file name is shown.
dotspacemacs-home-shorten-agenda-source t

;; If non-nil then byte-compile some of Spacemacs files.
dotspacemacs-byte-compile nil

) ; end-of setq-default
```


### Additional configuration {#additional-configuration}

정말 필요하면 user-init 에 넣어라. 일단 베이스만 남겨둔다.

```elisp
;;;; Additional configuration

(when (< emacs-major-version 29) ; emacs 28
  (setq-default dotspacemacs-enable-server nil))

  ;;;; END
) ;; end-of init
```


## User Init {#user-init}


### `START` user/init {#start-user-init}

```elisp
;;; User Initialization

(defun dotspacemacs/user-init ()
```


### User Initialization {#user-initialization}

Initialization function for user code. It is called immediately after
\`dotspacemacs/init', <kbd>before layer configuration executes</kbd>. This function is
mostly useful for variables that need to be set before packages are loaded. If
you are unsure, you should try in setting them in \`dotspacemacs/user-config' first.

```elisp
;;;; User Initilization

;; emacsclient -s ~/.cache/spacemacs-server -n
;; (setq server-name "spacemacs-server") ; default "server"
(setq server-name (concat "spacemacs-server-" emacs-major-version-string))

;;;;; unset keys before layers are loaded
(global-unset-key (kbd "M-c"))  ; unset capitalize-word
(global-unset-key (kbd "<f2>"))
(global-unset-key (kbd "<f3>"))
(global-unset-key (kbd "<f7>"))

;; 불필요한 Package cl is deprecated 경고 숨기기
;; (setq byte-compile-warnings '(not cl-functions))

;;;;; Define stable packages

(add-to-list 'package-pinned-packages '(clojure-mode . "nongnu") t)
(add-to-list 'package-pinned-packages '(cider . "nongnu") t)
(add-to-list 'package-pinned-packages '(modus-themes . "gnu") t)

;;;;; Load 'permachine' configuration

(defvar blog-admin-dir ""
  "blog-admin files location")

;; Most of my per-environment config done via =customize= and is in .custom.el.
;; However, some config is more involved, such as packages I just want in one
;; environment and not the others.  To that end, let's load a file that can contain
;; those customizations.
(let ((per-machine-filename "~/.spacemacs.d/permachine.el"))
  (when (file-exists-p per-machine-filename)
    (load-file per-machine-filename)))

;;;;; Emacspeak (OFF)

;; emacspeak 사용. 28 안정화 버전에서만 사용
;; (if (< emacs-major-version 29)
;;  (defvar *run-emacspeak* t))

;;;;; Theming

(setq spacemacs-theme-comment-bg nil
      spacemacs-theme-org-highlight t)

(setq theming-modifications
      '(
        (spacemacs-light
         (org-document-title :inherit variable-pitch)
         (tab-bar-tab :inherit variable-pitch)
         (header-line :weight semibold :inherit variable-pitch)
         (tab-bar :inherit variable-pitch)
         (org-level-1 :weight bold :inherit variable-pitch)
         (org-level-2 :weight semibold :inherit variable-pitch)
         (org-level-3 :weight semibold :inherit variable-pitch)
         (org-level-4 :inherit variable-pitch)
         (org-level-5 :inherit variable-pitch)
         (mode-line :inherit variable-pitch)
         (mode-line-inactive :inherit variable-pitch)
         )
        (spacemacs-dark
         (org-document-title :inherit variable-pitch)
         (tab-bar-tab :inherit variable-pitch)
         (header-line :inherit variable-pitch)
         (tab-bar :inherit variable-pitch)
         (org-level-1 :weight bold :inherit variable-pitch)
         (org-level-2 :weight semibold :inherit variable-pitch)
         (org-level-3 :weight semibold :inherit variable-pitch)
         (org-level-4 :inherit variable-pitch)
         (org-level-5 :inherit variable-pitch)
         (mode-line :inherit variable-pitch)
         (mode-line-inactive :inherit variable-pitch)
         )
        )
      )

;;;;; Load custom-file
(setq custom-file "~/.spacemacs.d/emacs-custom.el")
(load custom-file)
;; (setq custom-file (make-temp-file "emacs-custom"))

  ;;;;; END
) ;; end-of init
```


### User Environment {#user-environment}

Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls \`spacemacs/load-spacemacs-env' which loads the environment
variables declared in \`~/.spacemacs.env' or \`~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information.

```elisp
;;; User Environment

(defun dotspacemacs/user-env ()
  (spacemacs/load-spacemacs-env)
  )
```


## <span class="org-todo todo TODO">TODO</span> Custom Helper {#custom-helper}


### `START` Custom Helper {#start-custom-helper}

```elisp
;;; Custom Helper

```


### Custom Functions {#custom-functions}



```elisp
;;;;  Custom Functions

(defun delete-nth (index seq)
  "Delete the INDEX th element of SEQ.
   Return result sequence, SEQ __is__ modified."
  (if (equal index 0)
      (progn
        (setcar seq (car (cdr seq)))
        (setcdr seq (cdr (cdr seq))))
    (setcdr (nthcdr (1- index) seq) (nthcdr (1+ index) seq))))

(defun set-nth (index seq newval)
  "Set the INDEX th element of SEQ to NEWVAL.
   SEQ __is__ modified."
  (setcar (nthcdr index seq) newval))
```


### Check External Tools {#check-external-tools}



```elisp
;;;;  Check External Tools

;; Check exernal tools
(defun bool (val) (not (null val)))
;; Some packages do not work correctly on Emacs built with the LUCID feature
(defconst AG-P (bool (executable-find "ag")))
(defconst MPD-P (bool (and (executable-find "mpc") (executable-find "mpd"))))
(defconst MPV-P (bool (executable-find "mpv")))
(defconst REPO-P (bool (executable-find "repo")))
(defconst ZOTERO-P (bool (executable-find "zotero")))
```


### Custom Define `emacs-type` {#custom-define-emacs-type}

```elisp
;;;;  Custom Define 'emacs-type'

(defcustom emacs-type 'spacemacs
  "Select Emacs Distribution Types"
  :group 'emacs
  :type  '(choice
           (const :tag "spacemacs" spacemacs)
           (const :tag "minemacs" minemacs)
           (const :tag "doomemacs" doomemacs)
           (const :tag "vanillaemacs" vanillaemacs)))

(defun is-spacemacs() (eq emacs-type 'spacemacs))
(defun is-minemacs() (eq emacs-type 'minemacs))
(defun is-doomemacs() (eq emacs-type 'doomemacs))
(defun is-vanillaemacs() (eq emacs-type 'vanillaemacs))

;; (when (is-spacemacs) (message "I Love Spacemacs"))

;; /home/junghan/sync/man/dotsamples/korean/injae-dotfiles/module/+emacs.el
(defvar *is-mac*     (eq system-type 'darwin))
(defvar *is-windows* (eq system-type 'windows-nt))
(defvar *is-cygwin*  (eq system-type 'cygwin))
(defvar *is-linux*   (or (eq system-type 'gnu/linux) (eq system-type 'linux)))
(defvar *is-wsl*     (eq (string-match "Linux.*microsoft.*WSL2.*Linux" (shell-command-to-string "uname -a")) 0))
(defvar *is-unix*    (or *is-linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)))

;; Sample
;; (use-package ns-auto-titlebar
;; :if *is-mac*
```


### System Settings {#system-settings}


#### tramp and slow ssh {#tramp-and-slow-ssh}

/home/junghan/sync/man/dotsamples/vanilla/sqrt-dotfiles/Emacs.org
This section is about optioning the Emacs config.

The following is true if Emacs is meant to be used with TRAMP over slow ssh. Take a look at the TRAMP section for more details.

```elisp
(setq my/slow-ssh
      (or
       (string= (getenv "IS_TRAMP") "true")))
```

The following is true is Emacs is run on a remote server where I don't need stuff like my org workflow

```elisp
(setq my/remote-server
      (or (string= (getenv "IS_REMOTE") "true")
          (string= (system-name) "server1")
          (string= (system-name) "server2")
          (string= (system-name) "server3"))) ; for test
```

And the following is true if Emacs is run from termux on Android.

```elisp
;; (setq my/is-termux (string-match-p (rx (* nonl) "com.termux" (* nonl)) (getenv "HOME")))
```

Also, I sometimes need to know if a program is running inside Emacs (say, inside a terminal emulator). To do that, I set the following environment variable:

```elisp
(setenv "IS_EMACS" "true")
```


#### is-termux {#is-termux}

[Emacs Configuration - config.daviwil.com](https://config.daviwil.com/emacs)

```elisp
;; (require 'subr-x)
(setq my/is-termux
      (string-suffix-p "Android" (string-trim (shell-command-to-string "uname -a"))))
```


## Additional-packages {#additional-packages}

```emacs-lisp
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

(setq-default
 dotspacemacs-additional-packages
 '(
   all-the-icons ; compatibility
   conventional-changelog

   ;; phi-search ; ?
   ;; relint ; xr+relint Elisp regexp lint tool

   major-mode-hydra
   disk-usage

   org-reverse-datetree

   pangu-spacing

   fixed-page-mode

   keyfreq
   (command-log :location (recipe :fetcher github
                                  :repo "positron-solutions/command-log"))
   ;; (champagne :location (recipe :fetcher github
   ;;                              :repo "positron-solutions/champagne"))
   ;; (transient-showcase :location
   ;;                     (recipe :fetcher github
   ;;                             :repo "positron-solutions/transient-showcase"))

   ;; (dendroam :location (recipe :fetcher github :repo "vicrdguez/dendroam"))

   ;; (org-auctex :location (recipe :fetcher github "karthink/org-auctex"))
   ;; org-ql
   ;; org-sidebar

   direnv

   ;; (cal-korea-x :location (recipe :fetcher github :repo "cinsk/cal-korea-x"))
   ;; (typo :location (recipe :fetcher sourcehut :repo "pkal/typo")) ; TODO CHECK

    (dired-preview :location (recipe :fetcher github :repo "protesilaos/dired-preview"))

   ))
```


## User Config {#user-config}


### `Start` <span class="tag"><span class="donotmodify">donotmodify</span></span> {#start}

스페이스맥스 레이어를 사용하는 경우, 최대한 레이어를 추가할 때 설정한다.
사용자 정의 패키지는 여기서 설정한다. 좋다고 다 추가할 필요가 없다. 내가 수용할 수 있는 범위 내에서 추가한다.
Configuration function for user code. This function is called at the very end
of Spacemacs initialization after layers configuration. This is the place
where most of your configurations should be done. Unless it is explicitly
specified that a variable should be set before a package is loaded, you should
place your code here.

```elisp
;;; User Configuration

(defun dotspacemacs/user-config ()
```


### `Profile` USER-INFORMATION {#profile-user-information}

사용자가 여기만 설정하면 바로 사용할 수 있도록 한다.
<span class="timestamp-wrapper"><span class="timestamp">[2023-02-01 Wed 06:26]</span></span>


#### Profiles {#profiles}

나의 공개키는 다음 에서 확인 할수 있다.
<https://meta.sr.ht/~junghanacs.keys>, <https://meta.sr.ht/~junghanacs.pgp>

```elisp
(setq user-full-name "Junghan Kim"
      user-mail-address "junghanacs@gmail.com")
;; Set my GPG key as the default key
(setq-default epa-file-encrypt-to '("B5ADD9F47612A9DB"))
```


### Overide Spacemacs {#overide-spacemacs}

여기서 수정을 해야 반영이 될 것이다.
2023-05-02 spacemacs-default 및 관련 기본 패키지들은 대부분 defer 이다.
덮어쓰려면 사용자 설정에 넣어야 한다. 그래서 jh-base 의 설정 부분은
가져온다. 다른 레이어도 덮어 쓰는 부분은 다 확인해야 한다.


#### Default behavior {#default-behavior}

minemacs 설정을 가져온다. Emacs 28 이후에 추가된 기능이 반영되어 있어서
좋은 레퍼런스가 된다.
스페이스맥스 설정 값 중에 바꾸거나 변경할 것들을 기록한다.
간단한 것들 위주로 기록하고 양도 많고 복잡한 설정은 뒤에 추가한다.
프렉티컬리 설정을 먼저 가져온다. 스페이스맥스 닷파일에서 가져온게 의미 있다.

/home/junghan/sync/man/dotsamples/vanilla/minemacs/core/me-defaults.el
이 파일에 구성을 따라서 설정하자. 뒤에 설정한 내용들도 앞으로 끌어오자.
왜? Emacs 기본 설정이니까 여기서 잡는 게 맞다. 뒤에는 패키지 별로
설정하게 되는 것이니까. 물론 여기는 기존 Spacemacs 값들을 변경한다.
<span class="timestamp-wrapper"><span class="timestamp">[2023-01-29 Sun 07:56]</span></span>

```elisp
;; Line should be 80 characters wide, not 72 from corgi emacs
(setq-default
 ;; ====== Buffer-local variables ======
 ;; Display long lines
 truncate-lines nil
 ;; Default fill column width
 fill-column 80
 ;; Never mix, use only spaces
 indent-tabs-mode nil
 ;; Width for line numbers
 display-line-numbers-width 4
 ;; Small tab is enough!
 tab-width 2)


;; (setq auto-save-list-file-prefix "~/spacemacs/.cache/auto-save/")
(setq auto-save-interval 1500
      auto-save-timeout 180
      auto-save-visited-interval 90)

(setq
 ;; default shell
 ;; sh-shell 'bash
 ;; sh-indentation
 sh-basic-offset tab-width)

(setq
 ;; ====== Default behavior ======
 ;; Inhibit startup message
 ;; inhibit-startup-message t
 ;; Do not ring
 ;; ring-bell-function 'ignore
 ;; Increase the large file threshold to 50 MiB
 large-file-warning-threshold (* 50 1024 1024)

 ;; Initial scratch message (will be overridden if "fortune" is installed)
 ;; initial-scratch-message ";; MinEmacs -- start here!"
 ;; Set initial buffer to fundamental-mode for faster load
 ;; initial-major-mode 'fundamental-mode

 ;; Always prompt in minibuffer (no GUI)
 use-dialog-box nil
 ;; Use y or n instead of yes or no
 use-short-answers t
 ;; Confirm before quitting
 confirm-kill-emacs 'y-or-n-p
 ;; Filter duplicate entries in kill ring
 kill-do-not-save-duplicates t
 ;; Save existing clipboard text into the kill ring before replacing it.
 save-interprogram-paste-before-kill t

 ;; Save files only in sub-directories of current project
 ;; save-some-buffers-default-predicate 'save-some-buffers-root

 ;; Use single space between sentences
 sentence-end-double-space nil
 ;; Move stuff to trash
 delete-by-moving-to-trash t
 ;; Select help window for faster quit!
 help-window-select t
 ;; More info on completions
 completions-detailed t
 ;; Do not ask obvious questions, follow symlinks
 vc-follow-symlinks t
 ;; Use completing-read interface instead of definitions buffer (needs xref 1.1.0)
 xref-show-definitions-function #'xref-show-definitions-completing-read
 ;; Enable recursive calls to minibuffer
 ;; enable-recursive-minibuffers t ; default t
 ;; Kill the shell buffer after exit
 ;; shell-kill-buffer-on-exit t

 ;; ====== Passwords and encryption ======
 ;; Default auth-sources to GPG
 auth-sources '("~/.authinfo.gpg")
 ;; Enable password caching
 password-cache t
 ;; 10 minutes, default is 16 sec
 password-cache-expiry 600
 ;; Enable caching, do not keep asking about GPG key
 auth-source-do-cache t
 ;; All day, default is 2h (7200)
 auth-source-cache-expiry 86400

 ;; ====== Performances ======
 ;; Don’t compact font caches during GC
 inhibit-compacting-font-caches t
 ;; Increase single chunk bytes to read from subprocess (default 4096)
 read-process-output-max (if (eq system-type 'gnu/linux)
                             (condition-case nil
                                 ;; Android may raise permission-denied error
                                 (with-temp-buffer
                                   (insert-file-contents
                                    "/proc/sys/fs/pipe-max-size")
                                   (string-to-number (buffer-string)))
                               ;; If an error occured, fallback to the default value
                               (error read-process-output-max))
                           (* 1024 1024))

 ;; ====== Aesthetics and UI ======
 ;; Set to non-nil to flash!
 visible-bell nil

 ;; TODO 2023-06-19 왜 갑자기 클라이언트 프레임 사이즈가 이상하지?!
 ;; Do force frame size to be a multiple of char size
 frame-resize-pixelwise t

 ;; ;; Emacsclient does not use full frame size (NIL 필수!)
 frame-inhibit-implied-resize nil

 ;; Stretch cursor to the glyph width
 x-stretch-cursor t
 ;; Show trailing whitespaces
 show-trailing-whitespace t
 ;; Resize window combinations proportionally
 window-combination-resize t
 ;; Enable time in the mode-line
 ;; display-time-string-forms '((propertize (concat 24-hours ":" minutes)))
 ;; No ugly button for widgets
 widget-image-enable nil
 ;; Show unprettified symbol under cursor (when in `prettify-symbols-mode')
 ;; prettify-symbols-unprettify-at-point t
 ;; Make tooltips last a bit longer (default 10s)
 tooltip-hide-delay 20
 ;; Use small frames to display tooltips instead of the default OS tooltips
 use-system-tooltips nil

 ;; ====== Undo ======
 ;; 10MB (default is 160kB)
 undo-limit 10000000
 ;; 50MB (default is 240kB)
 undo-strong-limit 50000000
 ;; 150MB (default is 24MB)
 undo-outer-limit 150000000

 ;; ====== Editing ======
 ;; Hitting TAB behavior
 ;; tab-always-indent nil
 ;; Default behavior for `whitespace-cleanup'
 ;; whitespace-action '(cleanup auto-cleanup)
 ;; End files with newline
 require-final-newline t
 ;; Enable Drag-and-Drop of regions
 mouse-drag-and-drop-region t
 ;; Enable Drag-and-Drop of regions from Emacs to external programs
 mouse-drag-and-drop-region-cross-program t

 ;; ====== Scrolling ======
 ;; Do not adjust window-vscroll to view tall lines
 auto-window-vscroll nil
 ;; Fast scrolling
 fast-but-imprecise-scrolling t
 ;; Keep the point in the same position while scrolling
 scroll-preserve-screen-position t
 ;; Do not move cursor to the center when scrolling
 scroll-conservatively 101
 ;; Scroll at a margin of one line
 scroll-margin 1
 ;; Better scrolling on Emacs29+, specially on a touchpad
 pixel-scroll-precision-use-momentum t

 ;; 복붙만 한다.
 ;; ;; ====== Compilation ======
 ;; ;; Scroll compilation buffer
 ;; compilation-scroll-output t ; 'first-error can be a good option
 ;; ;; Always kill current compilation process before starting a new one
 ;; compilation-always-kill t
 ;; ;; Skip visited messages on compilation motion commands
 ;; compilation-skip-visited t
 ;; ;; Keep it readable
 ;; compilation-window-height 12
 ) ; end-of-setq

;; Kill minibuffer when switching by mouse to another window
;; Taken from: https://trey-jackson.blogspot.com/2010/04/emacs-tip-36-abort-minibuffer-when.html
;; (add-hook
;;  'mouse-leave-buffer-hook
;;  (defun +minibuffer--kill-on-mouse-h ()
;;    "Kill the minibuffer when switching to window with mouse."
;;    (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
;;      (abort-recursive-edit))))

;; Scroll pixel by pixel, in Emacs29+ there is a more pricise mode way to scroll
(if (>= emacs-major-version 29)
    (pixel-scroll-precision-mode 1)
  (pixel-scroll-mode 1))

;; Files with known long lines
;; SPC f l to open files literally to disable most text processing
;; So long mode when Emacs thinks a file would affect performance
(global-so-long-mode 1)

;; Easily navigate sillycased words
(global-subword-mode 1)

;; Emacs text rendering optimizations
;; https://200ok.ch/posts/2020-09-29_comprehensive_guide_on_handling_long_lines_in_emacs.html
;; Only render text left to right
(setq-default bidi-paragraph-direction 'left-to-right)

   ;;;;; org-clock-persist for share with machines
;; (setq org-clock-persist-file "~/sync/org/org-clock-save.el")
(setq org-clock-persist-query-save t)
(setq org-clock-persist-query-resume t)

;; 라인 컬럼 보여주는 검은 세로선
(if (display-graphic-p)
    (global-display-fill-column-indicator-mode))

;; /spacemacs/core/libs/ido-vertical-mode.el
;; 찾아서 꺼줘야 한다. Spacemacs 에서 자동으로 켜놓았네.
(ido-vertical-mode -1)
```


#### Garbage collection {#garbage-collection}

고수들마다 약간씩 다른 부분이 있다.
GC 메시지 출력, focus 나가면 GC 하자.

```elisp
;; Show a message when garbage collection happens? Useful while tuning the GC
(setq garbage-collection-messages t)
;; (add-function :after
;;               after-focus-change-function
;;               (lambda () (unless (frame-focus-state)
;;                            (garbage-collect))))
```


#### My configurations {#my-configurations}



kill-ring
: 클립보드 사이즈를 줄인다.

recentf
: recentf-exclude 설정 문제를 해결한다.
    내 마음대로 설정해야
    내가 필요한 파일만 남겨 둘 수 있다. 아이템 사이즈도 크게 한다.
    스페이스맥스 설정을 수정하여 기본 패스를 사용한다.
    10 분에 한번 씩 저장하게 한다. 스맥스는 IDLE 일때 저장하게 되어 있다.

history
: 1000 은 너무 많다. 느려진다. 적절하게 줄이자.

auto-revert-interval
: 주기를 늘린다.

<!--listend-->

```elisp
;; ====== Recent files ======
;; Increase the maximum number of saved items
;; Ignore case when searching recentf files
;; (setq recentf-case-fold-search t)
;; Exclude some files from being remembered by recentf
;; (setq recentf-max-saved-items 200) ; default 20
;; (add-to-list 'recentf-exclude ".gz")
;; (add-to-list 'recentf-exclude ".elc")

;; Show recursion depth in minibuffer (see `enable-recursive-minibuffers')
(minibuffer-depth-indicate-mode 1)

;; default 120 emacs-29, 60 emacs-28
(setq kill-ring-max 60) ; keep it small

;; automatically revert buffers for changed files
(setq auto-revert-interval 10) ; default 5

;; 22/11/26--06:50 :: golden-ratio
(setq golden-ratio-max-width 85)

;; 시간 표시 형식은 영어로 표시해서 호환성을 높입니다.
(setq system-time-locale "C")

;; Disable .# lock files
(setq create-lockfiles nil)

;; Ridiculous path view is vanilla emacs. change truename!
;; truename 을 원하지 않는다. 심볼링링크대로 쓰고 싶다. nil 로 사용한다.
(setq find-file-visit-truename t)

;; Shr group: Simple HTML Renderer를 의미한다. 여기 설정을 바꾸면 faces를 수정할 수 있음
(setq shr-use-fonts nil)

;; buffer size 를 표기 합니다.
(setq size-indication-mode t)
```


#### Frame and Scroll mode {#frame-and-scroll-mode}

28.2 에도 설정하는 변수가 있으나 공식적으로 29 부터 지원한다.

```elisp
;; Basic modes
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(menu-bar-mode -1)          ; Disable the menu bar

;; (column-number-mode +1)
;; (global-goto-address-mode +1) ; What is?
;; (global-visual-line-mode +1)
;; (delete-selection-mode +1)
;; (save-place-mode +1)

(unless my/is-termux
  ;; Read 'The Forgotten History of the Blinking Cursor'
  (blink-cursor-mode 1)

  ;; 2023-04-16 Learn how-to use menu-bar for beginner on GUI mode
  (when (display-graphic-p) ; gui
    ;; Give some breathing room
    (set-fringe-mode 10)
    ;; Mouse with context-menu
    (context-menu-mode 1)
    ;; Menu-bar
    ;; (menu-bar-mode 1)

    ;; Set up the visual bell
    (setq visual-bell t)
    )
  )

;; Don’t compact font caches during GC.
;; 이 설정 정말 중요하다. 특히 org-superstar 사용 시 필수!
(setq inhibit-compacting-font-caches t)

;; from writers-dot-spacemacs
;; (global-visual-line-mode 1)

;; (defun set-image-borderless ()
;;   (setq left-margin-width 0)
;;   (setq right-margin-width 0)
;;   (set-fringe-mode 0)
;;   (setq global-hl-line-mode nil)
;;   (image-transform-fit-to-height))
;; (add-hook 'image-mode-hook #'set-image-borderless)
```


#### Custom Functions {#custom-functions}



<!--list-separator-->

-  Popup-tips

    This function was found at [this site](http://blog.jenkster.com/2013/12/popup-help-in-emacs-lisp.html). This code is actually fairly simple, so
    Then we just call <kbd>popup-tip</kbd> to display it. This function does not function
    completely as expect yet as it show th results in a split window.

    ```elisp
    (defun my/describe-thing-in-popup ()
      (interactive)
      (let* ((thing (symbol-at-point))
             (help-xref-following t)
             (description (with-temp-buffer
                            (help-mode)
                            (help-xref-interned thing)
                            (buffer-string))))
        (popup-tip description
                   :point (point)
                   :around t
                   :height 30
                   :scroll-bar t
                   :margin t)))
    (spacemacs/set-leader-keys "hh" 'my/describe-thing-in-popup)
    ```


### <kbd>OVERIDE</kbd> :: `Keybindings` {#overide-keybindings}




#### Redefine `global-key` {#redefine-global-key}

```elisp
(global-set-key (kbd "C-M-i") 'completion-at-point)

;; false input
;; (global-unset-key (kbd "M-ESC ESC")) ; 'keyboard-escape-quit
(global-set-key (kbd "M-ESC ESC") 'keyboard-quit)

;; turn off kill emacs binding
(global-unset-key (kbd "C-x C-c")) ; save-buffer-and-kill-emacs

;; Kill this buffer now!
(global-set-key (kbd "M-S-q") 'spacemacs/kill-this-buffer)
;; 실수로 누르게 되는 빠른 종료 바인딩을 제거한다.
(spacemacs/set-leader-keys "qq" nil) ; prompt-kill-emacs

;; If you use a window manager be careful of possible key binding clashes
;; (global-set-key (kbd "M-<tab>") 'other-window) ; very useful
;; (global-set-key (kbd "M-<iso-lefttab>") (lambda() (interactive) (other-window -1))) ; == M-S-<tab>

;; Tab-bar with C-<tab> + more key bindings
;; (progn
;;   (global-set-key (kbd "s-\\") 'tab-bar-switch-to-tab)
;;   (global-set-key (kbd "s-[") 'tab-previous)
;;   (global-set-key (kbd "s-]") 'tab-next)
;;   (global-set-key (kbd "M-<f1>") '(lambda() (interactive) (tab-bar-select-tab 1)))
;;   (global-set-key (kbd "M-<f2>") '(lambda() (interactive) (tab-bar-select-tab 2)))
;;   (global-set-key (kbd "M-<f3>") '(lambda() (interactive) (tab-bar-select-tab 3)))
;;   (global-set-key (kbd "M-<f4>") '(lambda() (interactive) (tab-bar-select-tab 4)))
;;   (global-set-key (kbd "M-<f5>") '(lambda() (interactive) (tab-bar-select-tab 5)))
;;   (global-set-key (kbd "M-<f6>") '(lambda() (interactive) (tab-bar-select-tab 6)))
;;   (global-set-key (kbd "M-<f7>") '(lambda() (interactive) (tab-bar-select-tab 7)))
;;   )

;; TODO Check!
;; (global-set-key (kbd "C-s-0") 'spacemacs/switch-to-minibuffer-window)
;; (global-set-key (kbd "C-1") 'kill-this-buffer)
;; (global-set-key (kbd "C-<down>") (kbd "C-u 1 C-v"))
;; (global-set-key (kbd "C-<up>") (kbd "C-u 1 M-v"))
;; (global-set-key (kbd "M-/") #'hippie-expand)
;; (global-set-key (kbd "C-x C-j") 'dired-jump) ; what is?
;; (global-set-key (kbd "C-c r") 'remember) ; what is?

;; Confession time: vi's killing up to a char is better than emacs, so let's change things.
;; default 는 zap-to-char 인데 뭐가 다른가?!
;; (global-set-key (kbd "M-z") #'zap-up-to-char)

```


#### My Commands <span class="tag"><span class="mycustom">mycustom</span></span> {#my-commands}

```elisp
;; C-c
(global-set-key (kbd "C-c j a") 'my/open-abbrev-defs)
(global-set-key (kbd "C-c j c") 'my/open-dotspacemacs-org)
(global-set-key (kbd "C-c j d") 'my/open-hunspell-personal)
(global-set-key (kbd "C-c j D") 'my/open-dict-ko-mydata)
(global-set-key (kbd "C-c j t") 'my/open-tempel-templates)
(global-set-key (kbd "C-c j e") 'my/open-elfeed-list)
(global-set-key (kbd "C-c j q") 'my/open-fortune-quotes)
(global-set-key (kbd "C-c j r") 'my/open-dotsamples-readme)

(global-set-key (kbd "C-c j C") 'my/open-csaroid-list)
;; (global-set-key (kbd "C-c j i") 'my/open-IAM-org)
;; (global-set-key (kbd "C-c j w") 'my/open-dotworkflow-org)
;; (global-set-key (kbd "C-c j s") 'my/open-capture-inbox)

(global-set-key (kbd "C-c j h") 'my/browse-hugo-maybe)

;; 여기에 관리해야 하는 파일 더 넣어야 할 지도 glossary tags url people

```


#### Consult keybinding {#consult-keybinding}



<!--list-separator-->

-  global key

    <span class="timestamp-wrapper"><span class="timestamp">[2023-05-05 Fri 18:49]</span></span>
    global key

    ```elisp
    (global-set-key (kbd "M-s b") 'consult-buffer)
    (global-set-key (kbd "M-g t") 'consult-minor-mode-menu)
    ```

<!--list-separator-->

-  spacemacs key

    ```elisp
    ;; (setq-default completion-in-region-function #'consult-completion-in-region)
    (spacemacs/set-leader-keys "bb" 'consult-buffer) ; replace spacemacs's default

    (spacemacs/set-leader-keys "ss" nil)
    (spacemacs/declare-prefix "ss"  "Consult-List★")
    (spacemacs/declare-prefix "sss"  "Search★")
    (spacemacs/declare-prefix "ssr"  "Register★")
    (spacemacs/declare-prefix "ssf"  "File/Dir★")
    (spacemacs/declare-prefix "ssp"  "Project★")
    (spacemacs/declare-prefix "ssz"  "Help★")
    (spacemacs/set-leader-keys
      "ss." 'consult-man
      "ss#" #'consult-register
      ;; "ss/" #'spacemacs/compleseus-search-projectile-auto
      ;; "ss*" #'spacemacs/compleseus-search-default

      "ssa"  #'consult-org-agenda
      "ssb"  #'spacemacs/compleseus-switch-to-buffer
      "ssB"  #'consult-buffer
      "ssc"  #'consult-flycheck
      "ssC"  #'consult-flymake

      ;; "ssd"  #'consult-dir
      "ssD"  #'consult-dash

      "sse" #'consult-complex-command

      ;; "ssf" '✩File/Path✩'
      ;; "ssff"  #'consult-find
      "ssff"  #'spacemacs/compleseus-find-file
      "ssfr"  #'consult-recent-file
      "ssfl"  #'consult-locate

      "ssg"  #'consult-git-grep
      "ssG"  #'consult-git-log-grep

      "ssh"  #'consult-history

      "ssi"  #'consult-imenu
      "ssI"  #'consult-imenu-multi

      "ssj" #'consult-mark
      "ssJ" #'consult-global-mark


      "ssk" #'consult-keep-lines
      "ssK" #'consult-kmacro

      "ssl"  #'consult-line
      "ssL"  #'spacemacs/consult-line-multi
      ;; "ssL"  #'consult-line-multi

      "ssm"  #'consult-bookmark

      "ssn"  #'spacemacs/consult-jump-in-buffer

      "sso"  #'consult-outline
      "ssO"  #'consult-org-heading

      ;;  "ssp"  '✩Project✩'
      "sspb" #'consult-projectile-switch-to-buffer
      "sspd" #'consult-projectile-find-dir
      "sspf" #'consult-projectile-find-file
      "sspo" #'consult-projectile
      "sspr" #'consult-projectile-recentf
      "sspp" #'consult-projectile-switch-project

      ;; "ssq"

      ;; "ssr" '✩Register✩'
      "ssrr" #'consult-register
      "ssrl" #'consult-register-load
      "ssrs" #'consult-register-store

      ;; "sss" '✩Search✩'
      "ssss"  #'consult-ripgrep
      "sssf" #'spacemacs/compleseus-search-auto
      "sssd" #'spacemacs/compleseus-search-dir
      ;; "sssp" #'spacemacs/compleseus-search-projectile
      "sssg" #'consult-goto-line

      "sst" #'consult-minor-mode-menu

      "ssu" #'consult-focus-lines

      "ssv" #'consult-isearch-history
      "ssV" #'consult-isearch-forward

      ;; "ssw" #'consult-eglot-symbols

      "ssx" #'consult-lsp-symbols
      "ssX" #'consult-lsp-diagnostics

      "ssy"  #'consult-yank-from-kill-ring
      "ssY" #'consult-yasnippet

      ;; "ssz" '✩Help✩'
      "ssza"  #'consult-apropos
      "sszt"  #'consult-theme
      "sszi"  #'consult-info
      )
    ```


#### Spacemacs <kbd>root</kbd> bindings {#spacemacs-root-bindings}

<span class="timestamp-wrapper"><span class="timestamp">[2023-05-06 Sat 05:06]</span></span>
/home/junghan/spacemacs/layers/+spacemacs/spacemacs-defaults/keybindings.el

```elisp

(spacemacs/declare-prefix
  "!"   "shell cmd"
  "\""  "terminal here"
  "#"   "register"
  "'"   "open shell"
  "*"   "search w/"
  "/"   "search w/o"
  "0"   "treemacs"
  ";"   "latest-popup"
  ":"   "kill-last-popup"
  "?"   "show bindings"
  "a"   "applications"
  "b"   "buffers"
  "c"   "codes"
  "C"   "Capture/Colors"
  "d"   "debug"
  "D"   "Diff/Compare"
  "e"   "errors"
  ;; "E"   "Export"
  "f"   "files"
  "F"   "Frames"
  "g"   "git/vc"
  "h"   "help"
  "i"   "insertion"
  "j"   "jump/join"
  "k"   "lisp"
  "K"   "Macros"
  "l"   "layouts"
  "m"   "major-mode"
  "n"   "narrow/numbers"
  "N"   "Navigation"
  "o"   "user bindings"
  "p"   "projects"
  "P"   "Pandoc/export"
  "q"   "quit"
  "r"   "regs/rings"
  "s"   "search/symbol"
  "S"   "Spelling"
  "t"   "toggles"
  "T"   "Themes/UI"
  "C-t" "toggles(2)"
  "C-v" "rectangles"
  "u"   "universals"
  "v"   "er/expand"
  "w"   "windows"
  "x"   "text"
  "z"   "zoom"

  "<up>"   "window↑"
  "<down>"   "window↓"
  "<left>"   "window←"
  "<right>"   "window→"
  )
```


#### Spacemacs <kbd>major-mode</kbd> bindings : Org-mode {#spacemacs-major-mode-bindings-org-mode}



```elisp

;; Org-mode (citar and org-roam)
(spacemacs/declare-prefix-for-mode 'org-mode "mB" "bib/citar")
(spacemacs/set-leader-keys-for-major-mode 'org-mode
  "iT" 'bh/insert-inactive-timestamp
  "ic" 'citar-insert-citation
  "Bi" 'citar-insert-citation
  "Bn" 'citar-create-note
  "Bo" 'citar-open-note
  "Ba" 'citar-org-roam-ref-add
  "er" 'org-reveal-export-to-html
  "ep" 'org-hugo-export-wim-to-md
  )

```


#### ace-link conflicts with evil-collection {#ace-link-conflicts-with-evil-collection}

<span class="timestamp-wrapper"><span class="timestamp">[2023-05-21 Sun 11:41]</span></span>
evil-collection 을 추가해서 좋은데 충돌나는게 있기 마련.
수정해주면 된다.

```elisp
(evil-define-key 'normal Info-mode-map "o" 'ace-link-info)
;; 혹시 아래서도 안되면 위와 같이 잡아주라
;; (with-eval-after-load 'help-mode
;;   (define-key help-mode-map "o" 'ace-link-help))
;; (with-eval-after-load 'woman
;;   (define-key woman-mode-map "o" 'link-hint-open-link))
;; (with-eval-after-load 'eww
;;   (define-key eww-link-keymap "o" 'ace-link-eww)
;;   (define-key eww-mode-map "o" 'ace-link-eww)))))
```


#### evil tunning {#evil-tunning}

<span class="timestamp-wrapper"><span class="timestamp">[2023-05-21 Sun 13:04] </span></span> When I want to make a substitution, I want it to be
global more often than not --- so let's make that the default.

Now, EVIL cares a fair bit about keeping compatibility with Vim's default
behaviour. I don't. There are some particular settings that I'd rather be
something else, so let's change them.

```elisp
(setq evil-move-cursor-back nil)     ; Don't move the block cursor when toggling insert mode
(setq evil-kill-on-visual-paste nil) ; Don't put overwritten text in the kill ring

;; https://emacs.stackexchange.com/questions/39434/evil-dont-yank-with-only-whitespace-to-register/53536#53536
(with-eval-after-load 'evil-org
  (define-key evil-normal-state-map "x" 'delete-forward-char)
  (define-key evil-normal-state-map "X" 'delete-backward-char)
  (evil-define-key 'normal 'evil-org-mode "x" 'delete-forward-char)
  (evil-define-key 'normal 'evil-org-mode "X" 'delete-backward-char)
  )

;; (with-eval-after-load 'evil-maps
;;   (evil-global-set-key 'normal "C-=" 'er/expand-region)
;;   )
```


#### projectile `C-x p` {#projectile-c-x-p}

먼저 project built-in 에 의존성이 있는 패키지들을 제거한다. 예를 들어
multi-vterm, consult-dir 등이다. 그래야 프로젝타일로 키바인딩이 매끄럽게 적용이
된다.

```elisp
(define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
;; (setq projectile-project-search-path '("~/workspace/" "~/workspace/github" ("~/Exercism/emacs-lisp/" . 1)))
```


#### `def-custom` Spacemacs key bindings {#def-custom-spacemacs-key-bindings}

<span class="timestamp-wrapper"><span class="timestamp">[2023-04-23 Sun 04:41]</span></span>
phundrak-dotfiles/org/config/Deprecated/spacemacs.org

As you will see, I defined a LOT of custom keybindings. All of them are
Spacemacs keybindings, defined in a way they can be used seamlessly with Evil.
They almost all begin with <kbd>o</kbd>, which is a prefix reserved for user-defined
keybindings so they won’t conflict with any package. Let’s declare it like so.

However this one I use often, generally in org or text buffers.

```elisp
(spacemacs/set-leader-keys "o9" 'sort-lines)
;; (spacemacs/set-leader-keys "ow" 'eww)

;; Revert buffer - loads in .dir-locals.el changes
(spacemacs/set-leader-keys "oR" 'revert-buffer)
```

옮길 것 KEY BINDING
<span class="timestamp-wrapper"><span class="timestamp">[2023-05-10 Wed 11:18]</span></span>

```elisp
(spacemacs/set-leader-keys "oo" 'outline-minor-mode)
(spacemacs/set-leader-keys "o1" 'fontaine-set-preset)
(spacemacs/set-leader-keys "o2" 'fontaine-set-face-font)
```


#### <span class="org-todo todo TODO">TODO</span> Spacemacs <kbd>custom</kbd> bindings {#spacemacs-custom-bindings}

스페이스맥스에서 제거한 부분을 대체하는 빌트인 패키지 키 바인딩을
담는다. 메타 키를 몰라도 Spacemacs 키로 다 할 수 있어야 한다.

```elisp
(spacemacs/set-leader-keys
  "pm"      'magit-project-status
  )

(spacemacs/set-leader-keys "tS" #'text-scale-mode)

(spacemacs/declare-prefix "aoB"  "Bib/citar")
(spacemacs/set-leader-keys
  "aoBn" 'citar-create-note
  "aoBo" 'citar-open-note)
```


### HYDRA {#hydra}




#### Hydra for Major-mode {#hydra-for-major-mode}

<span class="timestamp-wrapper"><span class="timestamp">[2023-03-10 Fri 10:31]</span></span>
Hydra is useful for doing lots of things in succession.

```elisp
(require 'major-mode-hydra)
(require 'all-the-icons)

;; Before hydra because we use pretty-hydra-define in the hydra confg.
(setq major-mode-hydra-invisible-quit-key "q")
(setq major-mode-hydra-title-generator
      '(lambda (mode)
         (s-concat "\n"
                   (s-repeat 10 " ")
                   (all-the-icons-icon-for-mode mode :v-adjust 0.05)
                   " "
                   (symbol-name mode)
                   " commands")))
;; Mode maps
(major-mode-hydra-define org-mode
  (:title "Org-mode" :color amaranth :separator "=" :quit-key "<escape>")
  ("Movement"
   (("u" org-up-element "up" :exit nil)
    ("n" org-next-visible-heading "next visible heading" :exit nil)
    ("p" org-previous-visible-heading "previous visible heading" :exit nil)
    ("l" org-next-link "next link" :exit nil)
    ("L" org-previous-link "previous link" :exit nil)
    ("b" org-next-block "next block" :exit nil)
    ("B" org-prev-block "previous block" :exit nil)
    ("g" org-mark-ring-goto "pop mark" :exit nil))
   "Subtrees" (("k" org-cut-subtree "kill")
               (">" org-demote-subtree "demote" :exit nil)
               ("<" org-promote-subtree "promote" :exit nil)
               ("N" org-narrow-to-subtree "narrow")
               ("r" org-refile "refile")
               ("." org-tree-to-indirect-buffer "indirect buffer")
               ("'" org-id-get-create "create id"))
   "Inserting" (("c" citar-insert-citation "insert citation")
                ("e" org-expiry-insert-expiry "insert expiry property")
                ("i" org-insert-heading-respect-content "insert heading")
                ("y" ash/org-paste-link "yank link" :exit t))
   "Opening" (("o" org-open-at-point "open at point"))
   "Clock" (("P" org-pomodoro "Start pomodoro")
            ("Q" ash/org-pomodoro-til-meeting "Start pomodoro til half hour"))
   "Roam" (("-" org-roam-buffer-toggle "Backlinks" :toggle t)
           (";" org-roam-node-insert "add link")
           (":" ash/org-roam-node-insert-immediate "add link immediately")
           ("#" org-roam-tag-add "add tag")
           ("a" org-roam-alias-add "add alias")
           ("r" my/org-roam-node-from-cite "add reference note")
           ("R" org-roam-ref-add "add ref"))))

(major-mode-hydra-define emacs-lisp-mode
  (:title "Emacs-Lisp-mode" :color blue :separator "=" :quit-key "<escape>")
  ("Eval"
   (("b" eval-buffer "eval buffer")
    (";" eval-expression "eval expression")
    ("d" eval-defun "eval defun")
    ("D" edebug-defun "edebug defun")
    ("e" eval-last-sexp "eval last sexp")
    ("E" edebug-eval-last-sexp "edebug last sexp")
    ("l" ielm "ielm"))
   "Test"
   (("t" ert "prompt")
    ("T" (ert t) "all")
    ("F" (ert :failed) "failed"))
   "Doc"
   (("f" describe-function "function")
    ("v" describe-variable "variable")
    ("i" info-lookup-symbol "info lookup")))
  )

(major-mode-hydra-define clojure-mode
  (:title "Clojure-mode" :color pink :separator "=" :quit-key "<escape>")
  ("Load"
   (("k" cider-load-buffer "buffer" :exit nil)
    ("l" cider-load-file "file" :color red))))

(major-mode-hydra-define eshell-mode
  (:title "Eshell-mode" :color pink :separator "=" :quit-key "<escape>")
  ("Movement"
   (("h" consult-history "history" :exit t))))
```


#### Hydra All-Body {#hydra-all-body}

major-mode-hydra 패키지에 포함되어 있다. 따로 정리한다.
<span class="timestamp-wrapper"><span class="timestamp">[2023-03-10 Fri 10:32]</span></span>

```elisp
;; define everything here
(require 'pretty-hydra)
(require 's)
(require 'all-the-icons)
;; with-faicon function allows an icon in hydra title. Requires following requires and aliases. To omit don't include 'with-faicon' in appearance-title
;; define an icon function with all-the-icons-faicon
;; to use filecon, etc, define same function with icon set
(defun with-faicon (icon str &rest height v-adjust)
  (s-concat (all-the-icons-faicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))
(defun with-fileicon (icon str &rest height v-adjust)
  (s-concat (all-the-icons-fileicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))

  ;;;;; hydra-jumps
(pretty-hydra-define hydra-jumps ()
  ("Jump visually"
   (("j" avy-goto-word-1 "to word" :exit t)
    ("l" avy-goto-line "to line" :exit t)
    ("c" avy-goto-char "to char" :exit t)
    ("r" avy-resume "resume" :exit t))
   "Jump via minibuffer"
   (("i" consult-imenu "imenu" :exit t)
    ("o" consult-outline "outline" :exit t))
   "Jump & go"
   (("u" ash/avy-goto-url "open url" :exit t))
   "Misc"
   (("=" hydra-all/body "back" :exit t))))

  ;;;;; hydra-structural
(pretty-hydra-define hydra-structural ()
  ("Change"
   (
    ("," puni-slurp-forward "slurp-forward")
    ("." puni-barf-forward "barf-forward")
    ("]" puni-slurp-forward "slurp-backward")
    ("[" puni-barf-forward "barf-backward")
    ("." puni-splice "splice")
    ("?" puni-convolute "convolute"))
   "Movement"
   (("a" puni-beginning-of-sexp "beginning of sexp")
    ("e" puni-end-of-sexp "end of sexp")
    (")" puni-syntactic-forward-punc "down sexp")
    ("(" puni-syntactic-backward-punc "up sexp"))
   "Formatting"
   (("z" puni-squeeze "squeeze/unwrap"))
   "Misc"
   (("=" hydra-all/body "back" :exit t))))

  ;;;;; hydra-multiple-cursors
(pretty-hydra-define hydra-multiple-cursors ()
  ("Mark via region"
   (("l" mc/edit-lines "edit lines" :exit t)
    ("s" mc/mark-all-in-region-regexp "mark all in region re" :exit t))
   "Mark"
   (("a" mc/mark-all-like-this "mark all" :exit t)
    ("d" mc/mark-all-dwim "mark dwim" :exit t))
   "Mark incrementally"
   (("n" mc/mark-next-like-this "mark next like this")
    ("N" mc/skip-to-next-like-this "skip to next like this")
    ("M-n" mc/unmark-next-like-this "unmark next like this")
    ("p" mc/mark-previous-like-this "mark previous like this")
    ("P" mc/skip-to-previous-like-this "skip to previous like this")
    ("M-p" mc/unmark-previous-like-this "unmark previous like this")
    ("L" mc/mark-next-lines "mark next lines"))
   "Insert"
   (("0" mc/insert-numbers "insert numbers" :exit t)
    ("A" mc/insert-letters "insert letters" :exit t))
   "Misc"
   (("=" hydra-all/body "back" :exit t))))

  ;;;;; hydra-expand
(pretty-hydra-define hydra-expand ()
  ("Expand/Contract"
   (("e" er/expand-region "expand")
    ("c" er/contract-region "contract"))
   "Expand to..."
   (("d" er/mark-defun "defun")
    ("\"" er/mark-inside-quotes "quotes")
    ("'" er/mark-inside-quotes "quotes")
    ("p" er/mark-inside-pairs "pairs")
    ("." er/mark-method-call "call"))
   "Misc"
   (("=" hydra-all/body "back" :exit t))))

  ;;;;; hydra-ekg
;; (pretty-hydra-define hydra-ekg ()
;;   ("Navigation"
;;    (("t" ekg-show-notes-for-today "today" :exit t)
;;     ("g" ekg-show-notes-with-tag "tag" :exit t)
;;     ("r" ekg-show-notes-latest-captured "latest" :exit t)
;;     ("b" ekg-embedding-show-similar-to-current-buffer "similar to buffer" :exit t)
;;     ("s" ekg-embedding-search "search" :exit t))
;;    "Capture"
;;    (("c" ekg-capture)
;;     ("u" ash/capture-literature-note))
;;    ))

  ;;;;; hydra-yas
(pretty-hydra-define hydra-yas ()
  ("Snippets"
   (("n" yas-new-snippet "new" :exit t)
    ("r" yas-reload-all "reload" :exit t)
    ("v" yas-visit-snippet-file "visit" :exit t))
   "Movement"
   (("f" yas-next-field "forward field" :exit nil)
    ("b" yas-prev-field "previous field" :exit nil))))

  ;;;;; hydra-flycheck
(pretty-hydra-define hydra-flycheck ()
  ("Movement"
   (("n" flymake-goto-next-error "next error")
    ("p" flymake-goto-prev-error "previous error")
    ("d" flymake-goto-diagnostic "diagnostic")
    ("<" flycheck-previous-error "previous flycheck error")
    (">" flycheck-next-error "next flycheck error")
    ("l" flycheck-list-errors "list")
    ("." consult-flymake))
   "Display"
   (("." flymake-show-diagnostic "show diagnostic")
    ("B" flymake-show-diagnostics-buffer "diagnostics buffers"))
   "Misc"
   (("=" hydra-all/body "back" :exit t))))

  ;;;;; hydra-mail
;; notmuch is too specialized to be set up here, it varies from machine to
;; machine. At some point I should break it down into the general &
;; specialized parts.
(defun ash/inbox ()
  (interactive)
  (notmuch-search "tag:inbox" t))
(pretty-hydra-define hydra-mail ()
  ("Search"
   (("s" notmuch-search "search" :exit t)
    ("h" consult-notmuch "incremental search" :exit t))
   "Application"
   (("n" notmuch-hello "notmuch" :exit t)
    ("i" ash/inbox "inbox" :exit t)
    ("c" notmuch-mua-new-mail "compose" :exit t))
   "Misc"
   (("=" hydra-all/body "back" :exit t))))

  ;;;;; hydra-org-main
(pretty-hydra-define hydra-org-main ()
  ("Misc"
   (("a" org-agenda "agenda" :exit t)
    ("c" org-capture "capture" :exit t))
   "Links"
   (("s" org-store-link "store" :exit t))))

  ;;;;; hydra-find
(pretty-hydra-define hydra-find ()
  ("In-Buffer"
   (("i" consult-imenu "imenu" :exit t)
    ("m" consult-mark "mark rings" :exit t)
    ("o" consult-multi-occur "occur" :exit t)
    ("e" consult-flycheck "errors" :exit t)
    ("l" consult-goto-line "line" :exit t))
   "Other"
   (("r" consult-ripgrep "grep" :exit t)
    ("b" consult-bookmark "bookmark" :exit t)
    ("R" consult-register "register" :exit t)
    ("C" consult-complex-command "complex command" :exit t))))

  ;;;;; hydra-toggles
;; (defvar hydra-toggles--title (with-faicon "toggle-on" "Toggles"))
;; (pretty-hydra-define hydra-toggles
;;   (:color amaranth :quit-key "<espace>" :title hydra-toggles--title)
(pretty-hydra-define hydra-toggles ()
  ("Basic"
   (("n" linum-mode "line number" :toggle t)
    ("w" whitespace-mode "whitespace" :toggle t)
    ("W" whitespace-cleanup-mode "whitespace cleanup" :toggle t)
    ("r" rainbow-mode "rainbow" :toggle t)
    ("L" page-break-lines-mode "page break lines" :toggle t))
   "Highlight"
   (("s" symbol-overlay-mode "symbol" :toggle t)
    ("l" hl-line-mode "line" :toggle t)
    ("x" highlight-sexp-mode "sexp" :toggle t)
    ("t" hl-todo-mode "todo" :toggle t))
   "Coding"
   (
    ;; ("p" smartparens-mode "smartparens" :toggle t)
    ;; ("P" smartparens-strict-mode "smartparens strict" :toggle t)
    ;; ("S" show-smartparens-mode "show smartparens" :toggle t)
    ("f" flycheck-mode "flycheck" :toggle t))
   "Emacs"
   (("D" toggle-debug-on-error "debug on error" :toggle (default-value 'debug-on-error))
    ("X" toggle-debug-on-quit "debug on quit" :toggle (default-value 'debug-on-quit)))))

  ;;;;; hydra-all
(pretty-hydra-define hydra-all
  (:quit-key "<escape>" :title "All")
  ("Applications"
   (("m" hydra-mail/body "mail" :exit t)
    ("o" hydra-org-main/body "org" :exit t)
    ;; ("k" hydra-ekg/body "ekg" :exit t)
    ("S" hydra-straight/body "straight" :exit t)
    ;; ("!" ash/el-secretario-daily-review "secretary" :exit t)
    ("g" magit-status "magit" :exit t))
   "Editing"
   (("c" hydra-multiple-cursors/body "multiple cursors" :exit t)
    ("s" hydra-structural/body  "structural" :exit t)
    ("e" hydra-expand/body "expand region" :exit t)
    ("y" hydra-yas/body "snippets" :exit t))
   "Movement"
   (("j" hydra-jumps/body "jumps" :exit t)
    ("E" hydra-flycheck/body "errors" :exit t)
    ("G" deadgrep "grep" :exit t))
   "Misc"
   (("t" hydra-toggles/body "toggles" :exit t)
    ("f" hydra-find/body "find" :exit t))))
```


#### Hydra Jump to directory and files {#hydra-jump-to-directory-and-files}



```elisp
(defhydra
  hydra-jump-to-directory
  (:color amaranth)
  "Jump to directory"
  ("b" (find-file "~/git/blog") "Blog")
  ("c" (find-file "~/sync/obsd/cheat") "Cheat")
  ("C" (find-file "~/sync/org/csaoid") "Csaoid")
  ("d" (find-file "~/.spacemacs.d/dot-org") "Dot-org")
  ("D" (find-file "~/sync/man/dotsamples") "DotSamples")
  ("r" (find-file "~/sync/org/roam") "Org-roam")
  ("s" (find-file "~/.spacemacs.d/snippets/") "Snippets")
  ("v" (find-file "~/Videos") "Videos")
  ("p" (find-file "~/Pictures") "Pictures")
  ("q" nil "Quit" :color blue)) ; Add :color blue

(defhydra hydra-jump-to-system-file
  (:color amaranth)
  "Jump to system file"
  ("a" (find-file "~/sync/org/workflow/inbox.org") "inbox.org")
  ("b" (find-file "~/.zshrc") ".zshrc")
  ("u" (find-file "~/sync/org/elfeed/elfeed.org") "elfeed.org")
  ("q" nil "Quit" :color blue)) ; Add :color blue

(defhydra my-org-hydra
  (:color amaranth)
  "Org mode commands"
  ("a" org-agenda "org-agenda")
  ("l" org-agenda-list "org-agenda-list")
  ("f" find-agenda-file "find agenda file")
  ;; ("w" cfw:open-org-calendar "open-org-calendar")
  ("c" calendar "calendar")
  ("q" nil "Quit" :color blue))
```


#### Hydra keybinding {#hydra-keybinding}



```elisp
(global-set-key (kbd "<f1>") 'hydra-all/body)
(global-set-key (kbd "C-c C") 'hydra-all/body)
(global-set-key (kbd "<f2>") 'major-mode-hydra)
(global-set-key (kbd "M-g 0") 'major-mode-hydra)
(global-set-key (kbd "<f3>") 'hydra-jump-to-directory/body)
(global-set-key (kbd "M-g 1") 'hydra-jump-to-directory/body)
(global-set-key (kbd "M-g 2") 'hydra-jump-to-system-file/body)
;; (global-set-key (kbd "M-g 3") 'my-org-hydra/body)
;; (global-set-key (kbd "M-g j") 'dumb-jump-hydra/body) ; FYI
```


### KOREAN HANGUL {#korean-hangul}


#### pangu-spacing {#pangu-spacing}

<span class="timestamp-wrapper"><span class="timestamp">[2023-05-07 Sun 19:29]</span></span>
은 는 이 가 -- 조사만 빼면 좋으련만 이러한 접근이 더 깔끔하다고 본다.
오탈자 안나니까.

```elisp

;; (add-to-list 'load-path "~/sync/emacs/emacs-pkgs/pangu-spacing/")

;; /home/junghan/nosync/emacs-pkgs/emacs-29-git/lisp/emacs-lisp/rx.el
;; /home/junghan/spacemacs/layers/+intl/japanese/packages.el
(use-package pangu-spacing
  :init
  (progn ;; replacing `chinese-two-byte' by `japanese'
    (setq pangu-spacing-include-regexp
          ;; we didn't add korean because korean-hangul-two-byte is not implemented
          (rx (or (and (or (group-n 3 (any "。，！？；：「」（）、"))
                           (group-n 1 (or (in "가-힣")
                                          ;; (category korean-hangul-two-byte)
                                          (category chinse-two-byte)
                                          ;; (category japanese-hiragana-two-byte)
                                          ;; (category japanese-katakana-two-byte)
                                          )))
                       (group-n 2 (in "a-zA-Z0-9")))
                  (and (group-n 1 (in "a-zA-Z0-9"))
                       (or (group-n 3 (any "。，！？；：「」（）、"))
                           (group-n 2 (or (in "가-힣")
                                          ;; (category korean-hangul-two-byte)
                                          (category chinse-two-byte)
                                          ;; (category japanese-hiragana-two-byte)
                                          ;; (category japanese-katakana-two-byte)
                                          )))))))
    (spacemacs|hide-lighter pangu-spacing-mode)
    ;; Always insert `real' space in text-mode including org-mode.
    (setq pangu-spacing-real-insert-separtor t)
    ;; (global-pangu-spacing-mode 1)
    (add-hook 'text-mode-hook 'pangu-spacing-mode)))


;; (defun japanese/post-init-org ()
;;   (defadvice org-html-paragraph (before org-html-paragraph-advice
;;                                         (paragraph contents info) activate)
;;     "Join consecutive Japanese lines into a single long line without
;; unwanted space when exporting org-mode to html."
;;     (let* ((origin-contents (ad-get-arg 1))
;;            (fix-regexp "[[:multibyte:]]")
;;            (fixed-contents
;;             (replace-regexp-in-string
;;              (concat
;;               "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)") "\\1\\2" origin-contents)))
;;       (ad-set-arg 1 fixed-contents))))
```


#### word-select {#word-select}

<span class="timestamp-wrapper"><span class="timestamp">[2023-05-14 Sun 14:04]</span></span>
단어 선택(?) 무슨 역할인가?

```elisp
;; =============================================================================
;; my-select-word
;; (based on https://superuser.com/a/901624)
;; =============================================================================

(defun my-get-word-boundary ()
  "Return the boundary of the current word.
The return value is of the form: (cons pos1 pos2)."
  (save-excursion
    (let (p1 p2)
      (progn
        (skip-chars-backward "-가-힣 A-Za-z0-9_.") ;; here you can choose which symbols to use
        (setq p1 (point))
        (skip-chars-forward "-가-힣 A-Za-z0-9_.") ;; put the same here
        (setq p2 (point)))
      (cons p1 p2))))

(defun my-select-word ()
  "Mark the url under cursor."
  (interactive)
  (let (bds)
    (setq bds (my-get-word-boundary))
    (set-mark (car bds))))

(global-set-key [double-mouse-1] 'my-select-word)
```


#### <span class="org-todo done OFF">OFF</span> cal-korea-x <span class="tag"><span class="OFF">OFF</span></span> {#cal-korea-x}

한글 레이어에서 가져옴. 사용 안함.

```elisp
;; (use-package cal-korea-x
;;   :init
;;   (setq calendar-week-start-day 1) ; 1 Monday
;;   (add-hook 'calendar-today-visible-hook 'calendar-mark-today)
;;   (add-hook 'calendar-today-visible-hook 'calendar-mark-holidays)
;;   :config
;;   (progn
;;     (setq calendar-holidays cal-korea-x-korean-holidays)

;;     (copy-face 'default 'calendar-sunday-face)
;;     (copy-face 'default 'calendar-saturday-face)
;;     (set-face-attribute 'calendar-sunday-face nil
;;                         :foreground "#ff4500")
;;     (set-face-attribute 'calendar-saturday-face nil
;;                         :foreground "#eeee00")

;;     (define-advice calendar-generate-month
;;         (:after (month year indent) highlight-weekend-days)
;;       "Highlight weekend days"
;;       (mapcar
;;        (lambda (n)
;;          (let ((date (list month (1+ n) year)))
;;            (cond ((= (calendar-day-of-week date) 0)
;;                   (calendar-mark-visible-date date 'calendar-sunday-face))
;;                  ((= (calendar-day-of-week date) 6)
;;                   (calendar-mark-visible-date date 'calendar-saturday-face)))))
;;        (number-sequence 1 31)))

;;     (copy-face 'default 'calendar-iso-week-header-face)
;;     (copy-face 'calendar-iso-week-header-face 'calendar-iso-week-number-face)
;;     (set-face-attribute 'calendar-iso-week-header-face nil
;;                         :foreground "black"
;;                         :height 1.0)
;;     (set-face-attribute 'calendar-iso-week-number-face nil
;;                         :foreground "black"
;;                         :height 1.0)

;;     (setq calendar-intermonth-header
;;           (propertize "Wk"                  ; or e.g. "KW" in Germany
;;                       'font-lock-face 'calendar-iso-week-header-face))

;;     (setq calendar-intermonth-text
;;           '(propertize
;;             (format "%2d"
;;                     (car
;;                      (calendar-iso-from-absolute
;;                       (calendar-absolute-from-gregorian (list month day year)))))
;;             'font-lock-face 'calendar-iso-week-number-face))
;;     ))
```


### <span class="org-todo todo TODO">TODO</span> Migration the layer {#migration-the-layer}

<span class="timestamp-wrapper"><span class="timestamp">[2023-04-04 Tue 18:31]</span></span>
옮긴 패키지들


#### `Only` Emacs 29+ {#only-emacs-29-plus}

elisp :tangle (if (&gt;= emacs-major-version 28) "yes" "no")

```elisp
;; Use built-in packages
;; (if (> emacs-major-version 28)
;;     (require 'emacsql-sqlite-builtin))

;; Parentheses (show-paren-mode)
(if (> emacs-major-version 28)
    (setq show-paren-context-when-offscreen 'overlay)) ; default nil
```


#### Useful functions {#useful-functions}

Emacs doesn't have 64-bit-int processing except via calc.

```elisp
(defun ash/strdec-to-hex (n)
  "Given a decimal as a string, convert to hex.
This has to be done as a string to handle 64-bit or larger ints."
  (concat "0x" (replace-regexp-in-string "16#" "" (calc-eval `(,n calc-number-radix 16)))))
```


#### Direnv {#direnv}



```elisp
(use-package direnv
  :config
  (direnv-mode))
```


#### Command-log {#command-log}

<span class="timestamp-wrapper"><span class="timestamp">[2023-05-14 Sun 15:15]</span></span>
/home/junghan/spacemacs/layers/+tools/command-log/packages.el
커맨드로그 레이어를 사용하지 않고 아래 패키지를 넣는다.

키 바인딩은 맞춰주는게 좋을 것 같다. 그리고
(spacemacs/declare-prefix "atK" "keycast")
(spacemacs/set-leader-keys "atKm" #'keycast-mode-line-mode)
(spacemacs/set-leader-keys "atKh" #'keycast-header-line-mode)
(spacemacs/set-leader-keys "atKt" #'keycast-tab-bar-mode)
(spacemacs/declare-prefix "atl" "command log")
(spacemacs/set-leader-keys "atll" #'global-command-log-mode))

제외할 수 있는 함수가 있는가?
(setq clm/log-command-exceptions\* (append clm/log-command-exceptions\*
'(evil-next-line
evil-previous-line
evil-forward-char
evil-backward-char))
command-log-mode-auto-show t)))

```elisp
(use-package command-log
  :custom
  (command-log-window-text-scale 2 "Command log two steps higher text scale")
  (command-log-logging-shows-buffer t "Toggling will show the buffer.")
  (command-log-hiding-disables-logging t "Toggling visible buffer turns off logging.")
  (command-log-disabling-logging-kills-buffer t "The buffer will be new when displayed again.")
  (command-log-filter-commands '(self-insert-command) "Be chatty.
     Show everything besides self-insert-command")
  ;; Auto-enable with global minor mode (including minibuffer)
  (command-log-log-globally nil)
  )
```


#### Keyfreq {#keyfreq}

```elisp
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)
```


#### Screenshot `PNG GIF` {#screenshot-png-gif}

<span class="timestamp-wrapper"><span class="timestamp">[2023-06-08 Thu 14:33]</span></span>
잘된다.

```elisp
(global-set-key (kbd "<f6>") 'gif-screencast-start-or-stop)
```

<!--list-separator-->

- <span class="org-todo done OFF">OFF</span>  min emacs <span class="tag"><span class="OFF">OFF</span></span>

    ```elisp
    (defcustom +screenshot-delay 5
      "A delay to wait before taking the screenshot.
    Applicable only when calling `+screenshot-svg' with a prefix."
      :group 'minemacs-utils
      :type 'number)

    ;; Inspired by: reddit.com/r/emacs/comments/idz35e/comment/g2c2c6y
    ;;;###autoload
    (defun +screenshot-svg (outfile)
      "Save a screenshot of the current frame as an SVG image.
    Saves to a temp file and puts the filename in the kill ring. If launched with a
    prefix or universal argument, it waits for a moment (defined by
    `+screenshot-delay') before taking the screenshot."
      (interactive "FSave to file: ")
      (let ((outfile (file-name-with-extension outfile "svg")))
        (if current-prefix-arg
            (run-with-timer +screenshot-delay nil (apply-partially #'+screenshot-svg--take-screenshot outfile))
          (+screenshot-svg--take-screenshot outfile))))

    (defun +screenshot-svg--take-screenshot (&optional outfile)
      (let* ((tmp-file (make-temp-file "emacs-" nil ".svg"))
             (data (x-export-frames nil 'svg)))
        (with-temp-file tmp-file (insert data))
        (when (stringp outfile) (copy-file tmp-file outfile))
        (message "Screenshot saved to %s" (or outfile tmp-file))))
    ```


### Utility {#utility}




#### disk-usage {#disk-usage}

```elisp
(use-package disk-usage :ensure :after evil-collection :defer t)

;; 잘 되지만, 버퍼를 닫으면

;;;###autoload
(defun describe-word (word &optional prefix)
  "Briefly describe WORD entered by user. With PREFIX argument,
  show verbose descriptions with hyperlinks."
  (interactive "sDescribe word: \nP")
  (shell-command (concat "dict " word (cond ((null prefix) nil)
                                            (t " -v")))))

;;;###autoload
(defun describe-word-at-point (&optional prefix)
  "Briefly describe word at point. With PREFIX argument, show
  verbose descriptions with hyperlinks."
  (interactive "P")
  (let ( (word
          (if (region-active-p)
              (buffer-substring (region-beginning)
                                (region-end))
            (thing-at-point 'word))) )
    (shell-command (concat "dict " (cond ((null prefix) nil)
                                         (t "-f "))
                           word))))
```


#### kimim functions {#kimim-functions}



```elisp
;; unfill paragraph: the opposite of fill-paragraph
(defun kimim/unfill-paragraph-or-region (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))

;; generate timestamp such as 2016_1031_ for file name
(defun kimim/genfile-timestamp()
  (concat (format-time-string "%Y%m%d")
          (char-to-string (+ 65 (random 26)))
          (char-to-string (+ 65 (random 26)))
          "_"))

;; self define functions
(defun kimim/imenu-default-goto-function-advice (orig-fun &rest args)
  (apply orig-fun args)
  (recenter))

(defun now () (interactive)
       (insert (shell-command-to-string "date")))

(defun day ()
  "Insert string for today's date nicely formatted in American style,
    e.g. Sunday, September 17, 2000."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%A, %B %e, %Y")))

(defun today ()
  "Insert string for today's date nicely formatted in American style,
    e.g. 2000-10-12."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%Y-%m-%d")))

(defun today-pretty ()
  "Insert string for today's date nicely formatted in American style,
    e.g. 2000-10-12."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%A, %b %d, %Y")))

(defun toyear ()
  "Insert string for today's date nicely formatted in American style,
    e.g. 2000."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%Y")))


(defun get-file-line ()
  "Show (and set kill-ring) current file and line"
  (interactive)
  (unless (buffer-file-name)
    (error "No file for buffer %s" (buffer-name)))
  (let ((msg (format "%s::%d"
                     (file-truename (buffer-file-name))
                     (line-number-at-pos))))
    (kill-new msg)
    (message msg)))

(defun get-file-link ()
  "Show (and set kill-ring) current file"
  (interactive)
  (unless (buffer-file-name)
    (error "No file for buffer %s" (buffer-name)))
  (let ((msg (format "file:\\\\%s" (replace-regexp-in-string "/" "\\\\"
                                                             (file-truename (buffer-file-name))))))
    (kill-new msg)
    (message msg)))
```


#### search-engine : engine-mode {#search-engine-engine-mode}



```elisp
;; Set variables for search-engine layer
(spacemacs/set-leader-keys "s w s" 'engine/search-stack-overflow)
(spacemacs/set-leader-keys "s w e" 'engine/search-ecosia)
(spacemacs/set-leader-keys "s w d" 'engine/search-duck-duck-go)
(spacemacs/set-leader-keys "s w g" 'engine/search-github)
(spacemacs/set-leader-keys "s w i" 'engine/search-spacemacs-issues)
(spacemacs/set-leader-keys "s w M" 'engine/search-google-maps)
(spacemacs/set-leader-keys "s w b" 'engine/search-project-gutenberg)
(spacemacs/set-leader-keys "s w a" 'engine/search-wolfram-alpha)
(spacemacs/set-leader-keys "s w w" 'engine/search-wikipedia)
(spacemacs/set-leader-keys "s w m" 'engine/search-melpa)

(add-hook 'spacemacs-post-user-config-hook #'engine-mode)

;; (define-key global-map (kbd "C-x /") 'engine-mode-map)
```


#### conventional-changelog {#conventional-changelog}

사용법을 알야아 쓴다.
<https://github.com/liuyinz/emacs-conventional-changelog>

```elisp
(use-package conventional-changelog
  :init
  (with-eval-after-load 'magit-tag
    (transient-append-suffix 'magit-tag
      '(1 0 -1)
      '("c" "changelog" conventional-changelog-menu))))

(spacemacs/set-leader-keys "g/" 'conventional-changelog-menu)
```


#### <span class="org-todo done OFF">OFF</span> wc-mode  : word-count <span class="tag"><span class="OFF">OFF</span></span> {#wc-mode-word-count}



```elisp
(use-package wc-mode :ensure)
(setq wc-modeline-format "[Words: %tw, Chars: %tc]")
;; (add-hook 'org-mode-hook 'wc-mode)

(defun my/word-count (arg)
  (interactive "r")
  (count-words arg)
  )
```


#### dired-preview {#dired-preview}

<span class="timestamp-wrapper"><span class="timestamp">[2023-07-06 Thu 10:45]</span></span>
정식 등록 되면 옮기자.

```elisp
  (use-package dired-preview
    :after dired
    :demand
    :config
    ;; (add-hook 'dired-mode-hook #'dired-preview-mode)
    (spacemacs/set-leader-keys-for-major-mode 'dired-mode
      "p" 'dired-posframe-mode)
  )
```


### <kbd>Org-mode</kbd> Customizations {#org-mode-customizations}




#### <kbd>HUGO</kbd> Tunning {#hugo-tunning}

사이드 노트 테스트
{{< sidenote >}}
ox-hugo 관련 추가 설정이다. 매우매우 중요하다.
{{< /sidenote >}}
```text
절대 export 태그 넣지 마라! shortcode 내보내기 안된다.
```

This should be set for everything. I like to keep the last modified date, but
only consider things to be modified if 12 hours have passed.

```elisp
(with-eval-after-load 'ox-hugo
  (setq org-hugo-auto-set-lastmod t
        org-hugo-suppress-lastmod-period 43200.0)
  (setq org-hugo-section "notes")
  (setq org-hugo-paired-shortcodes "hint details mermaid sidenote")

  ;; https://ox-hugo.scripter.co/doc/formatting/
  ;; if org-hugo-use-code-for-kbd is non-nil
  ;; Requires CSS to render the <kbd> tag as something special.
  ;; eg: ~kbd~
  (setq org-hugo-use-code-for-kbd t)

  ;; https://ox-hugo.scripter.co/doc/linking-numbered-elements/
  ;; org-export-dictionary 에 Figure, Table 에 한글 번역을 넣으면
  ;; 한글로 바뀌어 export 될 것이다.
  (setq org-hugo-link-desc-insert-type t)

  ;; Assume all static files are images for now otherwise this
  ;; defaults to /ox-hugo/mypicture.png which is ugly
  (setq org-hugo-default-static-subdirectory-for-externals "imgs")

  ;; Override the default `org-hugo-export-creator-string' so that this
  ;; string is consistent in all ox-hugo tests.
  (setq org-hugo-export-creator-string "Emacs + Org mode + ox-hugo")

  ;; In that normal example of the sidenote, ox-hugo trims the whitespace around
  ;; the sidenote block. That is configured by customizing the
  ;; org-hugo-special-block-type-properties variable:
  (add-to-list 'org-hugo-special-block-type-properties '("sidenote" . (:trim-pre t :trim-post t)))

  ;; If this property is set to an empty string, this heading will not be auto-inserted.
  ;; default value is 'References'
  ;; https://ox-hugo.scripter.co/doc/org-cite-citations/
  (plist-put org-hugo-citations-plist :bibliography-section-heading "References")
  )

;; export this file on buffer
(spacemacs/set-leader-keys "Pe" #'org-export-dispatch)
(spacemacs/set-leader-keys "Pr" #'org-reveal-export-to-html)
(spacemacs/set-leader-keys "Pp" #'org-hugo-export-wim-to-md)
```


#### org-breadcrumb {#org-breadcrumb}

<span class="timestamp-wrapper"><span class="timestamp">[2023-05-18 Thu 16:37]</span></span>
이거 괜찮네. 내가 필요했던 게 이건데.
sticky-header 를 쓰는게 좋지 않겠어?!

```elisp
(setq org-refile-use-outline-path 'file) ; default nil
(setq org-outline-path-complete-in-steps nil)

(defun ndk/heading-title ()
  "Get the heading title."
  (save-excursion
    (if (not (org-at-heading-p))
        (org-previous-visible-heading 1))
    (org-element-property :title (org-element-at-point))))

(defun ndk/org-breadcrumbs ()
  "Get the chain of headings from the top level down
    to the current heading."
  (let ((breadcrumbs (org-format-outline-path
                      (org-get-outline-path)
                      (1- (frame-width))
                      nil " > "))
        (title (ndk/heading-title)))
    (if (string-empty-p breadcrumbs)
        ;; title
        (propertize (format " * %s" title) 'face 'org-level-7)
      ;; (format "%s" breadcrumbs)
      (propertize (format " * %s" breadcrumbs) 'face 'org-level-8)
      )))

(setq header-line-indent-width 2)
(defun ndk/set-header-line-format()
  (setq header-line-format '(:eval (ndk/org-breadcrumbs))))

;; ;; http://emacsredux.com/blog/2014/04/05/which-function-mode/
;; (which-function-mode)
;; ;; when editing js file, this feature is very useful
;; (setq-default header-line-format
;;               '((which-func-mode ("" which-func-format " "))))

(add-hook 'org-mode-hook #'ndk/set-header-line-format)

```


#### org-attach (built-in) {#org-attach--built-in}

<span class="timestamp-wrapper"><span class="timestamp">[2023-05-18 Thu 16:39]</span></span>
I was using org-download but switched to the built-in org-attach in 2022. I use
.dir-locals.el to customize org-attach-id-dir if necessary.

```elisp
(require 'org-attach)
(setq org-attach-id-dir "attach")
(setq org-attach-use-inheritance t)

;; Use timestamp as ID and attachment folder. See https://helpdeskheadesk.net/2022-03-13/
;; (setq org-id-method 'ts)
;; (setq org-attach-id-to-path-function-list
;;       '(org-attach-id-ts-folder-format
;;         org-attach-id-uuid-folder-format))
;; Shorten the Org timestamp ID
;; (setq org-id-ts-format "%Y%m%dT%H%M%S")

;; (global-set-key (kbd "<f1>")
;;                 (lambda ()
;;                   (interactive)
;;                   (consult-org-heading nil '("~/sync/org/workflow/inbox.org"))))

```


#### <span class="org-todo todo TODO">TODO</span> org-capture-goto-link {#org-capture-goto-link}



```elisp
;; /home/junghan/.emacs.tshu/lisp/lang-org.el
(defun org-capture-goto-link ()
  (interfative)
  (let ((file (nth 1 (org-capture-get :target)))
        (headline (plist-get org-store-link-plist :description))
        (link (plist-get org-store-link-plist :link)))
    (org-capture-put :target (list 'file+headline file headline))
    (widen)
    (goto-char (point-min))
    (let (case-fold-search)
      (if (re-search-forward
           (format org-complex-heading-regexp-format
                   (regexp-quote headline)) nil t)
          (org-end-of-subtree)
        (org-capture-put :flag t)
        (goto-char (point-max))
        (or (bolp) (insert "\n"))
        (insert "* TODO " headline "\n")
        (insert "[[" link "]]\n")
        (point)))))
```


#### org-reverse-datetree {#org-reverse-datetree}

[GitHub - akirak/org-reverse-datetree](https://github.com/akirak/org-reverse-datetree)
[An Annotated Spacemacs - For an org-mode workflow ·](https://out-of-cheese-error.netlify.app/spacemacs-config)

tshu 에서 가져왔다. capture review format 으로 괜찮은 것 같다.
reverse 가 어떤 효과가 있는지 모르겠다만. 정렬을 하면 규칙이 생기니까.
그리고 위에 spacemacs dot 에는 capture examples 이 있다.

```elisp
;; (defun jh-org/init-org-reverse-datetree ()
(use-package org-reverse-datetree
  :after org
  :commands (org-datetree-refile)
  :init
  (setq-default org-reverse-datetree-level-formats '("%Y" "%Y-%m %B" "%Y W%W" "%Y-%m-%d %A"))
  :config
  (setq diary-file "~/sync/org/workflow/log.org") ; calendar
  (setq org-agenda-bulk-custom-functions '((?R org-datetree-refile)))
  (defun org-datetree-refile ()
    (interactive)
    (org-reverse-datetree-refile-to-file org-log-file))
  )

(dolist (template
         `(
           ("w" "Web" plain (file+function org-inbox-file org-capture-goto-link)
            "%i\n%U\n%T\n%a\n" :empty-lines 1 :immediate-finish t)

           ("d" "Memo on Daylog" entry (file+function org-log-file
                                                      org-reverse-datetree-goto-date-in-file)
            "\n* %<%H:%M> - %?\n%T\n%a\n") ; :prepend t

           ("D" "Clocking on Daylog (clock-in)" entry (file+function org-log-file
                                                                     org-reverse-datetree-goto-date-in-file)
            "\n* %<%H:%M> - %?\n%a\n" :clock-in t :clock-resume t) ; :prepend t
           ;; "* %?\n" :clock-in t :clock-resume t :empty-lines 1)

           ("c" "Contacts" entry (file org-contacts-files)
            "* %(org-contacts-template-name)
  :PROPERTIES:
  :GITHUB:
  :EMAIL:
  :URL:
  :END:\n%U\n%T\n%a\n")

           ("R"  "Review")
           ("Ry" "Yesterday" plain
            (file+function org-log-file
                           (lambda () (org-reverse-datetree-goto-date-in-file
                                       (time-add (current-time) (days-to-time -1)))))
            "%?\n%i\n" :immediate-finish t :jump-to-captured t)
           ("Rt" "Today" plain
            (file+function org-log-file
                           (lambda () (org-reverse-datetree-goto-date-in-file)))
            "%?\n%i\n" :immediate-finish t :jump-to-captured t)
           ("Rl" "Last Week" plain
            (file+function org-log-file
                           (lambda () (let ((org-reverse-datetree-level-formats
                                             (butlast org-reverse-datetree-level-formats)))
                                        (org-reverse-datetree-goto-date-in-file
                                         (time-add (current-time) (days-to-time -7))))))
            "%?\n%i\n" :immediate-finish t :jump-to-captured t)
           ("Rw" "This Week" plain
            (file+function org-log-file
                           (lambda () (let ((org-reverse-datetree-level-formats
                                             (butlast org-reverse-datetree-level-formats)))
                                        (org-reverse-datetree-goto-date-in-file))))
            "%?\n%i\n" :immediate-finish t :jump-to-captured t)
           ("RD" "Select a Date" plain
            (file+function org-log-file
                           org-reverse-datetree-goto-read-date-in-file)
            "%?\n%i\n" :immediate-finish t :jump-to-captured t)
           ("RW" "Select a Week" plain
            (file+function org-log-file
                           (lambda () (let ((org-reverse-datetree-level-formats
                                             (butlast org-reverse-datetree-level-formats)))
                                        (org-reverse-datetree-goto-read-date-in-file))))
            "%?\n%i\n" :immediate-finish t :jump-to-captured t)
           ("RM" "Select a Month" plain
            (file+function org-log-file
                           (lambda () (let ((org-reverse-datetree-level-formats
                                             (butlast org-reverse-datetree-level-formats 2)))
                                        (org-reverse-datetree-goto-read-date-in-file))))
            "%?\n%i\n" :immediate-finish t :jump-to-captured t)
           ("RY" "Select a Year" plain
            (file+function org-log-file
                           (lambda () (let ((org-reverse-datetree-level-formats
                                             (butlast org-reverse-datetree-level-formats 3)))
                                        (org-reverse-datetree-goto-read-date-in-file))))
            "%?\n%i\n" :immediate-finish t :jump-to-captured t)))
  (add-to-list 'org-capture-templates template)
  )
```


#### fixed-page-mode {#fixed-page-mode}

<span class="timestamp-wrapper"><span class="timestamp">[2023-06-09 Fri 03:25]</span></span>
A page-based text editing/note taking/concept thinking Emacs minor
mode.  Presents buffer's content as pages of predefined number of
lines (50 by default).  It is an analog of pages in a notebook.  It
can be used with org mode or any other text mode.
[GitHub - emacsmirror/fixed-page-mode: A fixed page length...](https://github.com/emacsmirror/fixed-page-mode)

매우 유용하다. 애용하자.

```elisp
(use-package fixed-page-mode
  :ensure
  :init
  (setq fixed-page-length 100)
  )

(global-set-key (kbd "C-x n n") #'fixed-page-mode)
(spacemacs/set-leader-keys "nn" #'fixed-page-mode)
```


#### Reveal export {#reveal-export}

By default reveal is rather nice, there are just a few tweaks that I consider a
good idea.
/home/junghan/sync/man/dotsamples/doom/tecosaur-dot-doom/config.org

```elisp
(setq org-re-reveal-theme "white"
      org-re-reveal-transition "slide"
      org-re-reveal-plugins '(markdown notes math search zoom))
```


### <kbd>Startup</kbd> Layout and Workspace {#startup-layout-and-workspace}


#### LAYOUT-WORKSPACE -- `SPC l` <span class="tag"><span class="layout">layout</span></span> {#layout-workspace-spc-l}

레이아웃을 잡아놓고 사용하자. 일단 테스트부터 하자.

기본 레이아웃
: nothing
    -   @Org(o), @Notmuch(n), @Spacemacs(e)

추가 레이아웃
: -   @elFeed(f), @Python(p)
    -   ...

<!--listend-->

```elisp
;; ;;;;; Load  Permachine Layout
;; (my-define-custom-layout-per-machine) ; permachine.el

(spacemacs|define-custom-layout "@Agenda"
  :binding "a"
  :body

  (spacemacs/window-split-single-column)

  (find-file "~/sync/org/workflow/inbox.org")
  ;; (spacemacs/toggle-current-window-dedication)
  (split-window-right-and-focus)

  (find-file "~/sync/org/workflow/project.org")
  ;; (spacemacs/toggle-current-window-dedication)
  (split-window-right-and-focus)

  (org-agenda nil " ")
  (spacemacs/toggle-current-window-dedication)
  )

(spacemacs|define-custom-layout "@Roam"
  :binding "r"
  :body
  ;; (find-file "~/sync/org/roam")
  (spacemacs/window-split-single-column)
  (find-file "~/sync/org/roam/_index.org") ; Blog Index

  (split-window-right-and-focus)
  (org-roam-node-random)

  ;; (dired-sidebar-toggle-sidebar)
  (org-roam-buffer-toggle)
  )

(spacemacs|define-custom-layout "@Blog"
  :binding "b"
  :body
  (find-file "~/git/blog/config.yaml")
  (spacemacs/window-split-single-column)
  ;; (dired-sidebar-toggle-sidebar)
  ;; hugo prodigy
  )

(spacemacs|define-custom-layout "@Feed"
  :binding "f"
  :body
  (elfeed)
  (spacemacs/window-split-single-column)
  ;; (split-window-below-and-focus)
  ;; (find-file "~/sync/org/elfeed/elfeed.org")
  ;; (pocket-reader)
  )

;; (spacemacs|define-custom-layout "@Python"
;;   :binding "p"
;;   :body
;;   (find-file "*path to upper left file*")
;;   (split-window-right) ;; Create the right side but don't move focus
;;   (split-window-below-and-focus) ;; Split the left side into two and move focus
;;   (find-file "*path to lower left file*")
;;   (winum-select-window-3) ;; Go to the top right window
;;   (find-file "*path to upper right file*")
;;   (split-window-below-and-focus) ;; Split the right side into two and move focus
;;   (find-file "*path to lower right file*")
;;   (winum-select-window-1) ;; Move focus back to the first window (optional)
;;   )
```


### <span class="org-todo todo TODO">TODO</span> Macros {#macros}


#### Mirror buffer {#mirror-buffer}

```elisp
;; (defalias 'ash/mirror-buffer
;;   (kmacro "C-x 1 C-x 3 C-x o"))
;; (general-define-key "s-b" 'ash/mirror-buffer)
```


#### save-macro {#save-macro}



```elisp
;; Save a recorded macro with a name
(defun save-macro (name)
  "Takes a name as argument and save the last defined macro under
   this name at the end of your .emacs"
  (interactive "SName of the macro :")  ; ask for the name of the
                                        ; macro
  (kmacro-name-last-macro name)         ; use this name for
                                        ; the macro
  (find-file user-init-file)            ; open ~/.emacs
                                        ; or other user init file
  (goto-char (point-max))               ; go to
                                        ; the end of the .emacs
  (newline)                             ; insert a newline
  (insert-kbd-macro name)               ; copy the macro
  (newline)                             ; insert a newline
  (switch-to-buffer nil))               ; return to the initial buffer
```


### Backports Emacs 29 Plus {#backports-emacs-29-plus}

```elisp
  ;;;;  Backports Emacs 29 Plus

;; HACK: Load Emacs 29 back ports for earlier Emacs versions. Note that I do
;; only back port a very small number of the functions/variables that I use at
;; early stage from Emacs29+ to be compatible with Emacs 28.2. For any Emacs
;; version less than 29,
(if (< emacs-major-version 29)
    (require 'my-backports-29))
```


### `End` <span class="tag"><span class="donotmodify">donotmodify</span></span> {#end}

```elisp
)
```


## Local Variables <span class="tag"><span class="ARCHIVE">ARCHIVE</span></span> {#local-variables}
