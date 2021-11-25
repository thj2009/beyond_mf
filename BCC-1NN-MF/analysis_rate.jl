# Metropolis Hastings Sampling for BCC Lattice
# with NN interaction

using LatticeMC
#using HDF5
using Statistics
using JLD
# t = parse(Int, ARGS[1])
path = "./julia/"
files = readdir(path)
interactions = read_interaction("./interaction.txt")

klist = Array{Float64, 1}[]
covs = Array{Float64, 1}[]



global I = 0
for file in files
    c1 = parse(Float64, split(split(file, "mh_output_")[2], ".h5")[1])
    cov, ks = analysis_mh_rate(joinpath(path, file), "BCC",
                          [0, 1],
                          [(1, 0), (1,), (0, 0)],
                          [(0, 0), (0,), (0, 0)],
                          interactions,
                          [1.0, 1.0, 1.0],
                          [0.0, 0.0, 0.0], 500.0)
    jldopen(joinpath("./result/", "rate_$(c1).h5"), "w") do file
        write(file, "coverage", cov)
        write(file, "ks", ks)
    end
end





