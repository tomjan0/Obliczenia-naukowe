#Tomasz Janik

include("../InterpolationModule.jl")

function f1(x)
    return abs(x)
end

function f2(x)
    return 1 / (1 + x * x)
end

InterpolationModule.rysujNnfx(f1, Float64(-1), Float64(1), 5)
InterpolationModule.rysujNnfx(f1, Float64(-1), Float64(1), 10)
InterpolationModule.rysujNnfx(f1, Float64(-1), Float64(1), 15)

InterpolationModule.rysujNnfx(f2, Float64(-5), Float64(5), 5)
InterpolationModule.rysujNnfx(f2, Float64(-5), Float64(5), 10)
InterpolationModule.rysujNnfx(f2, Float64(-5), Float64(5), 15)
