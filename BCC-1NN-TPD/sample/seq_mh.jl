# Metropolis Hastings Sampling for BCC Lattice
# with NN interaction

#include("../src/LatticeMC.jl")
using LatticeMC
using LatinHypercubeSampling
using Distributions
using Printf
using JLD

nx, ny = 50, 50
# min, max energy of nn1
emin_nn1, emax_nn1 = -10, 10


# generate random input

e_nn1 = rand(Uniform(0, 1)) * (emax_nn1 - emin_nn1) + emin_nn1


tem = 500.

# ensure the c1 and c2 are positive

n1 = floor(Int, rand(Uniform(0, 1)) * nx * ny)

println("N1 = $(n1) at Temperature = $(tem)")
println("E(NN1) = $(e_nn1)")
c1 = n1 / (nx * ny)


# write interaction file
open("interaction.txt", "w") do io
   write(io, "one, A, 0, 1 a; None\n")
   write(io, "two, nn1_A_A, $(e_nn1), 1 a ! 1 b; NN1")
end

interactions = read_interaction("interaction.txt")



# # Define BCC Lattice
fcc = BCCLattice((nx, nx), [0, 1])
init_coverage!(fcc, [1 - c1, c1])

# Read Interactions
# interactions = read_interaction(joinpath(fld, "interaction.txt"))

# Metropolis Hastings 


opts = Dict(
    "tot_step" => 10000000,
    "burn_step" => 2000000,
    "write_step" => 100000,
    "save_step" => 500,
    "report" => "out_$(c1).txt",
    "savefile" => @sprintf("mh_output_%.2f_%.2f.h5", c1, e_nn1)
)


mh_sampling(fcc, tem, interactions, opts)


# do analysis
cov, ks = analysis_mh_rate(@sprintf("mh_output_%.2f_%.2f.h5", c1, e_nn1), "BCC",
                      [0, 1],
                      [(1,)],
                      [(0,)],
                      interactions,
                      [1.0],
                      [0.0], 500.0)
jldopen(@sprintf("rate_%.2f_%.2f.h5", c1, e_nn1), "w") do file
    write(file, "coverage", cov)
    write(file, "ks", ks)
    write(file, "enn1", e_nn1)
    write(file, "tem", tem)
end


 
