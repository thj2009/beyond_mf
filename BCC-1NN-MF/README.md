# BCC-1NN-MF

This folder is for the modeling framework of mean field microkinetic model with adsorbate interactions (on BCC lattice with first nearest neighbor interactions)

reference: https://pubs.acs.org/doi/abs/10.1021/acs.jpcc.1c04495

## Runing the model

1. install caslearn and LatticeMC

	please see https://github.com/thj2009/LatticeMC and https://github.com/thj2009/caslearn

2. execute run.sh get Lattice monte carlo result and perform macroscopic rate analysis

3. run model/surrogate_rate_nn.ipynb to train and save neural networks for macroscopic rate 

4. run model/modify_MM.ipynb to construct and compare different version of microkinetic models





