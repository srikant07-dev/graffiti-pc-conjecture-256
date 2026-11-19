# A disproof of Graffiti.pc Conjecture 256

18 November 2026

An infinite family of connected graphs violates Conjecture 256. The same construction shows that the largest universal coefficient in its proposed lower bound is $1$.

## The conjecture

Let $G$ be a finite simple connected graph with at least two vertices. Write $N(v)$ for the set of neighbors of $v$, $N(S)=\bigcup_{v\in S}N(v)$ for the neighborhood of a vertex set, and $A$ for the set of vertices of minimum degree. Set

$$
M(G)=\max_{uv\in E(G)} |N(u)\cup N(v)|.
$$

A set $D$ totally dominates $G$ if every vertex has a neighbor in $D$, including the vertices of $D$ themselves. The total domination number $\gamma_t(G)$ is the minimum cardinality of such a set. Conjecture 256 asserts

$$
\gamma_t(G)\ge \frac{2|N(A)|}{M(G)}.
$$

Ermelinda DeLaVina's *Written on the Wall II* gives the statement and edge-neighborhood definition on p. 149 and defines the neighborhood of a vertex set on p. 148. With these definitions a vertex in $A$ belongs to $N(A)$ whenever it has a neighbor in $A$. [Conjecture 256](https://www.uhd.edu/academics/sciences/mathematics-statistics/wowii/files/wowiiaii.pdf#page=149) · [Vertex-set neighborhood](https://www.uhd.edu/academics/sciences/mathematics-statistics/wowii/files/wowiiaii.pdf#page=148)

## Counterexample family

For integers $k\ge 2$ and $r\ge 1$, take a star with center $c$ and leaves $x_1,\ldots,x_k$. Attach one triangle at $c$ and $r$ triangles at each $x_i$. An attachment at a vertex $v$ adds two fresh vertices $a,b$ and the three edges $va,vb,ab$. Denote the resulting graph by $G_{k,r}$.

**Minimum-degree neighborhood.** Every new vertex has degree two. The original center has degree $k+2$, and each original leaf has degree $2r+1$. Thus $A$ is exactly the set of new vertices. Each new vertex has its triangle partner in $A$, and each original vertex has at least one attached triangle. Consequently,

$$
N(A)=V(G_{k,r}),\qquad |N(A)|=k(2r+1)+3.
$$

**Total domination.** The $k+1$ original star vertices totally dominate the graph. For the reverse inequality, group each original vertex $v$ with all new vertices in its attached triangles. Choose one new vertex in each group. It has both of its neighbors within that group, so a total dominating set meets every group. The groups are disjoint, giving $\gamma_t(G_{k,r})=k+1$.

**Maximum edge neighborhood.** The endpoints of a star edge $cx_i$ have no common neighbor, so the edge neighborhood has size $(k+2)+(2r+1)=2r+k+3$. For an edge in an attached triangle, the third vertex of that triangle is the unique common neighbor of the endpoints.

| Edge type | Size of $N(u)\cup N(v)$ |
| --- | ---: |
| Original star edge $cx_i$ | $2r+k+3$ |
| Edge from $c$ to one of its new vertices | $k+3$ |
| Edge from $x_i$ to one of its new vertices | $2r+2$ |
| Edge between two new vertices | $3$ |

It follows that $M(G_{k,r})=2r+k+3$. Substituting the three exact values gives

$$
2|N(A)|-\gamma_t(G_{k,r})M(G_{k,r})
=(k-1)(2r-k-3).
$$

Every $G_{k,r}$ with $2r>k+3$ therefore contradicts Conjecture 256. For example, $G_{2,3}$ has 17 vertices and would have to satisfy $3\ge 34/11$.

## Lean verification

`Graffiti256.lean` formalizes the universal conjecture and proves its negation as `Graffiti256.conjecture256_false`. It checks the 17-vertex graph, its connectivity, the two neighborhood counts, and the three-vertex total dominating set. This suffices because the conjectured lower bound on the minimum would also bound the size of every total dominating set.

From this directory, run `lean +leanprover/lean4:v4.36.0 Graffiti256.lean`. The file uses Lean's standard library. The axiom audit reports only `propext`, `Classical.choice`, and `Quot.sound`.

## The optimal coefficient

For any graph in the conjecture's domain, every vertex $u$ has a neighbor $v$, so $\lvert N(u)\rvert\le |N(u)\cup N(v)|\le M(G)$. The neighborhoods of the vertices of a minimum total dominating set cover $V(G)$. Summing their sizes yields

$$
|N(A)|\le |V(G)|\le \gamma_t(G)M(G).
$$

Thus coefficient $1$ works. In the family above, take $r=k^2$. Then

$$
\frac{\gamma_t(G_{k,k^2})M(G_{k,k^2})}{|N(A)|}
=\frac{(k+1)(2k^2+k+3)}{k(2k^2+1)+3}
\longrightarrow 1\qquad(k\to\infty).
$$

This rules out every universal coefficient greater than $1$, even among graphs in which every vertex has a neighbor of minimum degree.

## Derivation and checks

The catalogue's neighboring entries 254 and 257 give examples of how a small total dominating set can coexist with limited coverage by any single edge. For 256, attaching triangles to a star gives each original vertex neighbors of minimum degree and gives each new vertex a neighbor of the same degree. The original star vertices then provide a total dominating set, and the disjoint triangle groups certify its size. Increasing the number of triangles at each leaf makes the leaf degrees large while leaving the degree of the center, the only vertex adjacent to all original leaves, fixed. Increasing the number of leaves then gives the limiting coefficient. [Catalogue entries 254–257](https://www.uhd.edu/academics/sciences/mathematics-statistics/wowii/files/wowiiaii.pdf#page=148)

I also generated adjacency sets from the attachment rule, computed the two neighborhood quantities directly, and enumerated vertex subsets by size until finding a total dominating set. The computations agreed with the formulas for $(k,r)=(2,1),(2,2),(2,3),(2,7),(3,1),(3,3),(3,4),(4,1),(4,3),(4,4)$. This included equality at $(3,3)$ and strict violations when $2r-k-3>0$.

## Prior-resolution check

The conjecture was announced on 23 February 2007. The catalogue linked by DeLaVina's University of Houston-Downtown page, updated on 5 November 2026 and printed on 6 November 2026, lists entry 256 as open. The same catalogue records earlier resolutions for entries 254 and 257, which use different numerators. [Maintainer's page](https://www.uhd.edu/academics/sciences/mathematics-statistics/wowii/index.html) · [Catalogue entry](https://www.uhd.edu/academics/sciences/mathematics-statistics/wowii/files/wowiiaii.pdf#page=149)

I searched public web and scholarly indexes on 18 November 2026 for the exact identifier and for the underlying graph invariants. I found no earlier public resolution of entry 256 in the sources checked. This is a bounded priority check. In particular, the full text of the 2016 paper below was unavailable through the sources checked.

| Representative search or direct check | Result |
| --- | --- |
| `"conjecture 256" "Graffiti" total domination counterexample DeLaVina` | Located the original catalogue entry and work on other total domination conjectures. |
| `"Written on the Wall II" "Conjecture 256" graph proof refutation Desormeaux Henning Gebendorfer` | Found the catalogue's open label and related research. |
| `"Graffiti.pc" "minimum degree" "neighborhood of an edge" "total domination" conjecture` | Checked the formulation independently of its entry number. |
| `"Graffiti.pc" "minimum degree vertices" total domination conjecture 256 proved disproved site:arxiv.org OR site:github.com OR site:researchgate.net OR site:vibemathed.com` | Found related work with different statements and no exact resolution in the results examined. |
| DeLaVina, Liu, Pepper, Waller and West, *Some conjectures of Graffiti.pc on total domination* | Reviewed the paper's searchable text for entry 256. [Author-hosted paper](https://www.uhd.edu/documents/academics/sciences/total-dom-2007.pdf) |
| Desormeaux and Henning, *Lower bounds on the total domination number of a graph* | Checked the abstract and the conjecture catalogue's cross-references. The catalogue links this paper to a proof of 251 and to partial progress on 253. [Authors' institutional record](https://pure.uj.ac.za/en/publications/lower-bounds-on-the-total-domination-number-of-a-graph/) |

On 19 November 2026 I also searched the public Graffiti Verification repository's README for Conjecture 256 and variants tagged with *Written on the Wall II*, *Graffiti.pc*, or minimum degree. The four identifier matches all referred to a different conjecture numbered 256, about the adjacency spectral radius and maximum dual degree. [Archive README](https://gitlab.com/ai-village-agents/village/graffiti-verification/-/blob/main/README.md)
