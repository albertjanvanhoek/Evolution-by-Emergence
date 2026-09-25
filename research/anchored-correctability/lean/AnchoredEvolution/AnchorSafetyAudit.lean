import AnchoredEvolution.AnchorSafety

/-!
# Axiom audit: Anchor-Safety policy layer

Kept as a separate audit surface so the established 227-result Anchored
Correctability audit remains traceable while this post-v21.1 policy extension
is reviewed independently.

`Classical.choice` is expected only where the cut-separation formulation
extracts a separating witness from failure of indistinguishability. `sorryAx`
must never appear.
-/

#print axioms Anchored.AnchorSafety.discoverable_iff_not_sealed
#print axioms Anchored.AnchorSafety.anchorSafe_iff_unsealed
#print axioms Anchored.AnchorSafety.anchorSafe_iff_cuts_separated
#print axioms Anchored.AnchorSafety.sealed_error_invisible
#print axioms Anchored.AnchorSafety.evidence_preserves_safety
#print axioms Anchored.AnchorSafety.dropping_commitments_preserves_safety
#print axioms Anchored.AnchorSafety.redundant_cutsNothing
#print axioms Anchored.AnchorSafety.reconfiguration_preserves_safety
#print axioms Anchored.AnchorSafety.prune_safe
#print axioms Anchored.AnchorSafety.prune_redundant_safe
#print axioms Anchored.AnchorSafety.last_route_removal_seals
#print axioms Anchored.AnchorSafety.redundant_never_last
#print axioms Anchored.AnchorSafety.permanent_seal_permanent_error
#print axioms Anchored.AnchorSafety.repairable_seal_is_delay
#print axioms Anchored.AnchorSafety.irreversible_not_repairable
