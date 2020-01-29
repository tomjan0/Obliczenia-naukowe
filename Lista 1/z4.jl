# Tomasz Janik

#funkcja znajdująca taki x, że x*(1/x) != 1 wprzedziale (1,2)
function z4a()
	local x = 1.0 + 2^-52;
	while x*(1/x) == 1.0 && x > 1
		x = x + 2^-52
	end
	println(x)
end

#funkcja znajdująca najmniejszy taki x, że x*(1/x) != 1
function z4b()
	local x = floatmin(Float64)
	while x*(1/x) == 1.0
		x = nextfloat(x)
	end
	println(x)
end
