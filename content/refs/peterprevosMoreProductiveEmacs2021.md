+++
title = "Peter Prevos :: More Productive with Emacs (2022)🌲"
author = ["Junghan Kim"]
date = 2023-06-10T00:00:00+09:00
lastmod = 2023-06-22T17:02:00+09:00
keywords = ["references", "evergreen"]
draft = false
+++

{{< hint info >}}
이맥스란 무엇이며 왜 사용해야 하는지, 무엇이 장점인지 설명한다. 생산성 고수의
깔끔한 설명이 돋보인다. 특히 생산성 해킹은 키보드가 아닌 마음으로 하는 것이라는
말은 병아리 이맥서의 심장을 때린다.
{{< /hint >}}

<!--more-->

{{< details "About References Note" >}}
레퍼런스 노트는 1. 원문 번역, 2. 나의 생각 으로 구성 됩니다. 번역은 기계 번역 후
제가 이해할 만한 수준으로 수정한 것 입니다.
{{< /details >}}


## <span class="underline">나의 생각</span> : 훌륭하다. 초보자를 위한 3 가지 포인트. {#훌륭하다-dot-초보자를-위한-3-가지-포인트-dot}

Peter Prevos 님의 Emacs 생산성 해킹 시리즈의 서문에 해당하는 글 입니다.&nbsp;[^fn:1].
맨 뒤에 원문 링크를 보면 키워드에서 들어나듯이 연재 시리즈가 아주 구성이 훌륭합니다.
뭐든지 다 잘해요! 프로그램은 참 설명하기가 어렵습니다. 양도 많을 뿐더러 어느
부분을 제외하고 핵심을 다루어야 하는지를 판단하기도 애매합니다. 역시 이 분과
같은 고수는 전통을 알기에 정수를 뽑는 게 정말 남다릅니다. 저 또한 고수의
가이드를 따라 저의 글을 연재하려고 하고 있습니다.

이 분 글의 아쉬운 점은 3 가지 입니다. Emacs 바인딩을 기준으로 하는 것, 설명에
코드가 너무 많다는 것과 패키지 구성이 올드 하다는 점입니다. 요즘에는 일부
중학생들도 VIM 기본 편집은 할 수 있지 않나요? 모드 전환해서 글쓰고 저장하는 정도
말입니다. 방향키로 물론 사용 하구요. 이러한 상황이라면 VIM 스타일 편집은
입문자에게 필수라고 생각합니다. 이것만 알면 `스페이스` 누르고 원하는 기능 찾을
줄만 알면 Spacemacs 스타일 이맥스는 금방 사용할 수 있습니다.

다른 글들을 보면 설정 관련하여 코드가 너무 많습니다. 물론 개발자 연구자들에게는
큰 문제가 없을 것 입니다. 만약 생산성 해킹 도구로서 접근한다면 코드를 보면서
설정해서 사용하는 게 생산적인 일은 아닐 것 입니다. 그냥 오피스 설치하듯이 일단
설치하고 있는 대로 사용하면서 몸이 익히고 그 다음에 조금씩 평생 동안 수정을
하는 게 좋은 접근이라고 생각 합니다. 이맥스는 `라이프 해킹 도구` 이지요.

그리고 패키지 구성이 올드 합니다. 기능의 측면에서도 부족할 수 있지만 제 짧은
경험 상 올드 한 패키지들은 확실히 느립니다. Emacs 빌트인 API 를 활용한 패키지들은
같은 기능을 제공 하면서 코드 양이 1/5, 1/10 이라고 하니 (예를 들어 Helm vs.
Vertico) 런타임 시 확실히 다릅니다. 기능의 측면에서도 요즘 해외에서 많이
언급하는 Emacs 관련 팁들은 올드 패키지는 다루고 있지 않습니다. 그리고 예쁘고
깔끔해야 한다는 저만의 원칙이란...

저도 라이프 타임 생산성 해킹 도구로써 이맥스를 만지고 있기 때문에 이러한 글들은
저에게 많은 도움이 됩니다. 최근 이러한 글들이 많다는 점을 볼 때 생산성 해킹의
좋은 옵션으로 키보드 중심으로 하나의 프로그램으로 통합하는 게 주목 받게 될 것
입니다.

{{< figure src="/imgs/20230620-1543-screenshot.png" caption="<span class=\"figure-number\">Figure 1: </span>My workflow: Left Agenda and this article. Right: The exported result." width="100%" >}}


## <span class="underline">원문 번역</span> : More Productive with Emacs {#more-productive-with-emacs}

21 세기는 방해 요소로 가득 차 있습니다. 미디어 회사는 우리의 시선을 빼앗기 위해
끊임없는 전투를 벌이고 있으며, 그 결과 텔레비전과 인터넷 콘텐츠의 황금기를
낳았습니다. 이 전투는 훌륭한 예술 작품으로 이어지지만 우리가 창의적이고
생산적이지 못하게 할 수도 있습니다. 이 일련의 기사는 Emacs 로 생산성을 높이는
방법을 설명합니다.

생산성을 높이는 첫 번째 단계는 우리의 노력에서 처리해야 하는 방대한 양의 정보를
관리하는 데 도움이 되는 완벽한 소프트웨어 도구를 찾는 것 입니다. 대부분의
사람들은 요구 사항을 충족하기 위해 복잡한 웹 도구들을 사용합니다.

저는 오랫동안 이러한 상황에 있었습니다. 해야 할 일을 수행하기 위해 이
프로그램에서 저 프로그램으로 건너 다녔습니다. 작업 리스트에서 내 일정으로
이동하고, 워드 프로세서 및 스프레드시트, PDF 리더기 등을 말입니다. 이와 같은
작업들을 처리할 수 있는 하나의 프로그램이 있다면 좋지 않을까요?

Emacs 컴퓨팅 시스템에 오신 것을 환영합니다!


### What is Emacs? : 이맥스란? {#what-is-emacs-이맥스란}

[GNU Emacs](https://www.gnu.org/software/emacs/)의 공식 태그라인(tagline)은 "확장 가능한 self-documenting 텍스트
편집기" 입니다. 그러나 이러한 단어는 소프트웨어 개발 도구로서의 목적에만 초점을
맞춘 것 이기 때문에 제대로 Emacs 를 설명하는 말이 아닙니다.

Emacs 는 정보를 관리하고, 프로젝트를 추적하고, 기사, 책, 웹 사이트 및 기타
텍스트를 다루는 일을 처리하는 다용도 컴퓨팅 환경 그 자체 입니다. 다른 말로는
Emacs 는 스테로이드를 맞은 TextEdit 또는 메모장과 같다고 말할 수 있습니다. Emacs
의 첫 번째 버전은 거의 40 년 전에 개발되었으며 이 소프트웨어가 구식인 것처럼
보일 수 있습니다. 그러나 활기찬 개발자 커뮤니티는 지속적으로 시스템을
개선합니다.

{{< hint warning >}}
Emacs is not a productivity hack, it is a productivity hacking system.

Emacs 는 생산성 해킹 아니라, 생산성 해킹 **시스템** 입니다.
{{< /hint >}}

컴퓨터를 사용하다 보면 다양한 프로그램을 사용해야 하는 경우가 많습니다. 워드
프로세서에서 메모를 작성한 다음 스프레드시트로 전환하여 그래프를 만든 다음
복사하여 메모에 붙여 넣습니다. 다음으로 이메일 클라이언트를 열어 메모를 동료에게
보냅니다. 마지막 단계는 생산성 도구에서 작업을 종료하는 것입니다. 이 힘든 작업
후에 게임을 하고 Tetris 를 열 수 있습니다. 이러한 소프트웨어를 사용할 때
프로그램마다 다른 기술을 배워야 할 수도 있습니다. 개발자가 의도한 대로
각각의 소프트웨어를 사용해야 합니다.

Emacs 로 작업하는 것은 다른 경험입니다. Emacs 에서 메모를 작성하고, Emacs 로
그래프를 만들고, 결과를 이메일로 보내고 Emacs 로 작업을 종료합니다. 마지막으로
[게임을 플레이](https://www.masteringemacs.org/article/fun-games-in-emacs), 짐작하셨겠지만 Emacs 내에서 말입니다. Emacs 를 사용하는 경우
소프트웨어 한 부분만 배우면 되고 프로그래머가 소프트웨어를 사용하는 방식이
아니라 원하는 방식으로 작동하도록 구성할 수 있습니다.

처음에 Emacs 는 최신 소프트웨어라기보다 [angry fruit salad](https://www.urbandictionary.com/define.php?term=angry%20fruit%20salad)처럼 보일 수 있습니다.
이 단순한 모양에 속지 마십시오. 내부적으로는 강력한 시스템입니다. 아래 비디오는
Emacs 와 조직 모드 패키지를 사용하는 것이 어떤 것인지 보여줍니다.

[Emacs Org Mode Demo 2021 - YouTube](https://youtu.be/hnMntOQjs7Q)


### Why use Emacs? : 왜 사용해야 하는가? {#why-use-emacs-왜-사용해야-하는가}

Emacs 는 텍스트 편집기나 워드 프로세서가 아니며 스프레드시트나 이메일
클라이언트도 아닙니다. Emacs 는 [가변 소프트웨어(malleable software)](https://malleable.systems/blog/2020/04/01/the-most-successful-malleable-system-in-history/) 플랫폼으로
모든 작업을 수행할 수 있습니다. 키보드로 수행할 수 있습니다. Emacs 는 생산성의
`Swiss-Army Chainsaw` 입니다.

가단성(melleable) 소프트웨어의 첫 번째 원칙은 변경하기 쉽다는 것입니다. Emacs 는
LISP 언어를 사용하여 소프트웨어 내에서 응용 프로그램을 만들 수 있기 때문에
유연합니다. 이와 같은 작업은 어렵게 들릴 수 있지만 가능성 측면에서 말하는 것
입니다. 대부분의 Emacs 사용자는 자신이 개발한 것을 공유하기 때문에 코드를
작성하는 것이 강제적이거나 필요하지 않습니다. 무료로 사용할 수 있는 수천 개의
패키지로 Emacs 를 확장하고 구성할 수 있습니다.

사용자는 Emacs LISP 언어에 대한 약간의 지식만으로도 시스템의 거의 모든 것을
구성할 수 있습니다. 이 지식 요구 사항은 장애물로 보일 수 있지만 사용 방법을
배우면 처음 의도한 방식으로 컴퓨터를 자유롭게 즐길 수 있습니다. 소프트웨어는
사용자 따라 조정 할 수 있어야 합니다. 그 반대가 아닙니다.

이 접근 방식의 장점은 이 소프트웨어를 사용하는 방법에 있어 완전한 자유가 있다는
것입니다. 원하는 거의 모든 작업을 수행하도록 지시하고 특정 요구 사항에 맞게
구성할 수 있습니다. 단점은 최신 소프트웨어와 비교하여 컴퓨팅에 대해 완전히 다른
접근 방식이 필요하다는 것입니다. Emacs 를 사용하면 컴퓨터를 사용한다는 것의 원래
의미와 진정한 사용자 친화성을 되찾게 됩니다.

컴퓨터 사용 방식을 바꿀 준비가 되셨습니까? 매트릭스의 유명한 장면을 의역하자면
다음과 같습니다.

{{< hint danger >}}
파란색 Microsoft 알약을 복용하면 이야기는 끝나고, 모든 것이 동일하게 유지됩니다.
당신은 보라색 Emacs 알약을 먹으면 --- 이제부터 당신은 Wonderland 에 머물게 되고,
나는 당신에게 토끼 굴(Rabbit hole)이 얼마나 깊은지 보여 줄 겁니다.
{{< /hint >}}


### Redefining user-friendliness : 사용자-친화성 재정의 {#redefining-user-friendliness-사용자-친화성-재정의}

Emacs 의 Apple-esque
{{< sidenote >}}
It would be Apple-esque, meaning it was high quality, and very easy to use.
{{< /sidenote >}} 디자인의 결여는 새로운 사용자가 화려한 아이콘을 마우스나 손가락으로 포인팅 할 수
없기 때문에 처음에는 낙담할 수 있습니다. 안타깝게도 대부분의 소프트웨어 개발자는
부드러운 디자인과 마우스를 사용하는 것으로 사용자 친화성을 혼동합니다. 이러한
접근 방식은 학습 된 단순성을 달성하기 위해 사용자가 가질 수 있는 많은 장점을
희생 합니다. 그래픽 기반 소프트웨어(GUI)는 도금한 새장입니다. 즐거울 수도 있지만
그럼에도 불구하고 결국 우리(cage) 일 뿐입니다.

최신 소프트웨어는 "당신이 보는 것이 당신이 얻는 것"(WYSIWYG) 원칙을 따릅니다.
그래픽 인터페이스는 화면의 개체를 책상 위의 종이나 폴더처럼 보이게 하여 실제
세계를 시뮬레이션합니다. 문서를 가리키고 클릭하여 폴더로 드래그합니다. 문서는
종이에 있는 것처럼 표시되며 완료되면 쓰레기통으로 이동합니다. 그래픽
인터페이스는 물리적인 일을 하고 있다고 믿게 만드는 마술입니다. 이 접근 방식은
사람들이 컴퓨터 작동 방식을 이해하지 못하도록 합니다.

Emacs 및 기타 텍스트 편집기는 "What You See Is What You Mean"(WYSIWYM) 원칙을
사용합니다. 이 책을 쓰고 있는 동안에는 현대 워드 프로세서를 사용하는 것처럼
인쇄된 형태로 어떻게 보일지 알 수 없습니다. Emacs 에서는 최종 제품이 어떻게
보여야 하는지에 대한 텍스트, 이미지 및 컴퓨터에 대한 몇 가지 지침만 볼 수
있습니다. 이 접근 방식을 통해 최종 제품에 대해 걱정하는 대신 텍스트 작성에
집중할 수 있습니다.

WYSIWYG 접근 방식은 콘텐츠에서 마음을 산만하게 하고 사용자가 텍스트를 작성하는
대신 스타일을 만지작거리도록 유혹합니다. 전 세계의 사무원은 문서의 형식을
지정하거나 조판하는 데 많은 시간을 낭비합니다. Emacs 방식을 따르면 텍스트를
완성할 때까지 문서의 디자인에 대해 걱정함으로써 생산성을 높일 수 있습니다. 내가
이 책을 쓰고 있는 동안 몇 번의 키 입력만으로 텍스트를 완전한 형식의 전자책이나
웹 페이지로 변환하여 배포할 수 있습니다.

아래 이미지는 이것이 어떻게 생겼는지 보여줍니다. 왼쪽에는 이 기사를 작성하는
동안의 모습이 표시됩니다. 오른쪽에는 콘텐츠를 렌더링한 후의 결과가 표시됩니다.
화면의 색상은 실제 색상이 아닌 헤더나 메타 데이터와 같은 텍스트의 기능을
나타냅니다. 글꼴은 균일하고 이미지는 숨겨져있어 텍스트에 집중할 수 있습니다.
[Hugo 패키지](https://lucidmanager.org/productivity/create-websites-with-org-mode-and-hugo/)는 템플릿을 사용하여 Emacs 의 텍스트를 사용 가능한 웹사이트로
변환합니다.

{{< figure src="/imgs/20230620-1505-screenshot.png" caption="<span class=\"figure-number\">Figure 2: </span>The WYSIWYM approach: Left, this article as I am writing it in Emacs. Right: The exported result." width="100%" >}}


### The learning curve : 러닝 커브 {#headline-4}

두 번째 장애물은 Emacs 를 처음 열 때 보이는 모든 것이 스플래시(splash)
화면이라는 것입니다. Emacs 를 사용하려면 [이 편집기 사용의 기본 원칙](https://lucidmanager.org/productivity/getting-started-with-emacs/)을 배우고
관련 추가 기능 중 일부를 배워야 합니다. Emacs 는 오래 된 소프트웨어이므로 일부
기본 설정과 용어는 최신 그래픽 소프트웨어와 동일하지 않습니다.

{{< hint danger >}}
The steeper the learning curve, the bigger the reward.

학습 곡선이 가파를수록 보상이 커집니다.
{{< /hint >}}

예를 들어 파일을 여는 것은 'visiting a file' 입니다. 텍스트를 붙여넣는 것은
'yanking' 이고, 텍스트를 잘라내는 것은 'killing' 와 같습니다. 아마도 Emacs 용어는
자르고 붙이기와 같은 수공예 활동을 기반으로 하는 현재 용어보다 좀 더 시적일
것입니다.

Emacs 를 배우는 비결은 사실상 무한한 구성 옵션에 압도 당하지 않고 수행해야 하는
작업에 필요한 기능의 일부만 배우는 것입니다. 어떠한 구성이 없더라도 Emacs 로
많은 일을 할 수 있습니다.

원하는 대로 소프트웨어를 구성하려면 Emacs Lisp 를 배워야 합니다. 어렵게 들릴 수
있지만 인터넷에서 예제를 간단히 복사하여 붙여넣기(kill and yank) 할 수 있습니다.
이 웹사이트의 기사는 Emacs 가 쓰기 도구가 되기 위해 알아야 할 사항을 안내합니다.
이러한 문서에서 구성 파일을 다운로드하고 사용하여 시작할 수도 있습니다.

[GitHub에서 다운로드](https://github.com/pprevos/EmacsLife)


### Advantages of using Emacs 이맥스 사용의  장점 {#headline-5}

다음은 Emacs 를 사용하여 글로 된 콘텐츠를 만드는 주요 이점 중 일부입니다.

1.  하나의 소프트웨어로 대부분의 컴퓨팅 활동을 커버할 수 있기에 이 하나만 잘
    배운다면 모든 `생산성` 을 끌어 올릴 수 있습니다.
2.  모든 정보를 일반 텍스트 파일에 저장합니다. 난해한 파일 형식으로 인한 호환성에
    문제가 없을 것입니다.
3.  특정 작업 흐름에 맞게 소프트웨어의 거의 모든 것을 수정할 수 있습니다.
4.  Emacs 는 GNU/Linux, Windows, Chrome OS 및 Apple 의 OS X 와 ​​같은 모든 주요 운영 체제에서 실행됩니다.
5.  Emacs 는 오픈 소스이며 기꺼이 도움을 주는 대규모 커뮤니티의 지원을 받습니다.


### Limitations of Emacs 이맥스의 한계 {#headline-6}

이 다기능 편집기에 대한 찬사를 듣고 나면 Emacs 가 전능한 소프트웨어의 신이라고
생각할 것입니다. 어떤 사람들은 감탄을 표하기 위해 [Emacs 교회](https://www.emacswiki.org/emacs/ChurchOfEmacs)를 가짜 종교로
세웠습니다.

Emacs 는 이미지를 표시하고 이를 텍스트와 통합할 수 있지만 그래픽 파일을
생성하거나 수정하는 기능은 제한되어 있습니다. 그림을 만들거나 편집해야 하는 경우
GIMP(GNU Image Manipulation Program) 사용을 고려해야 합니다. 비디오 콘텐츠는
지원되지 않으며 파일 또는 웹 페이지에 대한 하이퍼링크 이외의 텍스트와 쉽게
통합될 수 없습니다.

두 번째 단점은 Emacs 에 (아직) 완전히 작동하는 웹 브라우저가 없다는 것입니다.
Emacs 내에서 웹 서핑을 할 수 있는 패키지가 있지만 기능이 다소 제한적입니다.

Emacs 는 생산성 싱크(sink)가 될 위험이 있습니다. 그러나 모든 것을 구성할 수
있다고 해서 반드시 구성해야 한다는 의미는 아닙니다. 작업 흐름에 대해 걱정하는 데
너무 많은 시간을 소비하지 말고 그 시간을 작업 흐름에 사용하십시오. 참고로 대부분의
생산성 해킹은 키보드가 아닌 본인의 마음가짐의 영향을 크게 받기 때문에 모든
구성을 사전에 꼭 해야 하는 것은 아닙니다.


### More Productive with Emacs : 앞으로 배워 나갈 것들 {#headline-7}

이 웹 사이트에는 최소한이지만 합리적인 구성을 사용하여 Emacs 로 작업을 완료하는
데 도움이 되는 일련의 기사가 포함되어 있습니다.

이 일련의 기사는 연구원과 작가가 수행하는 대부분의 작업을 다룹니다. 각 기사는
활동에 대해 논의하고 Emacs 로 이를 수행하는 방법을 설명합니다.

다음 두 기사에서는 Emacs 설치, 구성 및 사용 방법을 소개합니다. 이 웹 사이트의
나머지 문서에서는 다양한 작업을 완료하는 방법에 대해 설명합니다. 이 기사에서
다루지 않는 유일한 주제는 Emacs 로 소프트웨어를 개발하는 것입니다.

1.  [Getting Started with Emacs](https://lucidmanager.org/productivity/getting-started-with-emacs/)
2.  [Configure Emacs](https://lucidmanager.org/productivity/configure-emacs/)
3.  [Emacs Completion System](https://lucidmanager.org/productivity/emacs-completion-system/)
4.  [Ricing Org mode](https://lucidmanager.org/productivity/ricing-org-mode/)
5.  [Distraction-Free Writing](https://lucidmanager.org/productivity/emacs-for-distraction-free-writing/)
6.  [Taking Notes with Org-Roam](https://lucidmanager.org/productivity/taking-notes-with-emacs-org-mode-and-org-roam/)
7.  [Manage your literature with Emacs BibTeX Mode](https://lucidmanager.org/productivity/emacs-bibtex-mode/)
8.  [Bibliographic notes with Denote and Citar](https://lucidmanager.org/productivity/bibliographic-notes-in-emacs-with-citar-denote/)
9.  [Writing Articles and Books with Org Mode](https://lucidmanager.org/productivity/publishing-with-org-mode-export/)
10. [Create Websites](https://lucidmanager.org/productivity/create-websites-with-org-mode-and-hugo/)
11. [Getting Things Done](https://lucidmanager.org/productivity/getting-things-done-with-emacs/)
12. [Manage files with dired](https://lucidmanager.org/productivity/manage-files-with-emacs/)
13. [Manage images with image-dired](https://lucidmanager.org/productivity/using-emacs-image-dired/)
14. [Read RSS feeds with Elfeed](https://lucidmanager.org/productivity/read-rss-feeds-with-emacs-and-elfeed/)
15. [Play Music with the Emacs Multimedia System](https://lucidmanager.org/productivity/configure-emms/)
16. [Using Emacs on a Chromebook](https://lucidmanager.org/productivity/emacs-chromebook/)

Emacs 는 수정 변형이 가능한 (melleable) 시스템이므로 모든 사람이 작업을 수행하기
위해 개인적으로 선호하는 것이 있습니다. 따라서 Emacs 로 생산성을 높이는 방법에
대한 모든 기사는 독단적입니다. 다른 작업 방식이 있는 경우 의견을 공유하고 아래에
의견을 남기거나 문의 양식을 작성하여 저에게 이메일을 보내주십시오.

[^fn:1]: [More Productive with Emacs: Writing, Researching, Publishing](https://lucidmanager.org/productivity/more-productive-with-emacs/)