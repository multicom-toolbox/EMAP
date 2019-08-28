#!/bin/bash
#SBATCH -J  Qprob
#SBATCH -o Qprob-%j.out
#SBATCH --partition Lewis,hpc5,hpc4
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time 2-00:00


mkdir -p /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_Qprob/
cd /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_Qprob/


export LD_LIBRARY_PATH=/storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/tools/Qprob/libs:$LD_LIBRARY_PATH

touch /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_Qprob.running
if [[ ! -f "/storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_Qprob/ALL_scores/feature_Qprob.T0980s1" ]];then
	printf "/storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/tools/DeepQA/tools/qprob_package/bin/Qprob.sh /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/examples/T0980s1.fasta /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/examples/T0980s1  /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_Qprob/ 2>&1 | tee  /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_Qprob/run_Qprob.log\n\n";								
	/storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/tools/DeepQA/tools/qprob_package/bin/Qprob.sh /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/examples/T0980s1.fasta /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/examples/T0980s1  /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_Qprob/ 2>&1 | tee  /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_Qprob/run_Qprob.log
fi

printf "\nFinished.."
printf "\nCheck log file </storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_Qprob.log>\n\n"


if [[ ! -f "/storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_Qprob/T0980s1.Qprob_score" ]];then 
	printf "!!!!! Failed to run Qprob, check the installation </storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/src/scripts/run_DeepRank_Qprob.pl>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_Qprob/T0980s1.Qprob_score\n\n"
fi
rm /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_Qprob.running
