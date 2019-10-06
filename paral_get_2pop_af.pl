@a=("AFR","AMR","EAS","EUR","SAS");
for($i=0;$i<4;$i++)
{
for($j=$i+1;$j<5;$j++)
{
$cmd="perl get_2pop_af.pl $a[$i] $a[$j] afs";
print $cmd,"\n";
$b=`$cmd`;
}
}

