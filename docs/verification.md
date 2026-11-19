# Verification

Install [Elan](https://github.com/leanprover/elan) and run `bash scripts/verify.sh` from the repository root. Windows users can use Git Bash. The repository pins Lean in [lean-toolchain](../lean-toolchain). The check runs the proof with warnings treated as errors and verifies the reported axiom list.

The theorem `Graffiti256.conjecture256_false` uses a connected 17-vertex counterexample with a three-vertex total dominating set. The [paper](../paper.pdf) proves the infinite family and the optimal coefficient. See the [result summary](../results/conjecture-256.md) for the exact scope.

To rebuild the PDF, run `pdflatex -interaction=nonstopmode -halt-on-error paper.tex` twice from the repository root.
