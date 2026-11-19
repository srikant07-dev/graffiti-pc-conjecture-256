# Repository guidance

- Read [CONTENTS.md](CONTENTS.md) before editing. The paper gives the general construction and sharp bound. Lean checks the disproof using one explicit graph.
- Run `bash scripts/verify.sh` with Elan installed after proof or toolchain changes.
- Keep the theorem statement aligned with the catalogue and the neighborhood convention in the paper. Keep the axiom report and reject proof placeholders.
- Rebuild the committed PDF whenever the TeX source changes. Update [HISTORY.md](HISTORY.md) for changes to the mathematics or verification.
- Distinguish machine verification, mathematical exposition, and independent review. Record sources for priority and attribution claims.
