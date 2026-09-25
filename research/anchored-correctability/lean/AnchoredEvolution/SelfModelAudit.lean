import AnchoredEvolution.SelfModel

/-!
# Axiom audit: self-model layer

Every headline result is expressed inside the Anchor-Safety vocabulary: self-claims
inherit the same correctability law as world-claims. `sorryAx` must never appear.
-/

#print axioms Anchored.SelfModel.self_claims_inherit
#print axioms Anchored.SelfModel.sealed_self_claim_breaks_safety
#print axioms Anchored.SelfModel.historyState_indist_iff
#print axioms Anchored.SelfModel.buffer_seals_dependence
#print axioms Anchored.SelfModel.buffer_exhausted_pairwise
#print axioms Anchored.SelfModel.pivotal_removal_seals
#print axioms Anchored.SelfModel.determined_removal_safe
#print axioms Anchored.SelfModel.determined_not_pivotal
#print axioms Anchored.SelfModel.backup_becomes_pivotal
#print axioms Anchored.SelfModel.introState_indist_iff
#print axioms Anchored.SelfModel.introspection_seals_both
