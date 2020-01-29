# Tomasz Janik

#funkcja licząca wartości wyrażeń dla kolejnych ujemnych potęg 8
function z6()
	#argument
	local x::Float64 = 8^-1
	#licznik iteracji
	local i = 1
	while x > 0
		#zadane wyrażenia
		local f::Float64 = sqrt(x*x + 1) - 1
		local g::Float64 = x*x/(sqrt(x*x + 1) + 1)
		println("8^-", i, ":  " , f, "   ", g)
		x = x/8
		i = i+1
	end
end
