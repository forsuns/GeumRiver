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

DecisionTreeRegressor = @load DecisionTreeRegressor pkg=DecisionTree

model = DecisionTreeRegressor(max_depth = -1, 
        min_samples_leaf = 5, 
        min_samples_split = 2, 
        min_purity_increase = 0.0, 
        n_subfeatures = 0, 
        post_prune = false, 
        merge_purity_threshold = 1.0, 
        feature_importance = :impurity)
  
for i=2:LA
        x = x3[(x3[:,1] .== i), :]
        x = x[:,2:4]
        y = y3[(y3[:,1] .== i), :]
        yu = y[:,3]
        mach1 = machine(model, x, yu)
        MLJ.fit!(mach1)
        MLJ.save( "./dec/u"*string(i)*".jls", mach1)
end
for i=2:LA
        x = x3[(x3[:,1] .== i), :]
        x = x[:,2:4]
        y = y3[(y3[:,1] .== i), :]
        yv = y[:,4]
        mach2 = machine(model, x, yv)
        MLJ.fit!(mach2)
        MLJ.save( "./dec/v"*string(i)*".jls", mach2)
end
