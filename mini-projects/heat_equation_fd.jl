using Plots

function solve_heat_equation()
    
    α = 1.0
    L = 1.0
    Nx = 50
    dx = L / (Nx - 1)

    dt = 0.0001
    Nt = 2000

    x = range(0, L, length=Nx)

    u = sin.(π .* x)


    u[1] = 0.0
    u[end] = 0.0

    for n in 1:Nt
        u_new = copy(u)

        for i in 2:Nx-1
            u_new[i] = u[i] + α * dt/dx^2 * (u[i+1] - 2u[i] + u[i-1])
        end

        u = u_new 
    end

    
    plot(x, u,
         title="1D Heat Equation (Finite Difference)",
         xlabel="x (Position)",
         ylabel="Temperature",
         legend=false,
         color=:red, lw=2)
end

solve_heat_equation()
