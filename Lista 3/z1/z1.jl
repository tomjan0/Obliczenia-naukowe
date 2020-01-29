#Tomasz Janik
#Find 0 of a function in given interval

function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    fa = f(a)
    fb = f(b)
    e = b - a
    r = a + e
    v = f(r)
    it = 0;
    if(sign(fa) == sign(fb))
        return (r, v, it, 1)
    end

    while (true)
        it = it + 1
        e = e/2
        r = a + e
        v = f(r)
        if (abs(e) < delta || abs(v) < epsilon)
            return (r,v,it, 0)
        end
        if (sign(v) != sign(fa))
            b = r
            fb = v
        else
            a = r
            fa = v
        end
    end
end
