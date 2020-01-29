#Tomasz Janik

function p(p0, r)
    pn::Float32 = p0
    println("0 $p0")
    for i in 1:40
        pn = pn + r * pn * (1-pn)
        println("$i $pn")
    end
end

function p1(p0, r)
    pn=p0
    pnmod = p0
    println("0 $p0")
    for i in 1:10
        pn = pn + r*pn*(1-pn)
        pnmod = pnmod + r*pnmod*(1-pnmod)
        println("$i;$pn;$pnmod")
    end
    pnmod = trunc(pn*1000)/1000
    for i in 11:40
        pn = pn + r*pn*(1-pn)
        pnmod = pnmod + r*pnmod*(1-pnmod)
        println("$i;$pn;$pnmod")
    end
end

function p2()
    pn32 = Float32(0.01)
    pn64 = Float64(0.01)
    r32 = Float32(3)
    r64 = Float64(3)
    for i in 1:40
        pn32 = pn32 + r32 * pn32 * (1-pn32)
        pn64 = pn64 + r64 * pn64 * (1-pn64)
        println("$i;$pn32;$pn64")
    end
end

p1(Float32(0.01), Float32(3))
p2()
