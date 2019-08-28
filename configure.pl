#!/usr/bin/perl -w
 use FileHandle; # use FileHandles instead of open(),close()
 use Cwd;
 use Cwd 'abs_path';

######################## !!! Don't Change the code below##############

$install_dir = getcwd;
$install_dir=abs_path($install_dir);


if(!-s $install_dir)
{
	die "The installation directory ($install_dir) is not existing\n";
}

if ( substr($install_dir, length($install_dir) - 1, 1) ne "/" )
{
        $install_dir .= "/";
}



print "checking whether the configuration file run in the installation folder ...";
$cur_dir = `pwd`;
chomp $cur_dir;
$configure_file = "$cur_dir/configure.pl";
if (! -f $configure_file)
{
        die "\nPlease check the installation directory setting and run the configure program under the main directory of DeepRank.\n";
}
print " OK!\n";



if (! -d $install_dir)
{
	die "can't find installation directory.\n";
}
if ( substr($install_dir, length($install_dir) - 1, 1) ne "/" )
{
	$install_dir .= "/"; 
}

$DeepRank_db_tools_dir = $install_dir;
######### check the DeepRank database and tools


$tools_dir = "$DeepRank_db_tools_dir/tools";

if(!(-d $tools_dir))
{
	die "Failed to find databases and tools under $DeepRank_db_tools_dir/\n";
}



print "\n#########  (1) Configuring scripts\n";

$option_list = "$install_dir/installation/DeepRank_configure_files/DeepRank_scripts_list";

if (! -f $option_list)
{
        die "\nOption file $option_list not exists.\n";
}
configure_file2($option_list,'scripts');
print "#########  Configuring scripts, done\n\n";



print "#########  (2) Configuring examples\n";

$option_list = "$install_dir/installation/DeepRank_configure_files/DeepRank_examples_list";

if (! -f $option_list)
{
        die "\nOption file $option_list not exists.\n";
}
system("rm $install_dir/installation/DeepRank_test_codes/*.sh");
configure_file2($option_list,'installation');


print "#########  Configuring examples, done\n\n\n";

system("chmod +x $install_dir/installation/DeepRank_test_codes/*sh");



### compress benchmark dataset
chdir("$install_dir/examples");
`tar -zxf T0980s1.tar.gz`;


print "######### Configuring programs\n";
$option_list = "$install_dir/installation/DeepRank_configure_files/DeepRank_programs_list";
configure_file2($option_list,'installation');

`cp $install_dir/installation/DeepRank_programs/*sh $install_dir/bin/`;
system("chmod +x $install_dir/installation/DeepRank_test_codes/*sh");
system("chmod +x $install_dir/bin/*.sh");
system("cp $install_dir/installation/DeepRank_test_codes/T*_run-*.sh $install_dir/examples");
system("chmod +x $install_dir/examples/*.sh");



sub prompt_yn {
  my ($query) = @_;
  my $answer = prompt("$query (Y/N): ");
  return lc($answer) eq 'y';
}
sub prompt {
  my ($query) = @_; # take a prompt string as argument
  local $| = 1; # activate autoflush to immediately show the prompt
  print $query;
  chomp(my $answer = <STDIN>);
  return $answer;
}


sub configure_file{
	my ($option_list,$prefix) = @_;
	open(IN,$option_list) || die "Failed to open file $option_list\n";
	$file_indx=0;
	while(<IN>)
	{
		$file = $_;
		chomp $file;
		if ($file =~ /^$prefix/)
		{
			$option_default = $install_dir.$file.'.default';
			$option_new = $install_dir.$file;
			$file_indx++;
			print "$file_indx: Configuring $option_new\n";
			if (! -f $option_default)
			{
					die "\nOption file $option_default not exists.\n";
			}	
			
			open(IN1,$option_default) || die "Failed to open file $option_default\n";
			open(OUT1,">$option_new") || die "Failed to open file $option_new\n";
			while(<IN1>)
			{
				$line = $_;
				chomp $line;

				if(index($line,'SOFTWARE_PATH')>=0)
				{
					$line =~ s/SOFTWARE_PATH/$install_dir/g;
					$line =~ s/\/\//\//g;
					print OUT1 $line."\n";
				}else{
					print OUT1 $line."\n";
				}
			}
			close IN1;
			close OUT1;
		}
	}
	close IN;
}


sub configure_tools{
	my ($option_list,$prefix,$DBtool_path) = @_;
	open(IN,$option_list) || die "Failed to open file $option_list\n";
	$file_indx=0;
	while(<IN>)
	{
		$file = $_;
		chomp $file;
		if ($file =~ /^$prefix/)
		{
			$option_default = $DBtool_path.$file.'.default';
			$option_new = $DBtool_path.$file;
			$file_indx++;
			print "$file_indx: Configuring $option_new\n";
			if (! -f $option_default)
			{
					next;
					#die "\nOption file $option_default not exists.\n";
			}	
			
			open(IN1,$option_default) || die "Failed to open file $option_default\n";
			open(OUT1,">$option_new") || die "Failed to open file $option_new\n";
			while(<IN1>)
			{
				$line = $_;
				chomp $line;

				if(index($line,'SOFTWARE_PATH')>=0)
				{
					$line =~ s/SOFTWARE_PATH/$DBtool_path/g;
					$line =~ s/\/\//\//g;
					print OUT1 $line."\n";
				}else{
					print OUT1 $line."\n";
				}
			}
			close IN1;
			close OUT1;
		}
	}
	close IN;
}



sub configure_file2{
	my ($option_list,$prefix) = @_;
	open(IN,$option_list) || die "Failed to open file $option_list\n";
	$file_indx=0;
	while(<IN>)
	{
		$file = $_;
		chomp $file;
		if ($file =~ /^$prefix/)
		{
			@tmparr = split('/',$file);
			$filename = pop @tmparr;
			chomp $filename;
			$filepath = join('/',@tmparr);
			$option_default = $install_dir.$filepath.'/.'.$filename.'.default';
			$option_new = $install_dir.$file;
			$file_indx++;
			print "$file_indx: Configuring $option_new\n";
			if (! -f $option_default)
			{
					die "\nOption file $option_default not exists.\n";
			}	
			
			open(IN1,$option_default) || die "Failed to open file $option_default\n";
			open(OUT1,">$option_new") || die "Failed to open file $option_new\n";
			while(<IN1>)
			{
				$line = $_;
				chomp $line;

				if(index($line,'SOFTWARE_PATH')>=0)
				{
					$line =~ s/SOFTWARE_PATH/$install_dir/g;
					$line =~ s/\/\//\//g;
					print OUT1 $line."\n";
				}else{
					print OUT1 $line."\n";
				}
			}
			close IN1;
			close OUT1;
		}
	}
	close IN;
}





=pod
database downloading 


/home/casp13/DeepRank_package/software/prosys_database/cm_lib/chain_stx_info
/home/casp13/DeepRank_package/software/prosys_database/cm_lib/pdb_cm
/home/casp13/DeepRank_package/software/prosys_database/cm_lib/pdb_cm.phr
/home/casp13/DeepRank_package/software/prosys_database/cm_lib/pdb_cm.pin
/home/casp13/DeepRank_package/software/prosys_database/cm_lib/pdb_cm.psq
/home/casp13/DeepRank_package/software/prosys_database/cm_lib/pdb_cm_all_sel.fasta 


/home/casp13/DeepRank_package/software/prosys_database/atom.tar.gz

/home/casp13/DeepRank_package/software/prosys_database/nr_latest/



=cut
