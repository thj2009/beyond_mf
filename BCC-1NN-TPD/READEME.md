# BCC-1NN-TPD

This folder is for the modeling framework of TPD profile incorporated with adsorbate interactions (on BCC lattice with first nearest neighbor interactions)

## Runing the model

1. install caslearn and LatticeMC

	please see https://github.com/thj2009/LatticeMC and https://github.com/thj2009/caslearn

2. execute run.sh get Lattice monte carlo result at a range of coverage values and adsorbate interactions, and extract macroscopic rate from MC simulations

3. extract all simulation results into result/ folder by 
```
	for i in {1..100}
	do
		cp $i/rate_* result/
	done
```

4. run model/ENN1-model.ipynb step by step to build the interaction embeded TPD model