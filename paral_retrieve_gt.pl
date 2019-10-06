@a=("AFR","AMR","EAS","EUR","SAS");
for($i=0;$i<4;$i++)
{
for($j=$i+1;$j<5;$j++)
{
$cmd="perl retrieve_gt.pl $a[$i] $a[$j]";
print $cmd,"\n";
$b=`$cmd`;
}
}

