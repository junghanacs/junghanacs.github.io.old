+++
title = "Emacs Translation Resources (+ OmegaT) 🌿"
author = ["Junghan Kim"]
date = 2023-06-27T12:18:00+09:00
publishDate = 2023-06-27T12:18:00+09:00
lastmod = 2023-06-27T12:18:00+09:00
keywords = ["notes", "draft", "seedling"]
draft = false
+++

{{< hint info >}}
`한글` 활용 관점에서 접근해야 한다. 관련 설정은 jh-writing 레이어에 반영되어
있다.
{{< /hint >}}

<!--more-->

Emacs 관련한 가장 훌륭한 번역 기술 자료를 담고 있다. 여기 자료를 기반으로
확장한다&nbsp;[^fn:1].


## emacs translation resources {#emacs-translation-resources}


### translation packages {#translation-packages}


#### translate mode {#translate-mode}

<https://github.com/rayw000/translate-mode/>

-   paragraph-based
-   uses `master`
-   two file model
-   works with a pair of buffers
-   new, not a lot of features, but actively developed


#### org-translate {#org-translate}

<https://elpa.gnu.org/packages/org-translate.html>

-   org-based
-   features segmentation (auto in source, manual in target)
-   single file source/target/glossary
-   author plans to do a full re-write as pure text mode and using a standard
    glossary format (TMX).
-   not really actively developed, but pretty well done.


#### emacs-cat {#emacs-cat}

-   really only just enables highlighting sentence in other buffer and moving the
    highlight without switching buffers.


### dictionaries {#dictionaries}


#### emacs-leo {#emacs-leo}

<https://github.com/mtenders/emacs-leo>
(updated version <https://codeberg.org/martianh/emacs-leo>)

-   online
-   interface to german focused online dictionaries


#### wordreference {#wordreference}

<https://codeberg.org/martianh/wordreference.el>

-   online
-   interface to romance language focused dictionaries


#### reverso.el {#reverso-dot-el}

<https://github.com/SqrtMinusOne/reverso.el>

-   online
-   includes translation, grammar, bilingual concordances, synonyms search.


#### sdcv-mode {#sdcv-mode}

<https://repo.or.cz/sdcv.el.git>

-   offline
-   star dict dictionaries
-   old and ugly (uses `outline-mode` but there are high-quality offline dictionaries available for `sdcv`, such as the Oxford English Dictionary, Le Littré Dictionnaire de la langue française, etc.
-   bi-gram phrases


#### etym.el {#etym-dot-el}

<https://codeberg.org/martianh/etym.el>

-   online
-   scrapes <https://etymonline.com>
-   quality etymological data
-   bare bones display still


### thesauruses {#thesauruses}


#### mw-thesaurus {#mw-thesaurus}

<https://github.com/agzam/mw-thesaurus.el>

-   merriam webster, open/free (non-commercial) API.
-   results formatted with org.


#### synosaurus {#synosaurus}

<https://github.com/hpdeifel/synosaurus>

-   uses wordnet (offline) and opendictionary (online) by default, can add others.
-   displays results as a popup, or ido or minibuffer.


#### wikionary-bro {#wikionary-bro}

<https://github.com/agzam/wiktionary-bro.el>

-   online
-   pretty rendered shr views
-   foldable results like org tree
-   open/free data from wikionary.


#### powerthesaurus {#powerthesaurus}


## machine translation {#machine-translation}


### go-translate {#go-translate}

<https://github.com/lorniu/go-translate>

-   translation framework that supports various backends like google, bing, deepl.


### google-translate {#google-translate}


### lingva.el {#lingva-dot-el}

<https://codeberg.org/martianh/lingva.el>

-   access google translations via lingva.ml instances, without google tracking.


### txl, deepl {#txl-deepl}

<https://github.com/tmalsburg/txl.el>

-   requires API key, subscribers only
-   no longer offers a free tier for API access.


### ob-translate {#ob-translate}

<https://github.com/krisajenkins/ob-translate>

-   translate text using org blocks
-   not updated in a long time


### babel {#babel}

<https://github.com/juergenhoetzel/babel>


## handy helpers {#handy-helpers}


### hl-sentence {#hl-sentence}

<https://github.com/milkypostman/hl-sentence>

-   highlight current sentence


### hl-checkerboard {#hl-checkerboard}

<https://codeberg.org/martianh/hl-checkerboard>

-   highlight every second sentence or clause


### centered-cursor-mode {#centered-cursor-mode}

<https://github.com/andre-r/centered-cursor-mode.el>


### scroll-all-mode {#scroll-all-mode}

-   scrolls all (not just 2!) windows in a frame.


## other handy packages {#other-handy-packages}


### org-remark {#org-remark}

<https://github.com/nobiot/org-remark>

-   annotations in separate org buffer/file.


### annotate.el {#annotate-dot-el}

<https://github.com/bastibe/annotate.el/>

-   in-buffer annotations as overlays
-   doesn't play with `variable-pitch-mode`
-   suited only for brief comments


### guess-language.el {#guess-language-dot-el}

<https://github.com/tmalsburg/guess-language.el>


### critic markup (`cm-mode`) {#critic-markup--cm-mode}

<https://github.com/joostkremers/criticmarkup-emacs>

-   track-changes functionality.
-   not recently updated but seems to work


### emacs-sentence-navigation {#emacs-sentence-navigation}

<https://github.com/noctuid/emacs-sentence-navigation>

-   regexps for skipping abbreviations etc. when navigating (or highlighting) by sentence.


## desirable but non-existent features {#desirable-but-non-existent-features}


### segmentation {#segmentation}

-   using CAT parsers for sophisticated segmentation/sentence-end functionality
    (break at normal sentence ending periods, but not at "Mr." or "etc.,")
    -   "Once the text is extracted, it needs to be segmented. Basic "no"
        segmentation usually means paragraph based segmentation. Paragraphs are
        defined differently depending on the original format (1, or 2 line breaks
        for a text file, a block tag for XML-based formats, etc.). // Fine-grained
        segmentation is obtained by using a set of native language based regex that
        includes break rules and no-break rules. A simple example is break after a
        "period followed by a space" but don't break after "Mr. " for English."
        (from the discussion above)

-   might it not be possible to convert OmegaT's Java segmentation regexes into
    Elisp, then plug them in to our sentence-end or segmentation variables?
    -   the regexes are in pairs: before poss break and after poss break.
    -   `segment.el` has almost achieved this now.

-   OmegaT's segmentation info is in
    `/OmegaT_ver.sion.num_Source/src/org/omegat/core/segmentation/`
-   the default rules are stored as XML `/OmegaT_ver.sion.num_Source/src/org/omegat/core/segmentation/defaultRules.srx`.
-   Okapi's segmentation rules files are in this repo.


### two-buffer scrolling/sync {#two-buffer-scrolling-sync}

-   we want this to be both rigorous and flexible. it has been done various times
    but it has never been done rigorously and flexibly (including assuming that
    buffers will lose sync and so making easy/fast ways to recover)
-   it should work with all the various ways people scroll and move point, including `cua-mode`, `centered-cursor-mode`, `org-mode`, and anything else that modifies common scrolling commands.


## thoughts about building new tools {#thoughts-about-building-new-tools}

martianh: I have been thinking recently about what would be needed to have some decent translation functionality in emacs, and quickly came to the conclusion that developing a CAT tool is likely too much work for an individual working in a free software environment.

martianh: 저는 최근에 emacs 에서 적절한 번역 기능을 갖기 위해 필요한 것이 무엇인지 생각해 보았고, CAT 도구를 개발하는 것은 자유 소프트웨어 환경에서 일하는 개인에게 너무 많은 일이라는 결론에 빠르게 도달했습니다.

That said, there are various handy packages available. My thought for the moment was that if we agreed on a few common needs, we could each work on implementing them as separate modules, then see about integrating them as minor modes in an encompassing major mode, or similar. Someone could work on segementation, someone on glossaries, somone on UI/highlighting, and so on.

즉, 다양한 편리한 패키지를 사용할 수 있습니다. 잠시 동안 내 생각은 우리가 몇 가지 일반적인 요구 사항에 동의하면 개별 모듈로 구현하는 작업을 수행한 다음 이를 포괄하는 주요 모드 또는 유사 항목에서 보조 모드로 통합하는 방법을 볼 수 있다는 것입니다. 누군가는 세분화, 누군가는 용어집, 누군가는 UI/강조 표시 등에 대해 작업할 수 있습니다.

I also think that, at least for my needs, the main things that would be a big help are actually the pretty basic things about highlighting, easy paired-buffer navigation, and so on. Rather than full-fledged CAT tools like glossaries and text analysis.

나는 또한 적어도 내 필요에 따라 큰 도움이 될 주요 사항은 실제로 강조 표시, 쉬운 쌍 버퍼 탐색 등에 대한 매우 기본적인 사항이라고 생각합니다. 용어집 및 텍스트 분석과 같은 본격적인 CAT 도구가 아닙니다.

Do you have some more ideas yourself? Why not let's discuss some and maybe delegate a few simple tasks each?

아이디어가 더 있으신가요? 각각 몇 가지 간단한 작업을 논의하고 위임하는 것은 어떻습니까?


## non-emacs free software translation resources {#non-emacs-free-software-translation-resources}


### omegat {#omegat}

<https://omegat.org/>

-   free translation memory tool
-   fully featured (translation memories, segmentation, glossaries, document conversion/compatability, interface to machine translation)


### apertium {#apertium}

<https://apertium.org/index.eng.html#?dir=fra-epo&q>=

<https://apertium.org/index.eng.html#?dir=fra-epo&q>=

-   GPL, public API
-   limited language pairs
-   rule-based (not neural)


### okapi framework {#okapi-framework}

<https://www.okapiframework.org/>

<https://www.okapiframework.org/>

-   vast open framework for various translation tasks.
-   maybe we could write some basic interfaces to the various tools it includes


### swordfish and friends {#swordfish-and-friends}

<https://www.maxprograms.com/products/index.html>

<https://www.maxprograms.com/products/index.html>

-   newer
-   is it open/free software? sort of, $120 per year after trial period. but open source.
-   good support from the dev
-   uses diff gloss format


## other discussion {#other-discussion}

<https://groups.google.com/g/gnu.emacs.help/c/Eb95WZ4iD6g>


## other emacs writing resources {#other-emacs-writing-resources}


### settings from 'emacs for writers' by Jay Dixit {#settings-from-emacs-for-writers-by-jay-dixit}

<https://github.com/incandescentman/Emacs-Settings>


### beautifying org mode {#beautifying-org-mode}

<https://zzamboni.org/post/beautifying-org-mode-in-emacs/>


### emacs as a word processor {#emacs-as-a-word-processor}

<http://www.howardism.org/Technical/Emacs/orgmode-wordprocessor.html>


### reddit post {#reddit-post}

<https://www.reddit.com/r/emacs/comments/2wqgyt/need_your_help_in_compiling_a_list_of_packages/>


### creative writing with emacs {#creative-writing-with-emacs}

<https://jacmoes.wordpress.com/2019/09/24/creative-writing-with-emacs/>

[^fn:1]: [martianh/emacs-translation-resources: A collection of tra...](https://codeberg.org/martianh/emacs-translation-resources)