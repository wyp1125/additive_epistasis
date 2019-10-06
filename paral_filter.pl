@a=("AFR","AMR","EAS","EUR","SAS");
for($i=0;$i<4;$i++)
{
for($j=$i+1;$j<5;$j++)
{
$cmd="/usr/bin/python3 filter_loci.py $a[$i]_$a[$j].af $a[$i]_$a[$j].2.af";
print $cmd,"\n";
$b=`$cmd`;
}
}

