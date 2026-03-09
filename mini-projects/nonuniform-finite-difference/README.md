# Non-Uniform Finite Difference Prototype

This mini-project explores how finite difference weights can be computed
for **non-uniform grids** using the Fornberg algorithm.

This topic is relevant for PDE discretization frameworks such as:

- MethodOfLines.jl
- DiffEqOperators.jl

## Goal

Understand how derivative stencils differ between:

- uniform grids
- non-uniform grids

## Prototype

The prototype computes derivative weights for arbitrary grid spacing.

Example non-uniform grid:


x = [0.0, 0.1, 0.25, 0.6]


Using the Fornberg algorithm we compute weights for derivative approximation.

## Motivation

Supporting non-uniform grids is important for:

- adaptive meshes
- boundary layer resolution
- stretched coordinate systems

This prototype was created as part of learning SciML internals.
