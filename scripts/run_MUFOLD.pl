#! /usr/bin/perl -w
# perl /home/casp13/test/QA_Amarda_Shehu/scripts/parse_MUFOLD_cluster.pl /home/casp13/test/QA_Amarda_Shehu/1AIL/models/ /home/casp13/test/QA_Amarda_Shehu/1AIL

#
require 5.003; # need this version of Perl or newer
use English; # use English names, not cryptic ones
use FileHandle; # use FileHandles instead of open(),close()
use Carp; # get standard error / warning messages
use Cwd;
use Cwd 'abs_path';
use Scalar::Util qw(looks_like_number);

$DeepRank_install = "/storage/htc/bdm/jh7x3/QA_eva_cheng20190826/";

$num = @ARGV;
if($num != 2)
{
	die "The parameter is not correct!\n";
}

$model_dir = $ARGV[0]; #
$output_dir = $ARGV[1]; #
$log_file = "$output_dir/MUFOLD_cluster_models.list"; #

-d $output_dir || `mkdir $output_dir`;
  
if(system("perl $DeepRank_install/scripts/1_MUFOLD_cluster_for_one_target.pl $model_dir  $DeepRank_install/tools/MUfold_cluster/MUFOLD_CL  $output_dir/MUFOLD_cluster &> $output_dir/MUFOLD_cluster.log"))
{
    print "<perl $DeepRank_install/scripts/1_MUFOLD_cluster_for_one_target.pl $model_dir  $DeepRank_install/tools/MUfold_cluster/MUFOLD_CL  $output_dir/MUFOLD_cluster &> $output_dir/MUFOLD_cluster.log> fails!\n";
    exit(0);
}

if(!(-e "$output_dir/MUFOLD_cluster"))
{
	die "Failed to find $output_dir/MUFOLD_cluster\n";
}

if(-d "$output_dir/MUFOLD_cluster_models/")
{
	`rm $output_dir/MUFOLD_cluster_models//*`;
}else{
	`mkdir $output_dir/MUFOLD_cluster_models/`;
}
$IN = new FileHandle "$output_dir/MUFOLD_cluster";
while(defined($line=<$IN>))
{
 chomp($line);
 @tem=split(/\s+/,$line);

 if($tem[0] eq "INFO" && $tem[2] eq "Cluster" && $tem[3] eq "Centroid")
 {# this is the start of cluster information
#			 print "We get the information that cluster starts!\n";
	 last;
 }
}

my(%modelscluster) = ();
my(%cluster_models)=();
my(%cluster)=();
######## read the cluster information #########
while(defined($line=<$IN>))
{
	 chomp($line);
	 if($line eq "INFO  : ======================================")
	 {# finish it
		 last;
	 }
	 print "$line\n";
	 @tem = split(/\:/,$line);
	 @infor = split(/\s+/,$tem[1]);
	 $key = $infor[1];                # cluster index
	 @infor = split(/\s+/,$tem[2]);
	 $value = $infor[1];
	 for($i=2;$i<@infor;$i++)
	 {
		 $value.="_".$infor[$i];
	 }
	 $cluster{$key}=$value;
	 $NUM_cluster++;
} 

if($NUM_cluster < 5)
{
	print "Warning, we get less than 5 clusters!\n";
}
%select_mdoels_in_cluster = ();
for($i=1;$i<=$NUM_cluster;$i++)
{
	 @tem=split(/\_/,$cluster{$i});
	 $model_num = $tem[1];
	 if($model_num>10000)
	 {
		print "For cluster $i, the cluster size ($model_num) is larger than 10000, maybe we can pick 100 models from this cluster!\n";
		$select_mdoels_in_cluster{$i} = 100;
	 }elsif($model_num>5000)
	 {
		print "For cluster $i, the cluster size ($model_num) is between 5000-10000, maybe we can pick 50 models from this cluster!\n";
		$select_mdoels_in_cluster{$i} = 50;
	 }else{
		print "For cluster $i, the cluster size ($model_num) is less than 5000, maybe we can pick 20 models from this cluster!\n";
		$select_mdoels_in_cluster{$i} = 20;
	 }
}
print "**********************\n";

#	 print "Now read the information of models for each cluster ...\n";
open(OUT,">$log_file") || die "Failed to open file $log_file\n";
print OUT "Cluster\tModel\n";
while(defined($line=<$IN>))
{
 chomp($line);
 @tem = split(/\:/,$line);
 if(@tem !=3)
 {# not the line we need : INFO  :    Item     Cluster                     DecoyName
	 next;
 }
 @infor = split(/\s+/,$tem[2]);       # get the cluster index and model name
 $cluster_index = $infor[1];
 $model_name = $infor[2];
 
 if(exists($cluster_models{$cluster_index}))
 {
	$cluster_models{$cluster_index}++;
 }else{
	$cluster_models{$cluster_index}=1;
 }
 
 if($cluster_models{$cluster_index}>$select_mdoels_in_cluster{$cluster_index})
 {
	next;
 }
 print OUT "$cluster_index\t$model_name\n";
 $file_path = "$model_dir/$model_name";
 -e $file_path || die "Failed to find $file_path\n";
 print $cluster_models{$cluster_index}."\tCluster$cluster_index\t$model_name\n";
 `cp $model_dir/$model_name $output_dir/MUFOLD_cluster_models/$model_name`;
 
}
close OUT;
$IN->close();
