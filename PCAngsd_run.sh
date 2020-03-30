#
pcangsd_path=/cerberus/projects/chrwhe/software/pcangsd

# Estimate covariance matrix and individual admixture proportions
python $pcangsd_path/pcangsd.py -beagle all_mds_depth_filter_ngsadmix.beagle.gz -admix -o admix_nok -threads 30

# Parsing Beagle file
# Read 13 samples and 729816 sites
#
# Estimating population allele frequencies
# EM (MAF) converged at iteration: 4
#
# Number of sites after MAF filtering (0.05): 729816


python $pcangsd_path/pcangsd.py -beagle all_mds_depth_filter_ngsadmix.beagle.gz -inbreed 1 -o inbreed_1 -threads 30
# Estimating per-individual inbreeding coefficients
# Using Simple model
# Inbreeding coefficients estimated (1). RMSE=0.12574231007
# Inbreeding coefficients estimated (2). RMSE=0.0036050001763
# Inbreeding coefficients estimated (3). RMSE=0.000303991366738
# Inbreeding coefficients estimated (4). RMSE=4.29472172655e-05
# EM (Inbreeding - individuals) converged at iteration: 4
# Saved per-individual inbreeding coefficients as inbreed_1.inbreed.npy (Binary)
python $pcangsd_path/pcangsd.py -beagle all_mds_depth_filter_ngsadmix.beagle.gz -inbreed 2 -o inbreed_2 -threads 30


# results were assessed then using PCangsd.R
