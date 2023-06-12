+++
title = "configs/emacs : Index"
author = ["Junghan Kim"]
date = 2023-06-11T00:00:00+09:00
lastmod = 2023-06-12
keywords = ["draft", "configs"]
draft = false
+++

{{< hint info >}}
나의 Literate Emacs Dotfiles. 전체를 소개하는 README 파일에 해당 합니다. 각각
설정 파일은 아래 링크를 참고 하세요!
{{< /hint >}}

<!--more-->


## 나의 Emacs 구성의 목표 {#나의-emacs-구성의-목표}

-   최대한 쉽게! Spacemacs 사용 경험 그대로!
-   VSpaceCode, SpaceVIM 과 함께 갈 수 있도록!
    Spacemacs 를 사용하는 이유이기도 하다. 하나의 사용자 경험으로 가져가면 좋다!
-   마우스를 옵션으로 활용 하도록 지원!
    입문자가 멘붕이 오지 않도록 마우스의 사용자 경험을 최대한 살려준다. (옵션)
-   EVIL 모달 편집 기반!
-   가능한 많은 기능!
    다양한 용도로 활용할 수 있도록 커스텀 레이어 관리
-   Emacs 내장 패키지 우선!
-   테마 모드라인 폰트 이모지 등 예쁘게 단 기능 우선!
-   화려한데 성능 잡아먹는 패키지는 아웃!
-   CJK 를 사랑하는 패키지는 우선 선택! (한글 중심)
-   여러 번 입력을 하더라도 과정에서 배움이 있도록 매크로 자제!
    훈련이 되야 한다. 키보드를 입력하는 자체가 배움이고 즐거움이다.


## Spacemacs {#spacemacs}

<span class="timestamp-wrapper"><span class="timestamp">[2023-06-12 Mon 15:50]</span></span>
Spacemacs 설정 파일 입니다.

- spacemacs


## Custom Layer {#custom-layer}

<span class="timestamp-wrapper"><span class="timestamp">[2023-06-11 Sun 12:48] </span></span> 기본 레이어에서 제공하는 기능과 키바인딩을 그대로
가져가면서 최신 기능 지원 및 성능 개선을 하고자 각 레이어 설정을 별도로
나누었습니다.

다음은 각 설정 파일의 링크. 아직 정리가 안 되서 차차 반영 할 예정입니다.

- jh-base
- jh-completion
- jh-visual
- jh-workspace
- jh-editing
- jh-navigation
- jh-writing
- jh-checker
- [jh-project]({{< relref "jh-project.md" >}})
- jh-utility
- jh-coding
- jh-org
- jh-org-workflow
- jh-pkm
- jh-misc
- jh-reading
- jh-javascript
- jh-clojure
- jh-python
