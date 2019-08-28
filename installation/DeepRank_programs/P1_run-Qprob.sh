#!/bin/sh

if [ $# -lt 4 ]
then
	echo "need four parameters : target id, path of fasta sequence, directory of input pdbs, directory of output" 
  printf "Usage: sh P1_run-Qprob.sh <target id>  <path of fasta sequence> <model directory> <output-directory>\n\n";
	
	printf "\t** Example: sh /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/bin/P1_run-Qprob.sh T0980s1 /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/examples/T0980s1.fasta /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/examples/T0980s1 /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/test_out/T0980s1_Qprob\n\n";
     
	exit 1
fi

targetid=$1 
fasta=$2 
model_dir=$3 
outputfolder=$4 

if [[ "$fasta" != /* ]]
then
   echo "Please provide absolute path for $fasta"
   exit
fi

if [[ "$outputfolder" != /* ]]
then
   echo "Please provide absolute path for $outputfolder"
   exit
fi


mkdir -p $outputfolder
cd $outputfolder

printf "/storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/tools/DeepQA/tools/qprob_package/bin/Qprob.sh  $fasta  $model_dir  $outputfolder \n\n";								
perl /storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/tools/DeepQA/tools/qprob_package/bin/Qprob.sh  $fasta  $model_dir  $outputfolder  2>&1 | tee  Qprob.log


printf "\nFinished.. check <$outputfolder/$targetid.Qprob_score>"
