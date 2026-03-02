using ModelingToolkit
using MethodOfLines
using DifferentialEquations
using DomainSets
using Plots

@parameters t x
@variables u(..)

Dt = Differential(t)
Dx = Differential(x)
Dxx = Dx^2

eq = Dt(u(t,x)) ~ Dxx(u(t,x))

domains = [
    t ∈ Interval(0.0, 0.5),
    x ∈ Interval(0.0, 1.0)
]

bcs = [
    u(0,x) ~ sin(π*x),
    u(t,0) ~ 0.0,
    u(t,1) ~ 0.0
]

@named pdesys = PDESystem(eq, bcs, domains, [t,x], [u(t,x)])

dx = 0.02
discretization = MOLFiniteDifference([x=>dx], t)

prob = discretize(pdesys, discretization)
sol = solve(prob, Tsit5(), saveat=0.01)

x_grid = sol[x]
t_grid = sol.t
u_matrix = sol[u(t, x)]

surface(x_grid, t_grid, u_matrix,
        xlabel="x (Position)", 
        ylabel="t (Time)", 
        zlabel="u(t,x) (Temperature)",
        title="1D Heat Equation Solution",
        color=:viridis)


