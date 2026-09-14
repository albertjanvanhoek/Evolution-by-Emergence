# When Does Change Become Cumulative?

Formal note extending the Organizational Accessibility framework with a stronger monotone-ratchet criterion.

Core definition:

\[
\mathcal R_t\subsetneq\mathcal R_{t+1}
\]

under a declared target family, evaluation protocol, horizon, establishment criterion, and accessibility threshold.

The note distinguishes:

- **cumulative organizational contribution** from the existing framework: retained history causally improves access to a designated later target;
- **strong monotone accessibility click**: the declared accessible repertoire is preserved and strictly expanded;
- **historically attributed ratchet click**: a strict monotone click for which retained earlier organization causally contributes to at least one newly accessible target under the parent framework's intervention criterion.

The machine-verified algebra is in:

formalization/cumulative-accessibility/CumulativeAccessibility.lean

This note is deliberately conditional. It does not claim that evolution generally follows the preorder, that complexity increases monotonically, or that cost is interchangeable with the probabilistic accessibility kernel.
