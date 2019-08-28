#!/bin/sh

if [ $# -lt 2 ]
then
	printf "need two parameters : directory of input pdbs, directory of output\n\n"
 
  printf "Usage: sh P1_run-SBROD.sh <model directory> <output-directory>\n\n";
	
	printf "\t** Example: sh /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/bin/P1_run-SBROD.sh /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/examples/T0980s1 /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_SBROD\n\n";
     
	exit 1
fi

model_dir=$1 
outputfolder=$2 



if [[ "$outputfolder" != /* ]]
then
   echo "Please provide absolute path for $outputfolder"
   exit
fi


mkdir -p $outputfolder
cd $outputfolder


echo "perl /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/scripts/run_DeepRank_SBROD.pl  $model_dir  $outputfolder\n\n";								
perl /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/scripts/run_SBROD.pl $model_dir  $outputfolder  2>&1 | tee  SBROD.log


printf "\nFinished.."
printf "\nCheck log file <$outputfolder/SBROD.log>\n\n"


if [[ ! -f "$outputfolder/SBROD_score.txt" ]];then 
	printf "!!!!! Failed to run SBROD, check the installation </storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/scripts/run_SBROD.pl>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: $outputfolder/SBROD_score.txt\n\n"
fi

