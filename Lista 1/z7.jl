# Tomasz Janik

#zadana funkcja do szukania pochodnej
function f(x)
	return Float64(sin(x) + cos(3*x))
end

#funkcja obliczająca przybliżone wartości pochodnej dla f
function z7()
	#dokładna wartość pochodnej
	local exact::Float64 = cos(1) - 3*sin(3)
	for n = 0:54
		local h::Float64 = 2.0^(-n)
		#warotść przybliżona pochodnej w danej iteracji
		local estimation::Float64 = (f(1+h) - f(1))/h
		println("h = 2^-", n, " | ~f' = ", estimation, "  diff = ", estimation-exact)
	end
end

#funkcja wyświetlając zmiany h w zależności od n
function z72()
	for n = 0:54
		local h::Float64 = 2.0^(-n)
		println(n, "  ", h, "  ", h + 1.0)
	end
end
