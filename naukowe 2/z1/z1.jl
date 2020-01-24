# Tomasz Janik

#funkcja wykonująca obliczenia we Float32
function z1f32()
	local res = Vector{Float32}(undef, 4)
	#wektor 1
	local v1 = Vector{Float32}(undef, 5)
	v1[1] = 2.718281828
	v1[2] = -3.141592654
	v1[3] = 1.414213562
	v1[4] = 0.5772156649
	v1[5] = 0.3010299957
	#wektor 2
	local v2 = Vector{Float32}(undef, 5)
	v2[1] = 1486.2497
	v2[2] = 878366.9879
	v2[3] = -22.37492
	v2[4] = 4773714.64
	v2[5] = 0.00018504
	#iloczyny cząstkowe
	local s = Vector{Float32}(undef, 5)
	s[1] = v1[1]*v2[1]
	s[2] = v1[2]*v2[2]
	s[3] = v1[3]*v2[3]
	s[4] = v1[4]*v2[4]
	s[5] = v1[5]*v2[5]


	#liczenie sumy w przód i w tył
	local sum::Float32 = 0
	local suminv::Float32 = 0
	for i = 1:5
		sum = sum + v1[i]*v2[i]
		suminv = suminv + v1[6-i]*v2[6-i]
	end
	println(sum)
	println(suminv)
	res[1] = sum
	res[2] =suminv

	sum = 0

	#metoda od największego do najmiejszego
	local sneg::Float32 = s[2] + s[3]
	local spos::Float32 =  s[4] + s[1] +s[5]
	local sum = sneg + spos
	println(sum)
	res[3] = sum

	sum = 0
	sneg = 0
	spos = 0
	#metoda od najmniejszego do największego
	local sneg =  s[3] + s[2]
	local spos =  s[5] + s[1] + s[4]
	local sum = spos + sneg
	println(sum)
	res[4] = sum
	println(res)
	return res
end

#funkcja wykonująca obliczenia we Float32
function z1f64()
	local res = Vector{Float64}(undef, 4)
	#wektor 1
	local v1 = Vector{Float64}(undef, 5)
	v1[1] = 2.718281828
	v1[2] = -3.141592654
	v1[3] = 1.414213562
	v1[4] = 0.577215664
	v1[5] = 0.301029995
	#wektor 2
	local v2 = Vector{Float64}(undef, 5)
	v2[1] = 1486.2497
	v2[2] = 878366.9879
	v2[3] = -22.37492
	v2[4] = 4773714.647
	v2[5] = 0.000185049
	#iloczyny cząstkowe
	local s = Vector{Float64}(undef, 5)
	s[1] = v1[1]*v2[1]
	s[2] = v1[2]*v2[2]
	s[3] = v1[3]*v2[3]
	s[4] = v1[4]*v2[4]
	s[5] = v1[5]*v2[5]


	#liczenie sumy w przód i w tył
	local sum::Float64 = 0
	local suminv::Float64 = 0
	for i = 1:5
		sum = sum + v1[i]*v2[i]
		suminv = suminv + v1[6-i]*v2[6-i]
	end
	println(sum)
	println(suminv)
	res[1] = sum
	res[2] = suminv

	sum = 0

	#metoda od największego do najmiejszego
	local sneg::Float64 = s[2] + s[3]
	local spos::Float64 =  s[4] + s[1] +s[5]
	local sum = sneg + spos
	println(sum)
	res[3] = sum

	sum = 0
	sneg = 0
	spos = 0
	#metoda od najmniejszego do największego
	local sneg =  s[3] + s[2]
	local spos =  s[5] + s[1] + s[4]
	local sum = spos + sneg
	println(sum)
	res[4] = sum

	println(res)
	return res
end


z1f32()

z1f64()
 
org32 = [-0.4999443, -0.4543457, -0.5, -0.5]
org64 = [1.0251881368296672e-10, -1.5643308870494366e-10, 0.0, 0.0]

mod32 = [-0.4999443, -0.4543457, -0.5, -0.5]
mod64 = [-0.004296342739891585, -0.004296342998713953, -0.004296342842280865, -0.004296342842280865]

println(org32 - mod32)
println(org64 - mod64)

println(eps(Float64))
