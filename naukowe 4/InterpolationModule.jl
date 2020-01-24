#Tomasz Janik

module InterpolationModule
    function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
        size = length(f)
        fx = f

        for i = 2:size
            for j = size:-1:i
                fx[j] = (fx[j] - fx[j-1]) / (x[j] - x[j-i+1])
            end
        end

        return fx
    end

    function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
        size = length(x)
        nt = fx[size]

        for i = size-1:-1:1
            nt = fx[i] + (t - x[i]) * nt
        end

        return nt
    end

    function naturalna(x::Vector{Float64}, fx::Vector{Float64})
        size = length(x)
        a = Vector{Float64}(undef, size)
        a[size] = fx[size]

        for i = size-1:-1:1
            a[i] = fx[i] - a[i+1] * x[i]

            for j = i+1:size-1
                a[j] = a[j] - a[j+1] * x[i]
            end
        end

        return a
    end

    function rysujNnfx(f, a::Float64, b::Float64, n::Int)
        xs = Vector{Float64}(undef, n + 1)
        fs = Vector{Float64}(undef, n + 1)

        h = (b - a) / n
        kh = Float64(0)

        for i = 1:n+1
            xs[i] = a + kh
            fs[i] = f(xs[i])
            kh += h
        end

        fx = ilorazyRoznicowe(xs, fs)

        density = 100
        pointsNo = Int64(floor((b-a) * density)) + 1
        h = (b-a) / (pointsNo - 1)
        kh = Float64(0)

        plotx = Vector{Float64}(undef, pointsNo)
        realVals = Vector{Float64}(undef, pointsNo)
        interVals = Vector{Float64}(undef, pointsNo)


        for i = 1:pointsNo
            plotx[i] = a + kh
            realVals[i] = f(plotx[i])
            interVals[i] = warNewton(xs, fx, plotx[i])
            kh += h
        end


        plot(plotx, [realVals, interVals], title=string("n = ", n), label=["Real" "Interpolated"])
        file = string(f, "_n", n)
        savefig(file)
    end

    using Plots

    export ilorazyRoznicowe, warNewton, naturalna, rysujNnfx
end
