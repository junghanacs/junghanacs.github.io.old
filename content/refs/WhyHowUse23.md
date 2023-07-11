+++
title = "Why and How I Use 'Org-mode' for My Writing and More"
author = ["Athalye", "Aditya"]
date = 2023-06-22T20:30:00+09:00
publishDate = 2023-06-22T20:30:00+09:00
lastmod = 2023-06-22T20:30:00+09:00
keywords = ["references", "seedling"]
draft = false
+++

{{< hint info >}}
아름다운 포스팅
{{< /hint >}}

<!--more-->

{{< details "About References Note" >}}
레퍼런스 노트는 1. 원문 번역, 2. 나의 생각 으로 구성 됩니다. 번역은 기계 번역 후
제가 이해할 만한 수준으로 수정한 것 입니다.
{{< /details >}}


## 아름다운 포스팅 {#아름다운-포스팅}

원문 링크를 한번 가보세요&nbsp;[^fn:1]. 급하시면 아래 링크를 누르세요.

[Why and How I use "Org Mode" for my writing and more](https://www.evalapply.org/posts/why-and-how-i-use-org-mode/)

이마저도 귀찮다면, 아래 스크린샷 일단 보세요. 어떻습니까?! 딱 느낌이 오지
않습니까? 읽을 필요도 없습니다. 일단 그냥 링크를 쭉 훑어 봅니다. 글씨를 읽는 게 아닙니다.

제가 이런 글을 마주하면 헉! 소리와 함께 감동을 느낍니다. 글을 읽는 것은 그 다음
입니다. Summary, Tags, Table of Contents, Font, Heading, Bold, Underline, Link,
Source Block, Footnote, Bidirectional Link, Terms, Em-Dash 등 모든 구성이 빈틈
없이 꽉 채워져 있습니다. 보면 알지요. `텍스트 마스터` 님이 남기신 글이지요!

이 분의 다른 글들도 훑어 봅니다. 읽는 게 아닙니다. 그냥 보는 겁니다. 역시. 모든
글이 일관성이 있는 형태 형식 구성미를 갖추고 있습니다. 이런 짓을 하려면 텍스트
마스터의 손 발이 되어 줄 편집기가 분명 있을 겁니다. (이 분은 이맥서 입니다.)

제목을 봅니다.

"나는 글쓰기와 그 이상의 것들에 도대체 왜 그리고 어떻게 "Org Mode" 를
사용하는가!"

남다릅니다. 이 글은 담고 싶었습니다. 그의 형식미를 거의 온전히 저의 것으로
옮겨서 담아 내려고 합니다 (사실 어려운 일이 아님). 제가 레퍼런스에 굳이 저의
허접한 번역을 담는 이유는 글 이전에 아름다운 포스팅을 담아 내고 싶어서 입니다.

역시 서론이 깁니다. 작업 중인 내용은 일단 Hidden 해 놓고, 대문에 걸쳐 놓습니다!

{{< figure src="/imgs/20230622-2035-screenshot.png" caption="<span class=\"figure-number\">Figure 1: </span>스크린샷도 아름답다." width="100%" >}}


## `원문` 글쓰기에  'Org-mode' 를 사용하는 이유와 방법 {#원문-글쓰기에-org-mode-를-사용하는-이유와-방법}

Why and How I use "Org Mode" for my writing and more

글쓰기 등에 "조직 모드"를 사용하는 이유와 방법

I find myself telling people that they will have to pry org-mode from my cold dead hands. Which befuddles me. Why, as an ingrate software nerd who has soured on software technology --- talk about biting the hand that feeds --- do I evince such strong sentiment about a software program?!

나는 사람들에게 차가운 죽은 손에서 조직 모드를 빼내야 할 것이라고 말하는 나 자신을 발견했습니다. 나를 어리둥절하게 만든다. 왜, 소프트웨어 기술에 신랄한 배은망덕한 소프트웨어광으로서--먹이는 손을 물어뜯는 것에 대해 말하면서--내가 소프트웨어 프로그램에 대해 그렇게 강한 감정을 나타내는가?!

You won't know of [Org Mode](https://orgmode.org/) if you live a normal life. [This page](https://orgmode.org/features.html) has pictures that will help you visualise it.

[Org Mode](https://orgmode.org/) 평범하게 살면 모를 겁니다. [이 페이지](https://orgmode.org/features.html)에는 시각화하는 데 도움이 되는 사진이 있습니다.

It is a decidedly un-sexy under-marketed weirdly niche tool for note taking (and a lot more). "Your life in plain text", they say.

메모 작성을 위한(그리고 훨씬 더 많은) 확실히 섹시하지 않은 과소 판매된 이상하게 틈새 도구입니다. "일반 텍스트로 된 당신의 삶"이라고 그들은 말합니다.

Yet, I find myself telling people that they will have to pry it from my cold dead hands. Which befuddles me. Why, as an ingrate software nerd who has soured on software technology ---talk about biting the hand that feeds--- do I evince such strong sentiment about a software program?!

그러나 나는 사람들에게 내 차가운 죽은 손에서 그것을 빼내야 할 것이라고 말하는 내 자신을 발견합니다. 나를 어리둥절하게 만든다. 왜, 소프트웨어 기술에 신랄한 배은망덕한 소프트웨어광으로서--먹이는 손을 물어뜯는 것에 대해 이야기하다--- 내가 소프트웨어 프로그램에 대해 그렇게 강한 감정을 나타내는가?!

Also, _plain text_? In 2022?!

또한 _일반 텍스트_? 2022 년에?!

Well, join the wonder club. I've been wondering the same thing!

자, 원더 클럽에 가입하세요. 나는 같은 것을 궁금해했습니다!

With further ado, I will:

더 고심하여 다음을 수행합니다.

-   illustrate my org-mode use with real examples
-   describe my "what, why, and how" in generally applicable terms
-   discuss some common objections and concerns
-   offer some shiny brain-food for your imagination

Also nerd alert. I can't remove some technicalities without also dumbing it down and doing your intelligence a disservice. Email me if you need help.

또한 괴상한 경고. 멍청하게 만들고 당신의 지능에 해를 끼치지 않고는 몇 가지 기술적인 부분을 제거할 수 없습니다. 도움이 필요하시면 저에게 이메일을 보내주세요.

Take what is useful and discard the rest!

유용한 것을 취하고 나머지는 버리십시오!

> Org is a highly flexible structured plain text file format, composed of a few simple, yet versatile, structures --- constructed to be both simple enough for the novice and powerful enough for the expert.
>
> Org 는 매우 유연한 구조화된 일반 텍스트 파일 형식으로, 몇 가지 단순하지만 다재다능한 구조로 구성되어 있습니다. --- 초보자도 충분히 간단하고 전문가도 충분히 강력하도록 구성되었습니다.
> --- [orgmode.org](https://orgmode.org)

Yes, it's true.

그래 그건 사실이야.


### What I use Org Mode for {#what-i-use-org-mode-for}

Over the last 8-odd years, I have _gradually_ come to use Org Mode (a.k.a. _org-mode_, _orgmode_, or just _org_) for all my:

지난 8 년 동안 나는 _점진적으로_ 조직 모드(일명 _org-mode_, _orgmode_ 또는 _org_)를 사용하게 되었습니다.

-   note-taking
-   live demo presentations
-   slide decks
-   diagramming
-   interactive polyglot computational notebooks
-   blogging. Indeed, this blog post and the surrounding website are written in org text and [made with](https://www.evalapply.org/#footer) tools that work with orgmode.

I have **never** used org for managing TODOs, calendaring, or any "productivity" use cases (time tracking, GTD etc.), which it has become popular for. Nor, as is also popular these days, is it my "second brain". (Or maybe it is because my ~/org directory is a total disaster zone. I just disorganise and use Emacs to search through the files.).

TODO, 일정 관리 또는 "생산성" 사용 사례(시간 추적, GTD 등)를 관리하기 위해 조직을 사용한 적이 **절대** 없습니다. 요즘 유행하는 것처럼 내 "두 번째 두뇌"도 아닙니다. (아니면 내 ~/org 디렉토리가 완전히 재난 지역이기 때문일 수도 있습니다. 파일을 검색하기 위해 Emacs 를 해체하고 사용합니다.).

Some Emacs-using manager-type friends have built very high-leverage workflows to help them stay on top of operations, coaching/mentoring, project management, and more. No other tool in the market comes close to what they can get their org workflows to do for them. (Also, the pun is deeply satisfying --- to run one's org with org :)

Emacs 를 사용하는 일부 관리자 유형의 친구는 운영, 코칭/멘토링, 프로젝트 관리 등을 잘 파악하는 데 도움이 되는 매우 활용도가 높은 워크플로를 구축했습니다. 시장에 있는 다른 어떤 도구도 조직 워크플로에서 수행할 수 있는 작업에 근접하지 않습니다. (또한 말장난은 --- org 와 함께 자신의 org 를 실행하는 데 매우 만족합니다 :)

I too have yet to find an alternative that lets me do _all_ my stuff more seamlessly and capably than org-mode. Granted I use the _Emacs_ implementation of org-mode, but I'm optimistic that more apps (web, mobile, desktop) are becoming general enough. I enumerate several of them later.

나도 조직 모드보다 더 원활하고 유능하게 _all_ 내 작업을 수행할 수 있는 대안을 아직 찾지 못했습니다. 조직 모드의 _Emacs_ 구현을 사용하는 것은 인정하지만 더 많은 앱(웹, 모바일, 데스크톱)이 충분히 일반화되고 있다고 낙관합니다. 나는 그들 중 몇 가지를 나중에 열거합니다.


### A pretty good example of my usage {#a-pretty-good-example-of-my-usage}

I enjoy teaching tutorial-style talks and workshops, and I like to live dangerously; only doing live demos. I recently did one of those at Functional Conf 2022. Here is the sequence of events of how things got done, via org-mode.

나는 튜토리얼 스타일의 대화와 워크샵을 가르치는 것을 좋아하고 위험하게 사는 것을 좋아합니다. 라이브 데모만 합니다. 나는 최근 Functional Conf 2022 에서 그 중 하나를 수행했습니다. 다음은 조직 모드를 통해 작업이 수행된 일련의 이벤트입니다.

1.  **Development**: The talk started off [as prose](https://gist.github.com/adityaathalye/1eeb80e407fa937337402b1f15480b24) in an orgmode file (click "Raw" button to see the orgmode text I actually typed out). Thanks to [org-babel](https://orgmode.org/worg/org-contrib/babel/), I was programming and testing the code examples _right inside the file_, as I went along developing and refining my ideas. This facility is known as "live computational notebook". org-babel was separate before, but now it comes built into the Emacs implementation of Org Mode. Epic win!

2.  **Publishing**: In fact, this content was a draft blog post in my website directory. Once it got decently OK, [I published it to my blog](https://www.evalapply.org/posts/n-ways-to-fizzbuzz-in-clojure/), to solicit feedback and to maintain as a living document, progressively improving the prose / examples / explanations.

3.  **Slideware**: The reviewed and revised blog post rapidly turned into [this hastily-made presentation version](https://gist.github.com/adityaathalye/398d6fc4c8ce9d23e2e393425f0b6454) (click "Raw" button to see the actual text I edited the post down to). I simply deleted prose, support material and extra-examples until I had just-right examples I could fit into a screen at a time (at a suitably large font size).

4.  **Live Demo**: That in turn enabled [the live demo](https://www.youtube.com/watch?v=BTouODWov-A) (video) with live code evaluation (with org-babel), and slide navigation using [org-tree-slide](https://github.com/takaxp/org-tree-slide).

5.  **PDF Handout**: Since then I have [cleaned up and restructured](https://raw.githubusercontent.com/adityaathalye/slideware/master/n-ways-to-fizz-buzz-clj.org) the hastily-done presentation version so it exports neatly via [Beamer](https://orgmode.org/worg/exporters/beamer/tutorial.html), into this [nifty PDF slide deck](https://github.com/adityaathalye/slideware/blob/master/n-ways-to-fizz-buzz-clj.pdf). The heavily improved and reformatted orgmode version remains eminently demoscene-able. If I were immune to last-minute prep, this is the version I would have used for the live demo.

6.  **Professor Points**: I also get intermediate [tex output](https://github.com/adityaathalye/slideware/blob/master/n-ways-to-fizz-buzz-clj.tex) for free, which I don't need, but may please you if you are a professor (or said professor's hopelessly sleep derived grad students).

7.  **Version-controlled and Highly Reproducible**: I can go back to any saved version of any of the org files above, and reliably reproduce output for "distribution" (PDF, tex, HTML etc.). In other words, it is all highly reproducible.


### How I got into the org life {#how-i-got-into-the-org-life}

Well, orgmode was created in anger almost 2 decades ago (circa 2003) by a particularly nerdy astronomer --- [Carsten Dominic](https://staff.science.uva.nl/c.dominik/) --- who was fed up with the anemic note taking tools du jour. I discovered it about a decade ago (circa 2013), right after I changed careers to "tech", because all the gentlenerds at the little company used Emacs. Told ya. Not normal. (Although, surprisingly, lots of normies use it too. Hi friends!).

음, orgmode 는 거의 20 년 전(2003 년경) 특별히 괴상한 천문학자 --- [Carsten Dominic](https://staff.science.uva.nl/c.dominik/) --- 화를 내며 만들어졌습니다. 오늘의 도구를 복용하는 빈혈 메모에 싫증이 난 사람. 나는 약 10 년 전(약 2013 년), "기술"로 경력을 바꾼 직후에 그것을 발견했습니다. 작은 회사의 모든 젠틀맨들이 Emacs 를 사용했기 때문입니다. 말했지. 정상이 아닙니다. (놀랍게도 많은 사람들도 그것을 사용합니다. 안녕 친구들!).

didn't pinch their ideas from org-mode&nbsp;[^fn:2].

But, long before I found Emacs org-mode, I had Microsoft OneNote in a past life as a Suit. In Gen-Z terms, OneNote was (is?) a "local-first" Personal Knowledge Management (PKM) app (that sold profitably---what a concept). I was a superfan and used it All The Time for All The Things. In hindsight, I wonder if they didn't pinch their ideas from org-mode&nbsp;[^fn:2][<sup>1</sup>]].

그러나 Emacs org-mode 를 발견하기 오래 전에 저는 과거에 Microsoft OneNote 를 슈트로 사용했습니다. Z 세대 관점에서 OneNote 는 "로컬 우선" PKM(Personal Knowledge Management) 앱(수익성있게 판매됨--무슨 개념)이었습니다. 나는 열렬한 팬이었고 모든 것을 위해 All The Time 을 사용했습니다. 돌이켜보면 그들이 조직 모드&nbsp;[^fn:2][<sup>1</sup>]]에서 아이디어를 꼬집지 않았는지 궁금합니다.

Anyway, after I fell into the oddball world of Unix and Emacs users, I started with "well, all I really need is a way to write and search copious notes".

어쨌든 Unix 와 Emacs 사용자라는 괴상한 세계에 빠져들고 나서 "글쎄요, 정말 필요한 것은 방대한 노트를 작성하고 검색하는 방법뿐입니다"라는 생각으로 시작했습니다.

If memory serves, it was m'colleague [Mayank](https://twitter.com/firesofmay), who's Emacs I first saw org in, and m'other colleague [Vedang](https://twitter.com/vedang) who's supercharged org-life provided ample inspiration as well as opportunities to rib him about his org dependence. With a little bit of monkey-see-monkey-do and some help, I started dropping words into .org files.

기억이 맞다면, 내가 처음 조직을 본 Emacs 인 m'colleague [Mayank](https://twitter.com/firesofmay)와 m'other 동료 [[<https://twitter.com/vedang>]였습니다. ][Vedang]] 강력한 조직 생활을 하는 사람은 그의 조직 의존성에 대해 그에게 늑장을 부릴 기회뿐만 아니라 충분한 영감을 제공했습니다. 약간의 monkey-see-monkey-do 와 약간의 도움으로 .org 파일에 단어를 넣기 시작했습니다.

Little did I know how it would gradually absorb all my OneNote use cases, and provide a lot more.

내 모든 OneNote 사용 사례를 점진적으로 흡수하고 더 많은 것을 제공하는 방법을 거의 알지 못했습니다.

I started with plain notes and checkboxes. It was just that for many months.

나는 평범한 메모와 확인란으로 시작했습니다. 몇 달 동안 그랬습니다.

-   Then I discovered org-babel for code-aware syntax highlighting and editing, because I wanted to also keep nice-looking code snippets in my documents.

-   그런 다음 코드 인식 구문 강조 표시 및 편집을 위한 org-babel 을 발견했습니다. 문서에서 보기 좋은 코드 스니펫도 유지하고 싶었기 때문입니다.

-   After several more months, I discovered org-babel supports interactive code evaluation with results capture. WAT??!!

-   몇 달이 더 지난 후 저는 org-babel 이 결과 캡처와 함께 대화형 코드 평가를 지원한다는 사실을 알게 되었습니다. 왓??!!

-   Then a year or two in, I started doing little talks. By that time I was clued-in enough to be pretty sure I'd find something to make org-mode do it. And sure enough there exist things like org-tree-slide and org-present.

-   그러다가 1, 2 년이 지나자 작은 대화를 시작했습니다. 그때까지 나는 org-mode 가 그렇게 하도록 만들 무언가를 찾을 수 있을 것이라고 확신할 만큼 충분히 힌트를 얻었습니다. 그리고 확실히 org-tree-slide 및 org-present 와 같은 것이 존재합니다.

-   Then I wanted to give PDF handouts and figured out how to export things. It was a bit painful to learn, but quite useful overall.

-   그런 다음 PDF 유인물을 제공하고 내보내는 방법을 알아냈습니다. 배우는 데 약간 고통스러웠지만 전반적으로 매우 유용했습니다.

-   Now my website is under org management :D

-   이제 내 웹사이트는 조직 관리하에 있습니다 :D

-   And whenever some new requirement comes up, org-mode is my first port of call, because _crucially_, **everything works with everything else**. In seamless composability resides the power of the ecosystem that has grown atop org-mode, both within the world of Emacs, and without it.

-   그리고 어떤 새로운 요구 사항이 나타날 때마다 org-mode 는 _결정적으로_, \*모든 것이 다른 모든 것과 함께 작동\*하기 때문에 조직 모드를 가장 먼저 호출합니다. 원활한 구성 가능성에는 Emacs 세계 내에서나 Emacs 없이 조직 모드에서 성장한 생태계의 힘이 있습니다.

Sometimes I have to put in annoyingly extra effort to make some new add-on requirement play well with my other requirements. But each time I've come away knowing that effort was way lower than having to find, shortlist, pick and learn an entire new tool with its own user interface, opinionated workflow, inevitable workarounds, and maybe incompatible data format (not plain org text).

때로는 새로운 추가 요구 사항이 내 다른 요구 사항과 잘 맞도록 하기 위해 성가시게 추가 노력을 기울여야 합니다. 하지만 그럴 때마다 자체 사용자 인터페이스, 독단적인 워크플로, 피할 수 없는 해결 방법, 호환되지 않는 데이터 형식(일반 조직 텍스트가 아님)이 포함된 전체 새 도구를 찾고, 선정하고, 선택하고 배우는 것보다 노력이 훨씬 적다는 것을 알고 떠날 때마다 ).

For the small price of occasional annoyance, I get to keep using my exact same workflow for everything. This has been a surprise win that is hard to explain in words, especially in today's world where standalone apps have normalised disconnected silos. In hindsight, I didn't really know exactly how much I would come to value composability. I do. A lot!

가끔 성가신 작은 대가를 치르더라도 모든 작업에 똑같은 작업 흐름을 계속 사용할 수 있습니다. 이는 특히 독립 실행형 앱이 분리된 사일로를 정규화한 오늘날의 세계에서 말로 설명하기 어려운 놀라운 승리였습니다. 돌이켜 보면 내가 얼마나 조합 가능성에 가치를 두게 될지 정확히 알지 못했습니다. 그래요. 많이!

Which is why, now you will have to pry org-mode from my cold dead hands.

그렇기 때문에 이제 내 차가운 손에서 org-mode 를 빼내야 합니다.


### Some common objections and questions {#some-common-objections-and-questions}

A reader may rightfully complain about several parts of this blog post, as well as the strangeness of Org Mode.

독자는 이 블로그 게시물의 여러 부분과 조직 모드의 이상함에 대해 정당하게 불평할 수 있습니다.


#### Bleh! A Church of Emacs evangelist... {#bleh-a-church-of-emacs-evangelist-dot-dot-dot}

Sorry, [programmer in-joke](https://www.emacswiki.org/emacs/ChurchOfEmacs) :-)

죄송합니다. [프로그래머 농담](https://www.emacswiki.org/emacs/ChurchOfEmacs) :-)

Orgmode became culturally easy for me as I was already using the venerable Emacs editor, but my ardour has little to do with my affiliation with the Church of Emacs. It has everything to do with _utility_. Utility is contextual. Which, for me, is "to write things down such that I can use it all usefully in (many) other ways".

orgmode 는 이미 유서 깊은 Emacs 편집기를 사용하고 있었기 때문에 문화적으로 쉬워졌습니다. /utility/와 관련이 있습니다. 유틸리티는 상황에 따라 다릅니다. 저에게는 "(많은) 다른 방법으로 모든 것을 유용하게 사용할 수 있도록 기록하는 것"입니다.

Besides, Emacs is no longer the only useful interface to org. Which, in fact, makes me want to stick with org-mode even more. Growing support is easing collaboration via org files.

게다가 Emacs 는 더 이상 조직에 유용한 유일한 인터페이스가 아닙니다. 사실, 조직 모드를 훨씬 더 고수하고 싶게 만듭니다. 지원이 늘어남에 따라 조직 파일을 통한 협업이 쉬워지고 있습니다.


#### But seriously, Emacs winkwink, amirite? {#but-seriously-emacs-winkwink-amirite}

Yes, it is a valid question because Emacs contains the canonical, complete implementation of org-mode. Many people use Emacs _just_ for org-mode.

예, Emacs 에는 조직 모드의 표준적이고 완전한 구현이 포함되어 있기 때문에 유효한 질문입니다. 많은 사람들이 조직 모드에 Emacs /just/를 사용합니다.

But also, seriously, no.

그러나 진지하게도 아닙니다.

Because not even the most hardcore _Emacs_ org-mode users use all of org-mode. One has particular requirements, which are likely serviceable by particular apps and tools enumerated below.

대부분의 하드코어 _Emacs_ org-mode 사용자도 org-mode 를 모두 사용하지 않기 때문입니다. 하나는 아래에 열거된 특정 앱과 도구로 서비스할 수 있는 특정 요구 사항이 있습니다.

See, it's just like normal people and spreadsheets. Not even the guru-est of y'all use all of your spreadsheet software. Or like normal people, normal pens, and normal paper. Even a child can use that stuff, but I'll eat my hat if you go to bed with my handwriting and wake up an ace calligrapher. BUT, you will probably be able to wake up with a pretty good idea, scribble it down and maybe change the world (if you can read my hand).

일반 사람과 스프레드시트와 같습니다. 여러분 중 전문가라도 모든 스프레드시트 소프트웨어를 사용하지는 않습니다. 아니면 평범한 사람, 평범한 펜, 평범한 종이처럼. 그 물건은 어린애도 쓸 수 있는데, 내 손글씨로 자고 일어나면 에이스 서예가를 깨워줄게. 하지만, 당신은 아마도 꽤 좋은 아이디어로 깨어나서 그것을 적고 아마도 세상을 바꿀 수 있을 것입니다(당신이 내 손을 읽을 수 있다면).

Utility is contextual, remember?

유틸리티는 상황에 따라 다릅니다. 기억하십니까?

So here are ways to use org-mode without Emacs, for useful-to-you purposes, without even caring it is orgmode text underneath.

따라서 Emacs 없이 유용한 목적으로 조직 모드를 사용하는 방법이 있습니다.

Mobile, Web, and Desktop apps:

모바일, 웹 및 데스크톱 앱:

-   mobile: [Orgro](https://orgro.org/), a mobile Org Mode file viewer for iOS and Android
-   mobile: [Plain Org](https://plainorg.com/), org text view and editor for iOS
-   mobile: [Orgzly](https://www.orgzly.com/), org text viewer and editor for Android (I use this on my phone, and sync notes to my PC with Dropbox).
-   mobile: [beorg](https://beorg.app/) for iOS (tasks, projects, notes)
-   mobile: [flathabits](https://flathabits.com/), inspired by Atomic Habits, with all your data stored in org files
-   web+desktop: [logseq](https://logseq.com/), a privacy-first, open-source knowledge base
-   web: [organise](https://organice.200ok.ch/), web-based org text editor and viewer
-   web: [braintool.org](https://braintool.org/), a Chrome plugin "to easily capture and categorize all the information and knowledge you want to keep track of, right at the point you discover it or create it"

Text Editors (apart from Emacs):

텍스트 편집기(Emacs 제외):

-   You can type [org markup text](https://orgmode.org/quickstart.html) (syntax) in any text editor, even Notepad.
-   Vim: <https://github.com/nvim-orgmode/orgmode>
-   Atom: <https://atom.io/packages/org-mode>
-   VSCode: <https://github.com/vscode-org-mode/vscode-org-mode>

A variety of utilities to:

다양한 유틸리티:

-   [Publish, Import, Export, Parse](https://orgmode.org/tools.html)
-   [More community-enumerated tools](https://orgmode.org/worg/org-tools/index.html) for the same
-   Even Github, Gitlab etc. support org markup these days!

I'm sure more people are making and releasing tools backed by org-mode text.

더 많은 사람들이 조직 모드 텍스트로 지원되는 도구를 만들고 릴리스하고 있다고 확신합니다.

The future is bright!

미래는 밝다!


#### But what if one app is not enough? {#but-what-if-one-app-is-not-enough}

Having your stuff written in a standard portable format like Org Mode text can become very useful, if you need / want to transcend your current app. But, until such time, feel free to use one app for one thing today (say tasks), and another one for another reason (say note taking), and yet another for, say, habits.

조직 모드 텍스트와 같은 표준 휴대용 형식으로 작성하는 것은 현재 앱을 필요로 하거나 초월하려는 경우 매우 유용할 수 있습니다. 그러나 그때까지 오늘은 한 가지 용도(예: 작업), 다른 용도(예: 메모 작성) 및 습관 용도로 하나의 앱을 자유롭게 사용하세요.

As long as those org-mode based apps don't lock in your data (most don't), then odds are that you will be able to roll all your use cases under one single app later. Worst case, if no other sufficiently capable app is available, or if the app you're using shuts down, Emacs will be there to fall back on!

이러한 조직 모드 기반 앱이 데이터를 잠그지 않는 한(대부분은 잠그지 않음) 나중에 하나의 단일 앱에서 모든 사용 사례를 롤링할 수 있을 가능성이 있습니다. 최악의 경우, 충분히 가능한 다른 앱을 사용할 수 없거나 사용 중인 앱이 종료되는 경우 Emacs 가 다시 사용할 수 있습니다!

Now, Emacs is unfortunately oddball because of half a century of conceptual baggage. Most commonly, it fetches derision for its notoriously awkward keyboard shortcuts. That is mainly because Emacs was already old by the time the PC mouse became mainstream. Keyboards were the only standard method to talk to computers. Also the key combinations feel strange because they don't make keyboards like they used to&nbsp;[^fn:3][<sup>2</sup>]].

이제 Emacs 는 불행하게도 반세기에 걸친 개념적 짐으로 인해 괴짜가 되었습니다. 가장 일반적으로 악명 높은 키보드 단축키 때문에 조롱을 받습니다. 그것은 주로 PC 마우스가 주류가 되었을 때 Emacs 가 이미 구식이었기 때문입니다. 키보드는 컴퓨터와 대화하는 유일한 표준 방법이었습니다. 또한&nbsp;[^fn:3][<sup>2</sup>]]처럼 키보드를 만들지 않기 때문에 키 조합이 이상하게 느껴집니다.

BUT, Emacs accepts you as you are!

그러나 Emacs 는 당신을 있는 그대로 받아들입니다!

Beneath its curmudgeonly exterior&nbsp;[^fn:4][<sup>3</sup>]], it is perhaps _the_ most accessible software application out there&nbsp;[^fn:5][<sup>4</sup>]]!

그 심술궂은 외관[^fn:4][<sup>3</sup>]] 아래에는 아마도 /가장/가장 접근하기 쉬운 소프트웨어 응용 프로그램일 것입니다[^fn:5][<sup>4</sup>]]!

Even I, after so many years of using Emacs org-mode, know barely a handful of very frequently-used keyboard shortcuts (TABTAB to expand tree structures, Shift-TAB to collapse them, ALT-up/down to move trees etc.). Most of the time I just search for commands in the Emacs command menu system (ALT-x followed by a guess for the name of the org command, e.g. `ALT-x org export`, and the system shows me command options with 'export' in the name).

수년 동안 Emacs 조직 모드를 사용한 나조차도 매우 자주 사용되는 키보드 단축키(트리 구조를 확장하려면 TABTAB, 트리 구조를 축소하려면 Shift-TAB, 트리를 이동하려면 ALT-위/아래로 등)를 거의 알지 못합니다. . 대부분의 경우 저는 Emacs 명령 메뉴 시스템에서 명령을 검색합니다(ALT-x 다음에 org 명령의 이름에 대한 추측이 뒤따름, 예: `ALT-x org export`, 시스템은 나에게 '내보내기'와 함께 명령 옵션을 보여줍니다) 이름에 ').

Emacs will always be a great choice because org-mode is built into Emacs. So the complete feature set of org-mode is available with zero configuration. Just install Emacs, mouse-open-create a new `.org` file and start typing text.

조직 모드가 Emacs 에 내장되어 있기 때문에 Emacs 는 항상 훌륭한 선택이 될 것입니다. 따라서 org-mode 의 전체 기능 세트는 제로 구성으로 사용할 수 있습니다. Emacs 를 설치하고 마우스를 열고 새 `.org` 파일을 만들고 텍스트 입력을 시작하십시오.


#### But (sexy VC-funded app)? {#but--sexy-vc-funded-app}

Immersed as I was, in a herd of Emacsen, I started to value some things a lot.

내가 Emacsen 무리에 빠져들면서 나는 몇 가지를 많이 소중히 여기기 시작했습니다.

Offline-first being one, which box OneNote checked off handsomely. _BUT_ proprietary data formats became deal-breakers too. It pains me that I can't trivially access my old OneNote dump to snicker at that cocky past-suit-me.

오프라인 우선 하나, OneNote 상자가 잘 체크되었습니다. _그러나_ 독점 데이터 형식도 거래를 방해하는 요소가 되었습니다. 그 건방진 과거의 나를 비웃기 위해 이전 OneNote 덤프에 사소하게 액세스할 수 없다는 것이 저를 괴롭힙니다.

The cool new tools have also failed to entice me away. Frankly, OneNote's UX and capability 15 years ago hands-down beats most of them. Which may also be why da noo cool don't impress. But that's less worse than the fact that that The Cloud is the new proprietary data format. If my OneNote notes were in The Cloud, and The Cloud "accidentally" chose to lock me out, I wouldn't even be able to dream of snickering at past-suit-me.

멋진 새 도구도 나를 유혹하지 못했습니다. 솔직히 15 년 전 OneNote 의 UX 와 기능은 대부분을 능가합니다. da noo cool 이 감명을 주지 못하는 이유이기도 합니다. 그러나 그것은 클라우드가 새로운 독점 데이터 형식이라는 사실보다 덜 나쁩니다. 내 OneNote 노트가 The Cloud 에 있고 The Cloud 가 "실수로" 나를 잠그기로 선택했다면 과거에 비웃는 꿈조차 꿀 수 없었을 것입니다.

So I now value _**local first**_, which implies _full_ data ownership, with content in a highly portable format, without rigid dependence on 3rd parties, especially not networks or remote services.

그래서 저는 이제 _\*local first\*/에 가치를 둡니다. 이는 특히 네트워크나 원격 서비스가 아닌 제 3 자에 대한 엄격한 의존 없이 이식성이 뛰어난 형식의 콘텐츠와 함께 /full_ 데이터 소유권을 의미합니다.

Of course, I now enjoy the specter of losing my backups, but I prefer being (ir)responsible to myself over being beholden to the mysterious demigods that reside in The Cloud Computer. Also, I'm used to it since my OneNote days. Suits can be responsible too, you know.

물론 지금은 백업을 잃어버리는 망령을 즐기지만 클라우드 컴퓨터에 상주하는 신비한 반신에게 신세를 지는 것보다 나 자신에게 (무)책임을 지는 것을 선호합니다. 또한 OneNote 시절부터 익숙합니다. 정장도 책임질 수 있습니다.

Now, _"Your life in plain text"_, as the org website says, is an absolute must-have. Plus, it gives me everything I liked in OneNote and more.

이제 /"평문으로 된 당신의 삶"/은 org 웹사이트에서 말했듯이 절대적인 필수 아이템입니다. 또한 OneNote 등에서 내가 좋아하는 모든 것을 제공합니다.

"Win, Win.", as the Suits say.

슈츠가 말하는 "승리, 승리."


#### But isn't org-mode a productivity app? {#but-isn-t-org-mode-a-productivity-app}

No. It is fundamentally about writing in a structured plain text data format.

아니요. 기본적으로 구조화된 일반 텍스트 데이터 형식으로 작성하는 것입니다.

Carsten Dominic created it to be a "system of note taking and project planning", with the insight that we think of tasks in context of projects. So it makes a lot of sense to unify prose-writing with denoting TODOs and project meta information directly in context of the prose.

Carsten Dominic 은 우리가 프로젝트의 맥락에서 작업을 생각한다는 통찰력으로 "메모 작성 및 프로젝트 계획 시스템"으로 만들었습니다. 따라서 TODO 를 나타내는 산문 작성을 통합하고 산문의 맥락에서 직접 메타 정보를 투사하는 것이 이치에 맞습니다.

Now, here's the nuance. While org prescribes a certain _syntax_ to structure text and to describe meta-information, it does _not_ prescribe or force _any one method_, to interpret and use the text; e.g. GTD or Kanban or GANTT or what have you.

자, 여기에 뉘앙스가 있습니다. org 는 텍스트를 구조화하고 메타 정보를 설명하기 위해 특정 _구문/을 규정하지만, 텍스트를 해석하고 사용하기 위해 /어떤 하나의 방법/을 규정하거나 강요하지 /않습니다_; 예를 들어 GTD, Kanban, GANTT 또는 무엇을 가지고 있습니까?

Besides, "productivity" means different things to different people. If your old man who types with two fingers routinely invents large scale industrial systems (at least one per year), you too would have a rather different view of what "productivity" means, and what tools one needs to be productive, compared to the many Internet subcultures and gurus who are each passionately vocal about their version of tomato timers.

게다가 "생산성"은 사람마다 다른 것을 의미합니다. 두 손가락으로 타자를 치는 당신의 노인이 일상적으로 대규모 산업 시스템을 발명한다면(최소한 1 년에 한 번), 당신 역시 "생산성"이 의미하는 것과 생산적이 되기 위해 필요한 도구에 대해 상당히 다른 관점을 갖게 될 것입니다. 토마토 타이머 버전에 대해 열정적으로 목소리를 내는 많은 인터넷 하위 문화 및 전문가.

Anyway, it turns out that given structured text and maybe associated metadata, one can build interesting use-cases and workflows that consume the content as a data structure.

어쨌든 주어진 구조화된 텍스트와 관련 메타데이터가 있으면 콘텐츠를 데이터 구조로 사용하는 흥미로운 사용 사례와 워크플로를 구축할 수 있습니다.

Lastly, we don't _have_ to think in "productivity" terms. The basic "outline" way of writing text is _absolutely fine and useful_ just by itself. Because writing = thinking. And because structured writing tool can help us easily structure / restructure our thinking. And because even if we share it as-is, our text is at least legible to anyone regardless of their text reading tool.

마지막으로, 우리는 "생산성" 측면에서 생각할 필요가 없습니다. 텍스트를 작성하는 기본 "개요" 방식은 그 자체로 _절대적으로 훌륭하고 유용합니다_. 글쓰기 = 생각하기 때문입니다. 그리고 구조화된 글쓰기 도구는 생각을 쉽게 구조화/재구성하는 데 도움이 되기 때문입니다. 그리고 있는 그대로 공유하더라도 우리의 텍스트는 텍스트 읽기 도구에 관계없이 누구에게나 읽을 수 있습니다.

Like this:

이와 같이:

```org
* Top level headline
  some text
** A second level
   some other text
*** A third level
    still other text
*** Another Third level
    more still  other text
* Another top level headline
* Lord of the Rings
  My favorite scenes are (in this order)

* 최상위 제목
  일부 텍스트
** 두 번째 수준
   다른 텍스트
*** 세 번째 수준
    또 다른 텍스트
*** 다른 세 번째 수준
    더 많은 다른 텍스트
* 또 다른 최상위 제목
* 반지의 제왕
  내가 좋아하는 장면은 (순서대로)
  1. The attack of the Rohirrim
  + Eowyn's fight with the witch king
     a. this was already my favorite scene in the book
     b. I really like Miranda Otto.
  3. Peter Jackson being shot by Legolas
  - on DVD only

  He makes a really funny face when it happens.

그는 그럴 때 정말 우스꽝스러운 표정을 짓는다.

  But in the end, no individual scenes matter but the film as a whole.

그러나 결국 중요한 것은 개별 장면이 아니라 영화 전체입니다.

  Important actors in this film are:

이 영화의 중요한 배우들은 다음과 같습니다.
  - Elijah Wood :: He plays Frodo
  - Sean Astin :: He plays Sam, Frodo's friend.  I still remember him
  very well from his role as Mikey Walsh in /The Goonies/.
```


#### But why org instead of markdown? {#but-why-org-instead-of-markdown}

OK, so I don't dislike markdown, I just like org much better. I'm facing off org v/s md because md is popular and widespread. Org Mode isn't. Naturally, org _looks_ odd in comparison, at first glance. But really, they have plenty in common.

좋아요, 저는 마크다운을 싫어하는 것이 아니라 org 를 훨씬 더 좋아할 뿐입니다. md 가 인기 있고 널리 퍼져 있기 때문에 org v/s md 와 맞서고 있습니다. 조직 모드는 그렇지 않습니다. 당연히 org _looks_ 는 언뜻 보면 이상하게 보입니다. 그러나 실제로 그들은 공통점이 많습니다.

For one, there are several flavours of markdown, each with their own syntax for how to describe text. Org Mode syntax is not very different. The general concepts remain similar. So all one really needs is a [syntax cheat sheet](https://orgmode.org/quickstart.html) for org.

하나는 텍스트를 설명하는 방법에 대한 고유한 구문이 있는 여러 종류의 마크다운이 있습니다. 조직 모드 구문은 크게 다르지 않습니다. 일반적인 개념은 유사하게 유지됩니다. 따라서 실제로 필요한 것은 조직을 위한 [구문 치트 시트](https://orgmode.org/quickstart.html)입니다.

Every other benefit of writing in structured plaintext remains available to me, including fine-grained version control, maximum portability, prose-like legibility, publishing to any other format (PDF, html, tex, odf, asciidoc, as well as various markdown variants).

세분화된 버전 제어, 최대 이식성, 산문과 같은 가독성, 다른 형식(PDF, html, tex, odf, asciidoc 및 다양한 마크다운 변형으로 게시)을 포함하여 구조화된 일반 텍스트로 작성하는 다른 모든 이점을 계속 사용할 수 있습니다. ).

To me, paying the cost of learning org syntax was well worth it because it afforded me access to text structured in one standard format, with better usability, functionality, and historical support than the various markdowns. I think this article makes a good case for learning org syntax: [Org Mode Is One of the Most Reasonable Markup Languages to Use for Text](https://karl-voit.at/2017/09/23/orgmode-as-markup-only/)

나에게 조직 구문 학습 비용을 지불하는 것은 다양한 마크다운보다 더 나은 사용성, 기능 및 역사적 지원과 함께 하나의 표준 형식으로 구조화된 텍스트에 액세스할 수 있었기 때문에 그만한 가치가 있었습니다. 이 문서는 조직 구문을 학습하는 좋은 사례라고 생각합니다. [Org Mode Is One of the Most Reasonable Markup 텍스트에 사용할 언어](https://karl-voit.at/2017/09/23/orgmode-as-markup-only/)

Plus, org text is explicitly designed to double as a raw datastructure that can be used to drive workflows, like showing presentations, or interactive notebooks, or project management etc. This design choice is explicitly _not_ the mandate of most other plaintext document formats.

또한 조직 텍스트는 프리젠테이션 표시, 대화형 노트북 또는 프로젝트 관리 등과 같은 워크플로를 구동하는 데 사용할 수 있는 원시 데이터 구조로 두 배로 명시적으로 설계되었습니다. 이 디자인 선택은 명시적으로 대부분의 다른 일반 텍스트 문서 형식의 의무 사항이 _아닙니다_ .


### Help! _Where do I even begin_? {#help-where-do-i-even-begin}

This is a common problem because orgmode has become A Lot!

이것은 orgmode 가 A Lot 가 되었기 때문에 일반적인 문제입니다!

Whatever you want to achieve will almost always be possible, if not through a special-purpose org-mode app, then through _Emacs_ org-mode. Being free to do anything is great, but it is also bewildering!

특별한 목적의 조직 모드 앱을 통해서가 아니라면 /Emacs/org-mode 를 통해 성취하고자 하는 것은 거의 항상 가능할 것입니다. 무엇이든 자유롭게 할 수 있다는 것은 대단한 일이지만 당황스럽기도 합니다!

I'd say eat the Elephant one bite at a time, in a problem/solution format, and that too only as long as you're hungry.

문제/해결책 형식으로 한 번에 한 입씩 코끼리를 먹으라고 말하고 싶습니다. 그것도 배고플 때에만요.

Method:

방법:

-   Review the intro on the front page of the [org-mode website](https://orgmode.org/quickstart.html), see the features, and the quickstart, to get an idea of what it's like.

-   [org-mode 웹사이트](https://orgmode.org/quickstart.html)의 첫 페이지에 있는 소개를 검토하고 기능과 빠른 시작을 확인하여 어떤 것인지 알아보세요.

-   Consider _"I want to do X. Can org-mode help me?"_ where X is **the most important** thing for **you**. The answer will almost certainly be _"Yes m'lorx, this way please."_. See if any of the apps I listed previously, fit your requirement.

-   /"나는 X 를 하고 싶습니다. 조직 모드가 나를 도울 수 있습니까?"/를 고려하십시오. 여기서 X 는 **당신\*에게 \*가장 중요한** 것입니다. 대답은 거의 확실하게 /"예 m'lorx, 이쪽으로 주세요."/일 것입니다. 이전에 나열한 앱 중 요구 사항에 맞는 앱이 있는지 확인하세요.

-   Then do **only that X** and see if it works for you. If you find yourself reaching for your orgmode app all the time, for X, then you know you have a winner. This trick keeps things simple, which should give you a strong sense of utility. It should also keep switching costs low if it fails you for X. In that case, your data is yours, so you can take it to another app.

-   그런 다음 \*해당 X\*만 수행하고 효과가 있는지 확인하십시오. X 를 위해 항상 orgmode 앱에 도달하는 경우 승자가 있다는 것을 알고 있습니다. 이 트릭은 일을 단순하게 유지하여 강력한 유용성을 제공합니다. 또한 X 에 대해 실패할 경우 전환 비용을 낮게 유지해야 합니다. 이 경우 데이터는 귀하의 것이므로 다른 앱으로 가져갈 수 있습니다.

-   If you can solve your X admirably, then you can think about your other Y/Z/PQR requirements and start solving them. Maybe in the same app or maybe in a second and third app. Many apps is fine because your data format is the same and you would have an escape hatch from the app. Again, consulting the org-mode website will help match Y/Z/PQR to org.

-   X 를 훌륭하게 해결할 수 있다면 다른 Y/Z/PQR 요구 사항에 대해 생각하고 해결을 시작할 수 있습니다. 같은 앱에 있을 수도 있고 두 번째 및 세 번째 앱에 있을 수도 있습니다. 데이터 형식이 동일하고 앱에서 탈출구가 있기 때문에 많은 앱이 괜찮습니다. 다시 말하지만 조직 모드 웹 사이트를 참조하면 Y/Z/PQR 을 조직에 일치시키는 데 도움이 됩니다.


### Shiny brain-food for your imagination {#shiny-brain-food-for-your-imagination}

I love to watch/read tutorials, HOWTOs, essays, trick-shots etc. published by org super-fans and super-users. Lots of inspiration exists out there! I don't know what I don't know!

저는 조직의 슈퍼 팬과 슈퍼 사용자가 게시한 자습서, HOWTO, 에세이, 트릭 샷 등을 보거나 읽는 것을 좋아합니다. 많은 영감이 존재합니다! 내가 뭘 모르는지 모르겠어!

Whenever I am stuck, I go to one of these resources:

막힐 때마다 다음 리소스 중 하나로 이동합니다.

-   [orgmode.org](https://orgmode.org/worg/exporters/beamer/tutorial.html) is the canonical reference manual.
-   [Worg](https://orgmode.org/worg/exporters/beamer/tutorial.html) is full of gold (tips, tricks, tutorials, hacks).

Whenever I'm looking for inspiration, I go to these resources:

영감을 찾을 때마다 다음 리소스를 찾습니다.

-   Document: norang's **epic** [life in orgmode](http://doc.norang.ca/org-mode.html) page
-   Document: EH Neilsen's [Emacs org-mode examples and cookbook](http://ehneilsen.net/notebook/orgExamples/org-examples.html) that shows how to make org into a full-bore computing environment.
-   Demo: Carsten Dominic's timeless presentation " [Emacs Org-mode - a system for note-taking and project planning](https://www.youtube.com/watch?v=oJTwQvgfgMM)"
-   Demo: Youtuber Rainer Konig has published a **fantastic** series of short, clear tutorials of the many [things one can do with Org](https://www.youtube.com/playlist?list=PLVtKhBrRV_ZkPnBtt_TD1Cs9PJlU0IIdE).
-   Demo: [Emacs For Writers](https://www.youtube.com/watch?v=FtieBc3KptU) by Jay Dixit, a widely-published science writer who is a non-programmer.
-   Demo: [Getting Started With Org Mode](https://www.youtube.com/watch?v=SzA2YODtgK4), for nerds of all feather.
-   Demo: [Consistent Technical Documents Using Emacs and Org Mode](https://www.youtube.com/watch?v=0g9BcZvQbXU)
-   Demo: How m'colleague [Suvrat](https://twitter.com/suvratapte) uses Emacs org-mode's "Org Capture" feature [to stay in flow](https://www.youtube.com/watch?v=tFt6plDQm58) while programming.
-   Demo: How m'colleague [Vedang](https://www.youtube.com/watch?v=KZoQ4EkfDPo) uses Emacs org-mode to run his whole life, as a team lead, project manager, and fallible human.
-   Search "orgmode" in YouTube for _lots_ more!

And if you need help getting started or getting un-stuck or advancing your org-life, email me! ( _weblog_ at this site).

그리고 시작하거나 문제를 해결하거나 조직 생활을 발전시키는 데 도움이 필요하면 저에게 이메일을 보내주세요! (이 사이트의 _weblog_).

[^fn:1]: [Why and How I use "Org Mode" for my writing and more](https://www.evalapply.org/posts/why-and-how-i-use-org-mode/)
[^fn:2]: OneNote came complete with always-on auto-save, outline text, checklists, cross linking, multiple notebooks, categories/tags, search, export, email and calendar integration. Even multimedia embeds, text-to-speech, text extraction from images, audio notes, exports etc. All available on-PC, sans Internet. But, I also used Ray Ozzie's Groove app (Dropbox a decade before Dropbox, and apparently reincarnated as Microsoft OneDrive), so syncing was seamless too. And all this was available for the price of an expensive but lifetime software license plus a piece of your soul. Cheap for me as a Suit, and so I lapped it up. Like I said, it's about utility and it was _fantastic_. Absent org-mode, and assuming I were still a suit, and assuming MS did not screw up OneNote, and assuming MS OneNote were the only good enough game in town, you might have even stood a sliver of a chance to convince today-me to turn a blind eye to the horrible inhumane spyware that Windows is today _because_ it also has OneNote. But of course, I would probably have rather suffered the ignominy of paying Apple an arm a leg and one's personal liberty for access to their increasingly walled-in walled gardens, if their MS Office package had a good enough OneNote. Come on MS! Why undo the wonderful accessibility work y'all are doing on the one hand, by allowing customer data to be weaponised for ads or "personalisation" or whatever? Anyway, I'm grateful for Linux. Both those other ships have sailed for me. Now if only NVIDIA stopped being such insufferable asses about those graphics drivers. Yeah, there is no pleasing some people.

    OneNote 는 상시 자동 저장, 개요 텍스트, 체크리스트, 교차 연결, 여러 전자 필기장, 범주/태그, 검색, 내보내기, 전자 메일 및 일정 통합으로 완성되었습니다. 멀티미디어 임베드, 텍스트 음성 변환, 이미지에서 텍스트 추출, 오디오 메모, 내보내기 등도 인터넷 없이 PC 에서 모두 사용할 수 있습니다. 하지만 Ray Ozzie 의 Groove 앱(Dropbox 보다 10 년 앞서 Dropbox, Microsoft OneDrive 로 환생한 것 같음)도 사용했기 때문에 동기화도 원활했습니다. 그리고 이 모든 것은 값비싸지만 평생 소프트웨어 라이센스와 영혼의 일부 가격으로 사용할 수 있습니다. 수트만큼 싸서 랩핑했습니다. 내가 말했듯이 그것은 유용성에 관한 것이고 그것은 _환상적/이었습니다. org-mode 가 없고, 내가 여전히 정장이라고 가정하고, MS 가 OneNote 를 망치지 않았다고 가정하고, MS OneNote 가 이 도시에서 유일하게 충분히 좋은 게임이라고 가정한다면, 당신은 오늘날 나를 설득할 수 있는 약간의 기회를 잡았을 수도 있습니다. 오늘날 Windows 가 존재하는 끔찍하고 비인도적인 스파이웨어를 눈감아 주는 것입니다. /왜냐하면_ Windows 에도 OneNote 가 있기 때문입니다. 그러나 물론 MS Office 패키지에 충분한 OneNote 가 포함되어 있었다면 Apple 에 팔 다리와 개인의 자유를 지불하고 점점 더 벽으로 둘러싸인 벽으로 둘러싸인 정원에 액세스하는 불명예를 겪었을 것입니다. 어서 MS! 광고나 "개인화" 등을 위해 고객 데이터를 무기화하도록 허용함으로써 한편으로는 여러분이 하고 있는 훌륭한 접근성 작업을 취소할 이유가 무엇입니까? 어쨌든 나는 리눅스에 감사한다. 다른 두 배 모두 나를 위해 항해했습니다. 이제 NVIDIA 만이 해당 그래픽 드라이버에 대해 참을 수 없는 엉덩이가 되는 것을 멈췄다면. 예, 어떤 사람들을 기쁘게 하는 것은 없습니다.
[^fn:3]: I wish they would take a lesson from the late great [Space Cadet](https://en.wikipedia.org/wiki/Space-cadet_keyboard) keyboard. Once I saw that, I couldn't un-see it. Ever since I always reconfigure keyboard layouts of my computers, to put CTRL (and META / ALT) under our thumbs, the way the Spirits of the Computer intended.

    그들이 고인이 된 위대한 [Space Cadet](https://en.wikipedia.org/wiki/Space-cadet_keyboard) 키보드에서 교훈을 얻었으면 좋겠습니다. 한 번 보면 눈을 뗄 수가 없었다. 컴퓨터의 영혼이 의도한 대로 CTRL(및 META/ALT)을 엄지손가락 아래에 두기 위해 항상 컴퓨터의 키보드 레이아웃을 재구성한 이후로.
[^fn:4]: The vast majority of Emacs users are gentlenerds. Alas, odds are that the crabby trollish subset will project out of the ether into your browser window schooling you about How You Are Doing It All Wrong By Using The Mouse. Smile and close the browser tab. Allow them to rail into the void. You do you.

    대다수의 Emacs 사용자는 신사입니다. 아아, 괴상한 트롤 같은 하위 집합이 에테르에서 브라우저 창으로 투사되어 마우스를 사용하여 모든 것을 잘못하고 있는 방법에 대해 교육할 가능성이 있습니다. 웃으며 브라우저 탭을 닫습니다. 공허 속으로 난간을 허용하십시오. 넌 너대로 해.
[^fn:5]: Ref: [Emacs Org-mode - a system for note-taking and project planning](https://www.youtube.com/watch?v=oJTwQvgfgMM) by Carsten Dominik, the inventor of org-mode. The video was curated by TV Raman, a blind-since-childhood programmer, who uses org-mode and who also created "Emacspeak" - Emacs for the Blind. For the more fortunate of us, though some Emacs default settings are weird, and though much of the language to explain Emacs is annoyingly crufty and old, it may be worth adapting to the oddities. Honestly, one doesn't need to learn much to derive use out of Emacs org-mode. That said, if you want all the familiarity of your Mouse and keyboard shortcuts, then by all means configure Emacs to fit your needs. That is its forte! Many "starter kits" are available, to remove the burden of figuring out how to do so. [mousemacs](https://github.com/corvideon/mousemacs) seems to be quite nice. Hit me up if you need help setting it up ( _weblog_ at this site)!

    참조: [Emacs Org-mode - 메모 작성 및 프로젝트 계획을 위한 시스템](https://www.youtube.com/watch?v=oJTwQvgfgMM) org-mode 의 발명가인 Carsten Dominik. 이 비디오는 org-mode 를 사용하고 "Emacspeak"(시각 장애인을 위한 Emacs)를 만든 시각 장애인 프로그래머인 TV Raman 이 큐레이팅했습니다. 운이 좋은 경우 일부 Emacs 기본 설정이 이상하고 Emacs 를 설명하는 많은 언어가 성가시게 조잡하고 오래되었지만 이상한 점에 적응할 가치가 있습니다. 솔직히 Emacs org-mode 를 사용하기 위해 많은 것을 배울 필요가 없습니다. 즉, 친숙한 마우스 및 키보드 단축키를 원하면 필요에 맞게 Emacs 를 구성하십시오. 그것이 강점입니다! 이를 수행하는 방법을 알아내는 부담을 없애기 위해 많은 "스타터 키트"를 사용할 수 있습니다. [mousemacs](https://github.com/corvideon/mousemacs) 꽤 좋은 것 같습니다. 설정하는 데 도움이 필요하시면 연락주세요( _weblog_ 이 사이트에서)!