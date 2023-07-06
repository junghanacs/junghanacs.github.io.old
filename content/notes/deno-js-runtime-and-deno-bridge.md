+++
title = "Deno JavaScript Runtime and Deno-Bridge🫛"
author = ["Junghan Kim"]
date = 2023-03-28T11:59:00+09:00
publishDate = 2023-07-06T11:02:00+09:00
lastmod = 2023-07-06T11:02:00+09:00
keywords = ["notes", "draft", "seedling"]
draft = false
+++

{{< hint info >}}
Deno: JavaScript Framework 이맥스를 확장하는 좋은 방법이다.
{{< /hint >}}

<!--more-->


## Deno-Bridge {#deno-bridge}

Emacs 를 튜닝하기 위해서 반드시 Emacs Lisp 을 사용해야 하는가?
아니다<a href="#citeproc_bib_item_1">[1]</a>.

왜 중국에서 이러한 접근을 주력으로 할까? Emacs 에서 영어가 아니면 제약이 많다.
그렇다고 다 뜯어 낼 수 도 없고 한계를 개선하기 위해서는 방법은 외부 툴과
연동하는 것이다. 그래서 아무렴 EAF 를 주력으로 밀고 있는 것이다. Deno 또한 같은
맥락의 일이다. 나에게도 매우 중요하다&nbsp;[^fn:1].


## Deno with <span class="underline">ASDF</span> {#deno-with}

설치하는 방법은 정말 다양하다. 이미 나도 설치 했었더라. 다시 설치한다. ASDF 로
툴 관리를 통합하는 게 여러모로 편하기 때문이다&nbsp;[^fn:2]

이것 말고도 내가 사용하고 앞으로 사용할 툴들은 이녀석으로 다 가능하다.

```text
asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git
asdf install deno latest
asdf global deno latest
```


## Deno for lsp-mode and eglot {#deno-for-lsp-mode-and-eglot}

감사하게도 잘 나와 있다&nbsp;[^fn:3]. eglot 용 서버로 명시해 놓았다.

## References

<style>.csl-left-margin{float: left; padding-right: 0em;}
 .csl-right-inline{margin: 0 0 0 1em;}</style><div class="csl-bib-body">
  <div class="csl-entry"><a id="citeproc_bib_item_1"></a>
    <div class="csl-left-margin">[1]</div><div class="csl-right-inline">A. Stewart, “Manateelazycat/deno-bridge.” May 11, 2023. Accessed: May 17, 2023. [Online]. Available: <a href="https://github.com/manateelazycat/deno-bridge">https://github.com/manateelazycat/deno-bridge</a></div>
  </div>
</div>

[^fn:1]: <https://github.com/nailuoGG/deno-bridge-echo>,
    <https://github.com/manateelazycat/deno-bridge>, <https://github.com/manateelazycat/insert-translated-name>
[^fn:2]: <https://deno.land/manual@v1.35.0/getting_started/installation#download-and-install>
[^fn:3]: <https://deno.land/manual@v1.35.0/getting_started/setup_your_environment#emacs>