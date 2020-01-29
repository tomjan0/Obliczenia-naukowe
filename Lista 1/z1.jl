# Tomasz Janik

#funkcja obliczajca macheps
function macheps()
	#zmienne dla każdgo typu
	local f16::Float16 = 1
	local f32::Float32 = 1
	local f64::Float64 = 1
	#sprawdzanie warunku
	while(1+f64/2 != 1)
		if f32/2 + 1 != 1
			f32 = f32/2
		end
		if f16/2 + 1 != 1
			f16 = f16/2
		end
		f64 = f64/2
	end

	print("$f16  $f32  $f64\n")
end

#funkcja obliczajca eta
function eta()
	#zmienne dla każdgo typu
	local f16::Float16 = 1
	local f32::Float32 = 1
	local f64::Float64 = 1
	while(f64/2>0)
		if f32/2 > 0
			f32 = f32/2
		end
		if f16/2 > 0
			f16 = f16/2
		end
		f64 = f64/2
	end
	#sprawdzanie warunku
	print("$f16  $f32  $f64\n")
end

#funkcja obliczajca max
function max()
	#zmienne dla części całkowitej każdgo typu
	local f16::Float16 = 1
	local f32::Float32 = 1
	local f64::Float64 = 1
	#obliczanie części całkowiej
	while(!isinf(f64*2))
		if !isinf(f32*2)
			f32 = f32*2
		end
		if !isinf(f16*2)
			f16 = f16*2
		end
			f64 = f64*2
	end
    #zmienne dla części ułamkowej każdgo typu
	local half16 = f16/2
	local half32 = f32/2
	local half64 = f64/2
	#obliczanie części ułamkowej
	while (!(isinf(f64+half64)))
		if !isinf(f32+half32)
			f32 = f32 + half32
			half32 = half32/2
		end
		if !isinf(f16 + half16)
			f16 = f16 + half16
			half16 = half16/2
		end
			f64 = f64+half64
			half64 = half64/2
	end
	print(f64,"  ",  f32, "  " , f16)
end
