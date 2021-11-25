# Metropolis Hastings Sampling for BCC Lattice
# with NN interaction

#include("../src/LatticeMC.jl")
using LatticeMC
using LatinHypercubeSampling
using Distributions

nx, ny = 50, 50


function mh_one_adsorbate(c1::Float64, tem::Float64)
    fld = "./"
    # # Define BCC Lattice
    bcc = BCCLattice((nx, nx), [0, 1])
    init_coverage!(bcc, [1 - c1, c1])

    # Read Interactions
    # interactions = read_interaction(joinpath(fld, "interaction.txt"))
    interactions = read_interaction(joinpath(fld, "interaction.txt"))
    int_tem = Int(tem)
    # Metropolis Hastings 

    opts = Dict(
        "tot_step" => 10000000,
        "burn_step" => 2000000,
        "write_step" => 100000,
        "save_step" => 500,
        "report" => joinpath(fld, "julia/out_$(c1).txt"),
        "savefile" => joinpath(fld, "julia/mh_output_$(c1).h5")
    )

    mh_sampling(bcc, tem, interactions, opts)
    nothing
end




t = 500.


for i=1:50
    # ensure the c1 and c2 are positive

    n1 = floor(Int, rand(Uniform(0, 1)) * nx * ny)

    println("N1 = $(n1) at Temperature = $(t)")
    c1 = n1 / (nx * ny)

    mh_one_adsorbate(c1, t)
end






 
