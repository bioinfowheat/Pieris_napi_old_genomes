
################################################
# run smc++
################################################

# with timepoints specified
# for i in {1..4} ; do echo $i ; done | cat | parallel -j 3 "smc++ cv --timepoints 5000 300000 -o pop{}/ 2.9e-9 pop{}/*.txt"

# without timepoints specified
for i in {1..4} ; do echo $i ; done | cat | parallel -j 3 "smc++ cv --timepoints 5000 300000 -o pop{}_notime_specified/ 2.9e-9 pop{}/*.txt"

################################################
# plot results
################################################

# with timepoints specified
# for g 0.5 plot
# smc++ plot -g 0.5 pop1_g0.5.pdf pop1/model.final.json
# for g 1 plots
# for i in {1..4} ; do echo $i ; done | cat | parallel -j 3 "smc++ plot -g 1 pop{}.pdf pop{}/model.final.json"
# all together in one plot
smc++ plot -g 1 combined_time_specified.pdf pop[1-4]/model.final.json

# without timepoints specified
# for g 0.5 plot
smc++ plot -g 0.5 pop1_g0.5_notime_specified.pdf pop1_notime_specified/model.final.json

# for g 1 plots separately
# for i in {1..4} ; do echo $i ; done | cat | parallel -j 3 "smc++ plot -g 1 pop{}_notime_specified.pdf pop{}_notime_specified/model.final.json"

# all together in one plot
smc++ plot -g 1 combined_notime_specified.pdf pop*_notime_specified/model.final.json

################################################
# email when done
################################################

email=chris.wheat@zoologi.su.se
location=$(pwd)
echo -e "at \n\n$location"| mutt -s "your script is finished" -- "$email"
