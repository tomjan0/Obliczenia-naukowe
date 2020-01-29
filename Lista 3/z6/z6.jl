#Tomasz Janik
include("../ZerosModule.jl")


function f1(x)
    return exp(1.0 -x) - 1.0
end

function f2(x)
    return x*exp(-x)
end

function pf1(x)
    return -exp(1.0 - x)
end

function pf2(x)
    return -exp(-x)*(x-1.0)
end

delta = 1e-5
epsilon = 1e-5

println(ZerosModule.mbisekcji(f1, 0.0, 1.5, delta, epsilon))
println(ZerosModule.mstycznych(f1,pf1, 1.5, delta, epsilon, 200))
println(ZerosModule.msiecznych(f1, 0.0, 1.5, delta, epsilon, 200))

println(ZerosModule.mbisekcji(f2, -0.5, 1.0, delta, epsilon))
println(ZerosModule.mstycznych(f2,pf2, -0.5, delta, epsilon, 200))
println(ZerosModule.msiecznych(f2, -0.5, 1.0, delta, epsilon, 200))

println(ZerosModule.mstycznych(f1,pf1, 100.0, delta, epsilon, 200))
println(ZerosModule.mstycznych(f1,pf1, 5.0, delta, epsilon, 200))

println(ZerosModule.mstycznych(f2,pf2, 8.0, delta, epsilon, 200))
println(ZerosModule.mstycznych(f2,pf2, 45.0, delta, epsilon, 200))

println(ZerosModule.mbisekcji(f1, -10.0, 100.0, delta, epsilon))
println(ZerosModule.mbisekcji(f2, -243.0, 22.0, delta, epsilon))

println(ZerosModule.msiecznych(f1, 8.0, 1.0, delta, epsilon, 200))
println(ZerosModule.msiecznych(f2, 16.0, -12.0, delta, epsilon, 200))
