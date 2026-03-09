# The Mathematics of WENO on Non-Uniform Grids

## 1. The Uniform Assumption (Why it fails)
In the classic WENO-5 scheme, the smoothness indicators ($\beta_k$) for the three 3-point substencils are calculated using fixed coefficients. For example:

$\beta_0 = \frac{13}{12} (u_{i-2} - 2u_{i-1} + u_i)^2 + \frac{1}{4} (u_{i-2} - 4u_{i-1} + 3u_i)^2$

These constants ($\frac{13}{12}$ and $\frac{1}{4}$) heavily rely on the assumption that $\Delta x$ is constant across the entire domain. When we pass an `AbstractVector` representing a non-uniform grid to the current `MethodOfLines.jl` implementation, the scheme either throws a `BoundsError` or produces physically incorrect oscillations because the underlying fixed-coefficient math breaks down.

## 2. The Non-Uniform Solution
To support non-uniform grids, the smoothness indicators must be derived dynamically based on the local grid spacings. 

Let the local spacings be:
* $h_1 = x_{i-1} - x_{i-2}$
* $h_2 = x_i - x_{i-1}$
* $h_3 = x_{i+1} - x_i$
* $h_4 = x_{i+2} - x_{i+1}$

The reconstructed polynomials and their derivatives must be computed using these dynamic $h_k$ values instead of a global $\Delta x$. This requires assembling a generalized formulation for the smoothness indicators $\beta_k(h_1, h_2, h_3, h_4)$, which is mathematically intensive but computationally necessary for stable shock-capturing on clustered grids.
