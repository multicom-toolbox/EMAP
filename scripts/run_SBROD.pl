#! /usr/bin/perl -w
#
use Cwd;

# use email;
# use MIME::Lite;
require 5.003; # need this version of Perl or newer
use English; # use English names, not cryptic ones
use FileHandle; # use FileHandles instead of open(),close()
use Carp; # get standard error / warning messages
#use strict; # force disciplined use of variables
use Cwd 'abs_path';
use Scalar::Util qw(looks_like_number);
sub filter_score($$);

our %AA3TO1 = qw(ALA A ASN N CYS C GLN Q HIS H LEU L MET M PRO P THR T TYR Y ARG R ASP D GLU E GLY G ILE I LYS K PHE F SER S TRP W VAL V);
our %AA1TO3 = reverse %AA3TO1;


############## Revise the path ########################
$DeepRank_install = "/storage/htc/bdm/jh7x3/QA_eva_cheng20190826/EMAP/";
$H_tool = "$DeepRank_install/tools";

########################################################
if(@ARGV != 2)
{
die "The number of parameter is not correct!\n";
}

$dir_models = abs_path($ARGV[0]);
$dir_output = abs_path($ARGV[1]);

if(!(-d $dir_output))
{
	`mkdir $dir_output`;
}

## Run SBROD
chdir("$H_tool/SBROD");
print("./assess_protein $dir_models/* &> $dir_output/SBROD_score.txt.tmp\n\n");
system("./assess_protein $dir_models/* &> $dir_output/SBROD_score.txt.tmp");


## check if model number match 
open(IN,"$dir_output/SBROD_score.txt.tmp") || die "Failed to open file $dir_output/SBROD_score.txt.tmp\n";
$model_num = 0;
@score_prediction = ();
while(<IN>)
{
    $line=$_;
    chomp $line;
    $line =~ s/^\s+|\s+$//g;
    
    
    
    @tmp = split(/\s++/,$line);
    $model = $tmp[0];
    $score = $tmp[1];
    
    
    @tmp2 = split(/\//,$model);
    $model = pop @tmp2;
    chomp $model;
    
    push @score_prediction, {
                name => $model,
                score => $score 
    };

  $model_num++;
}
close IN; 

#rank all the models by max score
@score_prediction = sort { $b->{"score"} <=> $a->{"score"}} @score_prediction; 


open(OUTTMP, ">$dir_output/SBROD_score.txt") || die "can't create file $dir_output/SBROD_score.txt\n";
for ($i = 0; $i < @score_prediction; $i++)
{
	print OUTTMP $score_prediction[$i]->{"name"}, "\t", $score_prediction[$i]->{"score"}, "\n";  		
}
close OUTTMP; 


`rm $dir_output/SBROD_score.txt.tmp`;
print "Final score is saved in $dir_output/SBROD_score.txt\n\n";



