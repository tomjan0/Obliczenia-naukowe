#Tomasz Janik
include("testfuns.jl")
include("matrixgen.jl")
using .matrixgen
using Plots
using SparseArrays

# testGauss("Dane16_1_1/A.txt", "Dane16_1_1/b.txt", "out.txt", true, false)
# testGauss("Dane10000_1_1/A.txt", "Dane10000_1_1/b.txt", "out.txt", true, false)
# testGauss("Dane50000_1_1/A.txt", "Dane50000_1_1/b.txt", "gauspivot.txt", true, true)
# testGauss("Dane16_1_1/A.txt", "Dane16_1_1/b.txt", "out.txt", false, false)
# testGauss("Dane10000_1_1/A.txt", "Dane10000_1_1/b.txt", "out.txt", false, false)
# testGauss("Dane50000_1_1/A.txt", "Dane50000_1_1/b.txt", "gaus.txt", false, true)

# testLU("Dane16_1_1/A.txt", "Dane16_1_1/b.txt", "out.txt", true, false)
# testLU("Dane10000_1_1/A.txt", "Dane10000_1_1/b.txt", "out.txt", true, false)
# testLU("Dane50000_1_1/A.txt", "Dane50000_1_1/b.txt", "lupivot.txt", true, true)
# testLU("Dane16_1_1/A.txt", "Dane16_1_1/b.txt", "out.txt", false, false)
# testLU("Dane10000_1_1/A.txt", "Dane10000_1_1/b.txt", "out.txt", false, false)
# testLU("Dane50000_1_1/A.txt", "Dane50000_1_1/b.txt", "lu.txt", false, true)

# testAll("Dane50000_1_1/A.txt")

# Sizes of matrices to generate
matrixes = [100, 500, 1000, 2000, 5000, 10000, 20000, 25000, 30000, 50000, 100000]
# matrixes = [100, 500, 1000]
sub_size = 4
cond = Float64(1.0)

# Tests results
times_gauss = Vector{Float64}(undef,length(matrixes))
times_gauss_choose = Vector{Float64}(undef,length(matrixes))
times_lu = Vector{Float64}(undef,length(matrixes))
times_lu_choose = Vector{Float64}(undef,length(matrixes))
times_lu_solve = Vector{Float64}(undef,length(matrixes))
times_lu_choose_solve = Vector{Float64}(undef,length(matrixes))

memory_gauss = Vector{Float64}(undef,length(matrixes))
memory_gauss_choose = Vector{Float64}(undef,length(matrixes))
memory_lu = Vector{Float64}(undef,length(matrixes))
memory_lu_choose = Vector{Float64}(undef,length(matrixes))
memory_lu_solve = Vector{Float64}(undef,length(matrixes))
memory_lu_choose_solve = Vector{Float64}(undef,length(matrixes))



for i = 1:length(matrixes)
    @time begin
    # blockmat(matrixes[i], sub_size, cond, "test_matrix.txt")
    #
    #
    # matrix = readMatrix("test_matrix.txt")
    mat = (blockmat(matrixes[i], sub_size, cond, "test_matrix.txt"), matrixes[i], sub_size)
    matrix = (dropzeros(mat[1]),mat[2],mat[3])
    bvec = generateBVec(matrix[1], matrix[2], matrix[3])
    vec = copy(bvec)
    # Gauss
    results = @timed solveGauss(matrix[1], vec, matrix[2], matrix[3])

    times_gauss[i] = results[2]
    memory_gauss[i] = results[3]


    # matrix = readMatrix("test_matrix.txt")
    # vec = generateBVec(matrix[1], matrix[2], matrix[3])

    matrix = (dropzeros(mat[1]),mat[2],mat[3])
    vec = copy(bvec)
    # Gauss with choose
    results = @timed solveGaussPivot(matrix[1], vec, matrix[2], matrix[3])

    times_gauss_choose[i] = results[2]
    memory_gauss_choose[i] = results[3]

    # Loading generated matrix and computing vector of right sides
    # matrix = readMatrix("test_matrix.txt")
    # vec = generateBVec(matrix[1], matrix[2], matrix[3])
    matrix = (dropzeros(mat[1]),mat[2],mat[3])
    vec = copy(bvec)
    # LU
    results = @timed luDecomp(matrix[1], vec, matrix[2], matrix[3])
    data = results[1]

    times_lu[i] = results[2]
    memory_lu[i] = results[3]

    results = @timed solveLuDecomp(data[1], data[2], matrix[2], matrix[3])

    times_lu_solve[i] = results[2] + times_lu[i]
    memory_lu_solve[i] = results[3] + memory_lu[i]

    # LU with choose

    # matrix = readMatrix("test_matrix.txt")
    # vec = generateBVec(matrix[1], matrix[2], matrix[3])
    matrix = (dropzeros(mat[1]),mat[2],mat[3])
    vec = copy(bvec)
    results = @timed luDecompPivot(matrix[1], vec, matrix[2], matrix[3])
    data = results[1]

    times_lu_choose[i] = results[2]
    memory_lu_choose[i] = results[3]

    results = @timed solveLuDecompPivot(data[1], data[2], data[3], matrix[2], matrix[3])

    times_lu_choose_solve[i] = results[2] + times_lu_choose[i]
    memory_lu_choose_solve[i] = results[3] + memory_lu_choose[i]
end
end


# y = [times_gauss,times_gauss_choose,times_lu_solve,times_lu_choose_solve]
# labels = ["Gauss" "Gauss with pivot" "LU" "LU with pivot"]
# println(y)

# plot(matrixes,y,title="Time",label=labels, lw=1)
# # title("Time")
# savefig("times123.png")
#
#
# y = [memory_gauss,memory_gauss_choose,memory_lu_solve,memory_lu_choose_solve]
# labels = ["Gauss" "Gauss with pivot" "LU" "LU with pivot"]
#
# plot(matrixes,y,title="Memory",label=labels, lw=1)
# # title("Time")
# savefig("memory123.png")
