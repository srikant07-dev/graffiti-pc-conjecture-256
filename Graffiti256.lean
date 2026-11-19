import Std

/-!
Graffiti.pc Conjecture 256, Written on the Wall II, p. 149.
Check with Lean 4.36.0 using: lean Graffiti256.lean
Only the Lean standard library is required.
-/

namespace Graffiti256

/-- A finite simple graph with vertices numbered 0 through n-1. -/
structure Graph (n : Nat) where
  adj : Fin n → Fin n → Bool
  symmetric : ∀ u v, adj u v = adj v u
  loopless : ∀ v, adj v v = false

inductive Reachable {n : Nat} (G : Graph n) : Fin n → Fin n → Prop where
  | refl (v) : Reachable G v v
  | edge {u v} : G.adj u v = true → Reachable G u v
  | trans {u v w} : Reachable G u v → Reachable G v w → Reachable G u w

def Connected {n : Nat} (G : Graph n) : Prop :=
  ∀ u v, Reachable G u v

def TotalDominates {n : Nat} (G : Graph n) (D : List (Fin n)) : Prop :=
  ∀ v, ∃ w, w ∈ D ∧ G.adj v w = true

def degree {n : Nat} (G : Graph n) (v : Fin n) : Nat :=
  ((List.finRange n).filter (G.adj v)).length

def minDegree {n : Nat} (G : Graph n) : Nat :=
  ((List.finRange n).map (degree G)).foldr min n

/-- The size of the union of the open neighborhoods of minimum-degree vertices. -/
def minDegreeNeighborCount {n : Nat} (G : Graph n) : Nat :=
  ((List.finRange n).filter fun v =>
    (List.finRange n).any fun w => degree G w == minDegree G && G.adj v w).length

def edgeNeighborhoodSize {n : Nat} (G : Graph n) (u v : Fin n) : Nat :=
  ((List.finRange n).filter fun w => G.adj u w || G.adj v w).length

def maxEdgeNeighborhood {n : Nat} (G : Graph n) : Nat :=
  let vertices := List.finRange n
  (vertices.flatMap fun u =>
    (vertices.filter (G.adj u)).map (edgeNeighborhoodSize G u)).foldr max 0

/-- The conjecture after clearing the denominator. Requiring the bound for
every total dominating set is equivalent to requiring it for a smallest one. -/
def Conjecture256 : Prop :=
  ∀ n : Nat, 2 ≤ n → ∀ G : Graph n, Connected G →
    ∀ D : List (Fin n), D.Nodup → TotalDominates G D →
      2 * minDegreeNeighborCount G ≤ D.length * maxEdgeNeighborhood G

-- The original path is 0--1--2. Each tuple (root, a, b) lists one triangle.
private def triangles : List (Fin 17 × Fin 17 × Fin 17) :=
  [(1, 3, 4), (0, 5, 6), (0, 7, 8), (0, 9, 10),
   (2, 11, 12), (2, 13, 14), (2, 15, 16)]

private def edges : List (Fin 17 × Fin 17) :=
  [(0, 1), (1, 2)] ++
    triangles.flatMap (fun (root, a, b) => [(root, a), (root, b), (a, b)])

private def adjacent (u v : Fin 17) : Bool :=
  edges.contains (u, v) || edges.contains (v, u)

def counterexample : Graph 17 where
  adj := adjacent
  symmetric := by decide
  loopless := by decide

private theorem withinTwoOfCenter :
    ∀ v : Fin 17, v = 1 ∨ counterexample.adj v 1 = true ∨
      ∃ w : Fin 17, counterexample.adj v w = true ∧ counterexample.adj w 1 = true := by
  decide

private theorem Reachable.reverse {n : Nat} {G : Graph n} {u v : Fin n}
    (h : Reachable G u v) : Reachable G v u := by
  induction h with
  | refl w => exact .refl w
  | edge h => exact .edge ((G.symmetric _ _).symm.trans h)
  | trans _ _ first second => exact .trans second first

theorem counterexampleConnected : Connected counterexample := by
  have toCenter (v : Fin 17) : Reachable counterexample v 1 := by
    rcases withinTwoOfCenter v with same | one | ⟨w, first, second⟩
    · subst v
      exact .refl _
    · exact .edge one
    · exact .trans (.edge first) (.edge second)
  intro u v
  exact .trans (toCenter u) (Reachable.reverse (toCenter v))

def chosen : List (Fin 17) := [0, 1, 2]

theorem chosenNodup : chosen.Nodup := by decide
theorem chosenDominates : TotalDominates counterexample chosen := by
  unfold TotalDominates
  decide

theorem counterexampleMinDegree : minDegree counterexample = 2 := by decide
theorem counterexampleNeighborCount : minDegreeNeighborCount counterexample = 17 := by decide
theorem counterexampleMaxEdgeNeighborhood : maxEdgeNeighborhood counterexample = 11 := by decide

/-- The bound would force 34 ≤ 33 for this graph and its three chosen vertices. -/
theorem conjecture256_false : ¬ Conjecture256 := by
  intro h
  have bound := h 17 (by decide) counterexample counterexampleConnected
    chosen chosenNodup chosenDominates
  rw [counterexampleNeighborCount, counterexampleMaxEdgeNeighborhood] at bound
  have impossible : ¬ (2 * 17 ≤ chosen.length * 11) := by decide
  exact impossible bound

#print axioms conjecture256_false

end Graffiti256
