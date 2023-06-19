#!/usr/bin/env bash
# Time-stamp: <2022-06-16 13:04:39 kmodi>

# Go Chroma
# https://gohugo.io/content-management/syntax-highlighting/#generate-syntax-highlighter-css
gen_chroma_css () {
    css_file="${1}"_chroma.css
    hugo gen chromastyles --style="${1}" > "${css_file}"

    # Workaround for https://github.com/gohugoio/hugo/issues/10022 --
    # copy the .chroma rules for .code-inline as well.
    sed -r -i 's|\.chroma([^{]+)|\0, .code-inline\1|g' "${css_file}"
}
gen_chroma_css trac
gen_chroma_css github
