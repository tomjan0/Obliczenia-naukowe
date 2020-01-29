##Tomasz Janik

include("../ZerosModule.jl")

function f(x)
    return 3.0*x - exp(x)
end

println(ZerosModule.mbisekcji(f, 0.0, 1.0, 1e-4, 1e-4))
println(ZerosModule.mbisekcji(f, 1.0, 2.0, 1e-4, 1e-4))
