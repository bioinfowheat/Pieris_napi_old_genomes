
################################################
# run smc++
################################################

# with timepoints specified
# for i in {1..4} ; do echo $i ; done | cat | parallel -j 3 "smc++ cv --timepoints 5000 300000 -o pop{}/ 2.9e-9 pop{}/*.txt"

# using estimate to try and control Nmax, 50 bp windows
# for i in {1..6} ; do echo $i ; done | cat | parallel -j 4 "smc++ estimate --timepoints 5000 500000 -w 50 --unfold --Nmax 1000000 -o pop{}_tm5k500Nmax1M_estimate_w50_unfold/ 2.9e-9 pop{}/*.txt"
# now with thinning
for i in {1..6} ; do echo $i ; done | cat | parallel -j 4 "smc++ estimate --timepoints 5000 500000 -w 50 --thinning 200 --unfold --Nmax 1000000 -o pop{}_tm5k500Nmax1M_estimate_w50_unfold_thin200/ 2.9e-9 pop{}/*.txt"

################################################
# plot results
################################################

# with timepoints specified
# for g 0.5 plot
# smc++ plot -g 0.5 pop1_g0.5.pdf pop1/model.final.json
# for g 1 plots
# for i in {1..4} ; do echo $i ; done | cat | parallel -j 3 "smc++ plot -g 1 pop{}.pdf pop{}/model.final.json"
# all together in one plot
# with g 0.5, for two generations per year
# smc++ plot -g 0.5 -y 10 100000000 -x 1000 500000 combined_tm5k500Nmax1M_estimate_w50_unfold.0.5.pdf pop[1-6]_tm5k500Nmax1M_estimate_w50_unfold/model.final.json
smc++ plot -g 0.5 -y 10 100000000 -x 1000 500000 combined_tm5k500Nmax1M_estimate_w50_unfold_thin200.0.5.pdf pop[2-6]_tm5k500Nmax1M_estimate_w50_unfold_thin200/model.final.json

# for g 1 plot, for Abisko with one generation per year
smc++ plot -g 1 -y 10 100000000 -x 1000 500000 pop1_tm5k500Nmax1M_estimate_w50_unfold_thin200.1.pdf pop1_tm5k500Nmax1M_estimate_w50_unfold_thin200/model.final.json

# for g 1 plots separately
# for i in {1..4} ; do echo $i ; done | cat | parallel -j 3 "smc++ plot -g 1 pop{}_notime_specified.pdf pop{}_notime_specified/model.final.json"



################################################
# email when done
################################################

email=chris.wheat@zoologi.su.se
location=$(pwd)
echo -e "at \n\n$location"| mutt -s "your script is finished" -- "$email"
