#Tomasz Janik

include("../InterpolationModule.jl")

function f1(x)
    return exp(x)
end

function f2(x)
    return x*x*sin(x)
end

InterpolationModule.rysujNnfx(f1, Float64(0), Float64(1), 5)
InterpolationModule.rysujNnfx(f1, Float64(0), Float64(1), 10)
InterpolationModule.rysujNnfx(f1, Float64(0), Float64(1), 15)

InterpolationModule.rysujNnfx(f2, Float64(-1), Float64(1), 5)
InterpolationModule.rysujNnfx(f2, Float64(-1), Float64(1), 10)
InterpolationModule.rysujNnfx(f2, Float64(-1), Float64(1), 15)
