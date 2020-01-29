#Tomasz Janik

include("../ZerosModule.jl")

function f(x)
    return sin(x) - (x/2)^2
end

function pf(x)
    return cos(x) - x/2
end

println(ZerosModule.mbisekcji(f, 1.5, 2.0, 5e-6, 5e-6))
println(ZerosModule.mstycznych(f, pf, 1.5, 5e-6, 5e-6, 100))
println(ZerosModule.msiecznych(f, 1.0, 2.0, 5e-6, 5e-6, 100))
