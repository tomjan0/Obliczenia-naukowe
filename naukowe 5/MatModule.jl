#Tomasz Janik
module MatModule

    using SparseArrays, LinearAlgebra

    export readMatrix,readVector, writeRes, generateBVec, gauss, solveGauss,
    gaussPivot, solveGaussPivot, luDecomp, luDecompPivot,
    solveLuDecomp, solveLuDecompPivot

    function readMatrix(filepath::String)
        local data = C_NULL

        open(filepath, "r") do file
            sizes = split(readline(file), " ")
            n = parse(Int64, sizes[1])
            l = parse(Int64, sizes[2])

            A::SparseMatrixCSC{Float64, Int64} = spzeros(Float64, n, n)

            for line in eachline(file)
                data = split(line, " ")
                i = parse(Int64, data[1])
                j = parse(Int64, data[2])
                value = parse(Float64, data[3])

                A[i, j] = value
            end

            data = (A, n, l)
        end
        return data
    end

    function readVector(filepath::String)
        local data = C_NULL

        open(filepath, "r") do file
            n = parse(Int64, readline(file))

            # Vector b
            b = Vector{Float64}(undef, n)
            i = 1

            for line in eachline(file)
                b[i] = parse(Float64, line)
                i += 1
            end

            data = (b, n)
        end

        return data
    end

    function writeRes(filepath::String, x::Vector{Float64}, n::Int64, is_b_gen::Bool)
        local err::Float64
        local x_

        open(filepath, "w") do file
            if is_b_gen
                x_initial = ones(n)

                err = norm(x_initial - x) / norm(x_initial)
                println(file, err)
            end

            for i = 1:n
                println(file, x[i])
            end
        end
    end

    function generateBVec(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64)
        b = Vector{Float64}(undef, n)

        for i = 1:n
            b[i] = Float64(0.0)
            start = max(1, i - (l + 1))
            last  = min(n, i + (l + 1))

            for j = start:last
                b[i] += A[i, j]
            end
        end

        return b
    end

    function gauss(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64, is_lu::Bool)

        for k = 1:n - 1
            count = l + 1 - ((k + 1) % l)
            for i = k + 1:min(k+count,n)

                mult = A[i, k] / A[k, k]

                if is_lu
                    A[i, k] = mult
                else
                    A[i, k] = Float64(0.0)
                end

                for j = k + 1:min(k + l, n)
                    A[i, j] -= mult * A[k, j]
                end

                if !is_lu
                    b[i] -= mult * b[k]
                end
            end
        end

        return (A, b)
    end

    function solveGauss(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
        res = gauss(A, b, n, l, false)

        _A = res[1]
        _b = res[2]

        x = Vector{Float64}(undef, n)

        for i = n:-1:1
            sum = Float64(0.0)

            for j = i + 1:min(n, i + l)
                sum += _A[i, j] * x[j]
            end
            x[i] = (_b[i] - sum) / _A[i, i]
        end
        return x
    end

    function gaussPivot(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64, is_lu::Bool)

        swaps = Vector{Int64}(undef, n)
        for i = 1:n
            swaps[i] = i
        end

        for k = 1:n - 1
            count = l + 1 - ((k + 1) % l)
            maxid = k
            max = abs(A[k, k])

            for i = k+1:min(k+count,n)
                temp = abs(A[swaps[i], k])
                if temp > max
                    max = temp
                    maxid = i
                end
            end

            swaps[k], swaps[maxid] = swaps[maxid], swaps[k]

            for i = k + 1:min(k+count,n)
                mult = A[swaps[i], k] / A[swaps[k], k]

                if is_lu
                    A[swaps[i], k]  = mult
                else
                    A[swaps[i], k]  = Float64(0.0)
                end

                for j = k + 1:min(k + 2 * l, n)
                    A[swaps[i], j] -= mult * A[swaps[k], j]
                end

                if !is_lu
                    b[swaps[i]] -= mult * b[swaps[k]]
                end
            end
        end

        return (A, swaps, b)
    end

    function solveGaussPivot(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
        res = gaussPivot(A, b, n, l, false)

        _A = res[1]
        _swaps = res[2]
        _b = res[3]

        x = Vector{Float64}(undef, n)

        for i = n:-1:1
            sum = Float64(0.0)

            for j = i + 1:min(i + 2 * l + 1, n)
                sum += _A[_swaps[i], j] * x[j]
            end
            x[i] = (_b[_swaps[i]] - sum) / _A[_swaps[i], i]
        end
        return x
    end

    function luDecomp(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
        return gauss(A, b, n, l, true)
    end

    function luDecompPivot(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
         return gaussPivot(A, b, n, l, true)
    end

    function solveLuDecomp(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)


        for i = 1:n-1
            sum = Float64(0.0)
            for j in i+1:min(n, i+ l + 1)
                b[j] = b[j] - A[j, i] * b[i]
            end
        end

        x = Vector{Float64}(undef, n)

        for i = n:-1:1
            sum = Float64(0.0)

            for j = i + 1:min(i+ l, n)
                sum += A[i, j] * x[j]
            end
            x[i] = (b[i] -  sum) / A[i, i]
        end
        return x
        # for i = 1:n
        #     sum = Float64(0.0)
        #
        #     for j = max(1, Int64(l * floor((i - 1) / l))):i-1
        #         sum += A[i, j] * b[i]
        #     end
        #     b[i] = b[i] - sum
        # end
        #
        # x = Vector{Float64}(undef, n)
        #
        # for i = n:-1:1
        #     sum = Float64(0.0)
        #
        #     for j = i + 1:min(n, i + l)
        #         sum += A[i, j] * x[j]
        #     end
        #     x[i] = (b[i] - sum)/ A[i, i]
        # end
        # return x
    end

    function solveLuDecompPivot(A::SparseMatrixCSC{Float64, Int64}, swaps::Vector{Int64},
                                                    b::Vector{Float64}, n::Int64, l::Int64)
        for i = 1:n-1
            sum = Float64(0.0)
            for j in i+1:min(n, 2*l + i + 5)
                b[swaps[j]] = b[swaps[j]] - A[swaps[j], i] * b[swaps[i]]
            end
        end

        x = Vector{Float64}(undef, n)

        for i = n:-1:1
            sum = Float64(0.0)

            for j = i + 1:min(i + 2 * l, n)
                sum += A[swaps[i], j] * x[j]
            end
            x[i] = (b[swaps[i]] -  sum) / A[swaps[i], i]
        end
        return x
    end


end
