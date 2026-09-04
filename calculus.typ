#import "@preview/clean-math-paper:0.2.0": *

// --- Comment out for white theme
#set text(white)
#set page(fill: rgb("#303446"))
// ---

#let proof(body) = {
  set par(justify: true)
  [
    _Доказательство._
    #block(
      inset: (left: 15pt, right: 15pt),
      [
        #body
      ],
    )
    #align(right)[$square$]
  ]
}

#let shift(body) = {
  set par(justify: true)
  [
    #block(
      inset: (left: 15pt, right: 15pt),
      [
        #body
      ],
    )
  ]
}

#show table.cell: it => {
  if it.y == 0 {
    strong(it)
  } else {
    it
  }
}

#show heading: it => [
  #block(it.body)
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

$sum_(n=1)^infinity (= lim_(n->infinity) S_n)$ называется сходящейся, если сходится ${S_n}$.

$ sum_(n=0)^infinity q^n = 1/(1-q), space abs(q) < 1 $
$ sum_(n=1)^infinity 1/n^a, space space cases(
  a > 1 ==> "сходится",
  a <= 1 ==> "расходится",
  delim: #none,
) $

_Утверждение._ Ряд $sum_(k=1)^infinity$ сходится 
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

  $a_m <.= (1-delta)^n, space b_n = (1-delta)^n$

  2) $root(n, a_n) >= 1 ==> a_n >= 1$.
]

_Утверждение._ (Интегральный признак)

$f: [1, infinity) -> RR$, интегрируемая по Риману, монотонно невозрастает.

$ sum_(n=1)^infinity f(n) "сходится" <==> integral_1^infinity f(x) d x "сходится"$.

#proof[
  $ integral_1^k f(x) d x <= sum_(n=1)^k f(n) <= f(1) + integral_1^k f(x) d x. $
]

_Признак Куммера._ ${a_n > 0}_(n=1)^infinity, space {c_n > 0}_(n=1)^infinity$.

1) $exists delta > 0: a_n/a_(n+1) c_n - c_(n+1) > delta$ начиная с некоторого $n$ $==> sum_(n=1)^infinity a_n "сходится"$. 

2) Пусть $sum_(n=1)^infinity 1/c_n$ расходится и $a_n/a_(n+1) c_n - c_(n+1) <= 0$ начиная с некоторого $n$ $==> sum_(n=1)^infinity a_n$ расходится.

#shift[
  _Пример 1 (признак Даламбера)._ Если подставить $c_n = 1$, то:

  $a_n / a_(n+1) > 1 + delta$ начиная с некоторого $n$ $==> sum a_n$ сходится.

  $a_n / a_(n+1) <= 1$ начиная с некоторого $n$ $==> sum a_n$ расходится.

  _Пример 2 (признак Раабе)._ Если подставить $c_n = n$, то:

  $a_n / a_(n+1) > 1 + (1 + delta)/n$ начиная с некоторого $n$ $==> sum a_n$ сходится.

  $a_n / a_(n+1) <= 1 + 1/n$ начиная с некоторого $n$ $==> sum a_n$ расходится.
  ]

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
