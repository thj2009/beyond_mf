# Metropolis Hastings Sampling for BCC Lattice
# with NN interaction

using LatticeMC
#using HDF5
using Statistics
using JLD
using Glob

# t = parse(Int, ARGS[1])
path = "./"
file = glob("mh_output_*")[1]
interactions = read_interaction("./interaction.txt")

klist = Array{Float64, 1}[]
covs = Array{Float64, 1}[]

t0 = 500.
tem = 400.

println(interactions)
# iter over energies
for inter in interactions
    inter.energy *= tem / t0
end
println(interactions)

c1 = parse(Float64, split(split(file, "mh_output_")[2], ".h5")[1])
cov, ks = analysis_mh_rate(joinpath(path, file), "BCC",
                      [0, 1],
                      [(1,)],
                      [(0,)],
                      interactions,
                      [1.0],
                      [0.0], tem)
jldopen(joinpath("./", "rate_$(c1).h5"), "w") do file
    write(file, "coverage", cov)
    write(file, "ks", ks)
    write(file, "enn1", interactions[2].energy)
    write(file, "tem", tem)
end






