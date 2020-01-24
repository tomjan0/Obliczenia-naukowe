#Tomasz Janik
function seq(c, x0)
    xn = x0
    for i in 1:40
        xn = xn^2 + c
        # print("$xn,")
    end
    println(xn)
end


seq(-2, 1)
seq(-2, 2)
seq(-2, 1.99999999999999)
seq(-1, 1.0)
seq(-1, -1.0)
seq(-1, 0.75)
seq(-1, 0.25)
