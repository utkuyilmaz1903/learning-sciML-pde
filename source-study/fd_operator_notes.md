# Finite Difference Operator Study

## Goal
Understand how spatial derivatives are converted into finite difference stencils in MethodOfLines.jl.

---

## Observations
- MOLFiniteDifference defines discretization strategy.
- Spatial derivatives replaced during discretization.
- Grid spacing affects generated operators.

---

## Questions
- Where stencil coefficients defined?
- Can higher-order schemes be added?
- How would non-uniform grids change this?
