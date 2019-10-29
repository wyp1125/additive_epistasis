# Tools for additive epistatic interaction model
## Data simulation tools
#### 1) data_simulation.R
R program for generating a simulated case-control genotype dataset which contains pure epistatic interactions, computing GRS and comparing GRS between case and control groups. 
#### 2) offspring.R
R program for generating genotypes of offspring from the aforementioned simulated genotype dataset, computing GRS and comparing GRS among offspring groups.
#### 3) add_noise.R
R program to add a ratio of noises to the aforementioned simulated genotype dataset, compute GRS and compare GRS between case and control groups.
## Deep learning tools
#### 4) run_dnn.py
Python program to run deep neural network model (with Keras) for the additive epistatic interaction model (using occurrences of pure epistatic interactions as features).
#### 5) run_dnn_cv.py
Python program to run deep neural network model (with Keras) for the additive epistatic interaction model (using occurrences of pure epistatic interactions as features), in a cross-validation setting under which training and testing inputs are separated.
## Processing 1000 Genomes data
#### 6) get_2pop_af.pl
Perl program to retrieve the loci with MAF>0.01 and MAF<0.5 in two populations. 
#### 7) filter_loci.py
Python program to filter out loci with different MAFs between two populations.
#### 8) retrieve_gt.pl
Perl program to retrieve the genotypes of the loci after filtering
#### 9) generate_epi.py
