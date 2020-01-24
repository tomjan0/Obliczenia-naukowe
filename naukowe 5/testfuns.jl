#Tomasz Janik

include("./MatModule.jl")
using .MatModule
using Test


function testAll(matrixPath::String = "")
    matrix = readMatrix(matrixPath);
    vec = generateBVec(matrix[1], matrix[2], matrix[3])
    results = solveGauss(matrix[1],vec, matrix[2], matrix[3])
    writeRes("gauss.txt", results, matrix[2], true)

    matrix = readMatrix(matrixPath);
    vec = generateBVec(matrix[1], matrix[2], matrix[3])
    results = solveGaussPivot(matrix[1],vec, matrix[2], matrix[3])
    writeRes("gausspivot.txt", results, matrix[2], true)

    matrix = readMatrix(matrixPath);
    vec = generateBVec(matrix[1], matrix[2], matrix[3])
    tmp = luDecomp(matrix[1], vec, matrix[2], matrix[3])
    results = solveLuDecomp(tmp[1], vec, matrix[2], matrix[3])
    writeRes("lu.txt", results, matrix[2], true)

    matrix = readMatrix(matrixPath);
    vec = generateBVec(matrix[1], matrix[2], matrix[3])
    tmp = luDecompPivot(matrix[1], vec, matrix[2], matrix[3])
    results = solveLuDecompPivot(tmp[1], tmp[2], vec, matrix[2], matrix[3])
    writeRes("lupivot.txt", results, matrix[2], true)

end

# testAll("Dane50000_1_1/A.txt")


function testGauss(matrixPath::String = "", vectorPath::String = "", outPath::String = "",
                     choose::Bool = false, genB::Bool = false)
    local matrix
    local vec
    local results


    if matrixPath == ""
        error("Can't open file with matrix")
    else
        matrix = readMatrix(matrixPath)
    end

    if !genB
        vec = readVector(vectorPath)

    else
        t = generateBVec(matrix[1], matrix[2], matrix[3])

        vec = (t, 0)
    end

    if choose
        results = solveGaussPivot(matrix[1], vec[1], matrix[2], matrix[3])
    else
        results = solveGauss(matrix[1], vec[1], matrix[2], matrix[3])
    end

    if outPath != ""
        writeRes(outPath, results, matrix[2], genB)
    end
end


function testLU(matrixPath::String = "", vectorPath::String = "", outPath::String = "",
                                choose::Bool = false, genB::Bool = false)
    local matrix
    local vec
    local results


    if matrixPath == ""
        error("Can't open file with matrix")
    else
        matrix = readMatrix(matrixPath)
    end

    if !genB
        vec = readVector(vectorPath)

    else
        t = generateBVec(matrix[1], matrix[2], matrix[3])

        vec = (t, 0)
    end

    if choose
        tmp = luDecompPivot(matrix[1], vec[1], matrix[2], matrix[3])
        results = solveLuDecompPivot(tmp[1], tmp[2], vec[1], matrix[2], matrix[3])
    else
        tmp = luDecomp(matrix[1], vec[1], matrix[2], matrix[3])
        results = solveLuDecomp(tmp[1], vec[1], matrix[2], matrix[3])
    end

    if outPath != ""
        writeRes(outPath, results, matrix[2], genB)
    end
end
