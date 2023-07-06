+++
title = "태그와 카테고리: 도대체 어떻게 구성해야 하는가🌱"
author = ["Junghan Kim"]
date = 2022-10-07T14:50:00+09:00
publishDate = 2023-07-06
lastmod = 2023-06-23
keywords = ["notes", "draft", "seedling"]
draft = false
+++

{{< hint info >}}
이건 정말 어마어마한 문제로다.
{{< /hint >}}

<!--more-->


## org-mode :: tag and category {#org-mode-tag-and-category}

어떻게 태그와 카테고리로 파일을 구성 할 것인가? 그룹으로 묶어서 태그 시스템을
단계화 하는 전략도 좋을 것 같다.


## refile {#refile}

‘C-c C-w’ (‘org-refile’)
     Refile entry or region to a different location.  See \*note Refile
     and Copy::.


## Document Structure {#document-structure}


### Sparse Tree {#sparse-tree}

(setq org-agenda-custom-commands
      '(("f" occur-tree "FIXME")))

defines the key ‘f’ as a shortcut for creating a sparse tree matching
the string ‘FIXME’.

-   variable ‘org-list-demote-modify-bullet’.  To get a greater difference


### Drawers {#drawers}

   You can also arrange for state change notes (see \*note Tracking TODO
state changes::) and clock times (see \*note Clocking Work Time::) to be
stored in a ‘LOGBOOK’ drawer.  If you want to store a quick note there,
in a similar way to state changes, use

‘C-c C-z’
     Add a time-stamped note to the ‘LOGBOOK’ drawer.


### Categories {#categories}

11.4.1 Categories
The category is a broad label assigned to each agenda item.  By default,
the category is simply derived from the file name, but you can also
specify it with a special line in the buffer, like this:

   The display in the agenda buffer looks best if the category is not
longer than 10 characters.  You can set up icons for category by
customizing the ‘org-agenda-category-icon-alist’ variable.

There are multiple ways to set the category.  One way is to set
it in the document property drawer.  For example:

:CATEGORY: ELisp

Other ways to define it is as an Emacs file variable, for example

or for the file to contain a special line:

If the file does not specify a category, then file's base name
is used instead.


### Tags {#tags}

‘#+FILETAGS: :tag1:tag2:tag3:’
    Set tags that all entries in the file inherit from, including the top-level entries.


### Setupfile {#setupfile}

‘#+SETUPFILE: file’

The setup file or a URL pointing to such file is for additional in-buffer settings. Org loads this file and parses it for any settings in it only when Org opens the main file. If URL is specified, the contents are downloaded and stored in a temporary file cache. C-c C-c on the settings line parses and loads the file, and also resets the temporary file cache. Org also parses and loads the document during normal exporting process. Org parses the contents of this document as if it was included in the buffer. It can be another Org file. To visit the file—not a URL—use C-c ' while point is on the line with the file name.


### ‘#+TAGS: TAG1(c1) TAG2(c2)’ {#plus-tags-tag1--c1--tag2--c2}

These lines (several such lines are allowed) specify the valid tags in this file, and (potentially) the corresponding fast tag selection keys. The corresponding variable is org-tag-alist.


## 태그 시스템 그 자체가 엄청나게 중요하고 어려운 주제다 {#태그-시스템-그-자체가-엄청나게-중요하고-어려운-주제다}

잠시만.


#### 태그 규칙 참고 {#태그-규칙-참고}

[How to Use Tags](https://karl-voit.at/2022/01/29/How-to-Use-Tags/) :: 아주 좋은 연구 수준에서의 아티클

-   가능한 한 적은 수의 태그를 사용하십시오.
-   자체 정의된 태그 집합으로 자신을 제한하십시오.
-   세트 내의 태그는 겹치지 않아야 합니다.
-   관례상 태그는 복수형입니다.
-   태그는 소문자입니다.
-   태그는 단일 단어입니다.
-   일반적인 수준에서 태그를 유지합니다.
-   명백한 태그는 생략합니다.


## Insert Heading categories Examples {#insert-heading-categories-examples}

```emacs-lisp
;; http://article.gmane.org/gmane.emacs.orgmode/10256
(defun org-get-heading-title ()
  "Returns the heading of the current entry as a string, without the leading stars, the TODO keyword or the tags."
  (let ((title-with-props (org-get-heading t))
        (keyword (org-get-todo-state)))
    (substring-no-properties title-with-props (if keyword (1+ (length keyword))))))

(defun org-insert-heading-category ()
  "Insert a :CATEGORY: property and it's value to the PROPERTY drawer at point."
  (interactive)
  (let ((point (point)))
    (org-entry-put point "CATEGORY" (org-get-heading-title))))

(defun org-insert-heading-categories-all ()
  "Insert :CATEGORY: properties to each headlines indented level 2."
  (interactive)
  (org-map-entries
   (lambda ()
     (if (eq 2 (org-current-level))
         (org-insert-heading-category)))))
```


## tags-alist {#tags-alist}

여기에 추가해라. FILETAGS 가 될거야.

```emacs-lisp

    (setq org-tag-alist
          '((:startgroup)
            ;; Put mutually exclusive tags here
            (:endgroup)
            ("@home" . ?H)
            ("@work" . ?W)
            ("private" . ?P)))
```


## Ox-Hugo Sample {#ox-hugo-sample}

<span class="timestamp-wrapper"><span class="timestamp">[2023-06-23 Fri 13:03]</span></span>
/home/junghan/git/scripter.co/content-org/scripter-posts.org
이게 무슨 스타일인가?!

```text
#+tags: [ @emacs : @org org @elisp ]
#+tags: [ @web : @hugo css ]
,
#+tags: [ @org : ox_hugo ]
#+tags: [ @hugo : ox_hugo ]
,
#+tags: [ git : magit ]
```


## 스크린샷 {#스크린샷}


### refile - journal copy {#refile-journal-copy}

괜찮은 방법이다. 코드가 필요한가?
그러니까. 저널에 투두가 있을 필요가 없이 refile 에서 다 끝낸다는 전략인데?!
생각해보자. 캡처는 다 refile 로 가니까. 맞는 것 같기도하고.

리파일에 다 몰아 둘거면 refile 을 잘해야 한다.

{{< figure src="/imgs/20221007-1959-screenshot.png" >}}

```emacs-lisp
  (defun my/copy-idlink-to-clipboard() "Copy an ID link with the
headline to killring, if no ID is there then create a new unique
ID.  This function works only in org-mode or org-agenda buffers.

The purpose of this function is to easily construct id:-links to
org-mode items. If its assigned to a key it saves you marking the
text and copying to the killring."
       (interactive)
       (when (eq major-mode 'org-agenda-mode) ;switch to orgmode
     (org-agenda-show)
     (org-agenda-goto))
       (when (eq major-mode 'org-mode) ; do this only in org-mode buffers
     (setq mytmphead (nth 4 (org-heading-components)))
         (setq mytmpid (funcall 'org-id-get-create))
     (setq mytmplink (format "[[id:%s][%s]]" mytmpid mytmphead))
     (kill-new mytmplink)
     (message "Copied %s to killring (clipboard)" mytmplink)
       ))

(global-set-key (kbd "<f5>") 'my/copy-idlink-to-clipboard)
```

(setq my/org-roam-function-tags '("fleeting" "project" "bio" "literature" "permanent" "zettels"))
