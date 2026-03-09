using BenchmarkTools

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

N = 50
m = 2

# 1. Uniform Grid
x_uniform = collect(range(0.0, 1.0, length=N))
x0_uni = x_uniform[25]

# 2. Non-Uniform Grid
x_nonuniform = 0.5 .+ 0.5 .* (range(-1.0, 1.0, length=N) .^ 3)
x0_non = x_nonuniform[25]

println("=== Fornberg Algorithm Benchmark ===")
println("Grid Size: $N points, Derivative Order: $m")

println("\n1. Uniform Grid Performance:")
@btime fd_weights($x_uniform, $x0_uni, $m)

println("\n2. Non-Uniform Grid Performance:")
@btime fd_weights($x_nonuniform, $x0_non, $m)
