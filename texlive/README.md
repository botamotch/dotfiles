### 設定

- A5サイズ、縦書き、14行x35文字、源暎こぶり明朝 9pt
- その他
  - `hanging_punctuation` : ぶら下げ。末尾の句読点を改行しない

```
\documentclass[uplatex,
  tate,
  book,
  onecolumn,
  paper=a6,
  oneside,
  openany,
  fontsize=9pt,
  jafontsize=9pt,
  % linegap=6pt,
  number_of_lines=14,
  line_length=35zh,
  baselineskip=16pt,
  hanging_punctuation,
]{jlreq}

\usepackage{pxrubrica}
% \usepackage[jis2004,uplatex,deluxe]{otf} %
\usepackage[noalphabet, unicode]{pxchfon}
\setminchofont[0]{GenEiKoburiMin6-R.ttf}

\ModifyPageStyle{plain}{%
  running_head_position=top-center,
  nombre_position=bottom-center,
  odd_running_head={_chapter},
  even_running_head={},
  mark_format={_chapter={#1}}
}
\pagestyle{plain}
\ModifyHeading{chapter}{format={\large\sffamily #2},indent=2zw,lines=4}
\ModifyHeading{section}{format={\normalsize #2},indent=4zw,lines=2}

\begin{document}

（以下本文）

\end{document}
```

### コンパイル

```
$ uplatex document.tex
This is e-upTeX, Version 3.14159265-p3.8.3-u1.26-191112-2.6 (utf8.uptex) (TeX Live 2020/Arch Linux) (preloaded format=uplatex)
 restricted \write18 enabled.
entering extended mode
(./document.tex
pLaTeX2e <2020-10-01u04>+1 (based on LaTeX2e <2020-10-01> patch level 2)
...

$ dvipdfmx -p a6 document.dvi
document.dvi -> document.pdf
[1][2][3][4][5][6][7][8]
120313 bytes written
```

### 参考
- [(Linux) upLaTeX + jlreq で小説原稿を作る](https://aznote.jakou.com/linux/latex_novel.html)
- [jlreq/README-ja.md - abenori/jlreq](https://github.com/abenori/jlreq/blob/master/README-ja.md)

