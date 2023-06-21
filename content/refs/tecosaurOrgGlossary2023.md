+++
title = "Tecosaur :: Org Glossary (2022)🌱"
author = ["Junghan Kim"]
date = 2023-06-09T00:00:00+09:00
lastmod = 2023-06-21
keywords = ["references"]
draft = false
+++

{{< hint info >}}
Terms, Glossary 를 다루는 전략. 가히 아름답다.
{{< /hint >}}

<!--more-->

{{< details "About References Note" >}}
레퍼런스 노트는 1. 원문 번역, 2. 나의 생각 으로 구성 됩니다. 제 공부를 위해서
간단히 번역 한 것이니 참고 바랍니다.
{{< /details >}}

본 레퍼런스 노트는 <a href="#citeproc_bib_item_1">[1]</a> 문서를 번역한 것 입니다.

## References

<style>.csl-left-margin{float: left; padding-right: 0em;}
 .csl-right-inline{margin: 0 0 0 1em;}</style><div class="csl-bib-body">
  <div class="csl-entry"><a id="citeproc_bib_item_1"></a>
    <div class="csl-left-margin">[1]</div><div class="csl-right-inline">tecosaur, “Org Glossary.” May 26, 2023. Accessed: Jun. 08, 2023. [Online]. Available: <a href="https://github.com/tecosaur/org-glossary">https://github.com/tecosaur/org-glossary</a></div>
  </div>
</div>


## 용어를 아십니까 {#용어를-아십니까}

("Glossary" "Acronyms" "Index" "Text Substitutions")

-   glossaries 용어 사전
-   acronyms 줄임말
-   indices 색인


## <span class="underline">나의 생각</span> : 어떻게 활용 할 수 있을까?! {#어떻게-활용-할-수-있을까}


## <span class="underline">원문 번역</span> : Org Glossary Manual {#org-glossary-manual}


### Introduction {#introduction}


#### Summary 요약 {#summary-요약}

Org Glossary 는 모든 `ox-*` 백엔드에 대해 정의된 용어의 버퍼 내 강조 표시 및 높은
품질의 내보내기를 지원하여 Org 문서 내에서 _glossary-like_ 구조 (용어집, 두
문자어, 색인 등)로 작업하기 위한 유연한 모델을 정의합니다.


#### Quickstart {#quickstart}

용어집 항목을 정의하려면 `Glossary` 또는 =Acronyms=라는 제목의 문서에 최상위 제목을
배치하고 다음과 같이 Org 정의 목록을 사용하여 용어를 정의합니다.

```text
* Glossary
- Emacs :: A lisp-based generic user-centric text manipulation environment that
  masquerades as a text editor.
- Org mode :: A rich and versatile editing mode for the lovely Org format.
```

그런 다음 글을 쓸 때 평소 사용하던 대로 용어를 사용하면 됩니다. 내보낼 때 Org Glossary 는 자동으로 다음을 수행합니다.

-   Pick up on the uses of defined terms
-   Generate a Glossary/Acronym section at the end of the document
-   Link uses of terms with their definitions, in a backend-appropriate manner (e.g. hyperlinks in html)
-   Give the expanded version of each acronym in parenthesis when they are first used (e.g. "PICNIC (Problem In Chair, Not In Computer)")

특정 용어에 대한 색인을 생성하려면 거의 동일한 작업을 수행할 수 있습니다. `Index`
헤딩을 사용하고 그저 일반 목록 (plain list)으로 용어를 나열하면 됩니다.

```text
* Index
- org-mode
```

이 모든 것이 어떻게 작동하는지 확인하려면 Org Glossary 가 설치된 상태에서 다음 예제를 내보내십시오.

```text
Try using Org Glossary for all your glosses, acronyms, and more within your
favourite ML with a unicorn mascot. It attempts to provide powerful
functionality, in keeping with the simplicity of the Org ML we all know and
love.

* Glossary
- glosses :: Brief notations, giving the meaning of a word or wording in a text.
* Acronyms
- ML :: Markup Language
* Index
- unicorn
```

Org 모드에 있는 동안 용어 사용에 대한 visual indication 을 보려면 =M-x org-glossary-mode=를 호출하십시오.

{{< figure src="/imgs/20230609-0653-screenshot.png" caption="<span class=\"figure-number\">Figure 1: </span>Visual Indication on org-glossary-mode" >}}


#### Design {#design}

분량이 많거나 기술적인 문서에서는 종종 용어를 명확히 하고 발생 항목을 나열하는
부록이 필요합니다. 이것은 용어집, 색인 또는 다른 형태를 취할 수 있습니다. Org
Glossary 는 이러한 모든 용어집과 유사한 형식을 /tracked generated text
replacements/로 추상화합니다. 대부분의 구조는 다음과 같습니다.

1.  Search for definitions of `$term`
2.  Replace all uses of `$term` with `f($term)`
3.  Generate a definition section for all used terms, linking to the uses

Out of the box, four glossary-like structures are configured:

기본적으로 4 개의 용어집과 유사한 구조가 구성됩니다.

Glossary
: The term is transformed to the same text, but linking to the definition.

Acronyms
: The first use of the term adds the definition in parentheses, and subsequent uses simply link to the definition (behaving the same as glossary terms).

Index
: The term is unchanged (the entire purpose of the index is achieved via step 3. alone).

Text Substitutions
: The term is replaced with its definition.

인덱스 관련 동작과 (usage detection)과 텍스트 대체하는 동작(fontification)에
관한 약간 특별한 케이스가 있지만, 이는 향후 일반화를 통해 최소한으로 유지되고
이상적으로는 제거가 될 것 입니다.


### <span class="org-todo todo TODO">TODO</span> 작업 중 {#작업-중}

뒤 내용은 숨김 처리함.
