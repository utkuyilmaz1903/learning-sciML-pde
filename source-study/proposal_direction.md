# Possible GSoC Direction: MethodOfLines Enhancement

## Motivation
While studying MethodOfLines.jl internals, I observed how spatial derivatives are converted into finite difference operators.

Currently, discretization primarily focuses on standard finite difference schemes. Extending support toward higher-order discretizations could improve accuracy-performance tradeoffs for PDE simulations.

## Idea
Investigate how finite difference stencils are generated and explore:

- higher-order finite difference schemes
- modular stencil definitions
- extensible operator construction

## Why This Direction
This aligns with:
- PDE discretization goals
- MethodOfLines.jl enhancement tasks
- my current learning trajectory

## Next Investigation
- locate stencil coefficient generation
- test manual higher-order discretization
- compare numerical error
