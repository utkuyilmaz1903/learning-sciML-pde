using Plots
using Printf

function build_fvm_geometry()
    println("FVM Non-Uniform Grid Geometry Builder")
    N_nodes = 21
    xi = range(-1.0, 1.0, length=N_nodes)
    x_nodes = 0.5 .+ 0.5 .* (xi .^ 3) # Grid clustered towards the center
    
    # In FVM, faces are typically located halfway between two nodes. 
    # Boundaries are the absolute ends of the domain.
    x_faces = zeros(N_nodes + 1)
    x_faces[1] = x_nodes[1]       # Left boundary
    x_faces[end] = x_nodes[end]   # Right boundary
    
    for i in 2:N_nodes
        x_faces[i] = (x_nodes[i-1] + x_nodes[i]) / 2.0
    end
    cell_volumes = diff(x_faces)
    
    # Mass Conservation Verification
    total_volume = sum(cell_volumes)
    expected_volume = x_nodes[end] - x_nodes[1]
    
    println("Domain Start: ", x_nodes[1])
    println("Domain End:   ", x_nodes[end])
    @printf("Calculated Total Volume: %.10f\n", total_volume)
    @printf("Expected Total Volume:   %.10f\n", expected_volume)
    
    if abs(total_volume - expected_volume) < 1e-10
        println("-> SUCCESS: Mass Conservation verified. Cells perfectly cover the domain.")
    else
        println("-> ERROR: Volume loss detected!")
    end
  
    p = scatter(x_nodes, zeros(N_nodes), marker=:circle, markersize=6, 
                label="Nodes (Cell Centers)", color=:blue, grid=false)
    scatter!(p, x_faces, zeros(N_nodes+1), marker=:vline, markersize=15, 
             label="Cell Faces (Interfaces)", color=:red)
             
    plot!(p, title="FVM Geometry on Non-Uniform Grid", 
          yticks=:none, xlabel="Spatial Domain (x)", legend=:topleft)
          
    display(p)
    savefig(p, "fvm_nonuniform_geometry.png")
end

build_fvm_geometry()
