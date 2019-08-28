# EMAP
The system of estimating model accuracy for protein structures


**(1) Download package (short path is recommended)**

```
git clone https://github.com/multicom-toolbox/EMAP.git


cd EMAP
```

**(2) Setup the tools and  database (required)**

```
perl setup_database.pl
```

Please refer to 'cite_methods_for_publication.txt' to cite the methods that you used for publication. The tools can be also downloaded from their official websites.



**(3) Configure system (required)**

```
perl configure.pl
```



**(4) Testing methods (recommended)**

```

cd examples

sh T1_run-SBROD.sh  

sh T2_run-MUFOLD.sh  

sh T3_run-Qprob.sh

```

**(8) Run methods for quality assessment**

```
   SBROD Usage:
   $ sh P1_run-SBROD.sh <model directory> <output-directory>

   Example: sh /storage/htc/bdm/jh7x3/EMAP/bin/P1_run-SBROD.sh /storage/htc/bdm/jh7x3/EMAP/examples/T0980s1 /storage/htc/bdm/jh7x3/EMAP/test_out/T0980s1_SBROD
   
   
   MUFOLD Usage: 
   $sh P1_run-MUFOLD.sh <model directory> <output-directory>

   Example: sh /storage/htc/bdm/jh7x3/EMAP/bin/P1_run-MUFOLD.sh /storage/htc/bdm/jh7x3/EMAP/examples/T0980s1 /storage/htc/bdm/jh7x3/EMAP/test_out/T0980s1_MUFOLD
        
        
   Qprob Usage: 
   $ sh P1_run-Qprob.sh <target id>  <path of fasta sequence> <model directory> <output-directory>

    Example: sh /storage/htc/bdm/jh7x3/EMAP/bin/P1_run-Qprob.sh T0980s1 /storage/htc/bdm/jh7x3/EMAP/examples/T0980s1.fasta /storage/htc/bdm/jh7x3/EMAP/examples/T0980s1 /storage/htc/bdm/jh7x3/EMAP/test_out/T0980s1_Qprob
        
        
```
