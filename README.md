# Tools for additive epistatic interaction model
#### 1) data_simulation.R
R program for generating a simulated case-control genotype dataset which contains pure epistatic interactions, computing GRS and comparing GRS between case and control groups. 
#### 2) offspring.R
R program for generating genotypes of offspring from the aforementioned simulated genotype dataset, computing GRS and comparing GRS among offspring groups.
#### 3) add_noise.R
R program to add a ratio of noises to the aforementioned simulated genotype dataset, compute GRS and compare GRS between case and control groups.
#### 4) run_dnn.py
Python program to run deep neural network model (with Keras) for the additive epistatic interaction model (using occurrences of pure epistatic interactions as features).
#### 5) run_dnn_cv.py
Python program to run deep neural network model (with Keras) for the additive epistatic interaction model (using occurrences of pure epistatic interactions as features), in a cross-validation setting under which training and testing inputs are separated.
