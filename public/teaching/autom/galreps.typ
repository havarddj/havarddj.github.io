// spacing, headings & eq numbering
#set heading(numbering: "1.1.1")
#set math.equation(numbering: "(1.1)")
#show heading: set block(above: 1.4em, below: 1em)

#show par: set block(spacing: 1.1em)
// font
#set text(
  font: "New Computer Modern",
  size: 11pt
)

// #show heading.where(level:1): it => [
//   #set align(center)
//   #set text(12pt, weight: "regular")
//     #counter(heading).display() #smallcaps(it.body)
// ]
// #show heading.where(level:2): it => [
//   #set align(center)
//   #set text(11pt, weight: "regular")
//     #counter(heading).display() #smallcaps(it.body)
// ]


// bibliography
// #set cite(style: "chicago-author-date")

#show link: set text(fill: rgb(150, 50, 100))


// *commutative diagrams*
#import "@preview/commute:0.2.0": node, arr, commutative-diagram

// *theorem environments*
#import "@preview/ctheorems:1.1.0": *
#show: thmrules
// #let mythm(name, Name) = thmbox(name, Name, inset: (x: 0em, top: 0em),
//  breakable:true, base_level: 1.1heorem")
// heorem = mythm("theorem", "Theorem")
// #let lemma = mythm("lemma", "Lemma")
// #let proposition = mythm("proposition", "Proposition")
// #let definition = mythm("definition", "Definition")
// #let example = mythm("example", "Example")
#let theorem = thmbox("theorem", "Theorem", inset: (x: 0em, top: 0em), base_level: 1)
#let lemma = thmbox("theorem", "Lemma", inset: (x: 0em, top: 0em), base_level: 1)
#let proposition = thmbox("theorem", "Proposition", inset: (x: 0em, top: 0em), base_level: 1)
#let definition = thmbox("theorem", "Definition", inset: (x: 0em, top: 0em), base_level: 1)
#let example = thmbox("theorem", "Example", inset: (x: 0em, top: 0em), base_level: 1)
#show math.frac: it => $it.num slash it.denom$ // make / slash, not frac
#let corollary = thmbox("theorem", "Corollary", inset: (x: 0em, top: 0em), base_level: 1)

#let proof = thmplain(
    "proof",
    "Proof",
    base: "theorem",
    inset: (x: 0em, top: 0em),
    bodyfmt: body => [#body #h(1fr) $square$]
).with(numbering: none)

// *title stuff*

#let title = [Attaching Galois representations to automorphic forms]
#set document(title: [Galois representations and automorphic forms], author: "Håvard Damm-Johnsen")
#align(center, text(17pt)[
    *#title*
])
// math operators
#let Spec = math.op("Spec")
#let Sp = math.op("Sp")
#let SO = math.op("SO")
#let GSpin = $op("GSpin")$
#let Spin = $op("Spin")$
#let GSO = $op("GSO")$
#let Res = $op("Res")$
#let SL = math.op("SL")
#let GL = math.op("GL")
#let Cl = math.op("Cl")
#let uhp = math.frak("h")
// #let Nm (..x)= []
#let norm(x) = math.op("Nm")(x)
#let norm = math.op("Nm")
#let isom = math.tilde.equiv
#let isomto = $accent(arrow, ~)$ // janky, but it works!
#let diag(x) = [#math.Delta #x]
#let order(x) = [#math.cal(x)]
#let tensor = math.times.circle
#let dirsum = math.plus.circle
#let resprod(x) = $attach(product, tr: ', b: #x)$
#let Stab(x, G) = $op("Stab")_#G #x$
#let doublequot(H1,G,H2) = $#H1 backslash #G slash #h(2pt)#H2$
#let coker = $op("coker")$
#let pm = $plus.minus$
#let Hom = $op("Hom")$
#let End = $op("End")$
#let OO = $cal(O)$
#let Pic = $op("Pic")$
#let disc = $op("disc")$
#let circ = $circle.stroked.tiny$
#let vee = $or$


#outline(indent:true, fill:none)


= Lecture 1: $GL_2 /QQ$

The goal is to prove the following theorem:

#theorem[
    Let $ell$ be prime, $N > 5$, $f$ a weight $2$ newform, $lambda$ a
    place of $K_f$ above $ell$. Then there exists a continuous
    representation $rho_(f, lambda) : G_QQ -> GL_2(K_(f,lambda))$,
    such that 
    - $rho_(f,lambda)$ is unramified away from $N ell$,
    - $rho_(f,lambda)(sigma_p)$ has min poly $X^2 - a_p (f)X $
    
]

== The Eichler--Shimura relation

Let $Y_1(N)$ be the open modular curve, a scheme defined over
$ZZ[1/N]$. As a scheme it admits a finite flat map $Y_1(N) ->
AA^1_ZZ[1/N]$, and we can define $X_1(N)$ as the normalization of
$Y_1(N)$. This has good reduction away from $N$.

We also define $Y_1(N,p)$ to be the cover of $Y_1(N,p)$ with
additional data given by $C subset E$ (for $(E,P) in Y_1(N)$), and
with this define geometric Hecke operators:

$
X_1(N) <- X_1(N,p) -> X_1(N),
$

Geometrically, this gives rise to endomorphisms $T_p^*$, $(T_p)_*$ of
$Pic^0 X_1(N)$, which we can make sense of $mod p$. This is not
obvious because $X_1(N,p)$ is only defined over $ZZ[1/N p]$.

We can also define diamond operators $angle.l q angle.r$ for $(q,N)
=1$, which are also endomorphisms of $Pic^0 (X_1(N))$. We also define
the Frobenius isogeny $F$ in there.

#theorem([Eichler--Shimura congruence relation])[
    We have the following identity in $End_FF_p (Pic^0 X_1(N))$,
    $
    F + angle.l p angle.r_* F^v = (T_p)_*
$
]

The idea is to check that the two sides agree on the complement of the
supersingular locus.

For $ell divides.not N$, let $T = T_ell (Pic^0_X_1(N))$ be the
$ell$-adic Tate module, and let $V_ell = T_ell tensor QQ_ell$, and we
denote this Galois representation by $rho_ell$. By the
Néron--Ogg--Shafarevich criterion, this is unramified away from $N
ell$. To find $rho_ell (sigma_p)$, we use the diagram
// https://t.yw.je/#N4Igdg9gJgpgziAXAbVABwnAlgFyxMJZABgBpiBdUkANwEMAbAVxiRADUB9GBhgAgAUABSwBjAHrE+ADU4BGAQDkAlAHoAiuuUgAvqXSZc+QijnkqtRizZce-YWMkz5StQC03yOasUVteg2w8AiIAJnNqemZWRA5uXkERCSlZBRU+VT4AMSzONGU+XX0QDCDjMNI5CyjrWIAJcTlOAB0QAEucVsFU104IGhgAJwYsMBgBHOU80j5NeIZlcRoiwKMQlDIqyKsYkAam1o6ugR6VPoHh0fHNZRm5u0XlnQsYKABzeCJQADNBiABbJBmEA4CBIYgBEC-AFA6igpChSHQwGIcIgsGIADMSL+KIALHCMdjisjwYSkHjnjogA
#align(center, commutative-diagram(
    node((0, 0), [$V_ell (Pic^0 X_1(N)/QQ)$]),
  node((0, 1), [$V_ell (Pic^0 X_1 (N)/ZZ[1/N])$]),
  node((0, 2), [$V_ell (Pic^0 X_1 (N) / FF_p) $]),
  node((1, 2), [$H^1_"ét" (X_1 (N)_overline(FF)_p, QQ_ell)^or$]),
  node((1, 0), [$H^1_"ét" (X_1 (N)_overline(QQ), QQ_ell)^or$]),
  arr((0, 1), (0, 0), []),
  arr((0, 1), (0, 2), []),
  arr((0, 2), (1, 2), []),
  arr((1, 0), (1, 2), []),
  arr((0, 0), (1, 0), []),
))

and note that $F^2 - (T_p)_* F + angle.l p angle.r_* [p] = 0$ by
Eichler--Shimura, since $F F^or = [p]$. By some magic, we can replace
$F$ with $rho_ell (sigma_p)$.

To relate this to modular forms, we pass to $CC$ and work with $X^"an"
:= X_1(N)^"an"$. The exponential short exact sequence
$
0 -> 2 pi i underline(ZZ) -> cal(O)_(X^"an") -> cal(O)_(X^"an") -> 0,
$
gives a long exact sequence with which we identify $Pic^0(X^"an") isom
H^1 (X^"an", cal(O)_(X^"an") ) slash H^1(X^"an", underline(ZZ))$. We
can set up the Hecke correspondences as before.

Apparently there's a discrepancy between $(T_p)_*$ and $T_p^*$ where
the former are used in the previous story, and the latter coincide
with the ones related to modular forms. The way to pass between them
is to use the Weil pairing on $V_ell (X^"an")$, which "swaps the role
of the two", apparently. 

Now use the universal coefficient theorem to show that $T_ell (Pic^0
X^"an") isom H^1 (X^"an", ZZ) tensor ZZ_ell$. Using the Hodge
decomposition, we can identify this with $H^0(X^"an", Omega^1) dirsum
overline(H^0(X^"an", Omega^1))$. Technically, we should use
Kodaira--Spencer or something. This is the weight $2$ Eichler--Shimura
isomorphism. 

Maybe this is explained in Ribet--Stein?
