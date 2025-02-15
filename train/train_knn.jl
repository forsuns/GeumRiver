using MLJ
import MLJFlux
using Flux
import Optimisers
using CSV
using Plots
using DataFrames
using SymbolicRegression
using BSON: @save


LA=6837+1

dt1=CSV.read("./geumriver_summer.csv", DataFrame)

x3 = (dt1[:, Not(["TIME","Z","DEP","I","J","U","V","W","X","Y"])])
y3 = select(dt1,"L","K","U","V","W")

MultitargetKNNRegressor = @load MultitargetKNNRegressor pkg=NearestNeighborModels

model = MultitargetKNNRegressor(K = 5, 
        algorithm = :kdtree, 
        leafsize = 10, 
        reorder = true, 
        weights = NearestNeighborModels.Uniform())
  
for i=2:LA
        x = x3[(x3[:,1] .== i), :]
        x = x[:,2:4]
        y = y3[(y3[:,1] .== i), :]
        yu = y[:,3:5]
        mach = machine(model, x, yu)
        MLJ.fit!(mach)
        MLJ.save( "./knn/m"*string(i)*".jls", mach)
end
