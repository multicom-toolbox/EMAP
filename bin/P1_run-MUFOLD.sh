#!/bin/sh

if [ $# -lt 2 ]
then
	printf "need two parameters : directory of input pdbs, directory of output\n\n"
 
  printf "Usage: sh P1_run-MUFOLD.sh <model directory> <output-directory>\n\n";
	
	printf "\t** Example: sh /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/bin/P1_run-MUFOLD.sh /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/examples/T0980s1 /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/test_out/T0980s1_MUFOLD\n\n";
     
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


echo "perl /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/scripts/run_DeepRank_MUFOLD.pl  $model_dir  $outputfolder\n\n";								
perl /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/scripts/run_MUFOLD.pl $model_dir  $outputfolder  2>&1 | tee  MUFOLD.log


printf "\nFinished.."
printf "\nCheck log file <$outputfolder/MUFOLD.log>\n\n"


if [[ ! -f "$outputfolder/MUFOLD_cluster_models.list" ]];then 
	printf "!!!!! Failed to run MUFOLD, check the installation </storage/htc/bdm/jh7x3/QA_eva_cheng20190826/scripts/run_MUFOLD.pl>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: $outputfolder/MUFOLD_cluster_models.list\n\n"
fi

