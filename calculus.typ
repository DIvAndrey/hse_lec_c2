#import "@preview/clean-math-paper:0.2.0": *

#let ink    = rgb("#1B1D21")
#let accent = rgb("#27395C")
#let muted  = rgb("#8A9099")
#let rule   = rgb("#E2E5E9")
#let soft   = rgb("#F5F7F9")

#set text(font: "Libertinus Serif", size: 10.5pt, lang: "ru", fill: ink)
#set par(justify: true, leading: 0.68em, spacing: 1em)
#set list(marker: text(fill: accent, weight: 700)[•])

#set page(
  paper: "a4",
  margin: (top: 20mm, bottom: 18mm, left: 21mm, right: 21mm),
  fill: rgb("#FCFBF8"),
  numbering: "1",
  number-align: center,
  footer: context {
    set text(size: 8.5pt, fill: muted)
    line(length: 100%, stroke: 0.4pt + rule)
    v(-3pt)
    align(center)[#counter(page).display("1 / 1", both: true)]
  },
)

#show heading.where(level: 1): it => block(above: 1.3em, below: .6em)[
  #set block(spacing: 0pt)
  #text(size: 16pt, weight: 700, fill: accent)[#it.body]
  #v(2pt)
  #line(length: 100%, stroke: 0.9pt + accent)
]
#show heading.where(level: 2): it => block(above: 1em, below: .4em)[
  #text(size: 12.5pt, weight: 700, fill: accent)[#it.body]
]
#show heading.where(level: 3): it => block(above: .8em, below: .3em)[
  #text(size: 11pt, weight: 700)[#it.body]
]

// Названия определений, теорем и служебных пометок.
#let labels = ([Определение.], [Теорема.], [Теорема], [Лемма.], [Лемма],
  [Следствие.], [Пример.], [Примеры.], [Примеры:], [Замечание.],
  [Замечание:], [Упражнение.], [Решение.], [Вопрос:], [Вывод:])
#show emph: it => if labels.contains(it.body) {
  text(fill: accent, weight: 700, it.body)
} else {
  text(style: "italic", it.body)
}

#let proof(body) = block(
  width: 100%,
  fill: soft,
  stroke: (left: 2.5pt + accent),
  inset: (left: 10pt, right: 10pt, top: 7pt, bottom: 8pt),
  radius: 2pt,
  above: .7em, below: .7em,
)[
  #text(fill: accent, weight: 700)[Доказательство.]
  #h(.4em)
  #body
  #v(.35em)
  #align(right)[#box(width: 5pt, height: 5pt, fill: accent, radius: .5pt)]
]

= План

1. Теория рядов
2. Теория меры и интеграла
Коллок 1
3. Гармонический анализ (преобразование Фурье)
Коллок 2

= Лекция 1 (2026-09-04)

== Глава 1. Ряды

=== 1.1.

Если есть последовательность ${a_n}_(n=1)^infinity$, можно рассмотреть последовательность частичных сумм $S_n = sum_(k = 1)^n a_k$.

$sum_(n=1)^infinity a_n (= lim_(n->infinity) S_n)$ называется сходящейся, если сходится ${S_n}$.

$ sum_(n=0)^infinity q^n = 1/(1-q), space abs(q) < 1 $
$ sum_(n=1)^infinity 1/n^a, space space cases(
  a > 1 ==> "сходится",
  a <= 1 ==> "расходится",
  delim: #none,
) $

_Утверждение._ Ряд $sum_(k=1)^infinity a_k$ сходится 
$<==> forall epsilon > 0 space exists N in NN: abs(sum_(k=N)^(N+p) a_k) < epsilon space forall p in NN$.

=== 1.2. Неотрицательные ряды

_Утверждение._ (Признак сравнения)

Пусть ${a_n >= 0}_(n=1)^infinity, space {b_n >= 0}_(n=1)^infinity, space a_n <= b_n forall n, space sum_(n=1)^infinity b_n "сходится" ==> sum_(n=1)^infinity a_n "сходится"$.
#proof[
  $ abs(sum_(k=N)^(N+p) a_k) <= sum_(k=N)^(N+p) b_k $
]

_Утверждение._ ${a_n >= 0}_(n=1)^infinity$

1) $exists delta > 0$, т.ч. $root(n, a_n) <= 1-delta$ начиная с некоторого $n$ $==> "ряд" sum a_n "сходится"$.

2) $root(n, a_n) >= 1$ начиная с некоторого $n$ $==>$ ряд $sum a_n$ расходится.

#proof[
  1) $root(n, a_n) <= 1 - delta$

  $a_n <.= (1-delta)^n, space b_n = (1-delta)^n$

  2) $root(n, a_n) >= 1 ==> a_n >= 1$.
]

_Утверждение._ (Интегральный признак)

$f: [1, infinity) -> RR$, интегрируемая по Риману, монотонно невозрастает.

$ sum_(n=1)^infinity f(n) "сходится" <==> integral_1^infinity f(x) d x "сходится"$.

#proof[
  $ integral_1^k f(x) d x <= sum_(n=1)^k f(n) <= f(1) + integral_1^k f(x) d x. $
]

_Признак Куммера._ ${a_n > 0}_(n=1)^infinity, space {c_n > 0}_(n=1)^infinity$.

1. $exists delta > 0: a_n/a_(n+1) c_n - c_(n+1) > delta$ начиная с некоторого $n$ $==> sum_(n=1)^infinity a_n "сходится"$. 

2. Пусть $sum_(n=1)^infinity 1/c_n$ расходится и $a_n/a_(n+1) c_n - c_(n+1) <= 0$ начиная с некоторого $n$ $==> sum_(n=1)^infinity a_n$ расходится.

  _Пример 1 (признак Даламбера)._ Если подставить $c_n = 1$, то:

  $a_n / a_(n+1) > 1 + delta$ начиная с некоторого $n$ $==> sum a_n$ сходится.

  $a_n / a_(n+1) <= 1$ начиная с некоторого $n$ $==> sum a_n$ расходится.

  _Пример 2 (признак Раабе)._ Если подставить $c_n = n$, то:

  $a_n / a_(n+1) > 1 + (1 + delta)/n$ начиная с некоторого $n$ $==> sum a_n$ сходится.

  $a_n / a_(n+1) <= 1 + 1/n$ начиная с некоторого $n$ $==> sum a_n$ расходится.


#proof[
  1) $a_n c_n - a_(n+1) c_(n+1) > delta a_(n+1) > 0.$

  Последовательность ${a_n c_n}_(n=1)^infinity$ убывает

  $==> {a_n c_n}_(n=1)^infinity$ сходится

  $==>$ ряд $sum_(n=1)^infinity (a_n c_n - a_(n+1) c_(n+1))$ сходится

  $==>$ по признаку сравнения $sum_(n=1)^infinity delta a_(n+1)$ сходится

  $==> sum a_n$ сходится.

  2) $a_n / a_(n+1) <= c_(n+1) / c_n = d_n / d_(n+1), space space d_n = 1/c_n$

  Для $m > n$:

  $a_n / a_(n+1) dot ... dot a_m / a_(m+1) <= d_n / d_(n+1) dot ... dot d_m / d_(m+1)$.
  
  $==> a_n / a_(m+1) <= d_n / d_(m+1)$

  $==> a_(m+1) >= d_(m+1) a_n / d_n$

  $==> sum a_m$ расходится.
]

_Лемма._ ${a_n >= 0}_(n=1)^infinity$

Ряд $sum_(n=1)^infinity a_n$ сходится $<==>$ $sup {sum_(n in F) a_n : F subset NN "конечно"} < +infinity$

$sum_(n=1)^infinity a_n = sup {sum_(n in F) a_n : F subset NN "конечно"}$

#proof[
  *$(==>)$ *
  
  $F subset NN$ конечное.

  $exists N$ т.ч. $F subset {1, ..., N}$.

  $sum_(n in F) a_n <= sum_(n=1)^N a_n <= sum_(n=1)^infinity a_n$

  $==> sup{sum_(n in F) a_n : F in NN "конечно"} <= sum_(n=1)^infinity a_n$.

  *$(<==)$*
  
  $sum_(n=1)^N a_n = sum_(n in {1, ..., N}) a_n <= sup{sum_(n in F) a_n : F in NN "конечно"}$

  $==>$ ряд $sum_(n=1)^N a_n$ сходится и $sum_(n=1)^infinity a_n = lim_(N -> infinity) sum_(n=1)^N a_n <= sup {sum_(n in F) a_n : F subset NN "конечно"}$
]

_Следствие._ ${a_n >= 0}_(n=1)^infinity$ и $tau: NN -> NN$ -- биекция.

Ряд $sum_(n=1)^infinity a_n$ сходится $<==>$ $sum_(n=1)^infinity a_tau(n)$ сходится и (если сходится) $sum_(n=1)^infinity a_n = sum_(n=1)^infinity a_tau(n)$.

$F subset NN$

$sum_(n in F) a_tau(n) = sum_(n in tau(F)) a_n$

Далее для простоты считаем, что сумма ряда может быть бесконечной.

_Утверждение._ ${A_n subset NN}_(n=1)^infinity$ т.ч. $A_n inter A_m = emptyset, space n != m$ и $NN = union_(n=1)^infinity A_n$, ${a_m >= 0}_(m=1)^infinity$.

$sum_(m=1)^infinity a_m =^(<=)_(>=) sum_(n=1)^infinity (sum_(m in A_n) a_m)$.

#proof[
  *$(<=)$*

  $sum_(n=1)^infinity a_m = sup{sum_(n in F) a_n : F subset NN "конечно"}$

  $F subset NN$ конечное.

  $sum_(m in F) a_m = sum_(n=1)^N (sum_(m in F inter A_n) a_m) <= sum_(n=1)^N (sum_(m in A_n) a_m) <= sum_(n=1)^infinity (sum_(m in A_n) a_m).$

  $F subset union_(n=1)^infinity A_n ==> exists N in NN$, т.ч. $F subset union_(n=1)^N A_n$.

  *$(>=)$* 
  
  Пусть $sum_(m=1)^infinity a_m = S < +infinity$

  $epsilon > 0$

  $sup{sum_(m in F) a_m : F subset A_n "конечно"} < +infinity$

  $F_n subset A_n$ --- такое конечное множество, что
  
  $sum_(m in F_n) a_m >= sum_(m in A_n) a_m - epsilon/N$.

  $sum_(n=1)^infinity (sum_(m in A_n) a_m) <= sum_(n=1)^N (sum_(m in F_n) a_m + epsilon/N) <= epsilon + sum_(m in union_(n=1)^N F_n) a_m <= epsilon + S$

  $==> sum_(n=1)^N (sum_(m in A_n) a_m) <= S$
]
