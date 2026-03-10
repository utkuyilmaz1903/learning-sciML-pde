using Plots

function solve_non_uniform_heat_2d()
    println("Initializing 2D Non-Uniform Heat Equation...")
    
    α = 1.0
    L = 1.0
    N = 21
    xi = range(-1.0, 1.0, length=N)
    x = 0.5 .+ 0.5 .* (xi .^ 3)
    y = copy(x)

    dt = 0.00000005 
    Nt = 50000

    u = zeros(N, N)
    
    center_idx = 11
    u[center_idx, center_idx] = 1.0

    println("Starting simulation for $Nt steps. This might take a few seconds due to tiny dt...")

    for n in 1:Nt
        u_new = copy(u)
        for i in 2:N-1
            for j in 2:N-1
                hx_right = x[i+1] - x[i]
                hx_left  = x[i] - x[i-1]
                
                hy_top    = y[j+1] - y[j]
                hy_bottom = y[j] - y[j-1]

                diff_x_right = (u[i+1, j] - u[i, j]) / hx_right
                diff_x_left  = (u[i, j] - u[i-1, j]) / hx_left
                u_xx = (2.0 / (hx_right + hx_left)) * (diff_x_right - diff_x_left)
                
                diff_y_top    = (u[i, j+1] - u[i, j]) / hy_top
                diff_y_bottom = (u[i, j] - u[i, j-1]) / hy_bottom
                u_yy = (2.0 / (hy_top + hy_bottom)) * (diff_y_top - diff_y_bottom)
                
                u_new[i, j] = u[i, j] + α * dt * (u_xx + u_yy)
            end
        end
        u = u_new
    end

    println("Simulation finished! Generating Heatmap...")
    println("Simulation finished! Normalizing data for clear visualization...")

    u_normalized = u ./ maximum(u)

    heatmap(x, y, u_normalized', 
            title="2D Heat Equation on Non-Uniform Grid",
            xlabel="x (Position)", 
            ylabel="y (Position)",
            color=:inferno,
            aspect_ratio=:equal)
end

solve_non_uniform_heat_2d()
