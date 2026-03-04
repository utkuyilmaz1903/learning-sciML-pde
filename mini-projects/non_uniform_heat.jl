using Plots

function solve_non_uniform_heat()
    α = 1.0
    L = 1.0
    Nx = 21
    
    xi = range(-1.0, 1.0, length=Nx)
    x = 0.5 .+ 0.5 .* (xi .^ 3)

    dt = 0.0000001
    Nt = 150000

    u = sin.(π .* x)
    u[1] = 0.0
    u[end] = 0.0

    for n in 1:Nt
        u_new = copy(u)
        
        for i in 2:Nx-1
            h_right = x[i+1] - x[i]
            h_left = x[i] - x[i-1]

            diff_right = (u[i+1] - u[i]) / h_right
            diff_left = (u[i] - u[i-1]) / h_left
            
            u_xx = (2.0 / (h_right + h_left)) * (diff_right - diff_left)
            
            u_new[i] = u[i] + α * dt * u_xx
        end
        u = u_new
    end

    plot(x, u, 
         title="Non-Uniform 1D Heat Equation",
         xlabel="x (Position)", 
         ylabel="Temperature",
         marker=:circle, markersize=5, lw=2, color=:blue, legend=false)
end

solve_non_uniform_heat()
