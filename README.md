# Learning SciML PDE Discretization

This repository documents my learning journey and technical preparation for contributing to the SciML ecosystem, specifically towards **PDE discretization and numerical methods** projects.

My goal is to prepare for a Google Summer of Code (GSoC) project focused on:

> Discretizations of Partial Differential Equations (PDEs)

within the SciML organization.

---

## Background

I am a Computer Engineering student with strong foundations in:

- Differential Equations (AA)
- Linear Algebra (AA)
- Calculus and numerical reasoning

While exploring the SciML ecosystem, I encountered and resolved an installation-related issue and successfully contributed a merged pull request to the project. https://github.com/SciML/SciMLBase.jl/pull/1258 This experience motivated me to deeply understand the numerical and architectural foundations behind SciML's PDE tooling.

This repository serves as a **public learning log** showing my progress toward becoming an effective open-source contributor.

---

## Learning Objectives

The main goals of this repository are:

- Understand numerical discretization of PDEs
- Learn Finite Difference and Method of Lines approaches
- Study internal design of SciML PDE tools
- Explore how mathematical models become executable solvers
- Prepare meaningful contributions to SciML libraries

---

## Topics Covered

### Numerical PDE Foundations
- Finite Difference Method (FDM)
- Method of Lines (MOL)
- Stability intuition
- Grid discretization

### SciML Ecosystem
- DifferentialEquations.jl
- ModelingToolkit.jl
- MethodOfLines.jl

### Software Understanding
- Reading scientific computing source code
- Understanding solver abstractions
- Experiment-driven learning

---

## Repository Structure

```
learning-sciML-pde/
│
├── mini-projects/        # Small PDE implementations
├── WENO-NonUniform-Math  # WENO prototype functions for uniform and non-uniform grids
├── benchmarks/           # Performance and allocation tests
├── myNotes
└── source-study/         # Internal library exploration
```

---

## Progress

This repository is updated continuously as I:

- implement numerical methods from scratch,
- reproduce SciML examples,
- analyze internal implementations,
- and document insights gained during learning.

---

## Motivation

Rather than only applying to projects, I believe the best way to contribute to open source scientific computing is to **learn in public** and progressively integrate into the ecosystem.

This repository represents that process.

---

## Long-Term Goal

To contribute production-quality improvements to PDE discretization tooling in SciML and help make advanced numerical computing more accessible to users.

---

## Status

Active learning and preparation in progress.

### Mini Project 1
Finite Difference implementation of the 1D Heat Equation to understand PDE discretization fundamentals.

### Mini Project 2
Heat Equation solved using SciML's MethodOfLines.jl discretization pipeline.
Comparison between manual finite differences and automated discretization.

### Mini Project 3: Non-Uniform 1D Heat Equation (Proof of Concept)
A custom implementation of the 1D Heat Equation using an Explicit Finite Difference Method on a **non-uniform grid**. 
* Mapped a uniform spatial array into a clustered grid using a cubic function to focus on high-gradient areas.
* Dynamically calculated local spatial steps (`h_left` and `h_right`) for the second derivative stencil.
* Demonstrated the severe time-step penalty (microscopic `dt` requirement) caused by the explicit stability criterion on dense grids, highlighting the necessity of implicit solvers provided by `MethodOfLines.jl`.

### Mini Project 4: Non-Uniform Grid Advection-Diffusion Model
This project demonstrates the implementation of a microscopic gradient dynamics model (Advection-Diffusion PDE) utilizing a **non-uniform vector grid**. 

* **Key Feature:** Discretization is performed using `MOLFiniteDifference` with an explicit `UpwindScheme` on an `AbstractVector` grid. 
* **Open Source Contribution:** During the development of this model, a `BoundsError` bug in the core `MethodOfLines.jl` library regarding vector grid offsets was identified and successfully patched. You can review the fix here: [SciML/MethodOfLines.jl#533](https://github.com/SciML/MethodOfLines.jl/pull/533).

### Mini Project 5: Fornberg Algorithm Benchmarking
Performance testing of the Fornberg algorithm for dynamic finite difference weight generation on non-uniform grids.
* Utilized `BenchmarkTools.jl` to profile execution time and memory allocations.
* **Result:** Proved that node-by-node dynamic weight calculation has **zero performance overhead** and **zero extra memory allocation** compared to uniform grids, clearing the path for `MethodOfLines.jl` integration.

### Mini Project 6: WENO Scheme Math on Non-Uniform Grids
Theoretical analysis and code prototyping of WENO smoothness indicators ($\beta_k$) for clustered grids.
* Demonstrated why classic hardcoded fractional weights (like 13/12 or 1/4) cause bounds errors and fail on non-uniform domains.
* Prototyped the mathematical necessity of dynamically calculating indicators based on local geometric distances ($h_k$) to prepare for full Lagrange interpolation in the GSoC project.

### Mini Project 7: 2D Non-Uniform Heat Equation
Extended the non-uniform grid logic to multi-dimensional PDEs to explore spatial stability.
* Implemented the 2D Heat Equation from scratch using a clustered cubic grid on both the X and Y axes.
* Dynamically calculated 2D Laplacian stencils ($u_{xx} + u_{yy}$) for variable geometric distances.
* Demonstrated the severe time-step constraints (microscopic `dt`) in explicit 2D schemes on clustered grids, further emphasizing the need for robust implicit solvers in `MethodOfLines.jl`.


