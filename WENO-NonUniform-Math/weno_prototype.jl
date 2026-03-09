function beta0_uniform(u_im2, u_im1, u_i)
    # The constants 13/12 and 1/4 are hardcoded, assuming constant dx
    term1 = (13.0 / 12.0) * (u_im2 - 2.0*u_im1 + u_i)^2
    term2 = (1.0 / 4.0) * (u_im2 - 4.0*u_im1 + 3.0*u_i)^2
    return term1 + term2
end

function beta0_nonuniform(u_im2, u_im1, u_i, x_im2, x_im1, x_i)
    h1 = x_im1 - x_im2
    h2 = x_i - x_im1
    
    # In the GSoC project, this will be fully derived using Lagrange interpolation.
    w1_dynamic = (h1^2 + h1*h2 + h2^2) / (h1 + h2)^2

    println(" -> Dynamic distances calculated: h1 = $h1, h2 = $h2")
    
    return w1_dynamic
end

println("=== WENO Theory Prototype Loaded ===")
println("Uniform beta0 calculates quickly but fails on clustered grids.")
println("Non-Uniform beta0 requires local distance calculations before applying weights.\n")

println("--- RUNNING TESTS ---")

u_vals = [1.0, 1.2, 1.5]

println("\nTest 1: Uniform Function Call")
beta_uni = beta0_uniform(u_vals[1], u_vals[2], u_vals[3])
println(" -> Uniform beta0 Result: ", beta_uni)

println("\nTest 2: Non-Uniform Function Call")

x_vals = [0.0, 0.05, 0.2] 
beta_non = beta0_nonuniform(u_vals[1], u_vals[2], u_vals[3], x_vals[1], x_vals[2], x_vals[3])
println(" -> Non-Uniform Dynamic Weight Result: ", beta_non)
println("\nTest Completed Successfully!")
