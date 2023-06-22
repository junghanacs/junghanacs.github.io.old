+++
title = "Glossary"
author = ["Junghan Kim"]
date = 2023-06-17T00:00:00+09:00
publishDate = 2023-06-19
lastmod = 2023-06-22
keywords = ["terms"]
draft = false
+++

{{< hint info >}}
테스트 중
{{< /hint >}}

<!--more-->

Try using Org Glossary for all your glosses, acronyms, and more within your
favourite ML with a unicorn mascot. It attempts to provide powerful
functionality, in keeping with the simplicity of the Org ML we all know and
love. Org mode 는 사랑입니다.

{{< details "Details" >}}
Glossary
: The term is transformed to the same text, but linking to the definition.

Acronyms
: The first use of the term adds the definition in parentheses, and subsequent uses simply link to the definition (behaving the same as glossary terms).

Index
: The term is unchanged (the entire purpose of the index is achieved via step 3. alone).

Text Substitutions
: The term is replaced with its definition.
{{< /details >}}

```text
마크다운으로 이렇게 들어가네!
## Glossary {#glossary}

**<span class="org-glsdef" id="gls.2">Emacs</span>**&emsp;A lisp-based generic user-centric text manipulation environment that
  masquerades as a text editor.&ensp;<a class="org-glsdef" href="#glsr.2.1">1</a>
```


## How-to {#how-to}

```text
- TERM :: DEFINITION
- SINGULAR KEY, PLURAL KEY = SINGULAR FORM, PLURAL FORM :: DEFINITION
```
