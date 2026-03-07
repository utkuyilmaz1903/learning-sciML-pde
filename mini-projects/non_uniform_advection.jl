using ModelingToolkit, MethodOfLines, OrdinaryDiffEq, DomainSets

# Variables and Differential Operators
@parameters t u
@variables n(..) totalPop(..)
Dt = Differential(t)
Du = Differential(u)
Duu = Differential(u)^2

# Simulation Parameters
b0 = 0.5; d0 = 0.1; l = 0.02; ρUp = 0.2; ρDown = 0.5; n0 = 2550.0; K = 10000.0
uMin = 0.0; uMax = 1.0

# Function Definitions
Iu = Integral(u in DomainSets.ClosedInterval(uMin, uMax))
β(u) = b0 + 0.1*u
δ(u) = d0
γ(u) = (β(u) - δ(u))*(1 - totalPop(t,u)/K)
ρ₊(u) = ρUp
ρ₋(u) = ρDown

# PDE System (Advection-Diffusion Equation)
equations  = [
    totalPop(t,u) ~ Iu(n(t,u)),
    Dt(n(t, u)) ~ 
    ( γ(u) - l*Du(ρ₊(u)) + l*Du(ρ₋(u)) + l^2/2*Duu(ρ₊(u)) + l^2/2*Duu(ρ₋(u)) ) * n(t,u) + 
    l*( -ρ₊(u) + ρ₋(u) + l*Du(ρ₊(u)) + l*Du(ρ₋(u)) ) * Du(n(t,u)) +
    l^2/2*( ρ₊(u) + ρ₋(u) ) * Duu(n(t,u))
]

# Boundary and Initial Conditions
bcs = [
    n(0.0, u) ~ n0,
    totalPop(0.0, u) ~ n0, # Added to prevent integration bounds error
    -( l^2/2*( ρ₊(uMin) + ρ₋(uMin) ) * Du(n(t,uMin)) ) + l*(ρ₊(uMin) - ρ₋(uMin)) * n(t,uMin) ~ 0.0,
    -( l^2/2*( ρ₊(uMax) + ρ₋(uMax) ) * Du(n(t,uMax)) ) + l*(ρ₊(uMax) - ρ₋(uMax)) * n(t,uMax) ~ 0.0
]

domains = [
    t ∈ Interval(0.0, 10.0),
    u ∈ Interval(uMin, uMax),
]

# The core feature: Non-uniform Vector Grid
uSteps = collect(range(0, 1, length=20)) 
@named pdesys = PDESystem(equations, bcs, domains, [t, u], [n(t,u), totalPop(t,u)])

# Discretization with UpwindScheme (Supported by our fix in PR #533)
discretization = MOLFiniteDifference([u => uSteps], t; advection_scheme = UpwindScheme())

println("Discretizing the model with a non-uniform vector grid...")
prob = discretize(pdesys, discretization)

println("Solving the ODE problem...")
sol = solve(prob, Tsit5(), saveat=1.0)
println("Simulation completed successfully! Solution matrix size: ", size(sol))
