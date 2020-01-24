#Tomasz Janik

include("./ZerosModule.jl")
using Test

function f1(x)
    return sin(x) - (x/2)^2
end

function pf1(x)
    return cos(x) - x/2
end

function f2(x)
    return x*exp(-x)
end

function pf2(x)
    return -exp(-x)*(x-1.0)
end

@test ZerosModule.mbisekcji(f1, 1.5, 2.0, 1e-4, 1e-4)[1] ≈ 1.93375 atol=1e-4
@test ZerosModule.mbisekcji(f2, -24.0, 2.0, 1e-4, 1e-4)[1] ≈ 0.0 atol=1e-4
@test ZerosModule.mstycznych(f1, pf1, 1.5, 1e-4, 1e-4, 100)[1] ≈ 1.93375 atol=1e-4
@test ZerosModule.msiecznych(f1, 1.0, 2.0, 1e-4, 1e-4, 100)[1] ≈ 1.93375 atol=1e-4
@test ZerosModule.mstycznych(f2, pf2, -0.5, 1e-4, 1e-4, 100)[1] ≈ 0.0 atol=1e-4
@test ZerosModule.msiecznych(f2, -0.5, 1.0, 1e-4, 1e-4, 100)[1] ≈ 0.0 atol=1e-4
@test ZerosModule.mstycznych(f2, pf2, 1.0, 1e-4, 1e-4, 100)[4] == 2
