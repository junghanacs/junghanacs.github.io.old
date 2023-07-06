+++
title = "menu/DotFiles/dot-emacs"
author = ["Junghan Kim"]
date = 2023-06-11T00:00:00+09:00
lastmod = 2023-07-06T17:51:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
Emacs 구성의 목표와 전체적인 소개. 상세 내용은 링크에서 확인 바랍니다.
{{< /hint >}}

<!--more-->


## Junghanacs: Emacs 목표 {#junghanacs-emacs-목표}

{{< hint warning >}}
-   쉬운 키바인딩 : Spacemacs
-   VSpaceCode, SpaceVIM
    Spacemacs 를 사용하는 이유. 하나의 사용자 경험으로 가져가면 좋다!
-   Offline First
-   마우스를 옵션으로 활용 하도록 지원!
    입문자가 멘붕이 오지 않도록 마우스의 사용자 경험을 최대한 살려준다. (옵션)
-   EVIL 모달 편집 기반!
-   가능한 많은 기능!
    다양한 용도로 활용할 수 있도록 커스텀 레이어 관리
-   Emacs 내장 패키지 우선!
-   테마 모드라인 폰트 이모지 등 예쁘게 단 기능 우선!
-   터미널 환경에서도 화면 구성이 깔끔해야 한다.
-   화려한데 성능 잡아먹는 패키지는 아웃!
-   CJK 를 사랑하는 패키지는 우선 선택! (한글 중심)
-   여러 번 입력을 하더라도 과정에서 배움이 있도록 매크로 자제!
    훈련이 되야 한다. 키보드를 입력하는 자체가 배움이고 즐거움이다.
{{< /hint >}}


## [Dot-Spacemacs]({{< relref "./spacemacs.md" >}}) {#d41d8c}

[Dot-Spacemacs]({{< relref "./spacemacs.md" >}}) 는 Spacemacs 설정 파일
입니다. 물론 이 파일 하나에 모든 커스텀 설정을 넣을 수 있습니다. 저도 그렇게
사용 했습니다. 아쉽게도 조금씩 튜닝을 하다 보면 감당이 안되는 지점에 이르게
됩니다. 다른 배포판이나 바닐라로 넘어 가는 게 일반적인 수순일 것입니다. 그러나
구성의 목표에서 언급한 바, 가장 쉬운 길을 만들고 싶었습니다. 쉬운 길이 최선의
길은 아닙니다. 각자 자신의 길을 가기 전 까지 동반자가 되었으면 합니다.


## <span class="underline">Custom</span> Layers {#layers}

위 Spacemacs 설정 파일에서 로딩하는 레이어 목록 입니다. 위의 설정 파일까지 하면
양이 적지 않습니다. 왜 별도로 나누었는 지에 대한 이야기를 하려면 상당히 길어 질
것 같습니다. 일단 설정 파일을 올립니다. 마음 같아서는 조금 더 정리를 하고
싶으나... 천천히 할 예정입니다. 일단 공개함으로써 저의 정리 작업은 시작이 된 것
입니다.


### [jh-base layer]({{< relref "configs/emacs/jh-base.md" >}}) {#d41d8c}


### [jh-completion layer]({{< relref "jh-completion.md" >}}) {#d41d8c}


### [jh-visual layer]({{< relref "jh-visual.md" >}}) {#d41d8c}


### [jh-workspace layer]({{< relref "jh-workspace.md" >}}) {#d41d8c}


### [jh-editing layer]({{< relref "jh-editing.md" >}}) {#d41d8c}


### [jh-navigation layer]({{< relref "jh-navigation.md" >}}) {#d41d8c}


### [jh-writing layer]({{< relref "jh-writing.md" >}}) {#d41d8c}


### [jh-checker layer]({{< relref "jh-checker.md" >}}) {#d41d8c}


### [jh-project layer]({{< relref "jh-project.md" >}}) {#d41d8c}


### [jh-utility layer]({{< relref "jh-utility.md" >}}) {#d41d8c}


### [jh-coding layer]({{< relref "jh-coding.md" >}}) {#d41d8c}


### [jh-org layer]({{< relref "jh-org.md" >}}) {#d41d8c}


### [jh-org-workflow layer]({{< relref "jh-org-workflow.md" >}}) {#d41d8c}


### [jh-pkm layer]({{< relref "jh-pkm.md" >}}) {#d41d8c}


### [jh-misc layer]({{< relref "jh-misc.md" >}}) {#d41d8c}


### [jh-reading layer]({{< relref "jh-reading.md" >}}) {#d41d8c}


### [jh-python layer]({{< relref "jh-python.md" >}}) {#d41d8c}


### [jh-javascript layer]({{< relref "jh-javascript.md" >}}) {#d41d8c}


### [jh-clojure layer]({{< relref "jh-clojure.md" >}}) {#d41d8c}
