# heat_equation_fd.jl
# Finite Difference solution of the 1D Heat Equation
#
# u_t = α u_xx

using Plots

# Parameters
α = 1.0               # diffusion coefficient
L = 1.0               # length of rod
Nx = 50               # spatial points
dx = L / (Nx - 1)

dt = 0.0005           # time step
Nt = 400              # number of time steps

# Spatial grid
x = range(0, L, length=Nx)

# Initial condition: sine wave
u = sin.(π .* x)

# Boundary conditions
u[1] = 0.0
u[end] = 0.0

# Time evolution
for n in 1:Nt
    u_new = copy(u)

    for i in 2:Nx-1
        u_new[i] = u[i] +
            α * dt/dx^2 *
            (u[i+1] - 2u[i] + u[i-1])
    end

    u = u_new
end

# Plot result
plot(x, u,
     title="Heat Equation Solution (Finite Difference)",
     xlabel="x",
     ylabel="Temperature",
     legend=false)
