using LinearAlgebra
using Plots

# Fornberg finite difference weights
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


# test function
f(x) = sin(x)
df(x) = cos(x)

# point where derivative is evaluated
x0 = 0.5

# uniform grid
x_uniform = x0 .+ [-0.2, -0.1, 0.0, 0.1]

# non-uniform grid
x_nonuniform = [0.2, 0.45, 0.5, 0.8]

# compute weights
w_uni = fd_weights(x_uniform, x0, 1)[:,2]
w_non = fd_weights(x_nonuniform, x0, 1)[:,2]

# derivative approximation
approx_uni = sum(w_uni .* f.(x_uniform))
approx_non = sum(w_non .* f.(x_nonuniform))

# exact derivative
exact = df(x0)

error_uni = abs(approx_uni - exact)
error_non = abs(approx_non - exact)

println("Uniform grid error: ", error_uni)
println("Non-uniform grid error: ", error_non)


bar(
    ["uniform grid", "non-uniform grid"],
    [error_uni, error_non],
    title="Derivative Approximation Error",
    ylabel="Absolute Error",
    legend=false
)
