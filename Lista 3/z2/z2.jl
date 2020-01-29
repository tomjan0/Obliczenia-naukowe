#Tomasz Janik

function mstycznych(f,pf,x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    r = x0
    v = f(r)
    if (abs(v) < epsilon)
        return (r, v, 0, 0)
    end

    if abs(pf(x0)) < epsilon
        return (r, v, 0, 2)
    end

    for it in 1:maxit
        next = r - v/pf(r)
        v = f(next)
        if(abs(next - r) < delta || abs(v) < epsilon)
            return (next, v, it, 0)
        end
        r = next
    end

    return (r, v, maxit, 1)
end
