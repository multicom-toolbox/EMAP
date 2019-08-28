#!/bin/bash
#SBATCH -J  SBROD
#SBATCH -o SBROD-%j.out
#SBATCH --partition Lewis,hpc5,hpc4
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time 1-00:00

mkdir -p /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_SBROD/
cd /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_SBROD/


touch /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_SBROD.running

printf "perl /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/scripts/run_SBROD.pl /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/examples/T0980s1  /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_SBROD/\n\n";								
perl /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/scripts/run_SBROD.pl /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/examples/T0980s1  /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_SBROD/ 2>&1 | tee  /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_SBROD.log



printf "\nFinished.."
printf "\nCheck log file </storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_SBROD.log>\n\n"


if [[ ! -f "/storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_SBROD/SBROD_score.txt" ]];then 
	printf "!!!!! Failed to run SBROD, check the installation </storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/scripts/run_SBROD.pl>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_SBROD/SBROD_score.txt\n\n"
fi
rm /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_SBROD.running
