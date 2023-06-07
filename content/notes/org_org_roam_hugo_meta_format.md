+++
title = "Org-Roam/Ox-Hugo 블로깅 할 때 확인해야 할 기능들"
author = ["Junghan Kim"]
date = 2023-06-05
lastmod = 2023-06-07
keywords = ["blogging"]
draft = false
+++

{{< hint info >}}
Org-Roam 에서 작성한 문서를 Hugo Markdown 으로 변환하기는 쉽다. 근데 각주, 인용,
태그, 요약, 코드, 일부 내용 감추기 등을 어떻게 하는가? 여기에 대한 답을 찾는다.
{{< /hint >}}

<!--more-->


## Summary 블록 {#summary-블록}

요약문은 한글, 컬럼 80 으로 2.5 줄 정도 가능하다. 간단히 쓰는게 항상 답이다.
간단히 요약하기란 쉽지 않다. 하지만 중요하다. 아래와 같이 포스팅 맨 위에
짧은 글을 넣으면 된다. `#+hugo: more` 이 구분자 역할을 한다. 왠만하면 문서에
html 코드를 넣고 싶지 않다. 제공하는 방법을 사용한다.

```text
My post summary.

#+hugo: more

My post content.
```


## Citation 서지 정보 자동화 {#citation-서지-정보-자동화}

다음과 같이 상/하단에 넣어야 한다. 레퍼런스를 달아 봅니다.
`SPC B i` 로 바인딩을 해 놓았다. <a href="#citeproc_bib_item_1">[1]</a> <a href="#citeproc_bib_item_2">[2]</a>
citar 사용법을 여기서 다룰 것은 아니다. 아무튼 깔끔하게 들어간다.

```text
#+EXPORT_HUGO_PANDOC_CITATIONS: t
,[cite:@HaekeowaHwaga14]
#+print_bibliography:
Below, the "References" heading will be auto-inserted.
```

여기 아래에 들어갑니다. 헤딩이 붙습니다.

## References

<style>.csl-left-margin{float: left; padding-right: 0em;}
 .csl-right-inline{margin: 0 0 0 1em;}</style><div class="csl-bib-body">
  <div class="csl-entry"><a id="citeproc_bib_item_1"></a>
    <div class="csl-left-margin">[1]</div><div class="csl-right-inline">P. Graham, <i>해커와 화가</i>. 2014. Available: <a href="http://www.yes24.com/Product/Goods/11775130">http://www.yes24.com/Product/Goods/11775130</a></div>
  </div>
  <div class="csl-entry"><a id="citeproc_bib_item_2"></a>
    <div class="csl-left-margin">[2]</div><div class="csl-right-inline">Jethro Kuan, “How I Take Notes with Org-roam,” 2022. <a href="https://jethrokuan.github.io/org-roam-guide/">https://jethrokuan.github.io/org-roam-guide/</a> (accessed May 16, 2023).</div>
  </div>
</div>


## Footnote 각주 관리 {#footnote-각주-관리}

각주는 이렇게 들어갑니다.&nbsp;[^fn:1]


## 코드, 인용, 예시 블록 {#코드-인용-예시-블록}

-   ':' 을 애용한다.

    ```text
    안녕하세요. 간단해서 좋습니다.
    ```
-   example
    ```text
      위에 요약문의 분량입니다. 대략 2.5 줄 정도 입니다. 한글로.
    ```
-   quote

    > 위에 요약문의 분량입니다. 대략 2.5 줄 정도 입니다. 한글로.
-   src
    소스코드 블록이다.
    ```emacs-lisp
      (with-eval-after-load 'ox-hugo
        (setq org-hugo-auto-set-lastmod 't
              org-hugo-section "posts"
              org-hugo-suppress-lastmod-period 43200.0
              )
    ```
-   center

    <style>.org-center { margin-left: auto; margin-right: auto; text-align: center; }</style>

    <div class="org-center">

    위에 요약문의 분량입니다. 대략 2.5 줄 정도 입니다. 한글로.

    </div>


## 일부 내용 숨기기 (noexport) {#일부-내용-숨기기--noexport}

블로그 리포는 공개되어 있다. 여기에 Markdown 파일이 그대로 있다. 숨기고 싶은
또는 숨겨야 하는 내용이 분명히 있을 것이다. 그렇다면 org 파일에서 아래와 같은
방법으로 숨기면 된다. 아예 private 프로퍼티를 넣고 ox-hugo 에서 걸러주는
방법도 있다. 나는 왠만하면 다 내용을 오픈하고자 한다. 다만 문제가 되거나
퀄리티가 많이 부족한 부분은 `헤딩` 수준에서 숨기길 원한다.


### noexport 태그 활용 {#noexport-태그-활용}

아래 헤딩은 안보입니다. 뭔가 더 있는데 안보이죠? 그럼 된겁니다.

```text
* 숨기고 싶은 헤딩이라면 태그를 달아라 :noexport:
```


### 파일 숨기기 (비추) {#파일-숨기기--비추}

연결 된 노트를 작성하는 경우라면 좋지 않은 방법이다. 링크를 블록하는
처리를 해줘야 한다.

```text
,:EXPORT_FILE_NAME: excluded-post
```


## 태그를 키워드로 변환 {#태그를-키워드로-변환}

키워드로 빼고 태그는 명시하는게 좋겠다. 태그와 카테고리는 관리가 필요하다.
지식 관리를 할 때 태그, 카테고리는 매우 중요한 분류 방법이다.
태그를 마구잡이로 잡는 것은 좋지 않은 방법이다. 대략 분류를 해놓고 그 안에서
설정을 하는게 좋다. 특히 디지털 가든에서는 태그 관리가 더 중요하다.
그래서 파일 태그가 이리저리 많더라도 변환 할 때는 키워드로 할당되도록 한다.
즉 블로그의 태그는 적절하게 관리한다. 자동화가 언제나 효과적인 것은 아니다.

```text
#+hugo_front_matter_key_replace: tags>keywords
```


## Short-code {#short-code}

<span class="timestamp-wrapper"><span class="timestamp">[2023-06-05 Mon 13:44]</span></span>
org 파일에서 제공하는 기능은 아니지만 블로그에서 보다 정보를 깔끔하게 정리하기
위해서 short-code 를 사용할 수 있다. 스니펫으로 만들어 놓으니 아주
편리하다.

{{< hint info >}}
Something
{{< /hint >}}

{{< hint warning >}}
Something
{{< /hint >}}

{{< hint danger >}}
Error
{{< /hint >}}

{{< expand "Custom Label" >}}
****Markdown content****
Lorem markdownum insigne. Olympo signis Delphis! Retexi Nereius nova develat
stringit, frustra Saturnius uteroque inter! Oculis non ritibus Telethusa
{{< /expand >}}

[^fn:1]: [How I Take Notes with Org-roam](https://jethrokuan.github.io/org-roam-guide/)