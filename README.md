# A disproof of Graffiti.pc Conjecture 256

Graffiti.pc Conjecture 256 proposed a lower bound on the total domination number of a connected graph. This repository gives an infinite family of counterexamples, proves the sharp replacement for the proposed constant, and includes a Lean-checked disproof of the universal statement. [Original catalogue entry](https://www.uhd.edu/academics/sciences/mathematics-statistics/wowii/files/wowiiaii.pdf#page=149)

## The conjecture and counterexample

A *total dominating set* is a set of vertices such that every vertex, including each chosen vertex, has a chosen neighbor. The minimum size of such a set is $\gamma_t(G)$. Write $A$ for the vertices of minimum degree, $N(A)$ for the union of their open neighborhoods, and $M(G)$ for the largest size of the union of the open neighborhoods of two adjacent vertices.

The conjecture asserted that $\gamma_t(G)\ge 2|N(A)|/M(G)$ for every finite simple connected graph with at least two vertices.

Take a three-vertex path. Attach one triangle at the middle vertex and three at each end, using two new vertices per triangle. The resulting graph has 17 vertices, every vertex has a minimum-degree neighbor, and the largest edge neighborhood has size 11. The three original vertices totally dominate the graph. The conjecture would require a total dominating set to have size at least $34/11>3$.

## Files

| File | Contents |
| --- | --- |
| [Research paper (PDF)](paper.pdf) | Statement, counterexample family, and sharp coefficient theorem |
| [LaTeX source](paper.tex) | Editable source for the research paper |
| [Lean proof](Graffiti256.lean) | Formal disproof using the 17-vertex graph |
| [Proof and research notes](graffiti-pc-conjecture-256.md) | Derivation, numerical checks, and prior-resolution search log |

## Check the Lean proof

With Lean 4.36.0 installed, run the following from the repository root.

~~~sh
lean Graffiti256.lean
~~~

The included [toolchain file](lean-toolchain) pins the version for Elan. The theorem is `Graffiti256.conjecture256_false`. The command checks the proof and prints the axiom audit, which lists `propext`, `Classical.choice`, and `Quot.sound`. The mathematical paper proves the entire counterexample family and the optimal coefficient.

## Rebuild the paper

With a standard LaTeX installation, run the following twice to resolve cross-references.

~~~sh
pdflatex -interaction=nonstopmode -halt-on-error paper.tex
~~~

## Research status

DeLaVina’s November 2026 catalogue lists the conjecture as open. The [research notes](graffiti-pc-conjecture-256.md#prior-resolution-check) document the sources checked for earlier resolutions and the limits of that search. The manuscript records the use of AI assistance.
