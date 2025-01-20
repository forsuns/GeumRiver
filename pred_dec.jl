using MLJ
import MLJFlux
using Flux
using CSV
using DataFrames
using BSON

LA=6837+1

dt1=CSV.read("./geumriver_winter.csv", DataFrame)

X1 = (dt1[:, Not(["I","J"])])

tt = 13.00
Y1 = X1[(X1[:,"TIME"] .>= tt), :]
Y1 = Y1[(Y1[:,"TIME"] .< tt+1), :]
X1 = X1[(X1[:,"TIME"] .>= tt), :]
X1 = X1[(X1[:,"TIME"] .< tt+1), :]
X2 = X1[(X1[:,"L"] .== 2), :]
X = (X2[:, Not(["L","BELV","TIME","Z","DEP","U","V","W","X","Y"])])
ir = size(X2,1)
j=1

Y = select(Y1,"U","V","W")
Y = Array{Float32}(Y);
DecisionTreeRegressor = @load DecisionTreeRegressor pkg=DecisionTree

function myloop1(j,ir,LA)
    @inbounds for i in 2:LA
        @fastmath X2 = X1[(X1[:,"L"] .== i), :]
        ir = size(X2,1)
        Y1[j:j+ir-1,:] = X2[1:ir,:]
        X = (X2[:, Not(["L","BELV","TIME","Z","DEP","U","V","W","X","Y"])])
        mach1 = machine("../train/dec/u"*string(i)*".jls")
        @fastmath R1 = MLJ.predict(mach1, X)
        mach2 = machine("../train/dec/v"*string(i)*".jls")
        @fastmath R2 = MLJ.predict(mach2, X)
        Y[j:j+ir-1,1] = R1[1:ir,:]
        Y[j:j+ir-1,2] = R2[1:ir,:]
        j=j+ir
        println(i)
    end
    println("complete!")
end

@time myloop1(j, ir, LA)

Y1 = Array{Float32}(Y1);
Y = Array{Float32}(Y);

out = [Y1 Y1[:,8] Y[:,1] Y1[:,9] Y[:,2]]
CSV.write("./dec_cur.csv",  Tables.table(out), writeheader=false)





