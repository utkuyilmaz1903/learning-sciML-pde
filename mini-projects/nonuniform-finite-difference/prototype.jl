using LinearAlgebra

"""
Compute finite difference weights for a non-uniform grid
using the Fornberg algorithm.
"""
function fd_weights(x, x0, m)
    n = length(x)
    c = zeros(n, m+1)

    c1 = 1.0
    c4 = x[1] - x0
    c[1,1] = 1.0

    for i in 2:n
        mn = min(i-1, m)
        c2 = 1.0
        c5 = c4
        c4 = x[i] - x0

        for j in 1:i-1
            c3 = x[i] - x[j]
            c2 *= c3

            if j == i-1
                for k in mn:-1:1
                    c[i,k+1] = c1*(k*c[i-1,k] - c5*c[i-1,k+1]) / c2
                end
                c[i,1] = -c1*c5*c[i-1,1] / c2
            end

            for k in mn:-1:1
                c[j,k+1] = (c4*c[j,k+1] - k*c[j,k]) / c3
            end

            c[j,1] = c4*c[j,1] / c3
        end

        c1 = c2
    end

    return c
end


# Example non-uniform grid
x = [0.0, 0.1, 0.25, 0.6]
x0 = x[2]

weights = fd_weights(x, x0, 1)

println("Finite difference weights:")
println(weights[:,2])
