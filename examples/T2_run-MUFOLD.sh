#!/bin/bash
#SBATCH -J  MUFOLD
#SBATCH -o MUFOLD-%j.out
#SBATCH --partition Lewis,hpc5,hpc4
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time 1-00:00

mkdir -p /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_MUFOLD/
cd /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_MUFOLD/


touch /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_MUFOLD.running

printf "perl /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/scripts/run_MUFOLD.pl /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/examples/T0980s1  /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_MUFOLD/\n\n";								
perl /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/scripts/run_MUFOLD.pl /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/examples/T0980s1  /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_MUFOLD/ 2>&1 | tee  /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_MUFOLD.log



printf "\nFinished.."
printf "\nCheck log file </storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_MUFOLD.log>\n\n"


if [[ ! -f "/storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_MUFOLD/MUFOLD_cluster_models.list" ]];then 
	printf "!!!!! Failed to run MUFOLD, check the installation </storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/scripts/run_MUFOLD.pl>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_MUFOLD/MUFOLD_cluster_models.list\n\n"
fi
rm /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_MUFOLD.running
